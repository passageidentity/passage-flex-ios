![Passage Swift](https://storage.googleapis.com/passage-docs/passage-github-banner.png)

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

let passageFlex = PassageFlex(appId: "YOUR_APP_ID")
let nonce = try await passageFlex.passkey.authenticate()
```
<br>

## Documentation
To get started using PassageFlex in your iOS app, please visit our [Passage Flex iOS Docs](https://docs.passage.id/flex/ios/config).

---
<br />
<p align="center">
  <picture>
    <source media="(prefers-color-scheme: light)" srcset="https://storage.googleapis.com/passage-docs/logo-small-light.pngg" width="150">
    <source media="(prefers-color-scheme: dark)" srcset="https://storage.googleapis.com/passage-docs/logo-small-dark.png" width="150">
    <img alt="Passage Logo" src="https://storage.googleapis.com/passage-docs/logo-small-light.png" width="150">
  </picture>
</p>

<p align="center">Give customers the passwordless future they deserve. To learn more check out <a href="https://passage.1password.com">passage.1password.com</a></p>

<p align="center">This project is licensed under the MIT license. See the <a href="./LICENSE"> LICENSE</a> file for more info.</p>
