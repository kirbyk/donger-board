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