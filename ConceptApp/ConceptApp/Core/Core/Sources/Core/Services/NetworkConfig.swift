// MARK: Import section

import MelonKit



// MARK: - NetworkConfig

public final class NetworkConfig: MLNNetworkConfiguration {
    // This line is changed by a script for each of the existing project schemes, except for the Periphery scheme
    // See more in Config Shell Scripts folder
    public override var prefix: StaticString { "jsonplaceholder" }
    public override var name: StaticString { "typicode" }
    public override var domain: StaticString { "com" }
}
