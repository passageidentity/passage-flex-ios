//
// LoginWebAuthnStartResponse.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct LoginWebAuthnStartResponse: Codable, JSONEncodable, Hashable {

    public var handshake: CredentialAssertionChallenge
    public var user: User?

    public init(handshake: CredentialAssertionChallenge, user: User? = nil) {
        self.handshake = handshake
        self.user = user
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case handshake
        case user
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(handshake, forKey: .handshake)
        try container.encodeIfPresent(user, forKey: .user)
    }
}

