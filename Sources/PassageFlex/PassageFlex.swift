import Foundation

public struct PassageFlex {
    
    public struct Passkey {
        
        public static let isSupported = Utilities.deviceOSSupportsPasskeys
        
        public static func register(with transactionId: String) async throws -> String {
            let appId = try Utilities.getAppId()
            // let challenge = POST /v1/apps/{app_id}/register/transactions/webauthn/start with transactionId
            // let handshake = ASAuthController.registrationRequest(challenge)
            // let result = POST /v1/apps/{app_id}/register/transactions/webauthn/finish with handshake
            // return result.nonce
            return ""
        }
        
        public static func authenticate(with transactionId: String? = nil) async throws -> String {
            let appId = try Utilities.getAppId()
            // let challenge = POST /v1/apps/{app_id}/register/transactions/authenticate/start with transactionId
            // let handshake = ASAuthController.assertionRequest(challenge)
            // let result = POST /v1/apps/{app_id}/register/transactions/authenticate/finish with handshake
            // return result.nonce
            return ""
        }
        
    }
    
}
