import Foundation

public enum ScreenState {
    case loading
    case connectionError
    case loadingError
    case loaded
}

@MainActor
public protocol ScreenStateable: AnyObject {
    var state: ScreenState { get }
}
