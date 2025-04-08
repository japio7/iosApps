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
    var odds = combo(40, 6)
    
    // Controls
    @IBOutlet weak var lblLottoNumbers: UILabel!
    @IBOutlet weak var lblNumbers: UILabel!
    @IBOutlet weak var lblRandomString: UILabel!
    
    @IBAction func btnGenerate(_ sender: UIButton) {
        
        // Random Numbers
        for i in 0...intNumbers.count-1 {
            intNumbers[i] = Int(arc4random_uniform(40))+1
        }
        
        while intNumbers[0] == intNumbers[1] || intNumbers[0] == intNumbers[2] || intNumbers[0] == intNumbers[3] || intNumbers[0] == intNumbers[4] || intNumbers[0] == intNumbers[5] ||
            intNumbers[1] == intNumbers[2] || intNumbers[1] == intNumbers[3] || intNumbers[1] == intNumbers[4] || intNumbers[1] == intNumbers[5] ||
            intNumbers[2] == intNumbers[3] || intNumbers[2] == intNumbers[4] || intNumbers[2] == intNumbers[5] ||
            intNumbers[3] == intNumbers[4] || intNumbers[3] == intNumbers[5] ||
            intNumbers[4] == intNumbers[5] {
            for i in 0...intNumbers.count-1 {
                intNumbers[i] = Int(arc4random_uniform(40))+1
            }
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
