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
3. Check your XCode project have the following frameworks: CFNetwork, AudioToolbox, AVFoundation and CoreMedia.

## Usage

Please also refer to [baresip docs](http://creytiv.com/doxygen/baresip-dox/html).

### Swift

Import headers on your `-Bridging_Header.h`.

```
#import <re.h>
#import <baresip.h>
```

#### Sample call

```
    var error = libre_init()
    guard error == 0
    else {
        //TODO: Could not init `libre`. Handle error value and redirect flow.
    }
```
