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
    var recentButton: UIButton!
    var favoriteButton: UIButton!
    var allButton: UIButton!
    var trendingButton: UIButton!
    var randomButton: UIButton!
    var tbdButton: UIButton!
    
    var dongerButton: UIButton!
    
    var scrollView: UIScrollView!
    
    var dongerView: UIScrollView!
    
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
        
        let numRows = 4
        let numColumns = 3
        
        let buttonSpacing = CGFloat(5)
        
        let buttonWidth = ( self.scrollView.bounds.width / CGFloat(numColumns) - buttonSpacing * (1 + 1 / CGFloat(numColumns)) ) * CGFloat(0.95)
        let buttonHeight = self.scrollView.bounds.height / CGFloat(numRows) - buttonSpacing * (1 + 1 / CGFloat(numRows))
        
        self.scrollView.contentSize.width = buttonSpacing + CGFloat(categories.count / numRows) * (buttonWidth + buttonSpacing)
        self.scrollView.contentSize.height = self.view.frame.height
        
        self.containerView = UIView()
        
        print("inb4")
        
        for (i, category) in categories.enumerate() {
            let button = UIButton(type: .System)
            
            let xVal = (CGFloat)(buttonWidth + buttonSpacing) * CGFloat(i / numRows) + buttonSpacing
            let yVal = (CGFloat)(buttonHeight + buttonSpacing) * CGFloat(i % numRows) + buttonSpacing
            
            button.frame = CGRectMake(xVal, yVal, buttonWidth, buttonHeight)
            button.backgroundColor = UIColor(red:0.37, green:0.76, blue:0.89, alpha:1.00)
            button.setTitle(category, forState: UIControlState.Normal)
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            button.addTarget(self, action: #selector(self.didTapDongerButton), forControlEvents: UIControlEvents.TouchUpInside)
            
            self.containerView.addSubview(button)
        }
        
        self.scrollView.addSubview(containerView)

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height - 40) // TODO: replace 40 with bottom nav height
        containerView.frame = CGRectMake(0, 0, scrollView.contentSize.width, scrollView.contentSize.height)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
    }
    
    func addRecentButton() {
        self.recentButton = UIButton()
        
        self.recentButton.setTitle("", forState: .Normal)
        self.recentButton.titleLabel!.font = UIFont(name: "FontAwesome", size: 20)
        self.recentButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.recentButton.sizeToFit()
        self.recentButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.recentButton)
        
        self.recentButton.leftAnchor.constraintEqualToAnchor(self.nextKeyboardButton.rightAnchor, constant: self.categoryButtonSpacing).active = true
        self.recentButton.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor, constant: -6).active = true
    }
    
    func addFavoriteButton() {
        self.favoriteButton = UIButton()
        
        self.favoriteButton.setTitle("", forState: .Normal)
        self.favoriteButton.titleLabel!.font = UIFont(name: "FontAwesome", size: 20)
        self.favoriteButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.favoriteButton.sizeToFit()
        self.favoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.favoriteButton)
        
        self.favoriteButton.leftAnchor.constraintEqualToAnchor(self.recentButton.rightAnchor, constant: self.categoryButtonSpacing).active = true
        self.favoriteButton.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor, constant: -6).active = true
    }
    
    func addAllButton() {
        self.allButton = UIButton()
        
        self.allButton.setTitle("", forState: .Normal)
        self.allButton.titleLabel!.font = UIFont(name: "FontAwesome", size: 20)
        self.allButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.allButton.sizeToFit()
        self.allButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.allButton)
    
        self.allButton.leftAnchor.constraintEqualToAnchor(self.favoriteButton.rightAnchor, constant: self.categoryButtonSpacing).active = true
        self.allButton.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor, constant: -6).active = true
    }
    
    func addTrendingButton() {
        self.trendingButton = UIButton()
        
        self.trendingButton.setTitle("", forState: .Normal)
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
        
        self.randomButton.setTitle("", forState: .Normal)
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
        
        self.tbdButton.setTitle("", forState: .Normal)
        self.tbdButton.titleLabel!.font = UIFont(name: "FontAwesome", size: 20)
        self.tbdButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.tbdButton.sizeToFit()
        self.tbdButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.tbdButton)
        
        self.tbdButton.leftAnchor.constraintEqualToAnchor(self.randomButton.rightAnchor, constant: 15).active = true
        self.tbdButton.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor, constant: -6).active = true
    }
    
    func addDeleteButton() {
        let deleteButton = UIImage(named: "delete.png")
        
        let imageView = UIImageView(image: deleteButton!)
        imageView.frame = CGRect(x: self.scrollView.bounds.width - 30 - 20, y: self.scrollView.bounds.height + 8, width: 27, height: 18)
        
        self.view.addSubview(imageView)
    }
    
    func didTapDongerButton() {
        print("didTapDongerButton")
        
        let frame = CGRectMake(0, 0, containerView.bounds.width, containerView.bounds.height - 40)

        self.dongerView = UIScrollView(frame: frame)
        self.dongerView.backgroundColor = UIColor.blueColor()
        dongerView.contentSize.height = self.view.frame.height
        dongerView.contentSize.width = self.view.frame.width
        
        self.containerView.addSubview(dongerView)
        
        /*
        let proxy = self.textDocumentProxy
        proxy.insertText("༼つ ◕_◕ ༽つ")
        */
    }
}
