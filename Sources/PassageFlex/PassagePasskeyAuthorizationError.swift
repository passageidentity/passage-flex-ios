import Foundation

public enum PassagePasskeyAuthorizationError: Error {
    case userCanceled
    case failed
    case unknown
    
    var description: String {
        switch self {
        case .userCanceled:
            return "The user canceled the request."
        case .failed:
            return "The authorization request failed."
        case .unknown:
            return "An unknown authorization error occurred."
        }
    }
    
}


