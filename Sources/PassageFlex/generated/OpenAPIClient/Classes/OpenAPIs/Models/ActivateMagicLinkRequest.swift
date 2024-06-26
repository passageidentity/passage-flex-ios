//
// ActivateMagicLinkRequest.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct ActivateMagicLinkRequest: Codable, JSONEncodable, Hashable {

    public var magicLink: String

    public init(magicLink: String) {
        self.magicLink = magicLink
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case magicLink = "magic_link"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(magicLink, forKey: .magicLink)
    }
}

