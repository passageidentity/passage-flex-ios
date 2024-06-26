//
// CredentialCreationPublicKeyUser.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

public struct CredentialCreationPublicKeyUser: Codable, JSONEncodable, Hashable {

    /** A human-palatable name for the user account, intended only for display. For example, \"Alex P. Müller\" or \"田中 倫\". The Relying Party SHOULD let the user choose this, and SHOULD NOT restrict the choice more than necessary. */
    public var displayName: String?
    /** A serialized URL which resolves to an image associated with the entity. For example, this could be a user’s avatar or a Relying Party's logo. This URL MUST be an a priori authenticated URL. Authenticators MUST accept and store a 128-byte minimum length for an icon member’s value. Authenticators MAY ignore an icon member’s value if its length is greater than 128 bytes. The URL’s scheme MAY be \"data\" to avoid fetches of the URL, at the cost of needing more storage.  Deprecated: this has been removed from the specification recommendations. */
    public var icon: String?
    /** ID is the user handle of the user account entity. To ensure secure operation, authentication and authorization decisions MUST be made on the basis of this id member, not the displayName nor name members. See Section 6.1 of [RFC8266](https://www.w3.org/TR/webauthn/#biblio-rfc8266). */
    public var id: String?
    /** A human-palatable name for the entity. Its function depends on what the PublicKeyCredentialEntity represents:  When inherited by PublicKeyCredentialRpEntity it is a human-palatable identifier for the Relying Party, intended only for display. For example, \"ACME Corporation\", \"Wonderful Widgets, Inc.\" or \"ОАО Примертех\".  When inherited by PublicKeyCredentialUserEntity, it is a human-palatable identifier for a user account. It is intended only for display, i.e., aiding the user in determining the difference between user accounts with similar displayNames. For example, \"alexm\", \"alex.p.mueller@example.com\" or \"+14255551234\". */
    public var name: String?

    public init(displayName: String? = nil, icon: String? = nil, id: String? = nil, name: String? = nil) {
        self.displayName = displayName
        self.icon = icon
        self.id = id
        self.name = name
    }

    public enum CodingKeys: String, CodingKey, CaseIterable {
        case displayName
        case icon
        case id
        case name
    }

    // Encodable protocol methods

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(displayName, forKey: .displayName)
        try container.encodeIfPresent(icon, forKey: .icon)
        try container.encodeIfPresent(id, forKey: .id)
        try container.encodeIfPresent(name, forKey: .name)
    }
}

