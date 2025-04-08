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

func factorial(_ n: Double) -> Double {
        return n < 2 ? 1 : n*factorial(n - 1)
    }

func combo(_ n: Double, _ r: Double) -> Int {
    // How many different combinations are there
    // when itemns cannot be repeated and order
    // does not matter
    let top = factorial(n)
    let bot = factorial(n-r) * factorial(r)
    return Int(top/bot)
}
