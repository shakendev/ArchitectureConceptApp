import MelonKit

@MainActor
public struct CommentsEvents {
    public typealias FeedbackAction = (MLNHapticFeedback.FeedbackType) -> Void

    let onHapticFeedback: FeedbackAction

    public init(onHapticFeedback: @escaping FeedbackAction) {
        self.onHapticFeedback = onHapticFeedback
    }
}
