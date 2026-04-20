# Shyama Brand Guidelines

## Wordmark

The Shyama wordmark is always set in two scripts, paired vertically:

- **"Shyama"** — Fraunces Medium, size determined by context
- **"श्यामा"** — Mukta Devanagari Regular, set at **60% of the Latin cap-height**, placed directly below

The Devanagari line is never displayed in isolation from the Latin line within the wordmark lockup. Both scripts carry equal visual weight — the bilingual pairing is not decoration; it is a statement of primary audience inclusion.

---

## Color Palette

| Token | Hex | Use |
|-------|-----|-----|
| `canvas` | `#F2ECE0` | Warm cream — primary background |
| `canvasDeep` | `#E8DFCE` | Slightly deeper cream — recessed surfaces, inset shadow targets |
| `ink` | `#1A1410` | Near-black with warm undertone — primary text |
| `inkSoft` | `#5C4A3E` | Warm brown — secondary text, captions |
| `terracotta` | `#B8502E` | Warm red-orange — primary accent, CTA buttons, scan orb |
| `honey` | `#D9A441` | Warm gold — secondary accent, confidence bars, highlights |
| `forest` | `#2E5D4F` | Deep green — success states, "skin-friendly" indicators |
| `clay` | `#8B4513` | Reddish brown — tertiary, ingredient warnings, caution states |

### Accessibility

- All text-on-background combinations must meet **WCAG AA** (≥ 4.5:1 contrast for normal text, ≥ 3:1 for large text / UI components).
- Soft-UI shadows are decorative and must never be the sole indicator of interactivity. Always pair with a border, icon, or label.
- `ink` (`#1A1410`) on `canvas` (`#F2ECE0`) yields a contrast ratio of approximately **14:1** — well above AA.
- `terracotta` (`#B8502E`) on `canvas` (`#F2ECE0`) yields approximately **4.6:1** — passes AA for normal text.

---

## Typography

| Role | Typeface | Size | Weight |
|------|----------|------|--------|
| Display Large | Fraunces | 40pt | Medium (500) |
| Display Medium | Fraunces | 28pt | Medium (500) |
| Headline | DM Sans | 20pt | SemiBold (600) |
| Body | DM Sans | 16pt | Regular (400) |
| Caption | DM Sans | 13pt | Regular (400) |
| Devanagari Accent | Mukta Devanagari | 24pt | SemiBold (600) |

### Typeface Rationale

**Fraunces** is a variable serif designed for editorial gravitas. Its optical size axis makes it legible even at large display sizes. It carries screen titles, scan result headlines, and the Latin portion of the wordmark.

**DM Sans** is a geometric humanist sans-serif — clean, approachable, highly legible at small sizes across all reading distances. It handles all UI labels, body copy, and button text.

**Mukta Devanagari** is used exclusively for the Devanagari script wordmark ("श्यामा") and any Hindi accent phrases. It is never used for extended Devanagari body copy without a separate type review.

---

## Voice and Tone

- **Warm, direct, inclusive** — we speak to all skin tones as the default, not as an edge case
- **Confident but humble** — we know our model's limits; we do not claim to diagnose
- **Bilingual by design** — Hindi phrasing is a primary audience signal, not decoration
- **Educational, never alarmist** — we inform and refer; we do not scare

---

## Logo Usage

- The wordmark must always appear on a background with sufficient contrast (`canvas #F2ECE0` preferred)
- Do not rotate, skew, recolor, or apply effects to the wordmark
- Minimum digital size: 32pt for the Latin letterforms
- Clear space: equal to the cap-height of the Latin "S" on all four sides
- The Devanagari and Latin lines must always appear together in the wordmark lockup
