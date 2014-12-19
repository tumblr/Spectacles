![Spectacles](https://github.com/tumblr/Spectacles/blob/master/Assets/logo.png)

# Spectacles

[![CI Status](http://img.shields.io/travis/tumblr/Spectacles.svg?style=flat)](https://travis-ci.org/Bryan Irace/Spectacles)
[![Version](https://img.shields.io/cocoapods/v/Spectacles.svg?style=flat)](http://cocoadocs.org/docsets/Spectacles)
[![License](https://img.shields.io/cocoapods/l/Spectacles.svg?style=flat)](http://cocoadocs.org/docsets/Spectacles)
[![Platform](https://img.shields.io/cocoapods/p/Spectacles.svg?style=flat)](http://cocoadocs.org/docsets/Spectacles)

A tiny library for parsing JSON podspecs.

This only exposes a very small subset of podspec properties at the moment (name, version, etc.), but could theoretically be expanded to include everything in the [specification](http://guides.cocoapods.org/syntax/podspec.html).

## Usage

```objc
TMPodspec *spec = [[TMPodspec alloc] initWithFileURL:
                   [[NSBundle mainBundle] URLForResource:@"Spectacles.podspec" withExtension:@"json"]];

self.label = [[UILabel alloc] init];
self.label.text = [NSString stringWithFormat:@"%@ (%@)", spec.name, spec.version];
```

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

Spectacles is available through [CocoaPods](http://cocoapods.org). To install it, simply add the following line to your Podfile:

    pod "Spectacles"

## Contributing

Please see [CONTRIBUTING.md](https://github.com/tumblr/Spectacles/blob/master/CONTRIBUTING.md) for information on how to help out.

## Contact

[Bryan Irace](mailto:bryan@tumblr.com)

## License

Copyright 2014 Tumblr, Inc.

Licensed under the Apache License, Version 2.0 (the “License”); you may not use
this file except in compliance with the License. You may obtain a copy of the
License at [apache.org/licenses/LICENSE-2.0](http://www.apache.org/licenses/LICENSE-2.0).

> Unless required by applicable law or agreed to in writing, software
> distributed under the License is distributed on an “AS IS” BASIS, WITHOUT
> WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
> License for the specific language governing permissions and limitations under
> the License.
