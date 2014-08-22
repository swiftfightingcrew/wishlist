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
        var chooseButtonFrame: CGRect = CGRectMake(40, CGRectGetMaxY(infoLabel.frame) + 20, CGRectGetWidth(self.view.frame) - 80, 40)
        chooseButton = UiUtil.createButton("Peter", myFrame: chooseButtonFrame)
        self.view.addSubview(chooseButton)
        // TODO: addTarget
    
        // New Button
        var newButtonFrame: CGRect = CGRectMake(40, CGRectGetMaxY(chooseButton.frame) + 20, CGRectGetWidth(self.view.frame) - 80, 40)
        newButton = UiUtil.createButton("Neuer Character", myFrame: newButtonFrame)
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
        // Landscape/Portrait Dimensionen neu zeichnen
        welcomeLabel.frame = CGRectMake(CGRectGetMinX(welcomeLabel.frame), CGRectGetMinY(welcomeLabel.frame), CGRectGetWidth(self.view.frame), CGRectGetHeight(welcomeLabel.frame))
    }
    
    // MARK: - Actions
    func newButtonTapped(sender: UIButton!) {
        println("Button Tapped")
        let newProfileViewController = NewProfileViewController()
        self.showViewController(newProfileViewController, sender: nil)
    }
}

