//
// OpenIDAPI.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

open class OpenIDAPI {

    /**
     Get OpenID Configuration
     
     - parameter appId: (path) App ID 
     - returns: OpenIdConfiguration
     */
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func getOpenIdConfiguration(appId: String) async throws -> OpenIdConfiguration {
        return try await getOpenIdConfigurationWithRequestBuilder(appId: appId).execute().body
    }

    /**
     Get OpenID Configuration
     - GET /apps/{app_id}/.well-known/openid-configuration
     - Get OpenID Configuration for an app.
     - parameter appId: (path) App ID 
     - returns: RequestBuilder<OpenIdConfiguration> 
     */
    open class func getOpenIdConfigurationWithRequestBuilder(appId: String) -> RequestBuilder<OpenIdConfiguration> {
        var localVariablePath = "/apps/{app_id}/.well-known/openid-configuration"
        let appIdPreEscape = "\(APIHelper.mapValueToPathItem(appId))"
        let appIdPostEscape = appIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{app_id}", with: appIdPostEscape, options: .literal, range: nil)
        let localVariableURLString = OpenAPIClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<OpenIdConfiguration>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: false)
    }
}
