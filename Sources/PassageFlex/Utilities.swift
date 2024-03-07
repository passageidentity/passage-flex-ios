import AuthenticationServices

internal struct Utilities {
    
    internal static var deviceOSSupportsPasskeys: Bool {
        #if os(iOS)
        if #available(iOS 16, *) {
            return true
        } else {
            return false
        }
        #elseif os(macOS)
        if #available(macOS 12.0, *) {
            return true
        } else {
            return false
        }
        #elseif os(tvOS)
        if #available(tvOS 16.0, *) {
            return true
        } else {
            return false
        }
        #else
        return false
        #endif
    }
    
    internal static func getAppId() throws -> String {
        guard
            let plistPath = Bundle.main.path(forResource: "Passage", ofType: "plist"),
            let plistData = FileManager.default.contents(atPath: plistPath)
        else {
            throw PassageConfigurationError.cannotFindPassagePlist
        }
        guard
            let plistContent = try? PropertyListSerialization
                .propertyList(from: plistData, format: nil) as? [String: Any],
            let appId = plistContent["appId"] as? String
        else {
            throw PassageConfigurationError.cannotFindAppId
        }
        return appId
    }
    
    internal static func convertRegistrationStartResponse(
        _ response: RegisterWebAuthnStartWithTransactionResponse
    ) throws -> PasskeyRegistrationData {
        guard
            let publicKey = response.handshake.challenge.publicKey,
            let rpId = publicKey.rp?.id,
            let challenge = publicKey.challenge?.decodeBase64UrlSafeString(),
            let user = publicKey.user,
            let userId = user.id,
            let userName = user.name
        else {
            // TODO: Better error
            throw PassagePasskeyAuthorizationError.unknown
        }
        return PasskeyRegistrationData(
            relyingPartyIdentifier: rpId,
            challenge: challenge,
            userName: userId,
            userId: Data(userId.utf8)
        )
    }
    
    @available(iOS 15.0, *)
    internal static func convertRegistrationCredential(
        _ credential: ASAuthorizationPlatformPublicKeyCredentialRegistration
    ) throws -> CredentialCreationResponse1 {
        let response = CredentialCreationResponseResponse(
            attestationObject: credential.rawAttestationObject?.encodeBase64UrlSafeString(),
            clientDataJSON: credential.rawClientDataJSON.encodeBase64UrlSafeString()
        )
        let credentialId = credential.credentialID.encodeBase64UrlSafeString()
        return CredentialCreationResponse1(
            id: credentialId,
            rawId: credentialId,
            response: response,
            type: "public-key"
        )
    }
    
}

extension String {
    func decodeBase64UrlSafeString() -> Data? {
        var base64 = self
            .replacingOccurrences(of: "-", with: "+")
            .replacingOccurrences(of: "_", with: "/")
        if base64.count % 4 != 0 {
            base64.append(
                String(repeating: "=", count: 4 - base64.count % 4)
            )
        }
        return Data(base64Encoded: base64)
    }
}

extension Data {
    func encodeBase64UrlSafeString() -> String {
        return self
            .base64EncodedString()
            .replacingOccurrences(of: "+", with: "-")
            .replacingOccurrences(of: "/", with: "_")
            .replacingOccurrences(of: "=", with: "")
    }
}
