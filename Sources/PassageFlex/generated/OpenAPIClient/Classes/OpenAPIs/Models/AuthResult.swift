//
// AuthResult.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct AuthResult: Codable, JSONEncodable, Hashable {

    public var authToken: String
    public var redirectUrl: String
    public var refreshToken: String?
    public var refreshTokenExpiration: Int?

    public init(authToken: String, redirectUrl: String, refreshToken: String? = nil, refreshTokenExpiration: Int? = nil) {
        self.authToken = authToken
        self.redirectUrl = redirectUrl
        self.refreshToken = refreshToken
        self.refreshTokenExpiration = refreshTokenExpiration
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case authToken = "auth_token"
        case redirectUrl = "redirect_url"
        case refreshToken = "refresh_token"
        case refreshTokenExpiration = "refresh_token_expiration"
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(authToken, forKey: .authToken)
        try container.encode(redirectUrl, forKey: .redirectUrl)
        try container.encodeIfPresent(refreshToken, forKey: .refreshToken)
        try container.encodeIfPresent(refreshTokenExpiration, forKey: .refreshTokenExpiration)
    }
}

