// Publisher-crafted reading view — stacked edition (not grid columns).
// Craft CSS: templates/html/reading.css (listed in [build.default] css).

`layout [
{{ body }}
]

`item [
`div { class="verse-content" } [
    `div { class="verse-block" } [
        `div { class="mula" } [`stream { ref="mula" }]
        `div { class="iast" data-verse="{{ verse }}" } [`stream { ref="iast" }]
    ]
]
]
