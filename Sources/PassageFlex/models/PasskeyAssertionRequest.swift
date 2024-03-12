import AuthenticationServices

@available(iOS 16.0, macOS 12.0, tvOS 16.0, visionOS 1.0, *)
internal struct PasskeyAssertionRequest {
    let relyingPartyIdentifier: String
    let challenge: Data
    let credentialIds: [ASAuthorizationPlatformPublicKeyCredentialDescriptor]?
    
    /// Converts a Passage webauthn start response into a passkey assertion request to provide to OS.
    ///
    /// - Parameter response: Response from calling Passage webauthn start with transaction id.
    ///
    /// - Returns: DTO for prompting user to authenticate with a passkey.
    internal static func from(
        _ response: AuthenticateWebAuthnStartWithTransactionResponse
    ) throws -> PasskeyAssertionRequest {
        let publicKey = response.handshake.challenge.publicKey
        let credentialIds = publicKey.allowCredentials?
            .compactMap { $0.id.decodeBase64UrlSafeString() }
            .map { ASAuthorizationPlatformPublicKeyCredentialDescriptor(
                credentialID: $0
            ) }
        guard
            let rpId = publicKey.rpId,
            let challenge = publicKey.challenge.decodeBase64UrlSafeString()
        else {
            throw PassagePasskeyAuthorizationError.webauthnError
        }
        return PasskeyAssertionRequest(
            relyingPartyIdentifier: rpId,
            challenge: challenge,
            credentialIds: credentialIds)
    }
    
}
