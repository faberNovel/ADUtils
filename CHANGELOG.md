#Change Log
All notable changes to this project will be documented in this file.
`ADUtils` adheres to [Semantic Versioning](http://semver.org/).

## [4.1.0]

### Added
- ProxyDetector: Provide a way to notify the user if a proxy is running on the phone

### Updated
- ad_localizedUppercaseString is now deprecated after iOS 9

### Removed

### Fixed

## [4.0.0]

### Added

### Updated
- Swift 4 support

### Removed

### Fixed

## [3.6.0]

### Added
- NavigationControllerObserver:  The NavigationControllerObserver class provides a simple API to observe the pop transitions that occur in a navigationController stack.
One drawback of UINavigationController is that its delegate is shared among multiple view controllers and this requires a lot of bookkeeping to register multiple delegates.
NavigationControllerObserver allows to register a delegate per viewController we want to observe.
What's more the class provides a navigationControllerDelegate property used to forward all the UINavigationControllerDelegate methods to another navigationController delegate if need be.
- important: The NavigationControllerObserver will observe only *animated* pop transitions. Indeed, if you call popViewController(animated: false) you won't be notified.

### Updated

### Removed

### Fixed

## [3.5.0]

### Added
- UIView + preferred layout size: Provides the preferred layout size for the view, this is the smallest size the view and its content can fit. You should populate the view before calling this method
- Optional + unwrap: Provides syntactic sugar to unwrap and execute a closure with an optional
- Add parameters owner and bundle in ad_fromNib method

### Updated

### Removed

### Fixed
