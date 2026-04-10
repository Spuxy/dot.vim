-- yamlls settings — schemastore.nvim provides the schema catalog
-- schemastore.nvim must be a dependency of lspconfig (see lspconfig.lua)
return {
  settings = {
    redhat = { telemetry = { enabled = false } },
    yaml = {
      -- Disable yamlls built-in schemaStore fetch — schemastore.nvim serves it locally
      schemaStore = { enable = false, url = "" },
      -- schemastore.nvim catalog handles most auto-detection by filename.
      -- Extra entries below cover k8s ecosystems not in the catalog.
      schemas = vim.tbl_deep_extend("force",
        require("schemastore").yaml.schemas(),
        {
          -- Kubernetes — matches common manifest directory structures
          kubernetes = {
            "k8s/**/*.{yaml,yml}",
            "kubernetes/**/*.{yaml,yml}",
            "manifests/**/*.{yaml,yml}",
            "manifest/**/*.{yaml,yml}",
            "deploy/**/*.{yaml,yml}",
            "resources/**/*.{yaml,yml}",
            "clusters/**/*.{yaml,yml}",
            "charts/**/templates/**/*.{yaml,yml}",
            "base/**/*.{yaml,yml}",
            "overlays/**/*.{yaml,yml}",
          },
          -- Flux CD (HelmRelease, Kustomization, GitRepository, etc.)
          ["https://raw.githubusercontent.com/fluxcd-community/flux2-schemas/refs/heads/main/all.json"] = {
            "flux/**/*.{yaml,yml}",
            "**/gotk-*.{yaml,yml}",
            "**/flux-*.{yaml,yml}",
          },
          -- ArgoCD (Application, AppProject, ApplicationSet)
          ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json"] = {
            "argocd/**/*.{yaml,yml}",
            "argo/**/*.{yaml,yml}",
            "**/application.{yaml,yml}",
          },
          -- Vault Agent / Vault Kubernetes auth configs
          ["https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/secrets.hashicorp.com/vaultauth_v1beta1.json"] = {
            "vault/**/*.{yaml,yml}",
            "**/vault-*.{yaml,yml}",
          },
        }
      ),
      -- validate = false avoids "matches multiple schemas" errors from kubernetes all.json (oneOf)
      validate = false,
      completion = true,
      hover = true,
      format = { enabled = false },
    },
  },
}
