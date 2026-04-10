-- Kubernetes/CRD schema auto-detection for yamlls
-- Based on: reddit.com/r/neovim/comments/1iykmqc
--
-- Strategy:
--   1. Extract apiVersion + kind from buffer content
--   2. Try datreeio/CRDs-catalog for CRD schemas (cached GitHub tree fetch)
--   3. Fall back to yannh/kubernetes-json-schema for core k8s resources
--   4. Attach the specific schema to yamlls for this buffer only
--
-- All HTTP calls are async (plenary.curl callback) — never blocks the UI.

local curl = require("plenary.curl")

local M = {
  schemas_catalog    = "datreeio/CRDs-catalog",
  catalog_branch     = "main",
  github_api         = "https://api.github.com/repos",
  github_headers     = {
    Accept                  = "application/vnd.github+json",
    ["X-GitHub-Api-Version"] = "2022-11-28",
  },
  _tree_cache = nil,   -- cached list of .json paths from CRDs-catalog
  _fetching   = false, -- guard against concurrent tree fetches
  _pending    = {},    -- callbacks waiting for the tree fetch
}

M.raw_base = "https://raw.githubusercontent.com/" .. M.schemas_catalog .. "/" .. M.catalog_branch

-- ── helpers ──────────────────────────────────────────────────────────────────

local function extract(buffer_content)
  local content = buffer_content:gsub("^%-%-%-%s*\n", "")
  local api_version = content:match("apiVersion:%s*([%w%.%/%-]+)")
  local kind        = content:match("kind:%s*([%w%-]+)")
  return api_version, kind
end

-- "argoproj.io/v1alpha1" + "Application" → "argoproj.io/application_v1alpha1.json"
local function crd_path(api_version, kind)
  local group, version = api_version:match("([^/]+)/([^/]+)")
  if not group or not version then return nil end
  return group .. "/" .. kind:lower() .. "_" .. version .. ".json"
end

local function attach(bufnr, schema_url, label)
  local filepath = vim.api.nvim_buf_get_name(bufnr)
  if filepath == "" then return end

  local clients = vim.lsp.get_clients({ name = "yamlls", bufnr = bufnr })
  if #clients == 0 then return end

  local client = clients[1]
  -- Mutate the client's live settings so the next didChangeConfiguration is complete
  client.config.settings = vim.tbl_deep_extend("force",
    client.config.settings or {},
    { yaml = { schemas = { [schema_url] = filepath } } }
  )
  client:notify("workspace/didChangeConfiguration", { settings = client.config.settings })
  vim.notify("[yaml] attached: " .. label, vim.log.levels.INFO)
end

-- ── CRD catalog (async, cached) ───────────────────────────────────────────────

local function get_tree(callback)
  if M._tree_cache then
    callback(M._tree_cache)
    return
  end

  -- Enqueue if a fetch is already in flight
  if M._fetching then
    table.insert(M._pending, callback)
    return
  end

  M._fetching = true
  local url = M.github_api .. "/" .. M.schemas_catalog .. "/git/trees/" .. M.catalog_branch
  curl.get(url, {
    headers = M.github_headers,
    query   = { recursive = 1 },
    callback = function(resp)
      vim.schedule(function()
        M._fetching = false
        if resp.status ~= 200 then
          vim.notify("[yaml-detect] CRD catalog fetch failed (" .. resp.status .. ")", vim.log.levels.WARN)
          callback(nil)
          for _, cb in ipairs(M._pending) do cb(nil) end
          M._pending = {}
          return
        end

        local ok, body = pcall(vim.fn.json_decode, resp.body)
        if not ok or not body or not body.tree then
          vim.notify("[yaml-detect] CRD catalog parse error", vim.log.levels.WARN)
          callback(nil)
          for _, cb in ipairs(M._pending) do cb(nil) end
          M._pending = {}
          return
        end

        local paths = {}
        for _, node in ipairs(body.tree) do
          if node.type == "blob" and node.path:match("%.json$") then
            paths[#paths + 1] = node.path
          end
        end

        M._tree_cache = paths
        callback(paths)
        for _, cb in ipairs(M._pending) do cb(paths) end
        M._pending = {}
      end)
    end,
  })
end

-- ── k8s core schema (async, per-kind) ────────────────────────────────────────

local function get_k8s_schema(api_version, kind, callback)
  local version  = api_version:match("/([%w%-]+)") or api_version
  local base     = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/refs/heads/master/master/"
  local with_ver = base .. kind:lower() .. "-" .. version .. ".json"
  local without  = base .. kind:lower() .. ".json"

  curl.get(with_ver, {
    callback = function(r1)
      vim.schedule(function()
        if r1.status == 200 then
          callback(with_ver)
          return
        end
        curl.get(without, {
          callback = function(r2)
            vim.schedule(function()
              callback(r2.status == 200 and without or nil)
            end)
          end,
        })
      end)
    end,
  })
end

-- ── main ─────────────────────────────────────────────────────────────────────

M.init = function(bufnr)
  local buffer_content = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n")
  local api_version, kind = extract(buffer_content)
  if not api_version or not kind then return end

  local target = crd_path(api_version, kind)

  -- 1. Try CRD catalog (covers Flux, Argo, Vault, any CRD)
  get_tree(function(paths)
    if paths and target then
      for _, path in ipairs(paths) do
        if path:match(vim.pesc(target)) then
          attach(bufnr, M.raw_base .. "/" .. path, kind .. " CRD")
          return
        end
      end
    end

    -- 2. Fallback: core kubernetes schema (Pod, Deployment, Service, etc.)
    get_k8s_schema(api_version, kind, function(url)
      if url then
        attach(bufnr, url, "k8s " .. kind)
      else
        vim.notify("[yaml] no schema found for " .. kind .. " (" .. api_version .. ")", vim.log.levels.WARN)
      end
    end)
  end)
end

-- ── autocmd setup ─────────────────────────────────────────────────────────────

function M.setup()
  local group = vim.api.nvim_create_augroup("yaml_schema_detect", { clear = true })

  vim.api.nvim_create_autocmd("FileType", {
    group   = group,
    pattern = "yaml",
    callback = function(args)
      local bufnr  = args.buf
      local clients = vim.lsp.get_clients({ name = "yamlls", bufnr = bufnr })
      if #clients > 0 then
        M.init(bufnr)
      else
        -- yamlls not ready yet — wait for it
        vim.api.nvim_create_autocmd("LspAttach", {
          once   = true,
          buffer = bufnr,
          group  = group,
          callback = function(lsp_args)
            local client = vim.lsp.get_client_by_id(lsp_args.data.client_id)
            if client and client.name == "yamlls" then
              M.init(bufnr)
            end
          end,
        })
      end
    end,
  })

  -- Re-detect on save (apiVersion/kind may have been added/changed)
  vim.api.nvim_create_autocmd("BufWritePost", {
    group   = group,
    pattern = { "*.yaml", "*.yml" },
    callback = function(args) M.init(args.buf) end,
  })
end

return M
