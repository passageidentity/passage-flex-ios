import Foundation

@available(iOS 16.0, macOS 12.0, tvOS 16.0, visionOS 1.0, *)
internal struct PassagePasskeyAuthentication {
    
    internal static func register(
        with transactionId: String,
        authenticatorAttachment: AuthenticatorAttachment = .platform,
        appId: String
    ) async throws -> String {
        // Request a Registration Start Handshake from Passage server
        let startRequest = RegisterWebAuthnStartWithTransactionRequest(
            transactionId: transactionId,
            authenticatorAttachment: authenticatorAttachment
        )
        let startResponse = try await RegisterAPI.registerWebauthnStartWithTransaction(
            appId: appId,
            registerWebAuthnStartWithTransactionRequest: startRequest
        )
        // Use the Registration Start Handshake to prompt the app user to create a passkey
        let registrationRequest = try PasskeyRegistrationRequest.from(startResponse)
        let authController = PasskeyAuthorizationController()
        let credential = try await authController.requestPasskeyRegistration(
            registrationRequest: registrationRequest,
            includeSecurityKeyOption: authenticatorAttachment == .crossPlatform
        )
        // Send the new Credential Handshake Response to Passage server
        let finishRequest = RegisterWebAuthnFinishWithTransactionRequest(
            handshakeId: startResponse.handshake.id,
            handshakeResponse: credential.response(),
            transactionId: startRequest.transactionId
        )
        let finishResponse = try await RegisterAPI.registerWebauthnFinishWithTransaction(
            appId: appId,
            registerWebAuthnFinishWithTransactionRequest: finishRequest
        )
        // If successful, Passage server will return a nonce.
        return finishResponse.nonce
    }

    internal static func authenticate(
        with transactionId: String? = nil,
        appId: String
    ) async throws -> String {
        // Request an Assertion Start Handshake from Passage server
        let startRequest = AuthenticateWebAuthnStartWithTransactionRequest(
            transactionId: transactionId
        )
        let startResponse = try await AuthenticateAPI.authenticateWebauthnStartWithTransaction(
            appId: appId,
            authenticateWebAuthnStartWithTransactionRequest: startRequest
        )
        // Use the Assertion Start Handshake to prompt the app user to select a passkey
        let assertionRequest = try PasskeyAssertionRequest.from(startResponse)
        let authController = PasskeyAuthorizationController()
        let credential = try await authController.requestPasskeyAssertion(
            assertionRequest: assertionRequest
        )
        // Send the Credential Handshake Response to Passage server
        let finishRequest = AuthenticateWebAuthnFinishWithTransactionRequest(
            handshakeId: startResponse.handshake.id,
            handshakeResponse: credential.response(),
            transactionId: transactionId
        )
        let finishResponse = try await AuthenticateAPI.authenticateWebauthnFinishWithTransaction(
            appId: appId,
            authenticateWebAuthnFinishWithTransactionRequest: finishRequest
        )
        // If successful, Passage server will return a nonce.
        return finishResponse.nonce
    }
    
    internal static func requestAutoFill(
        in window: PasskeyAutoFillWindow,
        appId: String,
        completion: @escaping (String?, Error?) -> Void
    ) {
        Task {
            do {
                // Request an Assertion Start Handshake from Passage server
                let startRequest = AuthenticateWebAuthnStartWithTransactionRequest()
                let startResponse = try await AuthenticateAPI
                    .authenticateWebauthnStartWithTransaction(
                        appId: appId,
                        authenticateWebAuthnStartWithTransactionRequest: startRequest
                    )
                // Use the Assertion Start Handshake to prompt the app user to select the
                // passkey provided in the keyboard autofill.
                let assertionRequest = try PasskeyAssertionRequest.from(startResponse)
                let authController = PasskeyAuthorizationController()
                let credential = try await authController
                    .requestPasskeyAssertionAutoFill(
                        assertionRequest: assertionRequest,
                        window: window
                    )
                // Send the Credential Handshake Response to Passage server
                let finishRequest = AuthenticateWebAuthnFinishWithTransactionRequest(
                    handshakeId: startResponse.handshake.id,
                    handshakeResponse: credential.response()
                )
                let finishResponse = try await AuthenticateAPI
                    .authenticateWebauthnFinishWithTransaction(
                        appId: appId,
                        authenticateWebAuthnFinishWithTransactionRequest: finishRequest
                    )
                // If successful, Passage server will return a nonce.
                completion(finishResponse.nonce, nil)
            } catch {
                completion(nil, error)
            }
        }
    }
    
}
