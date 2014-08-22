//
//  ViewController.swift
//  Wishlist
//
//  Created by Bernhard Lotter on 05.08.14.
//  Copyright (c) 2014 SwiftFighters. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var welcomeLabel: UILabel!
    var infoLabel: UILabel!
    var chooseButton: UIButton!
    var newButton: UIButton!
    
    // MARK: - Meine Methoden
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Welcome-Text
        welcomeLabel = UILabel (frame: CGRectMake(0, 0, CGRectGetWidth(self.view.frame), 40))
        welcomeLabel.text = "Willkommen"
        welcomeLabel.font = UIFont(name: "Chalkduster", size: 16)
        welcomeLabel.backgroundColor = UIColor.clearColor()
        welcomeLabel.textAlignment = .Center
        self.view.addSubview(welcomeLabel)
        
        // Info Text
        infoLabel = UILabel (frame: CGRectMake(0, CGRectGetMaxY(welcomeLabel.frame), CGRectGetWidth(self.view.frame), 120))
        infoLabel.text = "wähle deinen Charakter aus oder erstelle einen neuen!"
        infoLabel.font = UIFont(name: "Chalkduster", size: 14)
        infoLabel.backgroundColor = UIColor.clearColor()
        infoLabel.textAlignment = .Center
        infoLabel.numberOfLines = 0
        self.view.addSubview(infoLabel)
        
        // Choose Button
        chooseButton = UIButton (frame: CGRectMake(40, CGRectGetMaxY(infoLabel.frame) + 20, CGRectGetWidth(self.view.frame) - 80, 40))
        chooseButton.setTitle("Peter", forState: UIControlState.Normal)
        chooseButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        chooseButton.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Highlighted)
        chooseButton.layer.borderWidth = 1.0
        chooseButton.backgroundColor = UIColor.whiteColor()
        chooseButton.layer.cornerRadius = 15
        self.view.addSubview(chooseButton)
    
        // New Button
        newButton = UIButton (frame: CGRectMake(40, CGRectGetMaxY(chooseButton.frame) + 20, CGRectGetWidth(self.view.frame) - 80, 40))
        newButton.setTitle("Neuer Character", forState: UIControlState.Normal)
        newButton.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        newButton.setTitleColor(UIColor.orangeColor(), forState: UIControlState.Highlighted)
        newButton.layer.borderWidth = 1.0
        newButton.backgroundColor = UIColor.whiteColor()
        newButton.layer.cornerRadius = 15
        self.view.addSubview(newButton)
        newButton.addTarget(self, action: "newButtonTapped:", forControlEvents: UIControlEvents.TouchUpInside)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prefersStatusBarHidden() -> Bool {
        // Versteckt die Statusbar
        return true
    }

    override func viewWillLayoutSubviews() {
        welcomeLabel.frame = CGRectMake(CGRectGetMinX(welcomeLabel.frame), CGRectGetMinY(welcomeLabel.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(welcomeLabel.frame))
    }
    
    // MARK: - Actions
    func newButtonTapped(sender: UIButton!) {
        println("Button Tapped")
        let newProfileViewController = NewProfileViewController()
        self.showViewController(newProfileViewController, sender: nil)
    }
}

