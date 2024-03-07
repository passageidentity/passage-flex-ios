import AuthenticationServices

internal struct PasskeyRegistrationData {
    let relyingPartyIdentifier: String
    let challenge: Data
    let userName: String
    let userId: Data
}

@available(iOS 16.0, *)
internal struct PasskeyAssertionData {
    let relyingPartyIdentifier: String
    let challenge: Data
    let credentialIds: [ASAuthorizationPlatformPublicKeyCredentialDescriptor]?
}

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
        registrationData: PasskeyRegistrationData
    ) async throws -> ASAuthorizationPlatformPublicKeyCredentialRegistration {
        let publicKeyCredentialProvider = ASAuthorizationPlatformPublicKeyCredentialProvider(
            relyingPartyIdentifier: registrationData.relyingPartyIdentifier
        )
        let registrationRequest = publicKeyCredentialProvider
            .createCredentialRegistrationRequest(
                challenge: registrationData.challenge,
                name: registrationData.userName,
                userID: registrationData.userId
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
        assertionData: PasskeyAssertionData
    ) async throws -> ASAuthorizationPlatformPublicKeyCredentialAssertion {
        let publicKeyCredentialProvider = ASAuthorizationPlatformPublicKeyCredentialProvider(
            relyingPartyIdentifier: assertionData.relyingPartyIdentifier
        )
        let assertionRequest = publicKeyCredentialProvider
            .createCredentialAssertionRequest(
                challenge: assertionData.challenge
            )
        // Setting `allowedeCredentials` lets us specify which account the offered passkeys
        // should be tied to.
        // If this is not set, iOS will show all of the potential accounts' passkeys.
        if let credentialIds = assertionData.credentialIds {
            assertionRequest.allowedCredentials = credentialIds
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
