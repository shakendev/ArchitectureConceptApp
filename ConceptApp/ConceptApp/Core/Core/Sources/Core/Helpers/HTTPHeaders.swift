import MelonKit

@MainActor
public enum HTTPHeaders {
    public static let clientSource = MLNNetworkManager.HTTPHeader.xClientSource("ios-app")
    public static let contentType = MLNNetworkManager.HTTPHeader.contentType("application/json")
}
