//
//  KeyboardViewController.swift
//  DongerBoard
//
//  Created by Kirby Kohlmorgen on 5/5/16.
//  Copyright © 2016 Kirby Kohlmorgen. All rights reserved.
//

import UIKit
import Donger

class KeyboardViewController: UIInputViewController {

    var nextKeyboardButton: UIButton!
    var recentButton: UIButton!
    var allButton: UIButton!
    var trendingButton: UIButton!
    var randomButton: UIButton!
    var tbdButton: UIButton!
    var switchButton: UIButton!
    
    var dongerButton: UIButton!
    
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
    
    let donger = Donger()
    
    let greyColor = UIColor(red:0.35, green:0.34, blue:0.35, alpha:1.00)
    let categoryButtonSpacing = CGFloat(10)
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = greyColor
  
        self.scrollView = UIScrollView()
        view.addSubview(scrollView)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.addButtons()
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
    
    
    
    // Layout either categories of dongers or donger keys themselves
    func layoutButtons(labels: [String], keyboardLevel: Int) {
        let numRows = 4
        let numColumns = 3
        
        let buttonSpacing = CGFloat(5)
        
        let buttonWidth = ( scrollView.bounds.width / CGFloat(numColumns) - buttonSpacing * (1 + 1 / CGFloat(numColumns)) ) * CGFloat(0.95)
        let buttonHeight = scrollView.bounds.height / CGFloat(numRows) - buttonSpacing * (1 + 1 / CGFloat(numRows))
        
        scrollView.contentSize.width = buttonSpacing + CGFloat(labels.count / numRows) * (buttonWidth + buttonSpacing)
        scrollView.contentSize.height = buttonSpacing + CGFloat(numRows) * (buttonHeight + buttonSpacing)
        
        // Layout buttons in columns of 4
        for (i, category) in labels.enumerate() {
            let button = UIButton(type: .System)
            
            let xVal = (CGFloat)(buttonWidth + buttonSpacing) * CGFloat(i / numRows) + buttonSpacing
            let yVal = (CGFloat)(buttonHeight + buttonSpacing) * CGFloat(i % numRows) + buttonSpacing
            
            button.frame = CGRectMake(xVal, yVal, buttonWidth, buttonHeight)
            button.backgroundColor = UIColor(red:0.37, green:0.76, blue:0.89, alpha:1.00)
            button.setTitle(category, forState: UIControlState.Normal)
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            button.tag = keyboardLevel  // This is hacky but is used to differentiate between category buttons and donger keys
            button.addTarget(self, action: #selector(self.didTapDongerButton), forControlEvents: UIControlEvents.TouchUpInside)
            
            containerView.addSubview(button)
        }
        
        // Add container with all buttons to the scroll view
        scrollView.addSubview(containerView)
    }

    func addButtons() {
        self.addNextKeyboardButton()
        self.addCategoryButtons()
        self.addDeleteButton()
    }

    func addNextKeyboardButton() {
        self.nextKeyboardButton = UIButton()
        
        self.nextKeyboardButton.setTitle("ABC", forState: .Normal)
        self.nextKeyboardButton.titleLabel!.font = UIFont(name: "HelveticaNeue", size: 20)
        self.nextKeyboardButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(UIInputViewController.advanceToNextInputMode), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.nextKeyboardButton)

        self.nextKeyboardButton.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor, constant: 20).active = true
        self.nextKeyboardButton.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor, constant: -5).active = true
    }
    
    func addCategoryButtons() {
        self.addRecentButton()
        self.addFavoriteButton()
        self.addAllButton()
        self.addTrendingButton()
        self.addRandomButton()
        self.addTBDButton()
        self.addSwitchButton()
    }
    
    func addRecentButton() {
        self.recentButton = UIButton()
        
        self.recentButton.setTitle("\u{f017}", forState: .Normal)
        self.recentButton.titleLabel!.font = UIFont(name: "FontAwesome", size: 20)
        self.recentButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.recentButton.sizeToFit()
        self.recentButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.recentButton)
        
        self.recentButton.leftAnchor.constraintEqualToAnchor(self.nextKeyboardButton.rightAnchor, constant: self.categoryButtonSpacing).active = true
        self.recentButton.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor, constant: -6).active = true
    }
    
    func addFavoriteButton() {
        self.switchButton = UIButton()
        
        self.switchButton.setTitle("\u{f004}", forState: .Normal)
        self.switchButton.titleLabel!.font = UIFont(name: "FontAwesome", size: 20)
        self.switchButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.switchButton.sizeToFit()
        self.switchButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.switchButton)
        
        self.switchButton.leftAnchor.constraintEqualToAnchor(self.recentButton.rightAnchor, constant: self.categoryButtonSpacing).active = true
        self.switchButton.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor, constant: -6).active = true
    }
    
    func addAllButton() {
        self.allButton = UIButton()
        
        self.allButton.setTitle("\u{f118}", forState: .Normal)
        self.allButton.titleLabel!.font = UIFont(name: "FontAwesome", size: 20)
        self.allButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.allButton.sizeToFit()
        self.allButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.allButton)
    
        self.allButton.leftAnchor.constraintEqualToAnchor(self.switchButton.rightAnchor, constant: self.categoryButtonSpacing).active = true
        self.allButton.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor, constant: -6).active = true
    }
    
    func addTrendingButton() {
        self.trendingButton = UIButton()
        
        self.trendingButton.setTitle("\u{f201}", forState: .Normal)
        self.trendingButton.titleLabel!.font = UIFont(name: "FontAwesome", size: 20)
        self.trendingButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.trendingButton.sizeToFit()
        self.trendingButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.trendingButton)
        
        self.trendingButton.leftAnchor.constraintEqualToAnchor(self.allButton.rightAnchor, constant: self.categoryButtonSpacing).active = true
        self.trendingButton.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor, constant: -6).active = true
    }
    
    func addRandomButton() {
        self.randomButton = UIButton()
        
        self.randomButton.setTitle("\u{f006}", forState: .Normal)
        self.randomButton.titleLabel!.font = UIFont(name: "FontAwesome", size: 20)
        self.randomButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.randomButton.sizeToFit()
        self.randomButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.randomButton)
        
        self.randomButton.leftAnchor.constraintEqualToAnchor(self.trendingButton.rightAnchor, constant: self.categoryButtonSpacing).active = true
        self.randomButton.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor, constant: -6).active = true
    }
    
    func addTBDButton() {
        self.tbdButton = UIButton()
        
        self.tbdButton.setTitle("\u{f002}", forState: .Normal)
        self.tbdButton.titleLabel!.font = UIFont(name: "FontAwesome", size: 20)
        self.tbdButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.tbdButton.sizeToFit()
        self.tbdButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.tbdButton)
        
        self.tbdButton.leftAnchor.constraintEqualToAnchor(self.randomButton.rightAnchor, constant: 15).active = true
        self.tbdButton.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor, constant: -6).active = true
    }
    
    func addSwitchButton() {
        self.switchButton = UIButton()
        
        self.switchButton.setTitle("\u{f24d}", forState: .Normal)
        self.switchButton.titleLabel!.font = UIFont(name: "FontAwesome", size: 20)
        self.switchButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.switchButton.sizeToFit()
        self.switchButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.switchButton)
        
        self.switchButton.leftAnchor.constraintEqualToAnchor(self.tbdButton.rightAnchor, constant: self.categoryButtonSpacing).active = true
        self.switchButton.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor, constant: -6).active = true
        
        self.switchButton.addTarget(self, action: #selector(self.didTapSwitchButton), forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func addDeleteButton() {
        let deleteButton = UIImage(named: "delete.png")
        
        let imageView = UIImageView(image: deleteButton!)
        imageView.frame = CGRect(x: self.scrollView.bounds.width - 30 - 20, y: self.scrollView.bounds.height + 8, width: 27, height: 18)
        
        self.view.addSubview(imageView)
    }
    
    func didTapDongerButton(sender:UIButton) {
        print("didTapDongerButton")
        let text = sender.currentTitle!
        
        // Based on the tag we assigned in the argument, either display a new view with keys OR
        // enter the donger that was tapped into the text field
        if (sender.tag == 0) {
            let keyLabels = donger.getDongers(text)
            print(keyLabels)
        
            self.layoutButtons(keyLabels, keyboardLevel: 1)
        } else if (sender.tag == 1) {
            let proxy = self.textDocumentProxy
            proxy.insertText(text)
        }
        
    }
    
    // Switch back to categories layout
    func didTapSwitchButton() {
        self.layoutButtons(categories, keyboardLevel: 0)
    }
}
