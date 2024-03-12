import AuthenticationServices

@available(iOS 16.0, macOS 12.0, tvOS 16.0, visionOS 1.0, *)
extension ASAuthorizationPlatformPublicKeyCredentialAssertion {
    
    /// Converts assertion credential into a handshake response formatted for Passage webauthn finish request.
    ///
    /// - Returns: CredentialAssertionResponse
    internal func response() -> CredentialAssertionResponse {
        let response = CredentialAssertionResponseResponse(
            authenticatorData: rawAuthenticatorData.base64EncodedString(),
            clientDataJSON: rawClientDataJSON.base64EncodedString(),
            signature: signature.base64EncodedString(),
            userHandle: userID.base64EncodedString()
        )
        let credentialId = credentialID.encodeBase64UrlSafeString()
        return CredentialAssertionResponse(
            id: credentialId,
            rawId: credentialId,
            response: response,
            type: "public-key"
        )
    }
    
}
