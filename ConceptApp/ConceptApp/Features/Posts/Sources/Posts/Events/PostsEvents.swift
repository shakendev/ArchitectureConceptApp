import MelonKit

@MainActor
public struct PostsEvents {
    public typealias FeedbackAction = (MLNHapticFeedback.FeedbackType) -> Void

    let onHapticFeedback: FeedbackAction
    let onPostButtonTap: (Int) -> Void

    public init(
        onHapticFeedback: @escaping FeedbackAction,
        onPostButtonTap: @escaping (Int) -> Void
    ) {
        self.onHapticFeedback = onHapticFeedback
        self.onPostButtonTap = onPostButtonTap
    }
}
