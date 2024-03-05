import Foundation

internal struct Utilities {
    
    internal static var deviceOSSupportsPasskeys: Bool {
        #if os(iOS)
        if #available(iOS 16, *) {
            return true
        } else {
            return false
        }
        #elseif os(macOS)
        if #available(macOS 12.0, *) {
            return true
        } else {
            return false
        }
        #elseif os(tvOS)
        if #available(tvOS 16.0, *) {
            return true
        } else {
            return false
        }
        #else
        return false
        #endif
    }
    
    internal static func getAppId() throws -> String {
        guard
            let plistPath = Bundle.main.path(forResource: "Passage", ofType: "plist"),
            let plistData = FileManager.default.contents(atPath: plistPath)
        else {
            throw PassageConfigurationError.cannotFindPassagePlist
        }
        guard
            let plistContent = try? PropertyListSerialization
                .propertyList(from: plistData, format: nil) as? [String: Any],
            let appId = plistContent["appId"] as? String
        else {
            throw PassageConfigurationError.cannotFindAppId
        }
        return appId
    }
    
}
