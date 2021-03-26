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
    
    // Controls
    @IBOutlet weak var lblCash5Numbers: UILabel!
    @IBOutlet weak var lblNumbers: UILabel!
    @IBOutlet weak var lblRandomString: UILabel!
    
    func genRandNums1() {
        let rand1 = Int(arc4random_uniform(32))+1               // Random number for numbers between 1 and 32.
        let rand2 = Int(arc4random_uniform(32))+1               // Random number for numbers between 1 and 32.
        let rand3 = Int(arc4random_uniform(32))+1               // Random number for numbers between 1 and 32.
        let rand4 = Int(arc4random_uniform(32))+1               // Random number for numbers between 1 and 32.
        let rand5 = Int(arc4random_uniform(32))+1               // Random number for numbers between 1 and 32.
        intNumbers[0] = rand1
        intNumbers[1] = rand2
        intNumbers[2] = rand3
        intNumbers[3] = rand4
        intNumbers[4] = rand5
    }
    func genRandNums2() {
        let rand1 = Int(arc4random_uniform(32))+1               // Random number for numbers between 1 and 32.
        let rand2 = Int(arc4random_uniform(32))+1               // Random number for numbers between 1 and 32.
        let rand3 = Int(arc4random_uniform(32))+1               // Random number for numbers between 1 and 32.
        let rand4 = Int(arc4random_uniform(32))+1               // Random number for numbers between 1 and 32.
        let rand5 = Int(arc4random_uniform(32))+1               // Random number for numbers between 1 and 32.
        intNumbers[0] = rand1
        intNumbers[1] = rand2
        intNumbers[2] = rand3
        intNumbers[3] = rand4
        intNumbers[4] = rand5
    }
    
    @IBAction func btnGenerate(_ sender: UIButton) {
        
        // Random Numbers
        let rand1 = Int(arc4random_uniform(32))+1               // Random number for numbers between 1 and 32.
        let rand2 = Int(arc4random_uniform(32))+1               // Random number for numbers between 1 and 32.
        let rand3 = Int(arc4random_uniform(32))+1               // Random number for numbers between 1 and 32.
        let rand4 = Int(arc4random_uniform(32))+1               // Random number for numbers between 1 and 32.
        let rand5 = Int(arc4random_uniform(32))+1               // Random number for numbers between 1 and 32.
        
        // Random Numbers
        intNumbers[0] = rand1
        intNumbers[1] = rand2
        intNumbers[2] = rand3
        intNumbers[3] = rand4
        intNumbers[4] = rand5
        
        while intNumbers[0] == intNumbers[1] || intNumbers[0] == intNumbers[2] || intNumbers[0] == intNumbers[3] || intNumbers[0] == intNumbers[4] ||
            intNumbers[1] == intNumbers[2] || intNumbers[1] == intNumbers[3] || intNumbers[1] == intNumbers[4] ||
            intNumbers[2] == intNumbers[3] || intNumbers[2] == intNumbers[4] ||
            intNumbers[3] == intNumbers[4] {
                genRandNums1()
                genRandNums2()
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
