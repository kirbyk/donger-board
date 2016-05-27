//
//  DongerKey.swift
//  DongerBoard
//
//  Created by Nicholas Larew on 5/27/16.
//  Copyright © 2016 Kirby Kohlmorgen. All rights reserved.
//

import Foundation
import UIKit

protocol DongerKeyDelegate: class {
    func didTapDonger()
}

class DongerKey {
    var title: String!
    var button: UIButton!
    
    init(title: String) {
        self.title = title
    }
    
    func addButton(font: String = "San Francisco", spacing: CGFloat = 10, view: UIView, leftAnchorAlign: NSLayoutXAxisAnchor, keyboardLevel: Int) {
        self.button = UIButton()

        button.tag = keyboardLevel  // This is hacky but is used to differentiate between category buttons and donger keys
        
        button.setTitle(self.title, forState: .Normal)
        button.titleLabel!.font = UIFont(name: font, size: 20)
        button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        button.backgroundColor = UIColor(red:0.37, green:0.76, blue:0.89, alpha:1.00)
        button.layer.cornerRadius = 4.0
        button.sizeToFit()
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.addTarget(self, action: #selector(self.onButtonTap), forControlEvents: UIControlEvents.TouchUpInside)
        
        view.addSubview(button)
        
        button.leftAnchor.constraintEqualToAnchor(leftAnchorAlign, constant: spacing).active = true
        button.bottomAnchor.constraintEqualToAnchor(view.bottomAnchor, constant: -5).active = true
    }
    
    @objc func onButtonTap() {}
}

// 'ABC' button that goes to next keyboard
class dongerButton: DongerKey {
    weak var delegate: ControlKeyDelegate?
    
    override func onButtonTap() {
        delegate?.advanceNextKeyboard()
    }
}