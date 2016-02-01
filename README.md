# ARDeepLinkButton

[![Join the chat at https://gitter.im/alexruperez/ARDeepLinkButton](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/alexruperez/ARDeepLinkButton?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)
[![Twitter](http://img.shields.io/badge/contact-@alexruperez-blue.svg?style=flat)](http://twitter.com/alexruperez)
[![CI Status](http://img.shields.io/travis/alexruperez/ARDeepLinkButton.svg?style=flat)](https://travis-ci.org/alexruperez/ARDeepLinkButton)
[![Version](https://img.shields.io/cocoapods/v/ARDeepLinkButton.svg?style=flat)](http://cocoadocs.org/docsets/ARDeepLinkButton)
[![License](https://img.shields.io/cocoapods/l/ARDeepLinkButton.svg?style=flat)](http://cocoadocs.org/docsets/ARDeepLinkButton)
[![Platform](https://img.shields.io/cocoapods/p/ARDeepLinkButton.svg?style=flat)](http://cocoadocs.org/docsets/ARDeepLinkButton)
[![Analytics](https://ga-beacon.appspot.com/UA-55329295-1/ARDeepLinkButton/readme?pixel)](https://github.com/igrigorik/ga-beacon)

## Overview

`ARDeepLinkButton` is an `UIButton` subclass that handle deep links, shows in-app `SKStoreProductViewController` or redirects to the AppStore. Written in Swift 2.0

![ARDeepLinkButton Screenshot](https://raw.githubusercontent.com/alexruperez/ARDeepLinkButton/master/screenshot.png)

### Installation

`ARDeepLinkButton` is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your `Podfile`:

    pod "ARDeepLinkButton"

#### Or you can install it with [Swift Package Manager](https://github.com/apple/swift-package-manager):

    .Package(url: "ssh://git@github.com:alexruperez/ARDeepLinkButton.git", versions: Version(1,0,0)..<Version(2,0,0)),

#### Or you can install it with [Carthage](https://github.com/Carthage/Carthage):

    github "alexruperez/ARDeepLinkButton"

#### Or you can add the following files to your project:
* `ARDeepLinkButton.swift`
* `ARDeepLinkHandler.swift`

### Usage

`ARDeepLinkButton` is `@IBDesignable` and has the following properties:

```swift
@IBInspectable public var deepLink: String? // Example: "madbike://"
@IBInspectable public var iTunesURL: String? // Example: "https://itunes.apple.com/us/app/madbike/id1067596651?mt=8"
@IBInspectable public var cornerRadius: CGFloat // UIButton corner radius.
@IBInspectable public var borderWidth: CGFloat // UIButton border width.
@IBInspectable public var borderColor: UIColor? // UIButton border color.
@IBInspectable public var imageContentMode: Int // UIButton image UIViewContentMode value. Example: 1 for .ScaleAspectFit
@IBInspectable public var imageCornerRadius: CGFloat // UIButton image corner radius.
public lazy var deepLinkHandler = ARDeepLinkHandler() // Deep link handler, here you have access to SKStoreProductViewController in order to customize it.
public private(set) var appStoreId: String? // Automatically generated when iTunesURL is setted.
```

`ARDeepLinkHandler` can be used independently and has the following public methods:

```swift
public func handle(deepLink: String?, appStoreId: String?, iTunesURLString: String?) -> Bool
public func handle(appStoreId: String?, iTunesURLString: String?) -> Bool
public func handle(URLString: String?) -> Bool
```

#### iOS 9 Reminder

Add your deep link to `LSApplicationQueriesSchemes` in your `Info.plist`

```plist
<key>LSApplicationQueriesSchemes</key>
<array>
    <string>madbike</string>
</array>
```

# Etc.

* Contributions are very welcome.
* Attribution is appreciated (let's spread the word!), but not mandatory.

## Use it? Love/hate it?

Tweet the author [@alexruperez](http://twitter.com/alexruperez), and check out alexruperez's blog: http://alexruperez.com

## License

ARDeepLinkButton is available under the MIT license. See the LICENSE file for more info.
