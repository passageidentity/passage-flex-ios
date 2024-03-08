//
// OpenIdConfiguration.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct OpenIdConfiguration: Codable, JSONEncodable, Hashable {

    public var authorizationEndpoint: String
    public var issuer: String
    public var jwksUri: String

    public init(authorizationEndpoint: String, issuer: String, jwksUri: String) {
        self.authorizationEndpoint = authorizationEndpoint
        self.issuer = issuer
        self.jwksUri = jwksUri
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case authorizationEndpoint = "authorization_endpoint"
        case issuer
        case jwksUri = "jwks_uri"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(authorizationEndpoint, forKey: .authorizationEndpoint)
        try container.encode(issuer, forKey: .issuer)
        try container.encode(jwksUri, forKey: .jwksUri)
    }
}
