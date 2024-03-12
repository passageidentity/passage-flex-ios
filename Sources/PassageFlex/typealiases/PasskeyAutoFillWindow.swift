import Foundation

/**
 A platform-specific type that indicates the kind of user interface element to use as a presentation anchor.
 */
#if os(macOS)
import AppKit
public typealias PasskeyAutoFillWindow = NSWindow
#else
import UIKit
public typealias PasskeyAutoFillWindow = UIWindow
#endif
