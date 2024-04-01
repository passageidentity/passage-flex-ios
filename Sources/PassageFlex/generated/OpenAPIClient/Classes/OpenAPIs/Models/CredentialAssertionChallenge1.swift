//
// CredentialAssertionChallenge1.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct CredentialAssertionChallenge1: Codable, JSONEncodable, Hashable {

    public var challenge: ProtocolCredentialAssertion1
    public var id: String

    public init(challenge: ProtocolCredentialAssertion1, id: String) {
        self.challenge = challenge
        self.id = id
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case challenge
        case id
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(challenge, forKey: .challenge)
        try container.encode(id, forKey: .id)
    }
}
