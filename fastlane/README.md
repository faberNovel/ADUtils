fastlane documentation
================
# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```
xcode-select --install
```

Install _fastlane_ using
```
[sudo] gem install fastlane -NV
```
or alternatively using `brew cask install fastlane`

# Available Actions
### tests
```
fastlane tests
```
Run all unit tests
### prepare_release
```
fastlane prepare_release
```
Release a new version
### create_release_pr
```
fastlane create_release_pr
```
Create release PR
### publish_release
```
fastlane publish_release
```
Publish release

----

This README.md is auto-generated and will be re-generated every time [fastlane](https://fastlane.tools) is run.
More information about fastlane can be found on [fastlane.tools](https://fastlane.tools).
The documentation of fastlane can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
