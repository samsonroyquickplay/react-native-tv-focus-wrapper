# react-native-tv-focus-wrapper

React native tv focus wrapper, this wrapper was made to overcome focus delay issues when setting style from JS thread. Now we only support TVOS and soon androidTV and firestick. One other pending issue is to send animation and focus style from RN.

## Installation

```sh
npm install react-native-tv-focus-wrapper
```

## Usage

```js
import TvFocusWrapperView from "react-native-tv-focus-wrapper";

// ...
<TvFocusWrapperView>
  <View style={{ width: 100, height: 100, backgroundColor: 'blue' }} />
</TvFocusWrapperView>
```

## Contributing

See the [contributing guide](CONTRIBUTING.md) to learn how to contribute to the repository and the development workflow.

## License

MIT

---

Made with [create-react-native-library](https://github.com/callstack/react-native-builder-bob)
