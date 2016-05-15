//
//  Donger.swift
//  Donger
//
//  Created by Everett Berry on 5/15/16.
//  Copyright © 2016 Kirby Kohlmorgen. All rights reserved.
//

import Foundation
import UIKit


class Donger {
    
    // "inspired by" http://code.tutsplus.com/tutorials/working-with-json-in-swift--cms-25335 
    func readDongerFile() {
        // NOTE: dongers.json appears to not display correctly in Xcode but it's fine
        let url = NSBundle.mainBundle().URLForResource("data/dongers", withExtension: "json")
        let data = NSData(contentsOfURL: url!)
        
        do {
            let object = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
            if let dictionary = object as? [String: AnyObject] {
                readJSONObject(dictionary)
            }
        } catch {
            // Handle Error
            print("Error")
        }
    }
    
    func readJSONObject(object: [String: AnyObject]) {
        
        let somedonger = object["MAGIC"];
        print(somedonger)
    }
}