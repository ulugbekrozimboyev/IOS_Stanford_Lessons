//
//  ViewController.swift
//  Calculator
//
//  Created by Ulugbek on 2/18/17.
//  Copyright © 2017 Ulugbek. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var displayNumber:Int = 0
    
    var userIsInTyping = false

    @IBOutlet weak var displayLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func touchDigit(_ sender: UIButton) {
        
        let number = sender.currentTitle!
        print("\(number) clicked")
        
        if userIsInTyping {
            displayLabel.text = displayLabel.text! + number
        } else {
            displayLabel.text = number
        }
        userIsInTyping = true
    }

    @IBAction func performOperation(_ sender: UIButton) {
        userIsInTyping = false
        if let mathematicalSymbol = sender.currentTitle {
            
            if mathematicalSymbol == "P" {
                displayLabel.text = "\(M_PI)"
            }
            
        }
    }
}

