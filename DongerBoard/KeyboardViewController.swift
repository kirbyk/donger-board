//
//  KeyboardViewController.swift
//  DongerBoard
//
//  Created by Kirby Kohlmorgen on 5/5/16.
//  Copyright © 2016 Kirby Kohlmorgen. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {

    var nextKeyboardButton: UIButton!
    var dongerButton: UIButton!

    override func updateViewConstraints() {
        super.updateViewConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.addButtons()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

//    override func textDidChange(textInput: UITextInput?) {
//        var textColor: UIColor
//        let proxy = self.textDocumentProxy
//        
//        if proxy.keyboardAppearance == UIKeyboardAppearance.Dark {
//            textColor = UIColor.whiteColor()
//        } else {
//            textColor = UIColor.blackColor()
//        }
//        
//        self.nextKeyboardButton.setTitleColor(textColor, forState: .Normal)
//    }
    
    func addButtons() {
        self.addNextKeyboardButton()
        self.addDongerButton()
    }

    func addNextKeyboardButton() {
        self.nextKeyboardButton = UIButton(type: .System)
        
        self.nextKeyboardButton.setTitle("Next Keyboard", forState: .Normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(UIInputViewController.advanceToNextInputMode), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        // pin to the botton left corner
        self.nextKeyboardButton.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor).active = true
        self.nextKeyboardButton.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor).active = true
    }
    
    func addDongerButton() {
        self.dongerButton = UIButton(type: .System)
        
        self.dongerButton.setTitle("༼つ ◕_◕ ༽つ", forState: .Normal)
        self.dongerButton.sizeToFit()
        self.dongerButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.dongerButton.addTarget(self, action: #selector(self.didTapDongerButton), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.dongerButton)
        
        // center horizontally and vertically
        self.dongerButton.centerXAnchor.constraintEqualToAnchor(self.view.centerXAnchor).active = true
        self.dongerButton.centerYAnchor.constraintEqualToAnchor(self.view.centerYAnchor).active = true
    }
    
    func didTapDongerButton() {
        let proxy = self.textDocumentProxy
        proxy.insertText("༼つ ◕_◕ ༽つ")
    }
}
