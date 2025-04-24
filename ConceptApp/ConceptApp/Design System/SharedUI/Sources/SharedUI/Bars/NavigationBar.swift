import MelonUI
import SwiftUI

public struct NavigationBar<Content: View, LeadingBar: View>: View {
    private let title: String.LocalizationValue
    private let bundle: Bundle?

    private let content: Content
    private let leadingBar: LeadingBar

    public var body: some View {
        VStack(spacing: .zero) {
            MLNMarkdownText(separator: .empty, .text(title, bundle: bundle))
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .overlay(alignment: .leading) {
                    leadingBar
                        .padding(.leading, 16)
                }

            content
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }

    public init(
        title: String.LocalizationValue,
        bundle: Bundle? = nil,
        @ViewBuilder content: () -> Content,
        @ViewBuilder leadingBarItem leadingBar: () -> LeadingBar = { EmptyView() }
    ) {
        self.title = title
        self.bundle = bundle
        self.content = content()
        self.leadingBar = leadingBar()
    }
}

#Preview {
    NavigationBar(title: "Shrek") {
        Color.red
    } leadingBarItem: {
        Button("Back") { }
    }
}

