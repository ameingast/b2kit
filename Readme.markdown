<p align="center">
    <img src="Resources/B2.png" alt="B2 Logo" width="256" height="256" />
</p>

[![Build Status](https://api.travis-ci.org/ameingast/b2kit.png)](https://travis-ci.org/ameingast/b2kit)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

# B2Kit

B2Kit is a lightweight, zero-dependency Objective-C/Swift library for accessing 
[Backblaze B2](https://www.backblaze.com/b2/cloud-storage.html) under macOS/iOS/watchOS/tvOS.

## Installation

```TODO```

## Documentation

The entry point for this library is the [B2.h file](./Source/B2/B2.h). It contains documentation for all the library's methods.

For a more detailled B2 service documentation, check out the [official B2 documentation website](https://www.backblaze.com/b2/docs/).

## Examples

```TODO```

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

## TODO

### Documentation

* API
* Endpoints
* Blocking nature of B2Kit

### Missing end-points

* b2_get_download_authorization
* b2_list_file_versions
* b2_create_key
* b2_delete_key
* b2_list_keys

## Copyright and License

Copyright (c) 2018, Andreas Meingast <ameingast@gmail.com>.

The framework is published under a BSD style license. For more information, please see the [LICENSE](./LICENSE) file.
