import MelonKit

@MainActor
public struct PostEvents {
    public typealias FeedbackAction = (MLNHapticFeedback.FeedbackType) -> Void

    let onHapticFeedback: FeedbackAction
    let onBackButtonTap: () -> Void

    public init(
        onHapticFeedback: @escaping FeedbackAction,
        onBackButtonTap: @escaping () -> Void
    ) {
        self.onHapticFeedback = onHapticFeedback
        self.onBackButtonTap = onBackButtonTap
    }
}
