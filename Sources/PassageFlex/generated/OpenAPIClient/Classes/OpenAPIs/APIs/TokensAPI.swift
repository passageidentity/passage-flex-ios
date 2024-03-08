//
// TokensAPI.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

open class TokensAPI {

    /**
     Creates new auth and refresh token
     
     - parameter appId: (path) App ID 
     - parameter refreshAuthTokenRequest: (body) Refresh token 
     - returns: AuthResponse
     */
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func refreshAuthToken(appId: String, refreshAuthTokenRequest: RefreshAuthTokenRequest) async throws -> AuthResponse {
        return try await refreshAuthTokenWithRequestBuilder(appId: appId, refreshAuthTokenRequest: refreshAuthTokenRequest).execute().body
    }

    /**
     Creates new auth and refresh token
     - POST /apps/{app_id}/tokens
     - Creates and returns a new auth token and a new refresh token
     - parameter appId: (path) App ID 
     - parameter refreshAuthTokenRequest: (body) Refresh token 
     - returns: RequestBuilder<AuthResponse> 
     */
    open class func refreshAuthTokenWithRequestBuilder(appId: String, refreshAuthTokenRequest: RefreshAuthTokenRequest) -> RequestBuilder<AuthResponse> {
        var localVariablePath = "/apps/{app_id}/tokens"
        let appIdPreEscape = "\(APIHelper.mapValueToPathItem(appId))"
        let appIdPostEscape = appIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{app_id}", with: appIdPostEscape, options: .literal, range: nil)
        let localVariableURLString = OpenAPIClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: refreshAuthTokenRequest)

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            "Content-Type": "application/json",
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<AuthResponse>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "POST", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: false)
    }

    /**
     Revokes refresh token
     
     - parameter appId: (path) App ID 
     - parameter refreshToken: (query) Refresh token 
     - returns: Void
     */
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func revokeRefreshToken(appId: String, refreshToken: String) async throws {
        return try await revokeRefreshTokenWithRequestBuilder(appId: appId, refreshToken: refreshToken).execute().body
    }

    /**
     Revokes refresh token
     - DELETE /apps/{app_id}/tokens
     - Revokes the refresh token
     - parameter appId: (path) App ID 
     - parameter refreshToken: (query) Refresh token 
     - returns: RequestBuilder<Void> 
     */
    open class func revokeRefreshTokenWithRequestBuilder(appId: String, refreshToken: String) -> RequestBuilder<Void> {
        var localVariablePath = "/apps/{app_id}/tokens"
        let appIdPreEscape = "\(APIHelper.mapValueToPathItem(appId))"
        let appIdPostEscape = appIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{app_id}", with: appIdPostEscape, options: .literal, range: nil)
        let localVariableURLString = OpenAPIClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        var localVariableUrlComponents = URLComponents(string: localVariableURLString)
        localVariableUrlComponents?.queryItems = APIHelper.mapValuesToQueryItems([
            "refresh_token": (wrappedValue: refreshToken.encodeToJSON(), isExplode: true),
        ])

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<Void>.Type = OpenAPIClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return localVariableRequestBuilder.init(method: "DELETE", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: false)
    }
}