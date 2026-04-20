import Foundation

struct ScanResult: Identifiable {
    let id: UUID
    /// Human-readable name of the possible skin condition.
    let conditionName: String
    /// Model confidence score in range 0.0–1.0.
    let confidence: Double
    /// Plain-language educational description. Never diagnostic framing — see docs/language-hygiene.md.
    let briefDescription: String
    /// Guidance on when to seek professional care. Always references a licensed dermatologist.
    let whenToSeeDermatologist: String
}
