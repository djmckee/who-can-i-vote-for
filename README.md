# who-can-i-vote-for
An iOS app that tells you who you can vote for in your area in the 2015 UK General Election, using data from [yournextmp.com](https://yournextmp.com)'s API, written entirely in Swift.

##Frameworks/libraries/things used
* [Alamofire](https://github.com/Alamofire/Alamofire) helps hugely with the networking and allows for relatively painless communication with the [yournextmp.com](https://yournextmp.com) API.
* [Reachability.swift](https://github.com/ashleymills/Reachability.swift) does a fantastic job of working out if the user's got an active internet connection at the moment - all in Swift.
* [That Thing in Swift](https://thatthinginswift.com) was incredibly useful (especially in transitioning from Objective-C)