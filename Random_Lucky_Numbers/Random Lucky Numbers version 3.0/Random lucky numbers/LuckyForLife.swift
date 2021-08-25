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
    
    // Controls
    @IBOutlet weak var lblLuckyNumbers: UILabel!
    @IBOutlet weak var lblNumbers: UILabel!
    @IBOutlet weak var lblLuckyNumber: UILabel!
    @IBOutlet weak var lblRandomString: UILabel!
    
    func genRandNums1() {
        let rand1 = Int(arc4random_uniform(48))+1               // Random number for numbers between 1 and 48.
        let rand2 = Int(arc4random_uniform(48))+1               // Random number for numbers between 1 and 48.
        let rand3 = Int(arc4random_uniform(48))+1               // Random number for numbers between 1 and 48.
        let rand4 = Int(arc4random_uniform(48))+1               // Random number for numbers between 1 and 48.
        let rand5 = Int(arc4random_uniform(48))+1               // Random number for numbers between 1 and 48.
        intNumbers[0] = rand1
        intNumbers[1] = rand2
        intNumbers[2] = rand3
        intNumbers[3] = rand4
        intNumbers[4] = rand5
    }
    func genRandNums2() {
        let rand1 = Int(arc4random_uniform(48))+1               // Random number for numbers between 1 and 48.
        let rand2 = Int(arc4random_uniform(48))+1               // Random number for numbers between 1 and 48.
        let rand3 = Int(arc4random_uniform(48))+1               // Random number for numbers between 1 and 48.
        let rand4 = Int(arc4random_uniform(48))+1               // Random number for numbers between 1 and 48.
        let rand5 = Int(arc4random_uniform(48))+1               // Random number for numbers between 1 and 48.
        intNumbers[0] = rand1
        intNumbers[1] = rand2
        intNumbers[2] = rand3
        intNumbers[3] = rand4
        intNumbers[4] = rand5
    }
    
    @IBAction func btnGenerate(_ sender: UIButton) {
        
        var intLuckyNumber: Int = 1                             // To hold the lucky number.
        
        // Random numbers.
        let rand1 = Int(arc4random_uniform(48))+1               // Random number for numbers between 1 and 48.
        let rand2 = Int(arc4random_uniform(48))+1               // Random number for numbers between 1 and 48.
        let rand3 = Int(arc4random_uniform(48))+1               // Random number for numbers between 1 and 48.
        let rand4 = Int(arc4random_uniform(48))+1               // Random number for numbers between 1 and 48.
        let rand5 = Int(arc4random_uniform(48))+1               // Random number for numbers between 1 and 48.
        let randLuckyNum = Int(arc4random_uniform(18))+1           // Random number for PB number between 1 and 18.
        
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
        
        // Lucky Number
        intLuckyNumber = randLuckyNum
        
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
