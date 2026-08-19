; extends

; Crossplane function-go-templating keeps its Go template in a `template: |`
; block scalar, which plain yaml renders as one flat string. `helm` is the
; gotmpl grammar plus Sprig, which is the function set Crossplane exposes.
(block_mapping_pair
  key: (flow_node) @_template
  (#eq? @_template "template")
  value: (block_node
    (block_scalar) @injection.content
    (#set! injection.language "helm")
    (#offset! @injection.content 0 1 0 0)))
