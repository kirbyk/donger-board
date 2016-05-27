'use strict';

import React from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  Picker,
  NativeModules,
  Slider,
  TouchableOpacity
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
      color: "red",
      redValue: 0,
      greenValue: 0,
      blueValue: 0
    };
  }

  pickerValueChanged(color) {
    console.log("JS: picker value changed to " + color);
    // NativeModules.KeyboardManager.recordColor(color);
    this.setState({color: color});
  }

  onPressButton() {
    console.log("change keyboard color");
    NativeModules.KeyboardManager.recordColor(this.state.color, 
        this.state.redValue, 
        this.state.greenValue, 
        this.state.blueValue);
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
        <Text>Choose a preset color</Text>
        <Picker 
          selectedValue={this.state.color}
          onValueChange={(val) => this.pickerValueChanged(val)}>
          <Picker.Item label="Red" value="red" />
          <Picker.Item label="Blue" value="blue" />
        </Picker>

        <Text>Red</Text>
        <Text style={styles.text} >
          {(this.state.redValue * 256).toFixed(0)}
        </Text>
        <Slider
          {...this.props}
          onValueChange={(value) => this.setState({redValue: value})} 
        />

        <Text>Green</Text>
        <Text style={styles.text} >
          {(this.state.greenValue * 256).toFixed(0)}
        </Text>
        <Slider
          {...this.props}
          onValueChange={(value) => this.setState({greenValue: value})} 
        />

        <Text>Blue</Text>
        <Text style={styles.text} >
          {(this.state.blueValue * 256).toFixed(0)}
        </Text>
        <Slider
          {...this.props}
          onValueChange={(value) => this.setState({blueValue: value})} 
        />
        <TouchableOpacity onPress={this.onPressButton.bind(this)}>
          <Text>Set Keyboard Color</Text>
        </TouchableOpacity>
      </View>
      </View>
    )
  }
}

AppRegistry.registerComponent('DongerBoardApp', () => DongerBoardApp);
