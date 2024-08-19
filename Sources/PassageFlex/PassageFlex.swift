import Foundation

/// Use `PassageFlex` to easily add passkeys to your existing authentication system on Apple devices.
///
/// Find out more at: https://passage.1password.com
public class PassageFlex {
    
    private let appId: String
    /// PassageFlexPasskey utilitzes Apple's native passkey APIs and Passage Flex APIs together.
    public let passkey: PassageFlexPasskey
    
    public init(appId: String) {
        self.appId = appId
        self.passkey = PassageFlexPasskey(appId: appId)
    }
    
}
