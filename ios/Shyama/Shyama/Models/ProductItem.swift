import Foundation

struct ProductItem: Identifiable {
    let id = UUID()
    let brand: String
    let name: String
    let grade: String
    let score: Int
    let tags: [String]
    let tagCategory: ProductCategory
    let description: String
    let ingredients: [ProductIngredient]
}

struct ProductIngredient: Identifiable {
    let id = UUID()
    let name: String
    let grade: String
    let function_: String
    let isEDC: Bool
    let edcNote: String?
}

enum ProductCategory: String, CaseIterable {
    case forMe = "For me"
    case trending = "Trending"
    case new = "New"
    case melaninTested = "Melanin-tested"
}

// MARK: - Sample catalog

extension ProductItem {
    static let catalog: [ProductItem] = [topicalsFaded, fentyFatWater, eademMilkMarvel, breadHairOil, sheaMoistureElixir]

    static let topicalsFaded = ProductItem(
        brand: "Topicals",
        name: "Faded Serum",
        grade: "A",
        score: 94,
        tags: ["hyperpigmentation", "4c-safe", "fragrance-light"],
        tagCategory: .forMe,
        description: "Brightening serum with tranexamic acid, kojic acid, and niacinamide. Clinically tested on darker skin tones. Fades post-inflammatory hyperpigmentation without harsh bleaching agents.",
        ingredients: [
            .init(name: "Niacinamide", grade: "A", function_: "Brightening · barrier strengthener", isEDC: false, edcNote: nil),
            .init(name: "Tranexamic Acid", grade: "A", function_: "Gently fades dark marks · melanin-safe", isEDC: false, edcNote: nil),
            .init(name: "Kojic Acid", grade: "A−", function_: "Melanin-inhibiting brightener · mild", isEDC: false, edcNote: nil),
            .init(name: "Alpha Arbutin", grade: "A", function_: "Hydroquinone-free brightener · safer alternative", isEDC: false, edcNote: nil),
            .init(name: "Glycerin", grade: "A", function_: "Humectant · draws moisture to skin", isEDC: false, edcNote: nil),
            .init(name: "Centella Asiatica", grade: "A", function_: "Anti-inflammatory · barrier repair", isEDC: false, edcNote: nil),
            .init(name: "Phenoxyethanol", grade: "B", function_: "Preservative · within EU-safe limits", isEDC: false, edcNote: nil),
            .init(name: "Fragrance", grade: "C", function_: "Added scent · undisclosed mixture", isEDC: true, edcNote: "May mask phthalates — a class of hormone-disrupting chemicals. 'Fragrance' on a label can legally conceal 100+ untested compounds."),
        ]
    )

    static let fentyFatWater = ProductItem(
        brand: "Fenty Skin",
        name: "Fat Water Pore-Refining Toner Serum",
        grade: "A",
        score: 96,
        tags: ["fragrance-free", "deep skin", "toning"],
        tagCategory: .melaninTested,
        description: "Lightweight toner-serum hybrid with niacinamide and hyaluronic acid. Developed with diverse skin tones in mind and tested across skin tones 1–6.",
        ingredients: [
            .init(name: "Water", grade: "A", function_: "Solvent base", isEDC: false, edcNote: nil),
            .init(name: "Niacinamide", grade: "A", function_: "Pore-refining · brightening", isEDC: false, edcNote: nil),
            .init(name: "Hyaluronic Acid", grade: "A", function_: "Deep hydration · moisture retention", isEDC: false, edcNote: nil),
            .init(name: "Witch Hazel", grade: "B", function_: "Mild astringent · can be drying in excess", isEDC: false, edcNote: nil),
            .init(name: "Glycerin", grade: "A", function_: "Humectant · skin-identical", isEDC: false, edcNote: nil),
            .init(name: "Cassia Seed Extract", grade: "A", function_: "Brightening · traditional East Asian ingredient", isEDC: false, edcNote: nil),
            .init(name: "Lactic Acid", grade: "A−", function_: "Gentle AHA exfoliant · hydrating", isEDC: false, edcNote: nil),
            .init(name: "Sodium PCA", grade: "A", function_: "Natural moisturizing factor · dryness relief", isEDC: false, edcNote: nil),
        ]
    )

