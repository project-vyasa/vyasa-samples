// Publisher theme shell — packed as theme_layout; shared by grid and reading views.

`layout [
`html { lang="en" } [
    `head [
        `meta { charset="UTF-8" }
        `meta { name="viewport" content="width=device-width, initial-scale=1.0" }
        `title [ Bhagavad Gita - Reading View ]
        `link { href="https://fonts.googleapis.com/css2?family=Noto+Serif:ital,wght@0,100..900;1,100..900&display=swap" rel="stylesheet" }
        `link { href="https://fonts.googleapis.com/css2?family=Noto+Sans+Devanagari:wght@100..900&display=swap" rel="stylesheet" }
        `style [
            body { font-family: 'Noto Serif', serif; max-width: 1200px; margin: 0 auto; padding: 20px; background: #fdfdfd; color: #333; }
            h1 { text-align: center; color: #d35400; border-bottom: 2px solid #eee; padding-bottom: 1rem; }
            .verse-container { border-bottom: 1px solid #eee; padding: 40px 0; }
            .verse-header { margin-bottom: 20px; }
            .verse-id { font-size: 1.2rem; font-weight: bold; color: #7f8c8d; }
            
            .verse-grid { 
                display: flex; 
                flex-direction: column;
                gap: 20px; 
            }

            .column-header { 
                font-size: 0.8rem; text-transform: uppercase; letter-spacing: 1px; 
                color: #999; margin-bottom: 10px; border-bottom: 1px solid #eee; padding-bottom: 5px;
            }
            
            .section-title {
                font-size: 1.2rem;
                font-weight: bold;
                margin-top: 1.5rem;
                margin-bottom: 0.5rem;
                color: #333;
            }

            .mula { font-family: 'Noto Sans Devanagari', sans-serif; font-size: 1.2rem; line-height: 1.8; white-space: pre-wrap; }
            .transliteration { font-style: italic; color: #555; white-space: pre-wrap; }
            .translation { line-height: 1.6; }
            
            .synonyms-grid {
                display: grid;
                grid-template-columns: auto 1fr;
                column-gap: 15px;
                row-gap: 8px;
                line-height: 1.6;
            }
            .synonym-term {
                font-weight: bold;
                color: #2c3e50;
            }            
            /* Hide internals if leaked */
            .entity-header, .uvacha-label { display: inline-block; font-weight: bold; margin-right: 5px; }
            .entity-header::after { content: " "; }
        ]
    ]
    `div { class="reading-body" } [
        `h1 [ Bhagavad Gita As It Is ]
        {{ body }}
    ]
]
]
