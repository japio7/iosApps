//
//  PowerBall.swift
//  Random lucky numbers
//
//  Created by Jared Pino on 3/3/18.
//  Copyright © 2018 Jared Pino. All rights reserved.
//

import UIKit

class PowerBall: UIViewController {
    
    // Create an array to hold the five numers.
    var intNumbers = [0, 1, 2, 3, 4]                 // Array declaration.
    var intPowerBall: Int = 1                        // To hold the power ball number.
    var odds = combo(69, 5) * 26
    
    // Controls
    @IBOutlet weak var lblPowerBallNumbers: UILabel!
    @IBOutlet weak var lblNumbers: UILabel!
    @IBOutlet weak var lblPowerBall: UILabel!
    @IBOutlet weak var lblRandomString: UILabel!
    
    @IBAction func btnGenerate(_ sender: UIButton) {
        
        // Random Numbers
        for i in 0...intNumbers.count-1 {
            intNumbers[i] = Int(arc4random_uniform(69))+1
        }
        
        while intNumbers[0] == intNumbers[1] || intNumbers[0] == intNumbers[2] || intNumbers[0] == intNumbers[3] || intNumbers[0] == intNumbers[4] ||
            intNumbers[1] == intNumbers[2] || intNumbers[1] == intNumbers[3] || intNumbers[1] == intNumbers[4] ||
            intNumbers[2] == intNumbers[3] || intNumbers[2] == intNumbers[4] ||
            intNumbers[3] == intNumbers[4] {
            for i in 0...intNumbers.count-1 {
                intNumbers[i] = Int(arc4random_uniform(69))+1
            }
        }
        
        // PowerBall
        intPowerBall = Int(arc4random_uniform(26))+1
        
        // Fill the PowerBall numbers label.
        lblPowerBallNumbers.text = "Your PowerBall Numbers!"
        
        // Order the numbers from smallest to largest.
        intNumbers.sort(by: <)
        
        // Print the PowerBall numbers
        lblNumbers.text = "\(intNumbers[0])     \(intNumbers[1])     \(intNumbers[2])     \(intNumbers[3])     \(intNumbers[4])"
        
        // Print the PowerBall number.
        lblPowerBall.text = "\(intPowerBall)"
        
        // Print the random string.
        lblRandomString.text = randomString()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblPowerBallNumbers.text = ""
        lblNumbers.text = ""
        lblPowerBall.text = ""
        lblRandomString.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
