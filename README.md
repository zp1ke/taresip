# TareSIP

![Platform: iOS 7+](https://img.shields.io/badge/platform-iOS%207%2B-blue.svg?style=flat)
[![Cocoapods compatible](https://img.shields.io/badge/Cocoapods-compatible-4BC51D.svg?style=flat)](https://cocoapods.org)
[![License: BSD](https://img.shields.io/badge/license-BSD-lightgrey.svg?style=flat)](https://github.com/miche-atucha/taresip/blob/master/LICENSE)

[Cocoapod](https://cocoapods.org/) for [baresip](http://www.creytiv.com/baresip.html).

## Installation

Add the following line to your `Podfile` and run `pod install` command.

```
pod 'taresip'
```

## Build manually

1. Download project and run [build.sh](build.sh) script.
2. Drag generated libraries and headers files into your XCode project.
3. Check your XCode project has the following frameworks: `CFNetwork`, `AudioToolbox`, `AVFoundation`, `SystemConfiguration` and `CoreMedia`.
4. Check your XCode project has the follwing libraries: `libstdc++.tbd` and `libresolv.9.tbd`.

## Usage

Please also refer to [baresip docs](http://creytiv.com/doxygen/baresip-dox/html).

### Swift

Import headers on your `-Bridging_Header.h`.

```c
#import <re.h>
#import <baresip.h>
```

#### Sample call

```swift
var error = libre_init()
if error != 0
{
    //TODO: Could not init `libre`. Handle error value and redirect flow.
}
```
