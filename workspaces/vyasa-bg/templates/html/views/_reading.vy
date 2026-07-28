// Publisher-crafted reading layout (draft — underscore prefix skips pack until promoted).
// Theme shell lives in theme.vy; this file holds only the item weaving template.

`item [
`div { class="verse-content" } [
    `div { class="verse-block" } [
        `div { class="mula" } [`stream { ref="mula" }]
        `div { class="iast" data-verse="{{ verse }}" } [`stream { ref="iast" }]
    ]
]
]
