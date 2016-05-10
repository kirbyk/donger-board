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
    
    let greyColor = UIColor(red:0.35, green:0.34, blue:0.35, alpha:1.00)
    
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
        
        self.containerView = UIView()
        
        for (i, category) in categories.enumerate() {
            let button = UIButton(type: .System)
            
            let xVal = (CGFloat)(buttonWidth + buttonSpacing) * CGFloat(i / numRows) + buttonSpacing
            let yVal = (CGFloat)(buttonHeight + buttonSpacing) * CGFloat(i % numRows) + buttonSpacing
            
            button.frame = CGRectMake(xVal, yVal, buttonWidth, buttonHeight)
            button.backgroundColor = UIColor(red:0.37, green:0.76, blue:0.89, alpha:1.00)
            button.setTitle(category, forState: UIControlState.Normal)
            button.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            button.addTarget(self, action: #selector(self.didTapDongerButton), forControlEvents: UIControlEvents.TouchUpInside)
            
            containerView.addSubview(button)
        }
        
        scrollView.addSubview(containerView)

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
        self.addDeleteButton()
    }

    func addNextKeyboardButton() {
        self.nextKeyboardButton = UIButton(frame: CGRect(x: 0, y: self.scrollView.bounds.height, width: 100, height: 40))
        
        self.nextKeyboardButton.setTitle("ABC", forState: .Normal)
        self.nextKeyboardButton.titleLabel!.font = UIFont(name: "HelveticaNeue", size: 20)
        self.nextKeyboardButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.nextKeyboardButton.sizeToFit()
        self.nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.nextKeyboardButton.addTarget(self, action: #selector(UIInputViewController.advanceToNextInputMode), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(self.nextKeyboardButton)
        
        // pin to the botton left corner
        self.nextKeyboardButton.leftAnchor.constraintEqualToAnchor(self.view.leftAnchor, constant: 20).active = true
        self.nextKeyboardButton.bottomAnchor.constraintEqualToAnchor(self.view.bottomAnchor, constant: -6).active = true
    }
    
    func addDeleteButton() {
        let deleteButton = UIImage(named: "delete.png")
        let imageView = UIImageView(image: deleteButton!)
        imageView.frame = CGRect(x: self.scrollView.bounds.width - 30 - 20, y: self.scrollView.bounds.height + 5, width: 30, height: 20)
        self.view.addSubview(imageView)
    }
    
    func didTapDongerButton() {
        print("didTapDongerButton")
        
        let proxy = self.textDocumentProxy
        proxy.insertText("༼つ ◕_◕ ༽つ")
    }
}
