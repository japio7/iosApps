//
//  Lotto.swift
//  Random lucky numbers
//
//  Created by Jared Pino on 3/4/18.
//  Copyright © 2018 Jared Pino. All rights reserved.
//

import UIKit

class Lotto: UIViewController {
    
    // Create an array to hold the six numbers.
    var intNumbers = [0, 1, 2, 3, 4, 5]                     // Array declaration.
    
    // Controls
    @IBOutlet weak var lblLottoNumbers: UILabel!
    @IBOutlet weak var lblNumbers: UILabel!
    @IBOutlet weak var lblRandomString: UILabel!
    
    func genRandNums1() {
        let rand1 = Int(arc4random_uniform(42))+1               // Random number for numbers between 1 and 42.
        let rand2 = Int(arc4random_uniform(42))+1               // Random number for numbers between 1 and 42.
        let rand3 = Int(arc4random_uniform(42))+1               // Random number for numbers between 1 and 42.
        let rand4 = Int(arc4random_uniform(42))+1               // Random number for numbers between 1 and 42.
        let rand5 = Int(arc4random_uniform(42))+1               // Random number for numbers between 1 and 42.
        let rand6 = Int(arc4random_uniform(42))+1               // Random number for numbers between 1 and 42.
        intNumbers[0] = rand1
        intNumbers[1] = rand2
        intNumbers[2] = rand3
        intNumbers[3] = rand4
        intNumbers[4] = rand5
        intNumbers[5] = rand6
    }
    func genRandNums2() {
        let rand1 = Int(arc4random_uniform(42))+1               // Random number for numbers between 1 and 42.
        let rand2 = Int(arc4random_uniform(42))+1               // Random number for numbers between 1 and 42.
        let rand3 = Int(arc4random_uniform(42))+1               // Random number for numbers between 1 and 42.
        let rand4 = Int(arc4random_uniform(42))+1               // Random number for numbers between 1 and 42.
        let rand5 = Int(arc4random_uniform(42))+1               // Random number for numbers between 1 and 42.
        let rand6 = Int(arc4random_uniform(42))+1               // Random number for numbers between 1 and 42.
        intNumbers[0] = rand1
        intNumbers[1] = rand2
        intNumbers[2] = rand3
        intNumbers[3] = rand4
        intNumbers[4] = rand5
        intNumbers[5] = rand6
    }
    
    @IBAction func btnGenerate(_ sender: UIButton) {
        
        // Random Numbers
        let rand1 = Int(arc4random_uniform(42))+1               // Random number for numbers between 1 and 42.
        let rand2 = Int(arc4random_uniform(42))+1               // Random number for numbers between 1 and 42.
        let rand3 = Int(arc4random_uniform(42))+1               // Random number for numbers between 1 and 42.
        let rand4 = Int(arc4random_uniform(42))+1               // Random number for numbers between 1 and 42.
        let rand5 = Int(arc4random_uniform(42))+1               // Random number for numbers between 1 and 42.
        let rand6 = Int(arc4random_uniform(42))+1               // Random number for numbers between 1 and 42.
        
        // Random Numbers
        intNumbers[0] = rand1
        intNumbers[1] = rand2
        intNumbers[2] = rand3
        intNumbers[3] = rand4
        intNumbers[4] = rand5
        intNumbers[5] = rand6
        
        while intNumbers[0] == intNumbers[1] || intNumbers[0] == intNumbers[2] || intNumbers[0] == intNumbers[3] || intNumbers[0] == intNumbers[4] || intNumbers[0] == intNumbers[5] ||
            intNumbers[1] == intNumbers[2] || intNumbers[1] == intNumbers[3] || intNumbers[1] == intNumbers[4] || intNumbers[1] == intNumbers[5] ||
            intNumbers[2] == intNumbers[3] || intNumbers[2] == intNumbers[4] || intNumbers[2] == intNumbers[5] ||
            intNumbers[3] == intNumbers[4] || intNumbers[3] == intNumbers[5] ||
            intNumbers[4] == intNumbers[5] {
                genRandNums1()
                genRandNums2()
        }
        
        // Fill the Lotto numbers label.
        lblLottoNumbers.text = "Your Lotto Numbers!"
        
        // Order the numbers from smallest to biggest.
        intNumbers.sort(by: <)
        
        // Print the Lotto numbers
        lblNumbers.text = "\(intNumbers[0])     \(intNumbers[1])     \(intNumbers[2])     \(intNumbers[3])     \(intNumbers[4])     \(intNumbers[5])"
        
        // Print the random string.
        lblRandomString.text = randomString()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblLottoNumbers.text = ""
        lblNumbers.text = ""
        lblRandomString.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
