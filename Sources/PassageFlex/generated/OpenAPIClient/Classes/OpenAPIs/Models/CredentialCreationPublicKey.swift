//
// CredentialCreationPublicKey.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct CredentialCreationPublicKey: Codable, JSONEncodable, Hashable {

    public var attestation: String?
    public var authenticatorSelection: CredentialCreationPublicKeyAuthenticatorSelection?
    public var challenge: String?
    public var excludeCredentials: [CredentialCreationPublicKeyExcludeCredentialsInner]?
    public var extensions: AnyCodable?
    public var pubKeyCredParams: [CredentialCreationPublicKeyPubKeyCredParamsInner]?
    public var rp: CredentialCreationPublicKeyRp?
    public var timeout: Int?
    public var user: CredentialCreationPublicKeyUser?

    public init(attestation: String? = nil, authenticatorSelection: CredentialCreationPublicKeyAuthenticatorSelection? = nil, challenge: String? = nil, excludeCredentials: [CredentialCreationPublicKeyExcludeCredentialsInner]? = nil, extensions: AnyCodable? = nil, pubKeyCredParams: [CredentialCreationPublicKeyPubKeyCredParamsInner]? = nil, rp: CredentialCreationPublicKeyRp? = nil, timeout: Int? = nil, user: CredentialCreationPublicKeyUser? = nil) {
        self.attestation = attestation
        self.authenticatorSelection = authenticatorSelection
        self.challenge = challenge
        self.excludeCredentials = excludeCredentials
        self.extensions = extensions
        self.pubKeyCredParams = pubKeyCredParams
        self.rp = rp
        self.timeout = timeout
        self.user = user
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case attestation
        case authenticatorSelection
        case challenge
        case excludeCredentials
        case extensions
        case pubKeyCredParams
        case rp
        case timeout
        case user
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(attestation, forKey: .attestation)
        try container.encodeIfPresent(authenticatorSelection, forKey: .authenticatorSelection)
        try container.encodeIfPresent(challenge, forKey: .challenge)
        try container.encodeIfPresent(excludeCredentials, forKey: .excludeCredentials)
        try container.encodeIfPresent(extensions, forKey: .extensions)
        try container.encodeIfPresent(pubKeyCredParams, forKey: .pubKeyCredParams)
        try container.encodeIfPresent(rp, forKey: .rp)
        try container.encodeIfPresent(timeout, forKey: .timeout)
        try container.encodeIfPresent(user, forKey: .user)
    }
}

