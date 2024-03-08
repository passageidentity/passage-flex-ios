//
// Model404Code.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public enum Model404Code: String, Codable, CaseIterable {
    case appNotFound = "app_not_found"
    case userNotFound = "user_not_found"
    case magicLinkNotFound = "magic_link_not_found"
    case socialConnectionNotFound = "social_connection_not_found"
    case transactionNotFound = "transaction_not_found"
}