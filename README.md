# TareSIP

![Platform: iOS 7+](https://img.shields.io/badge/platform-iOS%207%2B-blue.svg?style=flat)
[![Cocoapods compatible](https://img.shields.io/badge/Cocoapods-compatible-4BC51D.svg?style=flat)](https://cocoapods.org)
[![License: BSD](https://img.shields.io/badge/license-BSD-lightgrey.svg?style=flat)](https://github.com/miche-atucha/taresip/blob/master/LICENSE)
[![Release version](https://img.shields.io/badge/release-0.1.0-blue.svg)]()

[Cocoapod](https://cocoapods.org/) for [baresip](http://www.creytiv.com/baresip.html).

## Installation

### With CocoaPods

Add the following line to your `Podfile` and run `pod install` command.

```
pod 'taresip'
```

### Build manually

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

#### Sample call flow

```swift
var agent: COpaquePointer = COpaquePointer(nilLiteral: ())
sip(&agent)
sipClose(agent)

func sip(inout agent: COpaquePointer)
{
    var error = libre_init()
    if error != 0
    {
        return
    }

    // Initialize dynamic modules.
    mod_init()
    
    // Make configure file.
    let mainBundle = NSBundle.mainBundle()
    if let path = mainBundle.resourcePath
    {
        conf_path_set(getCString(path))
    }
    error = conf_configure()
    if error != 0
    {
        return
    }

    // Initialize the SIP stack.
    error = ua_init("SIP", 1, 1, 1, 0)
    if error != 0
    {
        return
    }
    
    // Load modules.
    error = conf_modules()
    if error != 0
    {
        return
    }

    let addr: String = "sip:user:password@server.com:port;transport=udp;answermode=auto"

    // Start user agent.
    error = ua_alloc(&agent, getCString(addr))
    if error != 0
    {
        return
    }

    // Make an outgoing call.
    error = ua_connect(agent, nil, nil, "sip:target@server.com:port", nil, VIDMODE_OFF);
    if error != 0
    {
        return
    }

    // Start the main loop.
    re_main(nil)
}

private func sipClose(agent: COpaquePointer)
{
    mem_deref(UnsafeMutablePointer(agent))
    ua_close()
    mod_close()

    // Close and check for memory leaks.
    libre_close()
    tmr_debug()
    mem_debug()
}
```
