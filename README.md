# PinCodeField

![image](https://user-images.githubusercontent.com/6635954/135472253-d1b1a52d-fe2d-495e-a13a-d09324817e8c.png)

### Swift Package Manager

In your `Package.swift` file, add `PinCodeField` dependency to corresponding targets:

```swift
let package = Package(
  dependencies: [
    .package(url: "https://github.com/prongbang/PinCodeField.git", from: "1.0.0"),
  ],
)
```

For Swift, import the module:


```swift
import PinCodeField
```

SwiftUI:

```swift
PinCodeField(handler: { code, completion in
    print(code)
    completion(true)
})
```
