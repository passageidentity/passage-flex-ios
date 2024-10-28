struct PasskeyCreationOptions {
    let authenticatorAttachment: AuthenticatorAttachment
    
    init(authenticatorAttachment: AuthenticatorAttachment = .platform) {
        self.authenticatorAttachment = authenticatorAttachment
    }
}
