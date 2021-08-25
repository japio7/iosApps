//
//  PaymentStructure.swift
//  Universal LoanCalc
//
//  Created by Jared Pino on 1/19/19.
//  Copyright © 2019 Jared Pino. All rights reserved.
//

import Foundation
import UIKit

class PaymentStructure: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var passedData = DataToPass()
    var data: [String] = []
    
    var paymentNumber: Int = 0
    var principal: Double = 0
    var monthlyInterest: Double = 0
    var balance: Double = 0
    
    func paymentStructure() {
        
        data = []
        table.reloadData()
        
        balance = passedData.loanAmount
        
        for _ in 1...passedData.months {
                    paymentNumber += 1
            
            monthlyInterest = balance * ((passedData.APR / 100) / Double(passedData.MONTHS_YEAR))
            principal = passedData.monthlyPayment - monthlyInterest
            balance = balance - principal
                
            let fPrincipal = NSNumber(value: principal)
            let fResultPrincipal = NumberFormatter.localizedString(from: fPrincipal, number: .currency)
                           
            let fBalance = NSNumber(value: balance)
            let fResultBalance = NumberFormatter.localizedString(from: fBalance, number: .currency)
                           
            let fMonthlyInterest = NSNumber(value: monthlyInterest)
            let fResultMonthlyInterest = NumberFormatter.localizedString(from: fMonthlyInterest, number: .currency)
                           
            data += ["\(paymentNumber). P: \(fResultPrincipal), I: \(fResultMonthlyInterest), B: \(fResultBalance)"]
        }
                table.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentStructure()
    }
}
