`title [Bhagavad Gita]

`set settings {
    default_whitespace = "single"
    break_after = "।॥"
    // Sets the default attribute key when parsing structured action events (e.g., `uvaca`), automatically binding the subject argument to "speaker".
    event_header.subject_key = "speaker"
}

// Common Semantic Definitions
`command-def { name="devanagari" category="content" }
`command-def { name="iast" category="content" }

`command-def { name="annotate" category="metadata" flexible_args="true" }
`command-def { name="note" category="metadata" flexible_args="true" }
`command-def { name="frame" category="metadata" flexible_args="true" }

`alias-def { name="v" target="verse" }

// Common Entities (Generic)
`command-def { name="sanjaya" category="entity" }
`command-def { name="arjuna" category="entity" }
`command-def { name="krishna" category="entity" }
`command-def { name="dhritarashtra" category="entity" }

// Action Commands & Compound Aliases
`command-def { name="uvacha" category="action", flexible_args="true" }
`command-def { name="uvaca" category="action", flexible_args="true" }

`alias-def { name="dhritarashtra.uvaca", target="uvaca", params="speaker=dhritarashtra, action=uvaca" }
`alias-def { name="sanjaya.uvaca", target="uvaca", params="speaker=sanjaya, action=uvaca" }
`alias-def { name="arjuna.uvaca", target="uvaca", params="speaker=arjuna, action=uvaca" }
`alias-def { name="krishna.uvaca", target="uvaca", params="speaker=krishna, action=uvaca" }
