# Shyama — श्यामा

**An inclusive skincare companion for Black and brown communities.**

Shyama helps you learn about common skin conditions — with an AI that was built to see all skin tones, not just the ones historically over-represented in dermatology research and datasets.

> *Skincare that sees you.*

---

## What Shyama Is

- An **educational tool** that surfaces possible matches for what you might be seeing on your skin
- A reference for understanding ingredients in your skincare products
- A starting point for better conversations with your dermatologist

## What Shyama Is Not

- A diagnostic tool
- A replacement for professional medical care
- Certain about anything — every result uses "possible" and "may be" framing intentionally

See [`docs/language-hygiene.md`](docs/language-hygiene.md) and [`docs/medical-disclaimer.md`](docs/medical-disclaimer.md).

---

## Repository Structure

```
shyama/
├── ios/          SwiftUI app (iOS 17+)
├── ml/           ML training pipeline (planned)
├── design/       Brand guidelines, Figma exports
├── docs/         Privacy policy, medical disclaimer, language guide
├── README.md
└── LICENSE
```

---

## iOS App Quick Start

See [`ios/README.md`](ios/README.md) for full setup. Short version:

1. Download fonts: Fraunces, DM Sans, Mukta Devanagari from Google Fonts
2. Copy TTF files into `ios/Shyama/Resources/Fonts/`
3. Open `ios/Shyama/` in Xcode, add fonts to target + `Info.plist`
4. Build on iOS 17 simulator

---

## Design System

Minimalist soft-UI with cultural nuance — restrained neumorphism, warm cream palette (`#F2ECE0`), terracotta accents (`#B8502E`), bilingual wordmark (Fraunces + Mukta Devanagari). WCAG AA contrast throughout.

Full details in [`design/brand.md`](design/brand.md).

---

## Values

**Representation by default.** Our ML pipeline will report per-stratum accuracy across all six Fitzpatrick skin tone types. Aggregate metrics alone are not enough.

**Humility by design.** The app never says "you have X." It says "this may be X — consider talking to a dermatologist."

**Privacy first.** Skin images are processed on-device when possible. No data is sold. You can delete everything, anytime.

---

## Contributing

This project is in early development. Contribution guidelines will be published when the codebase stabilizes.

---

## License

See [LICENSE](LICENSE).
