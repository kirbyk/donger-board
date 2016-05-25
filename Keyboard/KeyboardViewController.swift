//
//  KeyboardViewController.swift
//  DongerBoard
//
//  Created by Kirby Kohlmorgen on 5/5/16.
//  Copyright © 2016 Kirby Kohlmorgen. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController, ControlKeyDelegate {

    var nextKeyboardButton = NextKeyboardButton(title: "ABC")
    var recentButton = ControlKey(title: "\u{f017}")
    var favoriteButton = ControlKey(title: "\u{f006}")
    var heartButton = ControlKey(title: "\u{f004}")
    var allButton = ControlKey(title: "\u{f118}")
    var trendingButton = ControlKey(title: "\u{f201}")
    var searchButton = ControlKey(title: "\u{f002}")
    var switchButton = SwitchBackCategories(title: "\u{f24d}")
    
    var scrollView: UIScrollView!
    var containerView = UIView()

    let categories = [
        "ALL",
        "AMENO",
        "ANGRY",
        "ANIMAL",
        "BRICK",
        "COOL",
        "CRACKER",
        "CRAZY",
        "CRY",
        "CUTE",
        "DANCE",
        "DEAD",
        "DONGER",
        "DUNNO",
        "EXCITED",
        "FIGHT",
        "FINGER",
        "FLEX",
        "FLIP",
        "FLOWER",
        "GLASSES",
        "GUN",
        "HAPPY",
        "HUH",
        "LENNY",
        "LOWER",
        "MAD",
        "MAGIC",
        "MAN",
        "MEH",
        "MOB",
        "MONOCLE",
        "MUSIC",
        "POINT",
        "PYRAMID",
        "RAISE",
        "RUN",
        "SAD",
        "SCARED",
        "SCARY",
        "SHOCKED",
        "SPIDER",
        "SURPRISED",
        "SWORD",
        "TABLE",
        "THROW",
        "TREE",
        "UGLY",
        "UPSET",
        "WALK",
        "WALL",
        "WHY"
    ]
    
    // Helper classes
    let donger = Donger()
    var dongerLengthStack = DongerLengthStack()
    
    let greyColor = UIColor(red:0.35, green:0.34, blue:0.35, alpha:1.00)
    let categoryButtonSpacing = CGFloat(10)
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = greyColor
        
        // "Register" delegate targets with this class
        switchButton.delegate = self
        nextKeyboardButton.delegate = self
  
        self.scrollView = UIScrollView()
        view.addSubview(scrollView)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.addKeyboardControlButtons()
        self.layoutButtons(categories, keyboardLevel: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height - 40) // TODO: replace 40 with bottom nav height
        containerView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // Layout bottom row of keyboard options (recent dongers, favorites, etc...)
    func addKeyboardControlButtons() {
        nextKeyboardButton.addButton("HelveticaNeue", spacing: CGFloat(20), view: self.view, leftAnchorAlign: self.view.leftAnchor)
        recentButton.addButton(view: self.view, leftAnchorAlign: self.nextKeyboardButton.button.rightAnchor)
        favoriteButton.addButton(view: self.view, leftAnchorAlign: self.recentButton.button.rightAnchor)
        heartButton.addButton(view: self.view, leftAnchorAlign: self.favoriteButton.button.rightAnchor)
        allButton.addButton(view: self.view, leftAnchorAlign: self.heartButton.button.rightAnchor)
        trendingButton.addButton(view: self.view, leftAnchorAlign: self.allButton.button.rightAnchor)
        searchButton.addButton(view: self.view, leftAnchorAlign: self.trendingButton.button.rightAnchor)
        switchButton.addButton(view: self.view, leftAnchorAlign: self.searchButton.button.rightAnchor)
        
        self.addDeleteButton()
    }
    
    // Layout either categories of dongers or donger keys themselves
    func layoutButtons(labels: [String], keyboardLevel: Int) {
        let numRows = 4
        let numColumns = 3
        
        let buttonSpacing = CGFloat(5)
        
        let buttonWidth = ( scrollView.bounds.width / CGFloat(numColumns) - buttonSpacing * (1 + 1 / CGFloat(numColumns)) ) * CGFloat(0.95)
        let buttonHeight = scrollView.bounds.height / CGFloat(numRows) - buttonSpacing * (1 + 1 / CGFloat(numRows))
        
        
        var incompleteColumn = false
        if labels.count % numRows != 0 {
            incompleteColumn = true
        }
        
        scrollView.contentSize.width = buttonSpacing + (incompleteColumn ? (CGFloat(labels.count / numRows)+1) * (buttonWidth + buttonSpacing) : CGFloat(labels.count / numRows) * (buttonWidth + buttonSpacing))
        scrollView.contentSize.height = buttonSpacing + CGFloat(numRows) * (buttonHeight + buttonSpacing)
        
        // Layout buttons in columns of 4
        for (i, category) in labels.enumerate() {
            let button = UIButton(type: .System)
            
            let xVal = (CGFloat)(buttonWidth + buttonSpacing) * CGFloat(i / numRows) + buttonSpacing
            let yVal = (CGFloat)(buttonHeight + buttonSpacing) * CGFloat(i % numRows) + buttonSpacing
            
            button.frame = CGRectMake(xVal, yVal, buttonWidth, buttonHeight)
            button.backgroundColor = UIColor(red:0.37, green:0.76, blue:0.89, alpha:1.00)
            button.layer.cornerRadius = 4.0
            button.setTitle(category, forState: UIControlState.Normal)
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            button.tag = keyboardLevel  // This is hacky but is used to differentiate between category buttons and donger keys
            button.addTarget(self, action: #selector(self.didTapDongerButton), forControlEvents: UIControlEvents.TouchUpInside)
            
            containerView.addSubview(button)
        }
        
        // Add container with all buttons to the scroll view
        scrollView.addSubview(containerView)
    }
    
    // TODO: remove hardcoded positioning
    func addDeleteButton() {
        let deleteButtonImg = UIImage(named: "delete.png")
        let deleteButton = UIButton(type: UIButtonType.Custom)
        deleteButton.setImage(deleteButtonImg, forState: .Normal)
        deleteButton.frame = CGRect(x: self.scrollView.bounds.width - 30 - 20, y: self.scrollView.bounds.height + 8, width: 27, height: 18)
        deleteButton.addTarget(self, action: #selector(self.didTapDelete), forControlEvents: UIControlEvents.TouchUpInside)

        self.view.addSubview(deleteButton)
    }
    
    func didTapDongerButton(sender:UIButton) {
        let text = sender.currentTitle!
        
        // Based on the tag we assigned in the argument, either display a new view with keys OR
        // enter the donger that was tapped into the text field
        if (sender.tag == 0) {
            let keyLabels = donger.getDongers(text)
            for view in containerView.subviews {
                view.removeFromSuperview()
            }
            self.layoutButtons(keyLabels, keyboardLevel: 1)
        } else if (sender.tag == 1) {
            let proxy = self.textDocumentProxy
            proxy.insertText(text)
            dongerLengthStack.push(text.characters.count)
        }
        
    }
    
    // Delete the entire length of the donger
    func didTapDelete() {
        let proxy = self.textDocumentProxy
        
        if let charsToDelete = dongerLengthStack.pop() {
            for _ in 0..<charsToDelete {
                proxy.deleteBackward()
            }
        }
        
    }
    
    // Next keyboard
    func advanceNextKeyboard() {
        super.advanceToNextInputMode()
    }
    
    // Switch back to categories layout
    func switchKeyboardTapped() {
        for view in containerView.subviews {
            view.removeFromSuperview()
        }
        self.layoutButtons(categories, keyboardLevel: 0)
    }
}