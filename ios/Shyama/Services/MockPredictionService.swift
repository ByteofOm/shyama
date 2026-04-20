import UIKit

// MARK: - Protocol

protocol PredictionService {
    func predict(image: UIImage) async throws -> [ScanResult]
}

// MARK: - Mock implementation

struct MockPredictionService: PredictionService {
    func predict(image: UIImage) async throws -> [ScanResult] {
        // Simulate on-device inference latency
        try await Task.sleep(nanoseconds: 2_000_000_000)

        return [
            ScanResult(
                id: UUID(),
                conditionName: "Post-inflammatory hyperpigmentation",
                confidence: 0.82,
                briefDescription: "Dark spots or patches that commonly appear after skin inflammation or injury. Very common across deeper skin tones and often fade gradually with consistent sun protection and gentle skincare.",
                whenToSeeDermatologist: "Please consult a licensed dermatologist for personalized guidance. If spots are rapidly changing in size or color, becoming raised, or not fading after several months of consistent care, schedule an appointment promptly."
            ),
            ScanResult(
                id: UUID(),
                conditionName: "Seborrheic dermatitis",
                confidence: 0.67,
                briefDescription: "A common condition associated with scaly patches, redness, and persistent flaking. It tends to affect oily areas such as the scalp, face, and chest, and can flare with stress or seasonal changes.",
                whenToSeeDermatologist: "A licensed dermatologist can confirm this and recommend appropriate care. Seek professional evaluation sooner if the condition spreads, becomes painful, or does not improve with gentle cleansing over two to four weeks."
            ),
            ScanResult(
                id: UUID(),
                conditionName: "Folliculitis",
                confidence: 0.54,
                briefDescription: "Inflammation of hair follicles that may appear as small red bumps or white-headed pimples. It is commonly associated with bacterial or fungal activity, friction, or occlusion of the follicle.",
                whenToSeeDermatologist: "Consult a licensed dermatologist if bumps are spreading, painful, or persist beyond two weeks. Seek urgent care immediately if you notice fever, significant swelling, warmth spreading from the area, or any discharge."
            )
        ]
    }
}
