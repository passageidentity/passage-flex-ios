import XCTest
@testable import PassageFlex

final class PassageFlexTests: XCTestCase {
    func testExample() async throws {
        // XCTest Documentation
        // https://developer.apple.com/documentation/xctest

        // Defining Test Cases and Test Methods
        // https://developer.apple.com/documentation/xctest/defining_test_cases_and_test_methods
        
        let transactionId = "abasfjasdlk345345982ybjk3t"
        
        do {
            let passageNonce = try await PassageFlex.Passkey.register(with: transactionId)
        } catch let error as PassageConfigurationError {
            switch error {
            case .cannotFindPassagePlist: print("Cannot find Passage.plist file.")
            case .cannotFindAppId: print("Cannot find passage app id.")
            }
        } catch {
            print("Unexpected error: \(error).")
        }
        
        
    }
    
    func testAutoFill() {
        do {
            let window = UIWindow()
            PassageFlex.Passkey.requestAutoFill(in: window) { nonce, error in
                
            }
        } catch {
            print("Unexpected error: \(error).")
        }
    }
}
