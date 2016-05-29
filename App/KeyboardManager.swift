//
//  KeyboardManager.swift
//  DongerBoard
//
//  Created by Everett Berry on 5/25/16.
//  Copyright © 2016 Kirby Kohlmorgen. All rights reserved.
//

import Foundation

@objc(KeyboardManager)
class KeyboardManager: NSObject {
    
    @objc func recordColor(color: String, red: Float, green: Float, blue: Float) {
        
        // Save user inputs for later use by the keyboard
        let defaults = NSUserDefaults(suiteName: "group.com.kirbykohlmorgen")
        defaults?.setObject(color, forKey: "keyboardColor")
        defaults?.setObject([red, green, blue], forKey: "keyboardRGB")
        defaults?.synchronize()
    }
    
}