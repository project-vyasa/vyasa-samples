// Publisher theme shell — packed as theme_layout; not a selectable reading mode.
// Grid and publisher-crafted views inherit this wrapper via the viewer fallback chain.

`layout [
`html { lang="en" } [
    `head [
        `meta { charset="UTF-8" }
        `meta { name="viewport" content="width=device-width, initial-scale=1.0" }
        `title [ Bhagavad Gita (Vyasa) ]
        `link { href="https://fonts.googleapis.com/css2?family=Noto+Sans+Devanagari:wght@400;500;700&family=Noto+Serif:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet" }
        `style [
            body {
                font-family: 'Noto Serif', serif;
                padding: 2rem;
                line-height: 1.6;
                color: #333;
                background-color: #fdfdfd;
            }
            .verse-content {
                text-align: center;
                margin: 1.5rem 0 2rem;
            }
            .mula {
                font-family: 'Noto Sans Devanagari', sans-serif;
                font-size: 1.4rem;
                margin-bottom: 0.75rem;
                font-weight: 500;
                white-space: pre-line;
            }
            .iast {
                font-family: 'Noto Serif', serif;
                font-style: italic;
                color: #555;
                font-size: 1.1rem;
                white-space: pre-line;
                display: block;
                margin-top: 1rem;
            }
            .iast .verse {
                display: inline;
            }
            .iast::after {
                content: " ॥ " attr(data-verse) " ॥";
                white-space: nowrap;
            }
        ]
    ]
    `body [
        `div { class="content" } [
            {{ body }}
        ]
    ]
]
]