    static let eademMilkMarvel = ProductItem(
        brand: "Eadem",
        name: "Milk Marvel Dark Spot Serum",
        grade: "A",
        score: 93,
        tags: ["brightening", "melanin-safe", "science-backed"],
        tagCategory: .trending,
        description: "Founded by two WOC scientists specifically for skin of color. The Smart Melanin technology targets excess pigmentation without disrupting healthy melanin production.",
        ingredients: [
            .init(name: "Niacinamide", grade: "A", function_: "Brightening · pore-refining", isEDC: false, edcNote: nil),
            .init(name: "Vitamin C (Ascorbic Acid)", grade: "A−", function_: "Antioxidant brightener · can oxidize quickly", isEDC: false, edcNote: nil),
            .init(name: "Azelaic Acid", grade: "A", function_: "Hyperpigmentation · anti-inflammatory · rosacea-safe", isEDC: false, edcNote: nil),
            .init(name: "Ceramide NP", grade: "A", function_: "Barrier restoration · locks in moisture", isEDC: false, edcNote: nil),
            .init(name: "Squalane", grade: "A", function_: "Lightweight emollient · non-comedogenic", isEDC: false, edcNote: nil),
            .init(name: "Phenoxyethanol", grade: "B", function_: "Preservative · within safe limits", isEDC: false, edcNote: nil),
            .init(name: "Ethylhexylglycerin", grade: "B+", function_: "Co-preservative · low irritation risk", isEDC: false, edcNote: nil),
        ]
    )

    static let breadHairOil = ProductItem(
        brand: "Bread Beauty Supply",
        name: "Hair Oil — scalp + lengths",
        grade: "A−",
        score: 88,
        tags: ["locs-safe", "4C", "scalp"],
        tagCategory: .forMe,
        description: "Lightweight multi-use oil for scalp and lengths. Castor + rosemary core with a slip that doesn't build up on coily/kinky textures. Formulated without heavy silicones.",
        ingredients: [
            .init(name: "Castor Oil (Ricinus Communis)", grade: "A", function_: "Seals moisture · promotes scalp circulation", isEDC: false, edcNote: nil),
            .init(name: "Rosemary Extract", grade: "A", function_: "DHT-blocker · stimulates hair growth", isEDC: false, edcNote: nil),
            .init(name: "Jojoba Oil", grade: "A", function_: "Wax ester similar to sebum · sealing", isEDC: false, edcNote: nil),
            .init(name: "Argan Oil", grade: "A", function_: "Lightweight moisture · frizz control", isEDC: false, edcNote: nil),
            .init(name: "Fragrance", grade: "C", function_: "Scent blend", isEDC: true, edcNote: "Generic 'fragrance' labeling can conceal phthalates. Phthalates are linked to hormone disruption and are especially concerning with frequent scalp absorption."),
            .init(name: "Tocopherol (Vitamin E)", grade: "A", function_: "Antioxidant · preserves oil stability", isEDC: false, edcNote: nil),
        ]
    )

    static let sheaMoistureElixir = ProductItem(
        brand: "SheaMoisture",
        name: "100% Raw Shea Butter Elixir",
        grade: "B+",
        score: 84,
        tags: ["dry skin", "butter", "body"],
        tagCategory: .forMe,
        description: "Raw unrefined shea with vitamin E and argan. Heavy occlusive — best used as final seal over damp skin. Excellent for dry skin types including Ruby's profile.",
        ingredients: [
            .init(name: "Butyrospermum Parkii (Shea) Butter", grade: "A", function_: "Occlusive · deep moisture sealing", isEDC: false, edcNote: nil),
            .init(name: "Argania Spinosa (Argan) Oil", grade: "A", function_: "Emollient · lightweight conditioning", isEDC: false, edcNote: nil),
            .init(name: "Tocopherol", grade: "A", function_: "Vitamin E · antioxidant", isEDC: false, edcNote: nil),
            .init(name: "Parfum (Fragrance)", grade: "C", function_: "Scent", isEDC: true, edcNote: "Parfum/Fragrance is a regulatory loophole — companies may use it to list hundreds of compounds as one ingredient. Common hidden EDCs: phthalates, musks, benzophenone."),
            .init(name: "Cetyl Alcohol", grade: "B+", function_: "Fatty alcohol · thickener · non-drying", isEDC: false, edcNote: nil),
        ]
    )
}
