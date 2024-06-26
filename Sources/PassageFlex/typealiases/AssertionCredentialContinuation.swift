import AuthenticationServices

@available(iOS 16.0, macOS 12.0, tvOS 16.0, visionOS 1.0, *)
internal typealias AssertionCredentialContinuation = CheckedContinuation<
    ASAuthorizationPlatformPublicKeyCredentialAssertion,
    Error
>
