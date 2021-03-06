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
    var deleteButton = DeleteButton(title: "\u{f100}")
    
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
    var keyColor = UIColor(red:0.37, green:0.76, blue:0.89, alpha:1.00)
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
        deleteButton.delegate = self
  
        self.scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        let defaults = NSUserDefaults(suiteName: "group.com.kirbykohlmorgen")
        
        if let keyboardColorPref = defaults?.stringForKey("keyboardColor") {
            print("In keyboard, color chosen is: " + keyboardColorPref)
        } else {
            print("Keyboard color not chosen: optional value not init'd")
        }
        
        print("here")
        if let kbRGB = defaults?.arrayForKey("keyboardRGB") {
            // I cannot be held responsbile for the ugliness of this code
            let _red = kbRGB[0] as! CGFloat
            let _green = kbRGB[1] as! CGFloat
            let _blue = kbRGB[2] as! CGFloat
            
            // Change keyboard color
            keyColor = UIColor(red: _red, green: _green, blue: _blue, alpha: 1.0)
        } else {
            print("Something went wrong selecting RGBs for keyboard")
        }
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
        searchButton.addButton(view: self.view, leftAnchorAlign: self.favoriteButton.button.rightAnchor)
        switchButton.addButton(view: self.view, leftAnchorAlign: self.searchButton.button.rightAnchor)
        deleteButton.addButton(view: self.view, leftAnchorAlign: self.switchButton.button.rightAnchor)
    }
    
    //Given a string, return a float of its width
    func evaluateStringWidth (textToEvaluate: String) -> CGFloat{
        let font = UIFont.systemFontOfSize(15)
        let attributes = NSDictionary(object: font, forKey:NSFontAttributeName)
        let sizeOfText = textToEvaluate.sizeWithAttributes((attributes as! [String : AnyObject]))
        
        return sizeOfText.width
    }
    
    // Layout either categories of dongers or donger keys themselves
    func layoutButtons(labels: [String], keyboardLevel: Int) {
        let numRows = 4
        let numColumns = 3
        
        let buttonSpacingX = CGFloat(5)
        let buttonSpacingY = CGFloat(5)
        let buttonPadding = CGFloat(20)
        
        let minButtonWidth = ( scrollView.bounds.width / CGFloat(numColumns) - buttonSpacingX * (1 + 1 / CGFloat(numColumns)) ) * CGFloat(0.95)
        let buttonHeight = scrollView.bounds.height / CGFloat(numRows) - buttonSpacingY * (1 + 1 / CGFloat(numRows))
        var buttonWidth = CGFloat(0)
        
        // Layout buttons in columns of 4, dynamically based on Donger size
        var finalScrollViewWidth = buttonSpacingX
        var xVal = CGFloat(0)
        for (i, category) in labels.enumerate() {
            let yVal = (CGFloat)(buttonHeight + buttonSpacingY) * CGFloat(i % numRows) + buttonSpacingY
            
            //For each column set buttonWidth to the width of the largest label
            if (i % numRows) == 0 {
                var maxDongerInColumn = CGFloat(0)
                
                //Handle the number of categories not being a multiple of numRows
                var currentColumnNumRows = numRows
                if (i + numRows) > labels.count{
                    currentColumnNumRows = labels.count - i
                }
                
                for j in i..<(i+currentColumnNumRows){
                    let currentWidth = evaluateStringWidth(labels[j])
                    if currentWidth > maxDongerInColumn {
                        maxDongerInColumn = currentWidth
                    }
                  }
                xVal += buttonWidth + buttonSpacingX
                buttonWidth = ((maxDongerInColumn + buttonPadding) > minButtonWidth ? maxDongerInColumn + buttonPadding : minButtonWidth)
                finalScrollViewWidth = xVal + buttonWidth
                
            }
 
            let button = UIButton(type: .System)
            
            button.frame = CGRectMake(xVal, yVal, buttonWidth, buttonHeight)
            button.backgroundColor = keyColor
            button.layer.cornerRadius = 4.0
            button.setTitle(category, forState: UIControlState.Normal)
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            button.tag = keyboardLevel  // This is hacky but is used to differentiate between category buttons and donger keys
            button.addTarget(self, action: #selector(self.didTapDongerButton), forControlEvents: UIControlEvents.TouchUpInside)
            
            
            containerView.addSubview(button)
        }
        finalScrollViewWidth += buttonSpacingX
        scrollView.contentSize.width = finalScrollViewWidth
        scrollView.contentSize.height = buttonSpacingY + CGFloat(numRows) * (buttonHeight + buttonSpacingY)
        
        // Add container with all buttons to the scroll view
        scrollView.addSubview(containerView)
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
            scrollView.scrollRectToVisible(CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height - 40), animated: false)
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
        scrollView.scrollRectToVisible(CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height - 40), animated: false)
        self.layoutButtons(categories, keyboardLevel: 0)
    }
}