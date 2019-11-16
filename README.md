# IPonCC ([updates are hosted elsewhere since 2018-06](https://gitlab.com/blanxd/IPonCC/-/releases))
Shows all sorts of IP addresses for the device in the iOS Control Center. Cellular, WiFi and VPN (and everything else), both IPv4 and IPv6.

**[Version 1.3](https://github.com/blanxd/IPonCC/releases) (2018-06-04)**
This is the way it was supposed to work in the 1st place:                                                                                                                                             
* Adds a separate "IP Addresses" item to the list of CC modules, which displays the addresses straight on the CC (3x1 size). 3D/long-touch on the module shows the expanded list with IPv6 addresses.
* The "IP Button" item in the module list can be used if there's no room for a 3x1 sized item in your CC, need to tap it to see the addresses.
* Adds a button in the expanded view for choosing whether to show a regular list or the internal unfiltered address list.

The public source files here remain the very alpha ones (ver.0.0.1), simply gathering the IP info and it only works by 3D-pressing the toggle.

**[Version 1.2](https://github.com/blanxd/IPonCC/releases) (2018-05-10)**
* 3D-touch now shows everything unfiltered, all interfaces by their BSD names.
* Internal optimizations, [CCSupport](https://github.com/opa334/CCSupport) is now a dependency.

The public source files here remain the very alpha ones (ver.0.0.1), simply gathering the IP info and it only works by 3D-pressing the toggle.

**[Version 1.1](https://github.com/blanxd/IPonCC/releases) (2018-04-14)**
* Functionality remains as in version 1.0
* Completely removed the dependency for Silo. It now only depends on iOS11 and MobileSubstrate of course.

The public source files here remain the very alpha ones (ver.0.0.1), simply gathering the IP info and it only works by 3D-pressing the toggle.

**[Version 1.0](https://github.com/blanxd/IPonCC/releases) (2018-04-07)**
* The version 1.0 is live now, no need to close/open it to see new data (not live technically, polling).
* No need to 3D-press it any more, a simple tap will do.
* The presentation is formatted better visually.
* Tapping any IP address copies it to the pasteboard.

The public source files here remain the very alpha ones (ver.0.0.1), simply gathering the IP info and it only works by 3D-pressing the toggle.

**Version 0.0.1 (2018-03-21)**

The toggle doesn't toggle anything, 3D-pressing it shows the info. It updates the info each time the toggle is 3D-touched, not live.
In order to compile this, one needs the headers and Frameworks dirs from [SiloToggleModule example](https://github.com/ioscreatix/SiloToggleModule) by [ioscreatix](https://github.com/ioscreatix), and theos of course.

The compiled .deb is 64-bit only. iOS >= 11.
