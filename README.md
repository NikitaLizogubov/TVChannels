# TVChannels

## Architecture

The app is using 'VIPER+VM' architectural pattern (UIKit).

## Tools

1. Xcode 13.x
2. [Swift Package Manager](https://swift.org/package-manager/)

## Requirements

1. TVos 15.0+
2. Swift
3. UIKit

## API

* https://demo-c.cdn.vmedia.ca/json/Channels
* https://demo-c.cdn.vmedia.ca/json/ProgramItems

## UI:
![simulator_screenshot_1713663B-8DCE-4750-9607-1269A73A2BD2](https://github.com/NikitaLizogubov/TVChannels/assets/42281938/405569c5-eaeb-41d4-9b99-3931750eff0b)

## Requirements and implementation:
1. - [x] User should be able to scroll up/down and left/right through all channels and all available programs.

https://github.com/NikitaLizogubov/TVChannels/assets/42281938/0f166591-8db5-483b-8bb8-ca724ab7ba60

2. - [x] Creating extendable architecture, which will allow lazy-loading and caching of program items in the future.

> To implement lazy loading we must support a query parameter like: ?page=1 or ?limit=10.
