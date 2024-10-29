import AuthenticationServices

@available(iOS 16.0, macOS 12.0, tvOS 16.0, visionOS 1.0, *)
internal class PasskeyAuthorizationController:
    NSObject,
    ASAuthorizationControllerDelegate
{
    
    private var registrationCredentialContinuation: RegistrationCredentialContinuation?
    
    private var assertionCredentialContinuation: AssertionCredentialContinuation?
    
    private var passkeyAutoFillWindow: PasskeyAutoFillWindow?
    
    internal func requestPasskeyRegistration(
        registrationRequest: PasskeyRegistrationRequest,
        includeSecurityKeyOption: Bool = false
    ) async throws -> ASAuthorizationPlatformPublicKeyCredentialRegistration {
        let publicKeyCredentialProvider = ASAuthorizationPlatformPublicKeyCredentialProvider(
            relyingPartyIdentifier: registrationRequest.relyingPartyIdentifier
        )
        let platformRegistrationRequest = publicKeyCredentialProvider
            .createCredentialRegistrationRequest(
                challenge: registrationRequest.challenge,
                name: registrationRequest.userName,
                userID: registrationRequest.userId
            )
        var requests: [ASAuthorizationRequest] = [ platformRegistrationRequest ]
       #if os(iOS) || os(macOS)
       if includeSecurityKeyOption {
           let securityKeyCredentialProvider = ASAuthorizationSecurityKeyPublicKeyCredentialProvider(
               relyingPartyIdentifier: registrationRequest.relyingPartyIdentifier
           )
           let securityKeyRegistrationRequest = securityKeyCredentialProvider
               .createCredentialRegistrationRequest(
                   challenge: registrationRequest.challenge,
                   displayName: registrationRequest.userName,
                   name: registrationRequest.userName,
                   userID: registrationRequest.userId
               )
           securityKeyRegistrationRequest.credentialParameters = [
               ASAuthorizationPublicKeyCredentialParameters(
                   algorithm: ASCOSEAlgorithmIdentifier.ES256
               )
           ]
           requests.append(securityKeyRegistrationRequest)
       }
       #endif
        let authController = ASAuthorizationController(authorizationRequests: requests)
        authController.delegate = self
        authController.presentationContextProvider = self
        authController.performRequests()
        return try await withCheckedThrowingContinuation(
            { [weak self] (continuation: RegistrationCredentialContinuation) in
                self?.registrationCredentialContinuation = continuation
            }
        )
    }
    
    internal func requestPasskeyAssertion(
        assertionRequest: PasskeyAssertionRequest
    ) async throws -> ASAuthorizationPlatformPublicKeyCredentialAssertion {
        let publicKeyCredentialProvider = ASAuthorizationPlatformPublicKeyCredentialProvider(
            relyingPartyIdentifier: assertionRequest.relyingPartyIdentifier
        )
        let authAssertionRequest = publicKeyCredentialProvider
            .createCredentialAssertionRequest(
                challenge: assertionRequest.challenge
            )
        // Setting `allowedCredentials` lets us specify which account the offered passkeys
        // should be tied to.
        // If this is not set, iOS will show all of the potential accounts' passkeys.
        if let credentialIds = assertionRequest.credentialIds {
            authAssertionRequest.allowedCredentials = credentialIds
        }
        let authController = ASAuthorizationController(
            authorizationRequests: [ authAssertionRequest ]
        )
        authController.delegate = self
        authController.performRequests()
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
    
}

@available(iOS 16.0, macOS 12.0, tvOS 16.0, visionOS 1.0, *)
extension PasskeyAuthorizationController:
    ASAuthorizationControllerPresentationContextProviding
{
    
    internal func requestPasskeyAssertionAutoFill (
        assertionRequest: PasskeyAssertionRequest,
        window: PasskeyAutoFillWindow
    ) async throws -> ASAuthorizationPlatformPublicKeyCredentialAssertion {
        let publicKeyCredentialProvider = ASAuthorizationPlatformPublicKeyCredentialProvider(
            relyingPartyIdentifier: assertionRequest.relyingPartyIdentifier
        )
        let authAssertionRequest = publicKeyCredentialProvider
            .createCredentialAssertionRequest(
                challenge: assertionRequest.challenge
            )
        let authController = ASAuthorizationController(
            authorizationRequests: [ authAssertionRequest ]
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
    
    // MARK: - ASAuthorizationControllerPresentationContextProviding Methods
    
    internal func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return passkeyAutoFillWindow ?? PasskeyAutoFillWindow()
    }
    
}
