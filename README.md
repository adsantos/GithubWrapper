# GitHub API Wrapper in Objective-C

## Installation

1. Install [CocoaPods](http://cocoapods.org).
2. Clone this project
3. In the home directory of this project, run pod install
4. Open Wrapper.xcworkspace in XCode

## Usage

In order to use this framework in another project, execute the following steps:

1. Install [CocoaPods](http://cocoapods.org).
2. In the home directory of your project, create a file called Podfile and add the following:
    ```
    platform :ios

    pod 'Wrapper', :git => "git://github.com/adsantos/GithubWrapper.git"
    ```

3. Run pod install
4. Open the generated *.xcworkspace in XCode
5. Run the Pods target
6. Run your project target

## Examples

TODO

## Supported versions

iOS 5+

## Contributing

1. [Fork the repository.](https://help.github.com/articles/fork-a-repo)
2. [Create a topic branch.](http://learn.github.com/p/branching.html)
3. Add specs for your unimplemented feature or bug fix.
4. Run the tests. If your tests pass, return to step 3.
5. Implement your feature or bug fix.
6. Run the tests. If your tests fail, return to step 5.
7. Add, commit, and push your changes.
8. [Submit a pull request.](https://help.github.com/articles/using-pull-requests)

## Copyright

Copyright (c) 2012 Adriana Santos. See [LICENSE](https://github.com/adsantos/GithubWrapper/blob/master/LICENSE) for details.
