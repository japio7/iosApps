//
//  Pick3.swift
//  Random lucky numbers
//
//  Created by Jared Pino on 3/4/18.
//  Copyright © 2018 Jared Pino. All rights reserved.
//

import UIKit

class Pick3: UIViewController {
    
    
    // Controls
    @IBOutlet weak var lblPick3: UILabel!
    @IBOutlet weak var lblNumbers: UILabel!
    @IBOutlet weak var lblRandomString: UILabel!
    
    @IBAction func btnGenerate(_ sender: UIButton) {
        
        // Create an array to hold the three numbers.
        var intNumbers = [0, 1, 2,]                     // Array declaration.
        
        // Random Numbers
        let rand1 = Int(arc4random_uniform(8))               // Random number for numbers between 0 and 8.
        let rand2 = Int(arc4random_uniform(8))               // Random number for numbers between 0 and 8.
        let rand3 = Int(arc4random_uniform(8))               // Random number for numbers between 0 and 8.
    
        // First number.
        intNumbers[0] = rand1
        
        // Second number.
        intNumbers[1] = rand2
        
        // Third number.
        intNumbers[2] = rand3
        
        // Fill the Pick 3 numbers label.
        lblPick3.text = "Your Pick 3 Numbers!"
        
        // Order the array from smallest to biggest.
        intNumbers.sort(by: <)
        
        // Print the Pick 3 numbers.
        lblNumbers.text = "\(intNumbers[0])        \(intNumbers[1])        \(intNumbers[2])"
        
        // Print the random string.
        lblRandomString.text = randomString()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lblPick3.text = ""
        lblNumbers.text = ""
        lblRandomString.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
