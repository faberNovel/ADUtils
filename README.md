 ADUtils: UIKit and Swift toolbox.


ADUtils is a set of helpers, shortcuts or other tools providing simplified interactions with UIKit and more generally with Swift.

- [Features](#features)
- [Requirements](#requirements)
- [Communication](#communication)
- [Credits](#credits)
- [License](#license)

## Features

- [x] Swift syntaxic sugar (object synchronization [(src)](Modules/ADUtils/AnyObject+Synchronize.swift), array filtering [(src)](Modules/ADUtils/Array+Filter.swift), optionnal unwrapping [(src)](Modules/ADUtils/Optional+Unwrap.swift))
- [x] Table and Collection views smooth deselection [(src)](Modules/ADUtils/DeselectableView.swift)
- [x] Table and Collection view syntaxic sugar [(src)](Modules/ADUtils/RegisterableView.swift)
- [x] Font wrapper for `Dynamic type` support [(src)](Modules/ADUtils/DynamicFont.swift)
- [x] [UINavigationController observation](https://en.fabernovel.com/insights/dev-en/coordinators-and-back-button) [(src)](Modules/ADUtils/NavigationControllerObserver.swift)
- [x] View nib instanciation [(src)](Modules/ADUtils/UIView+NibLoader.swift)
- [x] ViewController child insertion [(src)](Modules/ADUtils/UIViewController+ChildInsertion.swift)
- [x] Struct `UserDefaults` storage [(src)](Modules/ADUtils/PropertyListArchiver.swift)
- [x] Attributed String multi attributes helper [(src)](Modules/ADUtils/String+AttributedFormat.swift)
- [x] String localization syntaxic sugar [(src)](Modules/ADUtils/String+Localization.swift)
- [x] `UIView` (particularly `UITableViewCell`) size computation [(src)](Modules/ADUtils/UIView+PreferredLayoutSize.swift) [(src)](Modules/ADUtils/UITableViewCell+PreferredLayoutHeight.swift)
- [x] On device proxy detection [(src)](Modules/ADUtils/ProxyDetector.swift)
- [x] Core Graphic geometry utility [(src)](Modules/ADUtils/Geometry+Utilities.swift)
- [x] Constraints and insets utility [(src)](Modules/ADUtils/UIView+Constraints.swift) [(src)](Modules/ADUtils/UIEdgeInsets+Utilities.swift)

## Requirements

- iOS 8.1+ / tvOS 9.0+
- Xcode 8.3+
- Swift 3.1+

## Communication

- If you **need help**, use [Twitter](https://twitter.com/applidium).
- If you'd like to **ask a general question**, use [Twitter](https://twitter.com/applidium).
- If you'd like to **apply for a job**, [email us](jobs@applidium.com).
- If you **found a bug**, open an issue.
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Installation

### CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Cocoa projects. You can install it with the following command:

```bash
$ gem install cocoapods
```

To integrate ADUtils into your Xcode project using CocoaPods, specify it in your `Podfile`:

```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<Your Target Name>' do
    pod 'ADUtils', '~> 7.0'
end
```

Then, run the following command:

```bash
$ pod install
```

## Credits

ADUtils is owned and maintained by [Fabernovel Technologies](https://technologies.fabernovel.com/). You can follow us on Twitter at [@applidium](https://twitter.com/applidium).


## License

ADUtils is released under the MIT license. [See LICENSE](LICENSE) for details.