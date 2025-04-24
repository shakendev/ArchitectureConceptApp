import SwiftUI

public struct LoadingErrorView: View {
    public typealias Action = () -> Void

    private let action: Action

    public var body: some View {
        VStack(spacing: 50) {
            VStack(spacing: 10) {
                Text("Loading Error")
                    .bold()

                Text("Please, try update this page later...")
            }

            Button(action: action) {
                Text("Update")
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }

    public init(action: @escaping Action) {
        self.action = action
    }
}
