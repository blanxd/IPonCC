# IPonCC
Shows all sorts of IP addresses for the device in the iOS Control Center. Cellular, WiFi and VPN, both IPv4 and IPv6.

**Version 1.0 (2018-04-07)**
* The version 1.0 is live now, no need to close/open it to see new data (not live technically, polling).
* No need to 3D-press it any more, a simple tap will do.
* The presentation is formatted better visually.
* Tapping any IP address copies it to the pasteboard.

The public source files here remain the very alpha ones (ver.0.0.1), simply gathering the IP info and it only works by 3D-pressing the toggle.

**Version 0.0.1 (2018-03-21)**
The toggle doesn't toggle anything, 3D-pressing it shows the info. It updates the info each time the toggle is 3D-touched, not live.
In order to compile this, one needs the headers and Frameworks dirs from [SiloToggleModule example](https://github.com/ioscreatix/SiloToggleModule) by [ioscreatix](https://github.com/ioscreatix), and theos of course.

The compiled .deb is 64-bit only. iOS >= 11.
