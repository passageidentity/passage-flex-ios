import AuthenticationServices

@available(iOS 16.0, *)
@available(macOS 12.0, *)
@available(tvOS 16.0, *)
internal class PasskeyController: NSObject, ASAuthorizationControllerDelegate {
    
    private typealias RegistrationCheckedThrowingContinuation = CheckedContinuation<
        ASAuthorizationPlatformPublicKeyCredentialRegistration,
        Error
    >
    
    private typealias AssertionCheckedThrowingContinuation = CheckedContinuation<
        ASAuthorizationPlatformPublicKeyCredentialAssertion,
        Error
    >
    
    private var registrationCheckedThrowingContinuation: RegistrationCheckedThrowingContinuation?
    
    private var assertionThrowingContinuation: AssertionCheckedThrowingContinuation?
    
    internal func registerPasskey(
        handshake: String
    ) async throws -> ASAuthorizationPlatformPublicKeyCredentialRegistration {
        let rpId = ""
        let publicKeyCredentialProvider = ASAuthorizationPlatformPublicKeyCredentialProvider(
            relyingPartyIdentifier: rpId
        )
        let challenge = ""
        let userId = ""
        let decodedChallenge = Data()
        let registrationRequest = publicKeyCredentialProvider
            .createCredentialRegistrationRequest(
                challenge: decodedChallenge,
                name: "",
                userID: Data(userId.utf8)
            )
        let authController = ASAuthorizationController(
            authorizationRequests: [ registrationRequest ]
        )
        authController.delegate = self
        return try await withCheckedThrowingContinuation(
            { [weak self] (continuation: RegistrationCheckedThrowingContinuation) in
                guard let self = self else {
                    return
                }
                self.registrationCheckedThrowingContinuation = continuation
            }
        )
    }
    
    internal func assertPasskey(
        handshake: String
    ) async throws -> ASAuthorizationPlatformPublicKeyCredentialAssertion {
        let rpId = ""
        let publicKeyCredentialProvider = ASAuthorizationPlatformPublicKeyCredentialProvider(
            relyingPartyIdentifier: rpId
        )
        let challenge = ""
        let decodedChallenge = Data()
        let assertionRequest = publicKeyCredentialProvider
            .createCredentialAssertionRequest(
                challenge: decodedChallenge
            )
        let authController = ASAuthorizationController(
            authorizationRequests: [ assertionRequest ]
        )
        authController.delegate = self
        authController.performRequests()

        return try await withCheckedThrowingContinuation(
            { [weak self] (continuation: AssertionCheckedThrowingContinuation) in
                guard let self = self else {
                    return
                }
                self.assertionThrowingContinuation = continuation
            }
        )
    }
    
    // MARK: ASAuthorizationControllerDelegate Methods
    
    internal func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        
    }
    
    internal func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        
    }
    
}
