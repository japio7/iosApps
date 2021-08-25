//
//  LuckyForLife.swift
//  Random lucky numbers
//
//  Created by Jared Pino on 3/3/18.
//  Copyright © 2018 Jared Pino. All rights reserved.
//

import UIKit

class LuckyForLife: UIViewController {
    
    
    // Controls
    @IBOutlet weak var lblLuckyNumbers: UILabel!
    @IBOutlet weak var lblNumbers: UILabel!
    @IBOutlet weak var lblLuckyNumber: UILabel!
    @IBOutlet weak var lblRandomString: UILabel!
    
    @IBAction func btnHome(_ sender: UIButton) {
        
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
        
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromLeft
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        self.present(viewController, animated: true, completion: nil)
    }
    
    
    @IBAction func btnGenerate(_ sender: UIButton) {
        // Create an array to hold the five numers.
        var intNumbers = [0, 1, 2, 3, 4]                        // Array declaration.
        var intLuckyNumber: Int = 1                                  // To hold the power ball number.
        
        // Create an array of strings.
        
        
        // Create 5 random numbers.
        let rand1 = Int(arc4random_uniform(48))+1               // Random number for numbers between 1 and 48.
        let rand2 = Int(arc4random_uniform(48))+1               // Random number for numbers between 1 and 48.
        let rand3 = Int(arc4random_uniform(48))+1               // Random number for numbers between 1 and 48.
        let rand4 = Int(arc4random_uniform(48))+1               // Random number for numbers between 1 and 48.
        let rand5 = Int(arc4random_uniform(48))+1               // Random number for numbers between 1 and 48.
        let rand6 = Int(arc4random_uniform(48))+1               // Random number for numbers between 1 and 48.
        let rand7 = Int(arc4random_uniform(48))+1               // Random number for numbers between 1 and 48.
        let rand8 = Int(arc4random_uniform(48))+1               // Random number for numbers between 1 and 48.
        let rand9 = Int(arc4random_uniform(48))+1               // Random number for numbers between 1 and 48.
        let rand10 = Int(arc4random_uniform(48))+1               // Random number for numbers between 1 and 48.
        let randLucky = Int(arc4random_uniform(18))+1                // Random number for PB number between 1 and 18.
        
        // Random Numbers
        
        intNumbers[0] = rand1
        intNumbers[1] = rand2
        intNumbers[2] = rand3
        intNumbers[3] = rand4
        intNumbers[4] = rand5
        
        if intNumbers[0] == intNumbers[1] || intNumbers[0] == intNumbers[2] || intNumbers[0] == intNumbers[3] || intNumbers[0] == intNumbers[4]{
            intNumbers[0] = rand6
        }
        if intNumbers[1] == intNumbers[0] || intNumbers[1] == intNumbers[2] || intNumbers[1] == intNumbers[3] || intNumbers[1] == intNumbers[4]{
            intNumbers[1] = rand7
        }
        if intNumbers[2] == intNumbers[0] || intNumbers[2] == intNumbers[1] || intNumbers[2] == intNumbers[3] || intNumbers[2] == intNumbers[4]{
            intNumbers[2] = rand8
        }
        if intNumbers[3] == intNumbers[0] || intNumbers[3] == intNumbers[1] || intNumbers[3] == intNumbers[2] || intNumbers[3] == intNumbers[4]{
            intNumbers[2] = rand9
        }
        if intNumbers[4] == intNumbers[0] || intNumbers[4] == intNumbers[1] || intNumbers[4] == intNumbers[2] || intNumbers[4] == intNumbers[3]{
            intNumbers[4] = rand10
        }
        
        // Lucky Number
        intLuckyNumber = randLucky
        
        // Fill the lucky numbers label.
        lblLuckyNumbers.text = "Your Lucky for Life Numbers!"
        
        // Order the numbers from smallest to biggest.
        intNumbers.sort(by: <)
        
        // Print the Lucky for Life numbers.
        lblNumbers.text = "\(intNumbers[0])     \(intNumbers[1])     \(intNumbers[2])     \(intNumbers[3])     \(intNumbers[4])"
        
        // Print the Lucky number.
        lblLuckyNumber.text = "\(intLuckyNumber)"
        
        // Create an array of strings.
        let randomString = ["Good Luck!", "Great Choice!", "The Winning Numbers!", "You Got This!", "The Best Of Choice!", "Can't Go Wrong!"]
        
        // Fill the random string label.
        let randomIndex = Int(arc4random_uniform(UInt32(randomString.count)))
        
        let randomItem = randomString[randomIndex]
        
        lblRandomString.text = randomItem
    
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
