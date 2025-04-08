//
//  MegaMillions.swift
//  Random lucky numbers
//
//  Created by Jared Pino on 2/23/18.
//  Copyright © 2018 Jared Pino. All rights reserved.
//

import UIKit
import Foundation

class MegaMillions: UIViewController {
    
    // Create an array to hold the five numers.
    var intNumbers = [0, 1, 2, 3, 4]                 // Array declaration.
    var intMegaNum: Int = 1                          // To hold the power ball number.
    var odds = combo(70, 5) * 25
    
    // Controls
    @IBOutlet weak var lblMegaMillionsNumbers: UILabel!
    @IBOutlet weak var lblNumbers: UILabel!
    @IBOutlet weak var lblMegaBall: UILabel!
    @IBOutlet weak var lblRandomString: UILabel!
    
    @IBAction func btnGenerate(_ sender: UIButton) {
        
        // Random Numbers
        for i in 0...intNumbers.count-1 {
            intNumbers[i] = Int(arc4random_uniform(70))+1
        }
        
        while intNumbers[0] == intNumbers[1] || intNumbers[0] == intNumbers[2] || intNumbers[0] == intNumbers[3] || intNumbers[0] == intNumbers[4] ||
            intNumbers[1] == intNumbers[2] || intNumbers[1] == intNumbers[3] || intNumbers[1] == intNumbers[4] ||
            intNumbers[2] == intNumbers[3] || intNumbers[2] == intNumbers[4] ||
            intNumbers[3] == intNumbers[4] {
            for i in 0...intNumbers.count-1 {
                intNumbers[i] = Int(arc4random_uniform(70))+1
            }
        }
        
        // Mega Number
        intMegaNum = Int(arc4random_uniform(25))+1
        
        // Fill the Mega Millions numbers label.
        lblMegaMillionsNumbers.text = "Your Mega Millions Numbers!"
        
        // Order the numbers from smallest to largest.
        intNumbers.sort(by: <)
        
        // Print the Mega Millions numbers
        lblNumbers.text = "\(intNumbers[0])     \(intNumbers[1])     \(intNumbers[2])     \(intNumbers[3])     \(intNumbers[4])"
        
        // Print the Mega number.
        lblMegaBall.text = "\(intMegaNum)"
        
        // Print the random string.
        lblRandomString.text = randomString()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblMegaMillionsNumbers.text = ""
        lblNumbers.text = ""
        lblMegaBall.text = ""
        lblRandomString.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
