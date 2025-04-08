//
//  Cash5.swift
//  Random lucky numbers
//
//  Created by Jared Pino on 3/3/18.
//  Copyright © 2018 Jared Pino. All rights reserved.
//

import UIKit

class Cash5: UIViewController {
    
    // Create an array to hold the five numers.
    var intNumbers = [0, 1, 2, 3, 4]                 // Array declaration.
    var odds = combo(32, 5)
    
    // Controls
    @IBOutlet weak var lblCash5Numbers: UILabel!
    @IBOutlet weak var lblNumbers: UILabel!
    @IBOutlet weak var lblRandomString: UILabel!
    
    @IBAction func btnGenerate(_ sender: UIButton) {
        
        // Random Numbers
        for i in 0...intNumbers.count-1 {
            intNumbers[i] = Int(arc4random_uniform(32))+1
        }
        
        while intNumbers[0] == intNumbers[1] || intNumbers[0] == intNumbers[2] || intNumbers[0] == intNumbers[3] || intNumbers[0] == intNumbers[4] ||
            intNumbers[1] == intNumbers[2] || intNumbers[1] == intNumbers[3] || intNumbers[1] == intNumbers[4] ||
            intNumbers[2] == intNumbers[3] || intNumbers[2] == intNumbers[4] ||
            intNumbers[3] == intNumbers[4] {
            // Random Numbers
            for i in 0...intNumbers.count-1 {
                intNumbers[i] = Int(arc4random_uniform(32))+1
            }
        }
        
        // Fill the Cash 5 numbers label.
        lblCash5Numbers.text = "Your Cash 5 Numbers!"
        
        // Order the numbers from smallest to largest.
        intNumbers.sort(by: <)
        
        // Print the Cash 5 numbers
        lblNumbers.text = "\(intNumbers[0])     \(intNumbers[1])     \(intNumbers[2])     \(intNumbers[3])     \(intNumbers[4])"
        
        // Print the random string.
        lblRandomString.text = randomString()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblCash5Numbers.text = ""
        lblNumbers.text = ""
        lblRandomString.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
