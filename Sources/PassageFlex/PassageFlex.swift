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
        
        public static func authenticate(with transactionId: String? = nil) async throws -> String {
            let appId = try Utilities.getAppId()
            // let challenge = POST /v1/apps/{app_id}/register/transactions/authenticate/start with transactionId
            // let credentialId = method for parsing challenge for credential id
            // let handshake = PasskeyService.assertionRequest(challenge)
            // let result = POST /v1/apps/{app_id}/register/transactions/authenticate/finish with handshake
            // return result.nonce
            return ""
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
