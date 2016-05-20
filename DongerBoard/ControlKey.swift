//
//  ControlKey.swift
//  Donger
//
//  Created by Everett Berry on 5/18/16.
//  Copyright © 2016 Kirby Kohlmorgen. All rights reserved.
//

import Foundation
import UIKit

protocol ControlKeyDelegate: class {
    
    func switchKeyboardTapped()
    func advanceNextKeyboard()
}

class ControlKey {
    var title: String!
    var button: UIButton!
    
    init(title: String) {
        self.title = title
    }
    
    func addButton(font: String = "FontAwesome", spacing: CGFloat = 10, view: UIView, leftAnchorAlign: NSLayoutXAxisAnchor) {
        self.button = UIButton()
        
        button.setTitle(self.title, forState: .Normal)
        button.titleLabel!.font = UIFont(name: font, size: 20)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(self.onButtonTap), forControlEvents: .TouchUpInside)
        
        view.addSubview(button)
        
        button.leftAnchor.constraintEqualToAnchor(leftAnchorAlign, constant: spacing).active = true
        button.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -5).active = true
    }
    
    @objc func onButtonTap() {}
    
}

// Check out: http://stephenradford.me/creating-a-delegate-in-swift/
class SwitchBackCategories: ControlKey {
    weak var delegate: ControlKeyDelegate?
    
    override func onButtonTap() {
        delegate?.switchKeyboardTapped()
    }
    
}

// 'ABC' button that goes to next keyboard
class NextKeyboardButton: ControlKey {
    weak var delegate: ControlKeyDelegate?
    
    override func onButtonTap() {
        delegate?.advanceNextKeyboard()
    }
}