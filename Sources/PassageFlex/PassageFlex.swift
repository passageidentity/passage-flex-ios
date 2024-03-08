import Foundation

/// Use `PassageFlex` to easily add passkeys to your existing authentication system on Apple devices.
public struct PassageFlex {
    
    /// The base struct for utilizing Apple's native passkey APIs and Passage Flex APIs together.
    public struct Passkey {
        
        /// Checks if the user's device supports passkeys.
        public static let isSupported = Utilities.deviceOSSupportsPasskeys
        
        
        /// Registers a new passkey.
        ///
        /// Prompts the user associated with the provided Passage `transactionId` to create and register a new
        /// passkey for use with your app.
        ///
        /// - Parameters:
        ///   - transactionId: The Passage transaction id provided by your app's server.
        ///   - authenticatorAttachment: (Optional) The type of authentication that will be used in this
        ///   WebAuthN flow request. Defaults to `.platform`. Use `.cross-platform` for physical security
        ///   key registration.
        ///
        /// - Returns: A single-use "nonce" from Passage server to be exchanged for an authentication token on
        /// your app's server.
        ///
        /// - Throws: `PassagePasskeyAuthorizationError` when Apple passkey authorization fails.
        /// `PassageRegisterPasskeyServerError` when the Passage server returns an error.
        /// `PassageConfigurationError` when there was a problem with you app's configuration.
        @available(iOS 16.0, *)
        public static func register(
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
        
        /// Authenticates with a passkey.
        ///
        /// Prompts the user to select a passkey for authentication for your app. If a Passage `transactionId` is provided,
        /// this method will attempt to show only passkeys associated with that user account.
        ///
        /// - Parameters:
        ///   - transactionId: (Optional) The Passage transaction id provided by your app's server.
        ///
        /// - Returns: A single-use "nonce" from Passage server to be exchanged for an authentication token on
        /// your app's server.
        ///
        /// - Throws: `PassagePasskeyAuthorizationError` when Apple passkey authorization fails.
        /// `PassageAuthenticatePasskeyServerError` when the Passage server returns an error.
        /// `PassageConfigurationError` when there was a problem with you app's configuration.
        @available(iOS 16.0, *)
        public static func authenticate(with transactionId: String? = nil) async throws -> String {
            let thing = try await Passkey.register(with: "")
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
