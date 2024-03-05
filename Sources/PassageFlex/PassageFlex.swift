import Foundation

public struct PassageFlex {
    
    public struct Passkey {
        
        public static let isSupported = Utilities.deviceOSSupportsPasskeys
        
        public static func register(with transactionId: String) async throws -> String {
            let appId = try Utilities.getAppId()
            // let challenge = POST /v1/apps/{app_id}/register/transactions/webauthn/start with transactionId
            // let handshake = PasskeyService.registrationRequest(challenge)
            // let result = POST /v1/apps/{app_id}/register/transactions/webauthn/finish with handshake
            // return result.nonce
            return ""
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
