import Foundation

@available(iOS 16.0, macOS 12.0, tvOS 16.0, visionOS 1.0, *)
internal struct PassagePasskeyAuthentication {
    
    internal static func register(
        with transactionId: String,
        authenticatorAttachment: AuthenticatorAttachment = .platform
    ) async throws -> String {
        // Get Passage App ID from Passage.plist
        let appId = try Utilities.getAppId()
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
        let registrationData = try Utilities.convertRegistrationStartResponse(startResponse)
        let authController = PasskeyAuthorizationController()
        let credential = try await authController.requestPasskeyRegistration(
            registrationData: registrationData
        )
        // Send the new Credential Handshake Response to Passage server
        let handshakeResponse = try Utilities.convertRegistrationCredential(credential)
        let finishRequest = RegisterWebAuthnFinishWithTransactionRequest(
            handshakeId: startResponse.handshake.id,
            handshakeResponse: handshakeResponse,
            transactionId: startRequest.transactionId
        )
        let finishResponse = try await RegisterAPI.registerWebauthnFinishWithTransaction(
            appId: appId,
            registerWebAuthnFinishWithTransactionRequest: finishRequest
        )
        // If successful, Passage server will return a nonce.
        return finishResponse.nonce
    }

    internal static func authenticate(with transactionId: String? = nil) async throws -> String {
        // Get Passage App ID from Passage.plist
        let appId = try Utilities.getAppId()
        // Request an Assertion Start Handshake from Passage server
        let startRequest = AuthenticateWebAuthnStartWithTransactionRequest(
            transactionId: transactionId
        )
        let startResponse = try await AuthenticateAPI.authenticateWebauthnStartWithTransaction(
            appId: appId,
            authenticateWebAuthnStartWithTransactionRequest: startRequest
        )
        // Use the Assertion Start Handshake to prompt the app user to select a passkey
        let assertionData = try Utilities.convertAuthenticationStartResponse(startResponse)
        let authController = PasskeyAuthorizationController()
        let credential = try await authController.requestPasskeyAssertion(
            assertionData: assertionData
        )
        // Send the Credential Handshake Response to Passage server
        let handshakeResponse = try Utilities.convertAssertionCredential(credential)
        let finishRequest = AuthenticateWebAuthnFinishWithTransactionRequest(
            handshakeId: startResponse.handshake.id,
            handshakeResponse: handshakeResponse,
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
        completion: @escaping (String?, Error?) -> Void
    ) {
        Task {
            do {
                // Get Passage App ID from Passage.plist
                let appId = try Utilities.getAppId()
                // Request an Assertion Start Handshake from Passage server
                let startRequest = AuthenticateWebAuthnStartWithTransactionRequest()
                let startResponse = try await AuthenticateAPI
                    .authenticateWebauthnStartWithTransaction(
                        appId: appId,
                        authenticateWebAuthnStartWithTransactionRequest: startRequest
                    )
                // Use the Assertion Start Handshake to prompt the app user to select the
                // passkey provided in the keyboard autofill.
                let assertionData = try Utilities
                    .convertAuthenticationStartResponse(startResponse)
                let authController = PasskeyAuthorizationController()
                
                // TODO: Check for memory leak here if operation never completes.
                let credential = try await authController
                    .requestPasskeyAssertionAutoFill(
                        assertionData: assertionData,
                        window: window
                    )
                
                // Send the Credential Handshake Response to Passage server
                let handshakeResponse = try Utilities.convertAssertionCredential(credential)
                let finishRequest = AuthenticateWebAuthnFinishWithTransactionRequest(
                    handshakeId: startResponse.handshake.id,
                    handshakeResponse: handshakeResponse
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
