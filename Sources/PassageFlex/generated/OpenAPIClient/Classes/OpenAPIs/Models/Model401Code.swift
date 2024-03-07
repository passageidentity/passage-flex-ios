//
// Model401Code.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public enum Model401Code: String, Codable, CaseIterable {
    case discoverableLoginFailed = "discoverable_login_failed"
    case webauthnLoginFailed = "webauthn_login_failed"
    case invalidMagicLink = "invalid_magic_link"
    case invalidAccessToken = "invalid_access_token"
    case exceededAttempts = "exceeded_attempts"
}
