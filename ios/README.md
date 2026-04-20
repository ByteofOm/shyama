# Shyama iOS App

SwiftUI app targeting iOS 17+.

## First-Time Setup

### 1. Download and install fonts

The app uses three typefaces. Download them from Google Fonts and copy the TTF files into `ios/Shyama/Resources/Fonts/`:

| Typeface | URL | Files needed |
|----------|-----|--------------|
| Fraunces | https://fonts.google.com/specimen/Fraunces | `Fraunces-Regular.ttf`, `Fraunces-Medium.ttf` |
| DM Sans | https://fonts.google.com/specimen/DM+Sans | `DMSans-Regular.ttf`, `DMSans-Medium.ttf`, `DMSans-SemiBold.ttf` |
| Mukta Devanagari | https://fonts.google.com/specimen/Mukta+Devanagari | `MuktaDevanagari-Regular.ttf`, `MuktaDevanagari-SemiBold.ttf` |

### 2. Open in Xcode

Open the `ios/Shyama/` folder in Xcode (File → Open Folder). When you create the Xcode project, target the same directory.

### 3. Add fonts to the Xcode target

- Drag the TTF files from `Resources/Fonts/` into the Xcode project navigator
- In the "Add to targets" dialog, check **Shyama**
- In `Info.plist`, add the key `Fonts provided by application` (`UIAppFonts`) and list each TTF filename

The `registerFonts()` function in `Typography.swift` also registers fonts programmatically at launch as a fallback.

### 4. Build and run

Build on the **iPhone 15 Pro** simulator or later. iOS 17 is the minimum deployment target.

---

## Architecture

```
ios/Shyama/
├── ShyamaApp.swift          App entry point; calls registerFonts()
├── Views/                   One folder per screen
│   ├── Welcome/             Splash + onboarding
│   ├── Home/                Main hub with ScanOrb
│   ├── Scan/                Camera capture (stub)
│   ├── Results/             Scan results display (stub)
│   ├── Ingredients/         Ingredient lookup (stub)
│   └── Map/                 Find a dermatologist nearby (stub)
├── Models/                  Pure Swift data structs
├── Services/                Business logic and integrations
│   └── MockPredictionService.swift
├── DesignSystem/
│   ├── Colors.swift         Color palette tokens
│   ├── Typography.swift     Font scale + registerFonts()
│   ├── Spacing.swift        Named spacing values
│   └── Components/
│       ├── SoftButton.swift Neumorphic button (standard + prominent)
│       ├── SoftCard.swift   Neumorphic container card
│       └── ScanOrb.swift    Main scan CTA with breathing animation
└── Resources/
    ├── Fonts/               TTF files (not committed — add after download)
    └── Assets.xcassets/     App icon, accent color
```

## Design Principles

- Minimalist soft-UI (restrained neumorphism) — shadows accent, never dominate
- WCAG AA contrast on all text
- Full Dynamic Type support via `relativeTo:` font sizing
- VoiceOver labels and hints on all interactive elements
- Reduce Motion respected in all animations
