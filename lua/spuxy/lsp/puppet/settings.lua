-- puppet-languageserver is NOT installed via Mason.
-- Install manually:
--   gem install puppet-editor-services
-- or use the version bundled with Puppet Agent.
-- Ensure `puppet-languageserver` is on your $PATH.
return {
  cmd = { "puppet-languageserver", "--stdio" },
  filetypes = { "puppet" },
}
