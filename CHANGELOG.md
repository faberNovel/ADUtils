# Change Log
All notable changes to this project will be documented in this file.
`ADUtils` adheres to [Semantic Versioning](http://semver.org/).

## [5.0.0]

### Added
- Layout: `UITableViewCell.ad_preferredCellLayoutHeight(fittingWidth: CGFloat)` calculates the height of the cell content view
- Layout: `UIView.ad_preferredLayoutHeight(fittingWidth:)` and `UIView.ad_preferredLayoutWidth(fittingHeight:)`

### Removed
- `UIView.ad_preferredLayoutSize(fittingSize:lockDirections:)`

## [4.5.1]

### Added
- `DynamicFont` is now able to use system font inside `FontDescription`

## [4.5.0]

### Added
- Add `ad_localizedUppercaseString` and `localized` for Objective-C files

## [4.4.0]

### Added
- Layout: `ad_centerInSuperview(along axis:UILayoutConstraintAxis)` creates a constraint between centerX/Y anchors of a view and its superView
- Layout: `ad_centerInSuperView()` creates constraints to center a view in its superview along both axes
- Layout: `ad_constraint(to size:CGSize)` constraints a view width and height with the provided size
- Layout: All method that create constraints now enable to take a priorityLayout parameter (default is `UILayoutPriority.required`)
- `PropertyListArchiver`: `array(for key: String)` decodes data for key and returns an empty array if no data is found
- Unit tests are run to validate every commit

### Removed

### Fixed

- Unit tests: Fix `PropertyListArchiver` unit tests
- Do not notify proxy on simulator
- `NavigationControllerObserver`: fix a bug where bookeeping was done too late and view controller was not observed anymore

## [4.3.0]

### Added

- Use `Decodable` instead of `PropertyListReadable` in `PropertyListArchiver`
- Add `center` to `CGRect`

### Removed

### Fixed

## [4.2.0]

### Added
- `DynamicFontProvider`: an helper to provide dynamic type with custom font before iOS 11

### Updated

### Removed

### Fixed

## [4.1.0]

### Added
- `ProxyDetector`: Provide a way to notify the user if a proxy is running on the phone

### Updated
- `ad_localizedUppercaseString` is now deprecated after iOS 9

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
- `NavigationControllerObserver`:  The `NavigationControllerObserver` class provides a simple API to observe the pop transitions that occur in a navigationController stack.
One drawback of `UINavigationController` is that its delegate is shared among multiple view controllers and this requires a lot of bookkeeping to register multiple delegates.
`NavigationControllerObserver` allows to register a delegate per viewController we want to observe.
What's more the class provides a navigationControllerDelegate property used to forward all the `UINavigationControllerDelegate` methods to another navigationController delegate if need be.
- important: The `NavigationControllerObserver` will observe only *animated* pop transitions. Indeed, if you call `popViewController(animated: false)` you won't be notified.

### Updated

### Removed

### Fixed

## [3.5.0]

### Added
- UIView + preferred layout size: Provides the preferred layout size for the view, this is the smallest size the view and its content can fit. You should populate the view before calling this method
- Optional + unwrap: Provides syntactic sugar to unwrap and execute a closure with an optional
- Add parameters owner and bundle in `ad_fromNib` method

### Updated

### Removed

### Fixed
