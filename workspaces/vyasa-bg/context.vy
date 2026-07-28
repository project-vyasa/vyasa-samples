`title [Bhagavad Gita]

`set settings {
    default_whitespace = "single"
    break_after = "।॥"
}

// Stream & metadata commands
`command-def { name="devanagari" category="content" }
`command-def { name="iast" category="content" }

`command-def { name="annotate" category="metadata" flexible_args="true" }
`command-def { name="note" category="metadata" flexible_args="true" }

`alias-def { name="v" target="verse" }

// Speaker annotation markers (used in annotations/speakers.vy, not inline in content)
`command-def { name="uvaca" category="action", flexible_args="true" }

`alias-def { name="dhritarashtra.uvaca", target="uvaca", params="speaker=dhritarashtra, action=uvaca" }
`alias-def { name="sanjaya.uvaca", target="uvaca", params="speaker=sanjaya, action=uvaca" }
`alias-def { name="arjuna.uvaca", target="uvaca", params="speaker=arjuna, action=uvaca" }
`alias-def { name="krishna.uvaca", target="uvaca", params="speaker=krishna, action=uvaca" }
