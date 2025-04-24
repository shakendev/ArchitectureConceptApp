import MelonKit

public final class BasicHapticFeedback<FeedbackGenerator: MLNHapticFeedbackGeneratable>: MLNHapticFeedbackGeneratable {
    private let generator: FeedbackGenerator
    private var isEnabled = true

    public init(generator: FeedbackGenerator) {
        self.generator = generator
    }

    public func enable() { isEnabled = true }
    public func disable() { isEnabled = false }

    public func generate(with feedbackType: MLNHapticFeedback.FeedbackType) {
        guard isEnabled else { return }

        generator.generate(with: feedbackType)
    }
}
