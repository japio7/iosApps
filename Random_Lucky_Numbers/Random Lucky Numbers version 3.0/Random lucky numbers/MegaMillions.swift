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
    
    // Controls
    @IBOutlet weak var lblMegaMillionsNumbers: UILabel!
    @IBOutlet weak var lblNumbers: UILabel!
    @IBOutlet weak var lblMegaBall: UILabel!
    @IBOutlet weak var lblRandomString: UILabel!
    
    func genRandNums1() {
        let rand1 = Int(arc4random_uniform(70))+1               // Random number for numbers between 1 and 70.
        let rand2 = Int(arc4random_uniform(70))+1               // Random number for numbers between 1 and 70.
        let rand3 = Int(arc4random_uniform(70))+1               // Random number for numbers between 1 and 70.
        let rand4 = Int(arc4random_uniform(70))+1               // Random number for numbers between 1 and 70.
        let rand5 = Int(arc4random_uniform(70))+1               // Random number for numbers between 1 and 70.
        intNumbers[0] = rand1
        intNumbers[1] = rand2
        intNumbers[2] = rand3
        intNumbers[3] = rand4
        intNumbers[4] = rand5
    }
    func genRandNums2() {
        let rand1 = Int(arc4random_uniform(70))+1               // Random number for numbers between 1 and 70.
        let rand2 = Int(arc4random_uniform(70))+1               // Random number for numbers between 1 and 70.
        let rand3 = Int(arc4random_uniform(70))+1               // Random number for numbers between 1 and 70.
        let rand4 = Int(arc4random_uniform(70))+1               // Random number for numbers between 1 and 70.
        let rand5 = Int(arc4random_uniform(70))+1               // Random number for numbers between 1 and 70.
        intNumbers[0] = rand1
        intNumbers[1] = rand2
        intNumbers[2] = rand3
        intNumbers[3] = rand4
        intNumbers[4] = rand5
    }
    
    @IBAction func btnGenerate(_ sender: UIButton) {
        
        var intMegaNum: Int = 1                         // To hold the power ball number.
        
        // Random Numbers
        let rand1 = Int(arc4random_uniform(70))+1               // Random number for numbers between 1 and 69.
        let rand2 = Int(arc4random_uniform(70))+1               // Random number for numbers between 1 and 69.
        let rand3 = Int(arc4random_uniform(70))+1               // Random number for numbers between 1 and 69.
        let rand4 = Int(arc4random_uniform(70))+1               // Random number for numbers between 1 and 69.
        let rand5 = Int(arc4random_uniform(70))+1               // Random number for numbers between 1 and 69.
        let randMegaNum = Int(arc4random_uniform(25))+1            // Random number for PB number between 1 and 25.
       
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
        
        // Mega Number
        intMegaNum = randMegaNum
        
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
