DongerBoard
============

An iOS keyboard for [Dongers](http://dongerlist.com/).

> e.g., ༼つ ◕_◕ ༽つ

There are two main components to this iOS Application.

- **Custom Keyboard Extension** - This is what most people think of when they think of the *application*. It is an [iOS Extension](https://developer.apple.com/app-extensions/) in the form of an iOS keyboard. It's written in [Swift](https://github.com/apple/swift).
- **Application** - This is the actual iOS application from which the Custom Keyboard Extension extends from. The *Application* is what you actually download and install from the App Store. It's written in [React Native](https://github.com/facebook/react-native).

## Development

### Installation

```bash
brew install watchman flow
gem install cocoapods
npm install
pod install
```

### Building & Running

```bash
npm start
```

Open `DongerBoard.xcworkspace` and click the play button.

### Releasing App onto Phone
First, make sure react native command line tools are installed or run:  
```
npm install -g react-native-cli
```  

Run the following react-native command to transform the latest JS changes into a bundle. You may need to 'Add this file' to Xcode under the file manager if it does not already exist under the resources tab. Note that I am not including the jsbundle file in version control for now.
```
react-native bundle --entry-file ./index.ios.js --platform ios --bundle-output Resources/main.jsbundle
```  
Now "Edit Scheme" in Xcode to build and run a release version of the app and the bundle will be included on the phone.

