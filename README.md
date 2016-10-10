# TareSIP

![Platform: iOS 7+](https://img.shields.io/badge/platform-iOS%207%2B-blue.svg?style=flat)
[![Cocoapods compatible](https://img.shields.io/badge/Cocoapods-compatible-4BC51D.svg?style=flat)](https://cocoapods.org)
[![License: BSD](https://img.shields.io/badge/license-BSD-lightgrey.svg?style=flat)](https://github.com/miche-atucha/taresip/blob/master/LICENSE)
[![Release version](https://img.shields.io/badge/release-0.1.1-blue.svg)]()

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
{
    var agent: OpaquePointer? = nil
    var client: SipClient? = nil
    do {
        client = try SipClient(agent: &agent)
    } catch {
        print("error: \(error)")
    }
}

enum SipError: Error {
    case libre
    case config
    case stack
    case modules
    case userAgent
    case call
}

final class SipClient {

    required init?(agent: inout OpaquePointer?) throws {
        guard libre_init() == 0 else { throw SipError.libre }

        // Initialize dynamic modules.
        mod_init()

        // Make configure file.
        if let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
            conf_path_set(path)
        }
        guard conf_configure() == 0 else { throw SipError.config }

        // Initialize the SIP stack.
        guard ua_init("SIP", 1, 1, 1, 0) == 0 else { throw SipError.stack }

        // Load modules.
        guard conf_modules() == 0 else { throw SipError.modules }

        let addr = "sip:user:password@server.com:port;transport=udp;answermode=auto"

        // Start user agent.
        guard ua_alloc(&agent, addr) == 0 else { throw SipError.userAgent }

        // Make an outgoing call.
        guard ua_connect(agent, nil, nil, "sip:target@server.com:port", nil, VIDMODE_OFF) == 0 else { throw SipError.call }

        // Start the main loop.
        re_main(nil)
    }

    func close(agent: OpaquePointer) {
        mem_deref(UnsafeMutablePointer(agent))
        ua_close()
        mod_close()

        // Close and check for memory leaks.
        libre_close()
        tmr_debug()
        mem_debug()
    }

}

```
