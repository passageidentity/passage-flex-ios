//
// CurrentuserAPI.swift
//
// Generated by openapi-generator
// https://openapi-generator.tech
//

import Foundation
#if canImport(AnyCodable)
import AnyCodable
#endif

open class CurrentuserAPI {

    /**
     Revoke Device
     
     - parameter appId: (path) App ID 
     - parameter deviceId: (path) Device ID 
     - returns: Void
     */
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func deleteCurrentuserDevice(appId: String, deviceId: String) async throws {
        return try await deleteCurrentuserDeviceWithRequestBuilder(appId: appId, deviceId: deviceId).execute().body
    }

    /**
     Revoke Device
     - DELETE /apps/{app_id}/currentuser/devices/{device_id}
     - Revoke a device by ID for the current user. User must be authenticated via a bearer token.
     - Bearer Token:
       - type: http
       - name: bearerAuth
     - parameter appId: (path) App ID 
     - parameter deviceId: (path) Device ID 
     - returns: RequestBuilder<Void> 
     */
    open class func deleteCurrentuserDeviceWithRequestBuilder(appId: String, deviceId: String) -> RequestBuilder<Void> {
        var localVariablePath = "/apps/{app_id}/currentuser/devices/{device_id}"
        let appIdPreEscape = "\(APIHelper.mapValueToPathItem(appId))"
        let appIdPostEscape = appIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{app_id}", with: appIdPostEscape, options: .literal, range: nil)
        let deviceIdPreEscape = "\(APIHelper.mapValueToPathItem(deviceId))"
        let deviceIdPostEscape = deviceIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{device_id}", with: deviceIdPostEscape, options: .literal, range: nil)
        let localVariableURLString = OpenAPIClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<Void>.Type = OpenAPIClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return localVariableRequestBuilder.init(method: "DELETE", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     * enum for parameter socialConnectionType
     */
    public enum SocialConnectionType_deleteCurrentuserSocialConnection: String, CaseIterable {
        case apple = "apple"
        case github = "github"
        case google = "google"
    }

    /**
     Delete Social Connection
     
     - parameter appId: (path) App ID 
     - parameter socialConnectionType: (path) The type of social connection 
     - returns: Void
     */
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func deleteCurrentuserSocialConnection(appId: String, socialConnectionType: SocialConnectionType_deleteCurrentuserSocialConnection) async throws {
        return try await deleteCurrentuserSocialConnectionWithRequestBuilder(appId: appId, socialConnectionType: socialConnectionType).execute().body
    }

    /**
     Delete Social Connection
     - DELETE /apps/{app_id}/currentuser/social-connections/{social_connection_type}
     - Deletes a social connection for the current user. User must be authenticated via a bearer token.
     - Bearer Token:
       - type: http
       - name: bearerAuth
     - parameter appId: (path) App ID 
     - parameter socialConnectionType: (path) The type of social connection 
     - returns: RequestBuilder<Void> 
     */
    open class func deleteCurrentuserSocialConnectionWithRequestBuilder(appId: String, socialConnectionType: SocialConnectionType_deleteCurrentuserSocialConnection) -> RequestBuilder<Void> {
        var localVariablePath = "/apps/{app_id}/currentuser/social-connections/{social_connection_type}"
        let appIdPreEscape = "\(APIHelper.mapValueToPathItem(appId))"
        let appIdPostEscape = appIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{app_id}", with: appIdPostEscape, options: .literal, range: nil)
        let socialConnectionTypePreEscape = "\(socialConnectionType.rawValue)"
        let socialConnectionTypePostEscape = socialConnectionTypePreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{social_connection_type}", with: socialConnectionTypePostEscape, options: .literal, range: nil)
        let localVariableURLString = OpenAPIClientAPI.basePath + localVariablePath
        let localVariableParameters: [String: Any]? = nil

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<Void>.Type = OpenAPIClientAPI.requestBuilderFactory.getNonDecodableBuilder()

        return localVariableRequestBuilder.init(method: "DELETE", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Get Current User
     
     - parameter appId: (path) App ID 
     - returns: CurrentUserResponse
     */
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func getCurrentuser(appId: String) async throws -> CurrentUserResponse {
        return try await getCurrentuserWithRequestBuilder(appId: appId).execute().body
    }

    /**
     Get Current User
     - GET /apps/{app_id}/currentuser
     - Get information about a user that is currently authenticated via bearer token.
     - Bearer Token:
       - type: http
       - name: bearerAuth
     - parameter appId: (path) App ID 
     - returns: RequestBuilder<CurrentUserResponse> 
     */
    open class func getCurrentuserWithRequestBuilder(appId: String) -> RequestBuilder<CurrentUserResponse> {
        var localVariablePath = "/apps/{app_id}/currentuser"
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

        let localVariableRequestBuilder: RequestBuilder<CurrentUserResponse>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     List Devices
     
     - parameter appId: (path) App ID 
     - returns: CurrentUserDevices
     */
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func getCurrentuserDevices(appId: String) async throws -> CurrentUserDevices {
        return try await getCurrentuserDevicesWithRequestBuilder(appId: appId).execute().body
    }

    /**
     List Devices
     - GET /apps/{app_id}/currentuser/devices
     - List all WebAuthn devices for the authenticated user. User must be authenticated via bearer token.
     - Bearer Token:
       - type: http
       - name: bearerAuth
     - parameter appId: (path) App ID 
     - returns: RequestBuilder<CurrentUserDevices> 
     */
    open class func getCurrentuserDevicesWithRequestBuilder(appId: String) -> RequestBuilder<CurrentUserDevices> {
        var localVariablePath = "/apps/{app_id}/currentuser/devices"
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

        let localVariableRequestBuilder: RequestBuilder<CurrentUserDevices>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Get user's metadata
     
     - parameter appId: (path) App ID 
     - returns: UserMetadataResponse
     */
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func getCurrentuserMetadata(appId: String) async throws -> UserMetadataResponse {
        return try await getCurrentuserMetadataWithRequestBuilder(appId: appId).execute().body
    }

    /**
     Get user's metadata
     - GET /apps/{app_id}/currentuser/user-metadata
     - Get the user-metadata for the current user.
     - Bearer Token:
       - type: http
       - name: bearerAuth
     - parameter appId: (path) App ID 
     - returns: RequestBuilder<UserMetadataResponse> 
     */
    open class func getCurrentuserMetadataWithRequestBuilder(appId: String) -> RequestBuilder<UserMetadataResponse> {
        var localVariablePath = "/apps/{app_id}/currentuser/user-metadata"
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

        let localVariableRequestBuilder: RequestBuilder<UserMetadataResponse>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Get Social Connections
     
     - parameter appId: (path) App ID 
     - returns: SocialConnectionsResponse
     */
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func getCurrentuserSocialConnections(appId: String) async throws -> SocialConnectionsResponse {
        return try await getCurrentuserSocialConnectionsWithRequestBuilder(appId: appId).execute().body
    }

    /**
     Get Social Connections
     - GET /apps/{app_id}/currentuser/social-connections
     - Gets social connections for the current user. User must be authenticated via a bearer token.
     - Bearer Token:
       - type: http
       - name: bearerAuth
     - parameter appId: (path) App ID 
     - returns: RequestBuilder<SocialConnectionsResponse> 
     */
    open class func getCurrentuserSocialConnectionsWithRequestBuilder(appId: String) -> RequestBuilder<SocialConnectionsResponse> {
        var localVariablePath = "/apps/{app_id}/currentuser/social-connections"
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

        let localVariableRequestBuilder: RequestBuilder<SocialConnectionsResponse>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "GET", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Finish WebAuthn Add Device
     
     - parameter appId: (path) App ID 
     - parameter addDeviceFinishRequest: (body) WebAuthn Response Data 
     - returns: CurrentUserDevice
     */
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func postCurrentuserAddDeviceFinish(appId: String, addDeviceFinishRequest: AddDeviceFinishRequest) async throws -> CurrentUserDevice {
        return try await postCurrentuserAddDeviceFinishWithRequestBuilder(appId: appId, addDeviceFinishRequest: addDeviceFinishRequest).execute().body
    }

    /**
     Finish WebAuthn Add Device
     - POST /apps/{app_id}/currentuser/devices/finish
     - Complete a WebAuthn add device operation for the current user. This endpoint accepts and verifies the response from `navigator.credential.create()` and returns the created device for the user. User must be authenticated via a bearer token.
     - Bearer Token:
       - type: http
       - name: bearerAuth
     - parameter appId: (path) App ID 
     - parameter addDeviceFinishRequest: (body) WebAuthn Response Data 
     - returns: RequestBuilder<CurrentUserDevice> 
     */
    open class func postCurrentuserAddDeviceFinishWithRequestBuilder(appId: String, addDeviceFinishRequest: AddDeviceFinishRequest) -> RequestBuilder<CurrentUserDevice> {
        var localVariablePath = "/apps/{app_id}/currentuser/devices/finish"
        let appIdPreEscape = "\(APIHelper.mapValueToPathItem(appId))"
        let appIdPostEscape = appIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{app_id}", with: appIdPostEscape, options: .literal, range: nil)
        let localVariableURLString = OpenAPIClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: addDeviceFinishRequest)

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            "Content-Type": "application/json",
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<CurrentUserDevice>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "POST", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Start WebAuthn Add Device
     
     - parameter appId: (path) App ID 
     - parameter currentUserDevicesStartRequest: (body) WebAuthn Start Response Data (optional)
     - returns: AddDeviceStartResponse
     */
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func postCurrentuserAddDeviceStart(appId: String, currentUserDevicesStartRequest: CurrentUserDevicesStartRequest? = nil) async throws -> AddDeviceStartResponse {
        return try await postCurrentuserAddDeviceStartWithRequestBuilder(appId: appId, currentUserDevicesStartRequest: currentUserDevicesStartRequest).execute().body
    }

    /**
     Start WebAuthn Add Device
     - POST /apps/{app_id}/currentuser/devices/start
     - Initiate a WebAuthn add device operation for the current user. This endpoint creates a WebAuthn credential creation challenge that is used to perform the registration ceremony from the browser. User must be authenticated via a bearer token.
     - Bearer Token:
       - type: http
       - name: bearerAuth
     - parameter appId: (path) App ID 
     - parameter currentUserDevicesStartRequest: (body) WebAuthn Start Response Data (optional)
     - returns: RequestBuilder<AddDeviceStartResponse> 
     */
    open class func postCurrentuserAddDeviceStartWithRequestBuilder(appId: String, currentUserDevicesStartRequest: CurrentUserDevicesStartRequest? = nil) -> RequestBuilder<AddDeviceStartResponse> {
        var localVariablePath = "/apps/{app_id}/currentuser/devices/start"
        let appIdPreEscape = "\(APIHelper.mapValueToPathItem(appId))"
        let appIdPostEscape = appIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{app_id}", with: appIdPostEscape, options: .literal, range: nil)
        let localVariableURLString = OpenAPIClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: currentUserDevicesStartRequest)

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            :
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<AddDeviceStartResponse>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "POST", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Update Device
     
     - parameter appId: (path) App ID 
     - parameter deviceId: (path) Device ID 
     - parameter updateDeviceRequest: (body) Friendly Name 
     - returns: CurrentUserDevice
     */
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func updateCurrentuserDevice(appId: String, deviceId: String, updateDeviceRequest: UpdateDeviceRequest) async throws -> CurrentUserDevice {
        return try await updateCurrentuserDeviceWithRequestBuilder(appId: appId, deviceId: deviceId, updateDeviceRequest: updateDeviceRequest).execute().body
    }

    /**
     Update Device
     - PATCH /apps/{app_id}/currentuser/devices/{device_id}
     - Update a device by ID for the current user. Currently the only field that can be updated is the friendly name. User must be authenticated via a bearer token.
     - Bearer Token:
       - type: http
       - name: bearerAuth
     - parameter appId: (path) App ID 
     - parameter deviceId: (path) Device ID 
     - parameter updateDeviceRequest: (body) Friendly Name 
     - returns: RequestBuilder<CurrentUserDevice> 
     */
    open class func updateCurrentuserDeviceWithRequestBuilder(appId: String, deviceId: String, updateDeviceRequest: UpdateDeviceRequest) -> RequestBuilder<CurrentUserDevice> {
        var localVariablePath = "/apps/{app_id}/currentuser/devices/{device_id}"
        let appIdPreEscape = "\(APIHelper.mapValueToPathItem(appId))"
        let appIdPostEscape = appIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{app_id}", with: appIdPostEscape, options: .literal, range: nil)
        let deviceIdPreEscape = "\(APIHelper.mapValueToPathItem(deviceId))"
        let deviceIdPostEscape = deviceIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{device_id}", with: deviceIdPostEscape, options: .literal, range: nil)
        let localVariableURLString = OpenAPIClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: updateDeviceRequest)

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            "Content-Type": "application/json",
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<CurrentUserDevice>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "PATCH", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Update user's metadata
     
     - parameter appId: (path) App ID 
     - parameter updateMetadataRequest: (body) User Metadata 
     - returns: CurrentUserResponse
     */
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func updateCurrentuserMetadata(appId: String, updateMetadataRequest: UpdateMetadataRequest) async throws -> CurrentUserResponse {
        return try await updateCurrentuserMetadataWithRequestBuilder(appId: appId, updateMetadataRequest: updateMetadataRequest).execute().body
    }

    /**
     Update user's metadata
     - PATCH /apps/{app_id}/currentuser/user-metadata
     - Update the metadata for the current user. Only valid metadata fields are accepted. Invalid metadata fields that are present will abort the update. User must be authenticated via a bearer token.
     - Bearer Token:
       - type: http
       - name: bearerAuth
     - parameter appId: (path) App ID 
     - parameter updateMetadataRequest: (body) User Metadata 
     - returns: RequestBuilder<CurrentUserResponse> 
     */
    open class func updateCurrentuserMetadataWithRequestBuilder(appId: String, updateMetadataRequest: UpdateMetadataRequest) -> RequestBuilder<CurrentUserResponse> {
        var localVariablePath = "/apps/{app_id}/currentuser/user-metadata"
        let appIdPreEscape = "\(APIHelper.mapValueToPathItem(appId))"
        let appIdPostEscape = appIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{app_id}", with: appIdPostEscape, options: .literal, range: nil)
        let localVariableURLString = OpenAPIClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: updateMetadataRequest)

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            "Content-Type": "application/json",
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<CurrentUserResponse>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "PATCH", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Change Email
     
     - parameter appId: (path) App ID 
     - parameter updateUserEmailRequest: (body) email 
     - returns: MagicLinkResponse
     */
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func updateEmailCurrentuser(appId: String, updateUserEmailRequest: UpdateUserEmailRequest) async throws -> MagicLinkResponse {
        return try await updateEmailCurrentuserWithRequestBuilder(appId: appId, updateUserEmailRequest: updateUserEmailRequest).execute().body
    }

    /**
     Change Email
     - PATCH /apps/{app_id}/currentuser/email
     - Initiate an email change for the authenticated user. An email change requires verification, so an email will be sent to the user which they must verify before the email change takes effect.
     - Bearer Token:
       - type: http
       - name: bearerAuth
     - parameter appId: (path) App ID 
     - parameter updateUserEmailRequest: (body) email 
     - returns: RequestBuilder<MagicLinkResponse> 
     */
    open class func updateEmailCurrentuserWithRequestBuilder(appId: String, updateUserEmailRequest: UpdateUserEmailRequest) -> RequestBuilder<MagicLinkResponse> {
        var localVariablePath = "/apps/{app_id}/currentuser/email"
        let appIdPreEscape = "\(APIHelper.mapValueToPathItem(appId))"
        let appIdPostEscape = appIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{app_id}", with: appIdPostEscape, options: .literal, range: nil)
        let localVariableURLString = OpenAPIClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: updateUserEmailRequest)

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            "Content-Type": "application/json",
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<MagicLinkResponse>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "PATCH", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }

    /**
     Change Phone
     
     - parameter appId: (path) App ID 
     - parameter updateUserPhoneRequest: (body) phone 
     - returns: MagicLinkResponse
     */
    @available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 6.0, *)
    open class func updatePhoneCurrentuser(appId: String, updateUserPhoneRequest: UpdateUserPhoneRequest) async throws -> MagicLinkResponse {
        return try await updatePhoneCurrentuserWithRequestBuilder(appId: appId, updateUserPhoneRequest: updateUserPhoneRequest).execute().body
    }

    /**
     Change Phone
     - PATCH /apps/{app_id}/currentuser/phone
     - Initiate a phone number change for the authenticated user. An phone number change requires verification, so an SMS with a link will be sent to the user which they must verify before the phone number change takes effect.
     - Bearer Token:
       - type: http
       - name: bearerAuth
     - parameter appId: (path) App ID 
     - parameter updateUserPhoneRequest: (body) phone 
     - returns: RequestBuilder<MagicLinkResponse> 
     */
    open class func updatePhoneCurrentuserWithRequestBuilder(appId: String, updateUserPhoneRequest: UpdateUserPhoneRequest) -> RequestBuilder<MagicLinkResponse> {
        var localVariablePath = "/apps/{app_id}/currentuser/phone"
        let appIdPreEscape = "\(APIHelper.mapValueToPathItem(appId))"
        let appIdPostEscape = appIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        localVariablePath = localVariablePath.replacingOccurrences(of: "{app_id}", with: appIdPostEscape, options: .literal, range: nil)
        let localVariableURLString = OpenAPIClientAPI.basePath + localVariablePath
        let localVariableParameters = JSONEncodingHelper.encodingParameters(forEncodableObject: updateUserPhoneRequest)

        let localVariableUrlComponents = URLComponents(string: localVariableURLString)

        let localVariableNillableHeaders: [String: Any?] = [
            "Content-Type": "application/json",
        ]

        let localVariableHeaderParameters = APIHelper.rejectNilHeaders(localVariableNillableHeaders)

        let localVariableRequestBuilder: RequestBuilder<MagicLinkResponse>.Type = OpenAPIClientAPI.requestBuilderFactory.getBuilder()

        return localVariableRequestBuilder.init(method: "PATCH", URLString: (localVariableUrlComponents?.string ?? localVariableURLString), parameters: localVariableParameters, headers: localVariableHeaderParameters, requiresAuthentication: true)
    }
}
