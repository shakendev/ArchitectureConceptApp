import MelonUI
import SwiftUI

public struct BackgroundView<Content: View>: View {
    private let content: Content

    public var body: some View {
        MLNBackgroundView(color: .orange.opacity(0.5)) {
            content
        }
    }

    public init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
}
