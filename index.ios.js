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
    backgroundColor: '#5A585A',
  },
  contentcontainer: {
    flex: 1,
    margin: 20,
  },
  welcome: {
    fontSize: 16,
    textAlign: 'center',
    marginTop: 20
  },
  setKeyboardColorButton: {
    alignSelf: 'center',
  },
  setKeyboardColorText: {
    fontSize: 20,
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
    this.setState({color: color});
    /* NOTE: Picker component, moved here for later
          <Picker 
            selectedValue={this.state.color}
            onValueChange={(val) => this.pickerValueChanged(val)}>
            <Picker.Item label="Red" value="red" />
            <Picker.Item label="Blue" value="blue" />
          </Picker>
    */
  }

  onPressButton() {
    console.log("change keyboard color");
    NativeModules.KeyboardManager.recordColor(this.state.color, 
        this.state.redValue, 
        this.state.greenValue, 
        this.state.blueValue);
  }

  getColor = function() {
    var r = (this.state.redValue * 256).toFixed(0)
    var g = (this.state.greenValue * 256).toFixed(0)
    var b = (this.state.blueValue * 256).toFixed(0)

    return {
      color: 'rgba(' + r + ',' + g + ',' + b + ', 1.0)'
    }
  }
    
  render() {
    return (
      <View style={styles.container}>
        <View style={styles.contentcontainer}>
          <Text style={[styles.welcome, this.getColor()]}>
            (つ▀¯▀)つ Dongerboard Settings
          </Text>

          <View style={styles.colorchooser}>
            <Text style={this.getColor()}>Red</Text>
            <Text style={this.getColor()}>
              {(this.state.redValue * 256).toFixed(0)}
            </Text>
            <Slider
              {...this.props}
              onValueChange={(value) => this.setState({redValue: value})} 
            />

            <Text style={this.getColor()}>Green</Text>
            <Text style={this.getColor()}>
              {(this.state.greenValue * 256).toFixed(0)}
            </Text>
            <Slider
              {...this.props}
              onValueChange={(value) => this.setState({greenValue: value})} 
            />

            <Text style={this.getColor()}>Blue</Text>
            <Text style={this.getColor()}>
              {(this.state.blueValue * 256).toFixed(0)}
            </Text>
            <Slider
              {...this.props}
              onValueChange={(value) => this.setState({blueValue: value})} 
            />
            <TouchableOpacity 
              style={styles.setKeyboardColorButton}
              onPress={this.onPressButton.bind(this)}>
              <Text style={[styles.setKeyboardColorText, this.getColor()]}>
                Set Keyboard Color
              </Text>
            </TouchableOpacity>
          </View>

        </View>
      </View>
    )
  }
}

AppRegistry.registerComponent('DongerBoardApp', () => DongerBoardApp);
