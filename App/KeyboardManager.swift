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
    
    @objc func recordColor(color: String) {
        print("In swift")
        print(color)
        
        let defaults = NSUserDefaults(suiteName: "group.com.kirbykohlmorgen")
        defaults?.setObject(color, forKey: "keyboardColor")
        defaults?.synchronize()
    }
    
}