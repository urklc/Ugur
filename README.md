# Ugur
Framework includes initial functionality a new project requires

## Installation
### CocoaPods
```ruby
pod 'Ugur', '~> 1.2.0'
```

## Usage
### Foundation
#### LoremSwiftum
  * Helper class to generate Lorem Ipsum strings easily
  
#### JSONCodable
* Protocol to support using `Codable`s among the application with bypassing `Self` requirement as a generic constraint
  
### UI
#### KeyboardListener
  * Automatic handling of the `UIScrollView` *contentInset* when keyboard visibility is changed. Also tap gesture is added to dismiss keyboard
  
#### Extensions
  * `UICollectionView` and `UITableView` helpers to register/dequeue cells  
  * `UIColor` initializers from hex values  
  * `UIImage` filled with color generator  
  * Separator extension for `UIView`  
  * `UIViewController` helpers to get visible controller  
  * Badge addition for `UIBarButton`
  
#### Reusable Views
  * `CheckBoxView`  
  * `SegmentedControl`
  
#### Tools
  * Safe async image downloader for reusable cells: `AsyncImageContainingCell`  
  * `ImageSelectionManager` for easly taking pictures or picking from gallery
  
#### Views
  * `UKView` to load custom views from nibs. Can be used from both nibs and code.
  
### Utility
#### Localization
* Initialize a `Localization` instance and use `String` localization functionalities:
(`uk_localized` and `uk_uppercasedLocalized`) to support custom language selection within the app.