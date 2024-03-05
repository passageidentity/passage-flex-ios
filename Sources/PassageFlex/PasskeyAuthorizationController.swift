import AuthenticationServices

@available(iOS 16.0, *)
@available(macOS 12.0, *)
@available(tvOS 16.0, *)
internal class PasskeyAuthorizationController:
    NSObject,
    ASAuthorizationControllerDelegate,
    ASAuthorizationControllerPresentationContextProviding
{
    
    private typealias RegistrationCredentialContinuation = CheckedContinuation<
        ASAuthorizationPlatformPublicKeyCredentialRegistration,
        Error
    >
    
    private typealias AssertionCredentialContinuation = CheckedContinuation<
        ASAuthorizationPlatformPublicKeyCredentialAssertion,
        Error
    >
    
    private var registrationCredentialContinuation: RegistrationCredentialContinuation?
    
    private var assertionCredentialContinuation: AssertionCredentialContinuation?
    
    private var passkeyAutoFillWindow: PasskeyAutoFillWindow?
    
    internal func requestPasskeyRegistration(
        relyingPartyIdentifier: String,
        challenge: Data,
        userName: String,
        userId: String
    ) async throws -> ASAuthorizationPlatformPublicKeyCredentialRegistration {
        let publicKeyCredentialProvider = ASAuthorizationPlatformPublicKeyCredentialProvider(
            relyingPartyIdentifier: relyingPartyIdentifier
        )
        let registrationRequest = publicKeyCredentialProvider
            .createCredentialRegistrationRequest(
                challenge: challenge,
                name: userName,
                userID: Data(userId.utf8)
            )
        let authController = ASAuthorizationController(
            authorizationRequests: [ registrationRequest ]
        )
        authController.delegate = self
        authController.performRequests()
        return try await withCheckedThrowingContinuation(
            { [weak self] (continuation: RegistrationCredentialContinuation) in
                self?.registrationCredentialContinuation = continuation
            }
        )
    }
    
    internal func requestPasskeyAssertion(
        relyingPartyIdentifier: String,
        challenge: Data,
        credentialId: ASAuthorizationPlatformPublicKeyCredentialDescriptor? = nil
    ) async throws -> ASAuthorizationPlatformPublicKeyCredentialAssertion {
        let publicKeyCredentialProvider = ASAuthorizationPlatformPublicKeyCredentialProvider(
            relyingPartyIdentifier: relyingPartyIdentifier
        )
        let assertionRequest = publicKeyCredentialProvider
            .createCredentialAssertionRequest(
                challenge: challenge
            )
        if let credentialId {
            assertionRequest.allowedCredentials = [credentialId]
        }
        let authController = ASAuthorizationController(
            authorizationRequests: [ assertionRequest ]
        )
        authController.delegate = self
        authController.performRequests()
        return try await withCheckedThrowingContinuation(
            { [weak self] (continuation: AssertionCredentialContinuation) in
                self?.assertionCredentialContinuation = continuation
            }
        )
    }
    
    internal func requestPasskeyAssertionAutoFill (
        relyingPartyIdentifier: String,
        challenge: Data,
        window: PasskeyAutoFillWindow
    ) async throws -> ASAuthorizationPlatformPublicKeyCredentialAssertion {
        let publicKeyCredentialProvider = ASAuthorizationPlatformPublicKeyCredentialProvider(
            relyingPartyIdentifier: relyingPartyIdentifier
        )
        let assertionRequest = publicKeyCredentialProvider
            .createCredentialAssertionRequest(
                challenge: challenge
            )
        let authController = ASAuthorizationController(
            authorizationRequests: [ assertionRequest ]
        )
        authController.delegate = self
        authController.presentationContextProvider = self
        passkeyAutoFillWindow = window
        authController.performAutoFillAssistedRequests()
        return try await withCheckedThrowingContinuation(
            { [weak self] (continuation: AssertionCredentialContinuation) in
                self?.assertionCredentialContinuation = continuation
            }
        )
    }
    
    // MARK: ASAuthorizationControllerDelegate Methods
    
    internal func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithAuthorization authorization: ASAuthorization
    ) {
        switch authorization.credential {
        case let registrationCredential as ASAuthorizationPlatformPublicKeyCredentialRegistration:
            registrationCredentialContinuation?.resume(returning: registrationCredential)
        case let assertionCredential as ASAuthorizationPlatformPublicKeyCredentialAssertion:
            assertionCredentialContinuation?.resume(returning: assertionCredential)
        default:
            ()
        }
    }
    
    internal func authorizationController(
        controller: ASAuthorizationController,
        didCompleteWithError error: Error
    ) {
        var passageError = PassagePasskeyAuthorizationError.unknown
        if let authError = error as? ASAuthorizationError {
            if authError.code == .canceled {
                passageError = .userCanceled
            } else if authError.code == .failed {
                passageError = .failed
            }
        }
        assertionCredentialContinuation?.resume(throwing: passageError)
    }
    
    // MARK: - ASAuthorizationControllerPresentationContextProviding Methods
    
    internal func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return passkeyAutoFillWindow ?? PasskeyAutoFillWindow()
    }
    
}
