import SwiftUI

public struct ConnectionErrorView: View {
    public typealias Action = () -> Void

    private let action: Action

    public var body: some View {
        VStack(spacing: 50) {
            VStack(spacing: 10) {
                Text("Connection Error")
                    .bold()

                Text("Please, check ur connection & try update this page later...")
            }

            Button(action: action) {
                Text("Update")
            }
            .buttonStyle(.borderedProminent)
        }
    }

    public init(action: @escaping Action) {
        self.action = action
    }
}
