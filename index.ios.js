'use strict';

import React from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  Picker,
  NativeModules
} from 'react-native';

var styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
  }
});

class DongerBoardApp extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      color: "red"
    };
    /* TODO: use later for Picker
          selectedValue={this.state.color}
          onValueChange={(lang) => this.setState({color: "Blue"})}>
          */
  }

  pickerValueChanged(color) {
    console.log("JS: picker value changed to " + color);
    NativeModules.KeyboardManager.recordColor(color);
    this.setState({color: color});
  }

  render() {
    return (
        <View>
      <View style={styles.container}>
        <Text style={styles.welcome}>
          ༼つ ◕_◕ ༽つ
        </Text>
      </View>
      <View>
        <Picker 
          selectedValue={this.state.color}
          onValueChange={(val) => this.pickerValueChanged(val)}>
          <Picker.Item label="Red" value="red" />
          <Picker.Item label="Blue" value="blue" />
        </Picker>
      </View>
      </View>
    )
  }
}

AppRegistry.registerComponent('DongerBoardApp', () => DongerBoardApp);
