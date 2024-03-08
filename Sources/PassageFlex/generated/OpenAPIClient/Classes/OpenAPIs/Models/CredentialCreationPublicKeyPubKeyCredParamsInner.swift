//
// CredentialCreationPublicKeyPubKeyCredParamsInner.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct CredentialCreationPublicKeyPubKeyCredParamsInner: Codable, JSONEncodable, Hashable {

    public var alg: Int?
    public var type: String?

    public init(alg: Int? = nil, type: String? = nil) {
        self.alg = alg
        self.type = type
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case alg
        case type
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(alg, forKey: .alg)
        try container.encodeIfPresent(type, forKey: .type)
    }
}
