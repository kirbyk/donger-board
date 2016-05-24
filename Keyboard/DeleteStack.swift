//
//  DeleteStack.swift
//  DongerBoard
//
//  Created by Everett Berry on 5/20/16.
//  Copyright © 2016 Kirby Kohlmorgen. All rights reserved.
//

import Foundation

/*  Dongers in general are of variable length.
    We use a stack to keep track of these lengths
    and push and pop when we insert and delete dongers.
    NOTE: I'm not sure if this data structure will persist if someone
    were to switch keyboards then come back to DongerBoard. In that case
    we would want to save the stack to the actual app.
 
    This code taken from: https://developer.apple.com/library/ios/documentation/Swift/Conceptual/Swift_Programming_Language/Generics.html
 */
struct DongerLengthStack {
    var items = [Int]()
    
    mutating func push(item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
}