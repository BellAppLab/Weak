# Weak
_A Swift `weak` wrapper for all the things you don't want to retain._
_v0.1.0_

## Requirements

* Xcode 8.0+
* Swift 3.2+

## Usage

Declare your `Weak` variable in one of the two ways provided:

```swift
class TestClass {}

var aTestObject = TestClass()
let weakTestObject = Weak(aTestObject)

let anotherWeakTestObject = ≈test
```

If passing an optional to `Weak`, your weak variable will also be an optional:

```swift
var anOptionalObject: TestClass? = TestClass()
let optionalWeak = ≈test // optionalWeak is now an optional; it will be nil if the underlaying value is also nil
```

Access your variable:

```swift
weakTestObject.value //returns your value as an optional, since it may or may not have been released
```

## Operators

* `prefix ≈`
    * Shorthand contructor for a `Weak` variable
    
## Collections

You can safely store your `Weak` variables in collections (eg. `[Weak<TestClass>]`). The underlaying objects won't be retained.

```swift
var tests = (1...10).map { TestClass() } // 10 elements
var weakTests = tests.map { ≈$0 } // 10 elements

tests.removeLast() // `tests` now have 9 elements, but `weakTests` have 10

weakTests = weakTests.flattenedWeaks() // `weakTests` now have 9 elements too, since we dropped the released objects from it
```

You can also quickly "unwrap" the elements in a `Weak` collection:

```swift
let tests = weakTests.unwrappedWeaks()
```

The variable `tests` will now be a `[TestClass]` containing only the elements that haven't been released yet.

## Installation

### Cocoapods

Because of [this](http://stackoverflow.com/questions/39637123/cocoapods-app-xcworkspace-does-not-exists), I've dropped support for Cocoapods on this repo. I cannot have production code rely on a dependency manager that breaks this badly.

### Git Submodules

**Why submodules, you ask?**

Following [this thread](http://stackoverflow.com/questions/31080284/adding-several-pods-increases-ios-app-launch-time-by-10-seconds#31573908) and other similar to it, and given that Cocoapods only works with Swift by adding the use_frameworks! directive, there's a strong case for not bloating the app up with too many frameworks. Although git submodules are a bit trickier to work with, the burden of adding dependencies should weigh on the developer, not on the user. :wink:

To install Weak using git submodules:

```
cd toYourProjectsFolder
git submodule add -b submodule --name Weak https://github.com/BellAppLab/Weak.git
```

Then, navigate to the new Weak folder and drag the `Source` folder into your Xcode project.

## Author

Bell App Lab, apps@bellapplab.com

## License

Lazy is available under the MIT license. See the LICENSE file for more info.
