<p align="center">
    <img src="Resources/B2.png" alt="B2 Logo" width="256" height="256" />
</p>

[![build status](https://api.travis-ci.org/ameingast/b2kit.png)](https://travis-ci.org/ameingast/b2kit)
[![carthage compatible](https://img.shields.io/badge/carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![codecov](http://codecov.io/github/ameingast/b2kit/coverage.svg?branch=master)](http://codecov.io/github/ameingast/b2kit?branch=master)
[![license](https://img.shields.io/badge/license-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)
![platforms](https://img.shields.io/badge/platforms-macOS%20%7C%20iOS%20%7C%20tvOS%20%7C%20watchOS-blue.svg?longCache=true&style=flat)
[![donate](https://img.shields.io/badge/donate-paypal-green.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=E5NS7AQG7EN8J)

# B2Kit

B2Kit is a lightweight, zero-dependency Objective-C/Swift library for accessing 
[Backblaze B2](https://www.backblaze.com/b2/cloud-storage.html) under macOS/iOS/watchOS/tvOS.

## Installation

### Installation with CocoaPods

Integrating this framework with Cocoapods is straightforward.

Just declare this dependency in your Podfile:

```ruby
pod 'B2Kit', :git => 'https://github.com/ameingast/b2kit.git'
```

### Installation with Carthage                                                  

To use [Carthage](https://github.com/Carthage/Carthage) (a more lightweight, but more hands on package manager) just create a `Cartfile` with

```ruby                                                                         
github "ameingast/b2kit" "master"                                   
```                                        

Then follow the [steps in the Carthage guide](https://github.com/Carthage/Carthage#getting-started) basically:

* run `carthage update`                                                         
* drag the framework from Carthage/Build into Linked Frameworks on the General tab
* add `carthage copy-frameworks` to a `Run Scripts` phase                       

and you're done.

## Documentation

The entry point for this library is the [B2.h file](./Source/B2/B2.h). It contains documentation for all the library's methods.

For a more detailled B2 service documentation, check out the [official B2 documentation website](https://www.backblaze.com/b2/docs/).

## Examples

Some examples are available in the [project playground](Playground.playground/Contents.swift).

## Tests

B2Kit has a unit and integration test set. 

Unit tests can be executed in any environent, don't require internet access or user credentials.

In order to execute the integration test suite, you need to have network access to the B2 service and provide your B2 credentials in the 
following format in the file _Resources/Secrets.json_:

```javascript
{
    "ACCOUNT_ID": "...",
    "APPLICATION_KEY": "..."
}
```

Be careful. The integration test-suite modifies data in your B2 account. Data loss is possible!

## Contributing

Please submit bug reports and improvements through pull-requests or tickets on Github.

Before submitting please be sure to run the unit and integration test suite and make sure both pass.

If you like this library, please consider donating. Thank you!

## TODO

### Documentation

* API
* Endpoints

### Missing end-points

* b2_get_download_authorization
* b2_create_key
* b2_delete_key
* b2_list_keys

## Copyright and License

Copyright (c) 2018-2019, Andreas Meingast <ameingast@gmail.com>.

The framework is published under a BSD style license. For more information, please see the [LICENSE](./LICENSE) file.
