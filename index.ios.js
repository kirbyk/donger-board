'use strict';

import React from 'react';
import {
  AppRegistry,
  StyleSheet,
  Text,
  View,
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
    marginTop: 20,
    marginBottom: 60
  },
  setKeyboardColorButton: {
    marginTop: 20,
    alignSelf: 'center',
  },
  setKeyboardColorText: {
    fontSize: 20,
  }
});

class DongerBoardApp extends React.Component {
  constructor(props) {
    super(props);

    // These are the initial colors of the key in KeyboardViewController.swift
    this.state = {
      redValue: .37,
      greenValue: .76,
      blueValue: .89
    };
  }

  onPressButton() {
    // Pass the keyboard color variables to this swift function
    NativeModules.KeyboardManager.recordColor(this.state.color, 
        this.state.redValue, 
        this.state.greenValue, 
        this.state.blueValue);
  }

  // Called by each style component to dynamically update the colors
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

          <Text style={this.getColor()}>
            Red - {(this.state.redValue * 256).toFixed(0)}
          </Text>
          <Slider
            value={this.state.redValue}
            onValueChange={(value) => this.setState({redValue: value})} />

          <Text style={this.getColor()}>
            Green - {(this.state.greenValue * 256).toFixed(0)}
          </Text>
          <Slider
            value={this.state.greenValue}
            onValueChange={(value) => this.setState({greenValue: value})} />

          <Text style={this.getColor()}>
            Blue - {(this.state.blueValue * 256).toFixed(0)}
          </Text>
          <Slider
            value={this.state.blueValue}
            onValueChange={(value) => this.setState({blueValue: value})} />

          <TouchableOpacity 
            style={styles.setKeyboardColorButton}
            onPress={this.onPressButton.bind(this)}>
            <Text style={[styles.setKeyboardColorText, this.getColor()]}>
              Set Keyboard Color
            </Text>
          </TouchableOpacity>

        </View>
      </View>
    )
  }
}

AppRegistry.registerComponent('DongerBoardApp', () => DongerBoardApp);
