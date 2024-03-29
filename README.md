<img src="https://storage.googleapis.com/passage-docs/passage-logo-gradient.svg" alt="Passage logo" style="width:250px;"/>

### Native passkey authentication for your iOS app
## Welcome!
Integrating passkey technology can be really hard. That's why we built the PassageFlex iOS SDK - to make passkey authentication easy for you and your users.
<br>

## Usage

### Installation

You can import the PassageFlex via the Swift Package Manager. Simply search SPM for this url:
```
https://github.com/passageidentity/passage-flex-ios
```
Or you can import it using CocoaPods by add this pod to your app's Podfile:
```
pod 'PassageFlex'
```

### Example
And you can use it like this:
```swift
import PassageFlex

let nonce = try await PassageFlex.Passkey.authenticate()
```
<br>

## Documentation
To get started using PassageFlex in your iOS app, please visit our [Passage Docs](https://docs.passage.id/mobile/ios/).
