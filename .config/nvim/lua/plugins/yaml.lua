-- SchemaStore carries no Crossplane schemas, so Compositions and XRDs get no
-- completion or validation. These come from datreeio/CRDs-catalog.
--
-- The globs are directory-based on purpose: yamlls reports every unknown field
-- as an error, so a pattern that matches the wrong file buries the buffer in
-- false positives. Adjust these to your layout, or pin a single file with
--   # yaml-language-server: $schema=<url>
local crds = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/"

return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      yamlls = {
        settings = {
          yaml = {
            schemas = {
              [crds .. "apiextensions.crossplane.io/composition_v1.json"] = {
                "**/compositions/**/*.yaml",
                "**/composition.yaml",
              },
              [crds .. "apiextensions.crossplane.io/compositeresourcedefinition_v1.json"] = {
                "**/definitions/**/*.yaml",
                "**/definition.yaml",
                "**/xrd.yaml",
              },
              [crds .. "pkg.crossplane.io/function_v1.json"] = {
                "**/functions/**/*.yaml",
                "**/functions.yaml",
              },
              [crds .. "pkg.crossplane.io/provider_v1.json"] = {
                "**/providers/**/*.yaml",
                "**/providers.yaml",
              },
            },
          },
        },
      },
    },
  },
}
