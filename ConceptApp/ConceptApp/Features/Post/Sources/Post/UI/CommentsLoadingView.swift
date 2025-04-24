import SwiftUI

struct CommentsLoadingView: View {
    var body: some View {
        ProgressView()
            .progressViewStyle(.circular)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
