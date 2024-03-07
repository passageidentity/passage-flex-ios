import Foundation

public struct PassageFlex {
    
    public struct Passkey {
        
        public static let isSupported = Utilities.deviceOSSupportsPasskeys
        
        @available(iOS 16.0, *)
        public static func register(
            with transactionId: String,
            authenticatorAttachment: AuthenticatorAttachment? = nil
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
        
        @available(iOS 16.0, *)
        public static func authenticate(with transactionId: String? = nil) async throws -> String {
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
        
        public static func requestAutoFill(in window: PasskeyAutoFillWindow, completion: @escaping (String?, Error?) -> Void) {
            do {
                let appId = try Utilities.getAppId()
                Task {
                    // let challenge = POST /v1/apps/{app_id}/register/transactions/authenticate/start WITHOUT transactionId
                    // let handshake = PasskeyService.registrationRequest(challenge)
                }
            } catch {
                completion(nil, error)
            }
        }
        
    }
    
}
