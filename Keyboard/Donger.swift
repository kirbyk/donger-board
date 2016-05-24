//
//  Donger.swift
//  DongerBoard
//
//  Created by Everett Berry on 5/15/16.
//  Copyright © 2016 Kirby Kohlmorgen. All rights reserved.
//

import Foundation
import UIKit


class Donger {
    
    // Open the json file from the bundle, pass it along, and return
    // the dongers for this category
    func getDongers(category: String) -> [String] {
        // NOTE: dongers.json appears to not display incorrectly in Xcode but it's fine
        var dongerArray = [String]()
        
        let url = NSBundle.mainBundle().URLForResource("dongers", withExtension: "json")
        let data = NSData(contentsOfURL: url!)
        
        do {
            let object = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
            
            // Goofy Swift method of reading JSON data - return dongers here
            if let dictionary = object as? [String: AnyObject] {
                dongerArray = readJSONObject(dictionary, category: category)
                return dongerArray
            }
        } catch {
            // Handle Error
            print("Error")
        }
        
        // TODO: Hopefully never reach this lol
        return []
    }
    
    // Read the dongers for this category
    func readJSONObject(object: [String: AnyObject], category: String) -> [String] {
        var categoryDongers = [String]()
        
        if let dongers = object[category] as? [String] {
            for donger in dongers {
                categoryDongers.append(donger)
            }
        }
        
        return categoryDongers
    }
}