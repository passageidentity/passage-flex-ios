/// The base struct for utilizing Apple's native passkey APIs and Passage Flex APIs together.
public class PassageFlexPasskey {
    
    private let appId: String
    
    public init(appId: String) {
        self.appId = appId
    }
    
    /// Checks if the user's device supports passkeys.
    public let isSupported = Utilities.deviceOSSupportsPasskeys
    
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
    /// `PassageConfigurationError` when there was a problem with your app's configuration.
    @available(iOS 16.0, macOS 12.0, tvOS 16.0, visionOS 1.0, *)
    public func register(
        with transactionId: String,
        authenticatorAttachment: AuthenticatorAttachment = .platform
    ) async throws -> String {
        let nonce = try await PassagePasskeyAuthentication.register(
            with: transactionId,
            authenticatorAttachment: authenticatorAttachment,
            appId: appId
        )
        return nonce
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
    /// `PassageConfigurationError` when there was a problem with your app's configuration.
    @available(iOS 16.0, macOS 12.0, tvOS 16.0, visionOS 1.0, *)
    public func authenticate(with transactionId: String? = nil) async throws -> String {
        let nonce = try await PassagePasskeyAuthentication.authenticate(
            with: transactionId,
            appId: appId
        )
        return nonce
    }
    
    /// Initiaties a request for passkey AutoFill.
    ///
    /// Call this method on initial view load. When the user taps your designated UITextField, the AutoFill passkey suggestion
    /// will appear (if the user has a passkey). To designate a UITextField, set its `textContentType` to `username`.
    ///
    /// - Parameters:
    ///   - window: The window where the passkey autofill takes place. Required as an anchor for Apple UI.
    ///   - completion: Your completion handler. On success, should accept a String for the nonce value.
    ///   On failure, should catch thrown error.
    @available(iOS 16.0, macOS 12.0, tvOS 16.0, visionOS 1.0, *)
    public func requestAutoFill(in window: PasskeyAutoFillWindow, completion: @escaping (String?, Error?) -> Void) {
        PassagePasskeyAuthentication.requestAutoFill(
            in: window,
            appId: appId,
            completion: completion
        )
    }
    
}
