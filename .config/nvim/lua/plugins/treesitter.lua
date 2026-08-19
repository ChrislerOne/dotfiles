-- The helm queries are `; inherits: gotmpl`, and nvim-treesitter only links
-- queries/<lang> into the runtimepath for parsers it has installed. Without
-- gotmpl the inherit resolves to nothing and every gotmpl rule is dropped,
-- leaving only helm's own Sprig patterns.
return {
  "nvim-treesitter/nvim-treesitter",
  opts = { ensure_installed = { "gotmpl", "helm" } },
}
