//
//  LuckyForLife.swift
//  Random lucky numbers
//
//  Created by Jared Pino on 3/3/18.
//  Copyright © 2018 Jared Pino. All rights reserved.
//

import UIKit

class LuckyForLife: UIViewController {
    
    // Create an array to hold the five numers.
    var intNumbers = [0, 1, 2, 3, 4]                        // Array declaration.
    var intLuckyNumber: Int = 1                             // To hold the lucky number.
    var odds = combo(48, 5) * 18
    
    // Controls
    @IBOutlet weak var lblLuckyNumbers: UILabel!
    @IBOutlet weak var lblNumbers: UILabel!
    @IBOutlet weak var lblLuckyNumber: UILabel!
    @IBOutlet weak var lblRandomString: UILabel!
    
    @IBAction func btnGenerate(_ sender: UIButton) {
        
        // Random Numbers
        for i in 0...intNumbers.count-1 {
            intNumbers[i] = Int(arc4random_uniform(48))+1
        }
        
        while intNumbers[0] == intNumbers[1] || intNumbers[0] == intNumbers[2] || intNumbers[0] == intNumbers[3] || intNumbers[0] == intNumbers[4] ||
            intNumbers[1] == intNumbers[2] || intNumbers[1] == intNumbers[3] || intNumbers[1] == intNumbers[4] ||
            intNumbers[2] == intNumbers[3] || intNumbers[2] == intNumbers[4] ||
            intNumbers[3] == intNumbers[4] {
            // Random Numbers
            for i in 0...intNumbers.count-1 {
                intNumbers[i] = Int(arc4random_uniform(48))+1
            }
        }
        
        // Lucky Number
        intLuckyNumber = Int(arc4random_uniform(18))+1
        
        // Fill the lucky numbers label.
        lblLuckyNumbers.text = "Your Lucky for Life Numbers!"
        
        // Order the numbers from smallest to largest.
        intNumbers.sort(by: <)
        
        // Print the Lucky for Life numbers.
        lblNumbers.text = "\(intNumbers[0])     \(intNumbers[1])     \(intNumbers[2])     \(intNumbers[3])     \(intNumbers[4])"
        
        // Print the Lucky number.
        lblLuckyNumber.text = "\(intLuckyNumber)"
        
        // Print the random string.
        lblRandomString.text = randomString()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblLuckyNumbers.text = ""
        lblNumbers.text = ""
        lblLuckyNumber.text = ""
        lblRandomString.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
