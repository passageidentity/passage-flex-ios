public struct PasskeyCreationOptions {
    public let authenticatorAttachment: AuthenticatorAttachment
    
    public init(authenticatorAttachment: AuthenticatorAttachment = .platform) {
        self.authenticatorAttachment = authenticatorAttachment
    }
}
