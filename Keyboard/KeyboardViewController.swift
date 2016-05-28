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
        //dongerButton.delegate = self
  
        self.scrollView = UIScrollView()
        view.addSubview(scrollView)
        
        // Scratching the surface on changing keyboard color
        let defaults = NSUserDefaults(suiteName: "group.com.kirbykohlmorgen")
        // defaults?.objectForKey("keyboardColor")
        
        if let keyboardColorPref = defaults?.stringForKey("keyboardColor") {
            print("In keyboard, color chosen is: " + keyboardColorPref)
        } else {
            print("Keyboard color not chosen: optional value not init'd")
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
        //heartButton.addButton(view: self.view, leftAnchorAlign: self.favoriteButton.button.rightAnchor)
        //allButton.addButton(view: self.view, leftAnchorAlign: self.heartButton.button.rightAnchor)
        //trendingButton.addButton(view: self.view, leftAnchorAlign: self.allButton.button.rightAnchor)
        searchButton.addButton(view: self.view, leftAnchorAlign: self.favoriteButton.button.rightAnchor)//trendingButton.button.rightAnchor)
        switchButton.addButton(view: self.view, leftAnchorAlign: self.searchButton.button.rightAnchor)
        deleteButton.addButton(view: self.view, leftAnchorAlign: self.switchButton.button.rightAnchor)
        
        //self.addDeleteButton()
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
        
        //var buttonWidth = ( scrollView.bounds.width / CGFloat(numColumns) - buttonSpacing * (1 + 1 / CGFloat(numColumns)) ) * CGFloat(0.95)
        let buttonHeight = scrollView.bounds.height / CGFloat(numRows) - buttonSpacingY * (1 + 1 / CGFloat(numRows))
        var buttonWidth = CGFloat(0)
        
        
        /*
        var incompleteColumn = false
        if labels.count % numRows != 0 {
            incompleteColumn = true
        }
        */
        
        //scrollView.contentSize.width = buttonSpacing + (incompleteColumn ? (CGFloat(labels.count / numRows)+1) * (buttonWidth + buttonSpacing) : CGFloat(labels.count / numRows) * (buttonWidth + buttonSpacing))
        //scrollView.contentSize.height = buttonSpacing + CGFloat(numRows) * (buttonHeight + buttonSpacing)
        
        // Layout buttons in columns of 4
        var finalScrollViewWidth = buttonSpacingX
        var xVal = CGFloat(0)
        for (i, category) in labels.enumerate() {
            
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
                buttonWidth = maxDongerInColumn + buttonPadding
                finalScrollViewWidth = xVal + buttonWidth
                
            }
 
            
            let button = UIButton(type: .System)
            //let xVal = (CGFloat)(buttonWidth + buttonSpacingX) * CGFloat(i / numRows) + buttonSpacingX //This line breaks x axis spacing
            let yVal = (CGFloat)(buttonHeight + buttonSpacingY) * CGFloat(i % numRows) + buttonSpacingY
            
            print("      x:"+String(xVal)+" y:"+String(yVal))
            
            button.frame = CGRectMake(xVal, yVal, buttonWidth, buttonHeight)
            button.backgroundColor = UIColor(red:0.37, green:0.76, blue:0.89, alpha:1.00)
            button.layer.cornerRadius = 4.0
            button.setTitle(category, forState: UIControlState.Normal)
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            button.tag = keyboardLevel  // This is hacky but is used to differentiate between category buttons and donger keys
            button.addTarget(self, action: #selector(self.didTapDongerButton), forControlEvents: UIControlEvents.TouchUpInside)
            
            
            containerView.addSubview(button)
        }
        finalScrollViewWidth += buttonSpacingX
        scrollView.contentSize.width = finalScrollViewWidth
        //scrollView.contentSize.width = buttonSpacing + (incompleteColumn ? (CGFloat(labels.count / numRows)+1) * (buttonWidth + buttonSpacing) : CGFloat(labels.count / numRows) * (buttonWidth + buttonSpacing))
        scrollView.contentSize.height = buttonSpacingY + CGFloat(numRows) * (buttonHeight + buttonSpacingY)
        
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
        scrollView.scrollRectToVisible(CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height - 40), animated: true)
        self.layoutButtons(categories, keyboardLevel: 0)
    }
}