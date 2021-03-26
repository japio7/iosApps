//
//  Main.swift
//  Random lucky numbers
//
//  Created by Jared Pino on 11/11/18.
//  Copyright © 2018 Jared Pino. All rights reserved.
//

import UIKit

func randomString() -> String {
    // Create an array of random strings.
    let randomString = ["Good Luck!", "Great Choice!", "The Winning Numbers!", "You Got This!", "The Best Of Choice!", "Can't Go Wrong!", "Perfect Selection!"]
    
    // Fill the random string label.
    let randomIndex = Int(arc4random_uniform(UInt32(randomString.count)))
    
    let randomItem = randomString[randomIndex]
    
    return randomItem
}

