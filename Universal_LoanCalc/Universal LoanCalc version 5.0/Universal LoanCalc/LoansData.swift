//
//  LoansData.swift
//  Universal LoanCalc
//
//  Created by Jared Pino on 11/25/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import UIKit

class LoansData: UIViewController {
    
    var passedData = RowSelected()
    
    var aprToPass = 0.0
    var monthsToPass = 0
    var costToPass = 0.0
    var downPaymentToPass = 0.0
    var loanAmountToPass = 0.0
    var monthlyPaymentToPass = 0.0
    var totalInterestToPass = 0.0
    var totalAmountToPass = 0.0
    
    var data = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        label.text = Data.shared.myLoans[passedData.row!]
        apr.text = Data.shared.myLoansData[passedData.row!][0]
        months.text = Data.shared.myLoansData[passedData.row!][1]
        cost.text = Data.shared.myLoansData[passedData.row!][2]
        downPayment.text = Data.shared.myLoansData[passedData.row!][3]
        loanAmount.text = Data.shared.myLoansData[passedData.row!][4]
        monthlyPayment.text = Data.shared.myLoansData[passedData.row!][5]
        totalInterest.text = Data.shared.myLoansData[passedData.row!][6]
        totalAmount.text = Data.shared.myLoansData[passedData.row!][7]
        
        aprToPass = Double((apr.text?.dropLast())!)!
        monthsToPass = Int(months.text!)!
        
        let cost = cost.text?.dropFirst()
        costToPass = Double(cost!.replacingOccurrences(of: ",", with: ""))!
        
        let downPayment = downPayment.text?.dropFirst()
        downPaymentToPass = Double(downPayment!.replacingOccurrences(of: ",", with: ""))!
        
        let loanAmount = loanAmount.text?.dropFirst()
        loanAmountToPass = Double(loanAmount!.replacingOccurrences(of: ",", with: ""))!
        
        let monthlyPayment = monthlyPayment.text?.dropFirst()
        monthlyPaymentToPass = Double(monthlyPayment!.replacingOccurrences(of: ",", with: ""))!
        
        let totalInterest = totalInterest.text?.dropFirst()
        totalInterestToPass = Double(totalInterest!.replacingOccurrences(of: ",", with: ""))!
        
        let totalAmount = totalAmount.text?.dropFirst()
        totalAmountToPass = Double(totalAmount!.replacingOccurrences(of: ",", with: ""))!
    }
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var apr: UILabel!
    @IBOutlet weak var months: UILabel!
    @IBOutlet weak var cost: UILabel!
    @IBOutlet weak var downPayment: UILabel!
    @IBOutlet weak var loanAmount: UILabel!
    @IBOutlet weak var monthlyPayment: UILabel!
    @IBOutlet weak var totalInterest: UILabel!
    @IBOutlet weak var totalAmount: UILabel!
    
    @IBAction func storedPaymentStructure(_ sender: BorderedButton) {
        performSegue(withIdentifier: "stored payment structure", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stored payment structure" {
            if let destVC = segue.destination as? PaymentStructure {
                var valueToPass = DataToPassTo_PS_ADD()
                let cost = costToPass
                let downPayment = downPaymentToPass
                let months = monthsToPass
                let APR = aprToPass
                let monthlyRate = ((APR/100)/12)
                let loanAmount = cost - downPayment
                let monthlyPayment = (cost - downPayment) * (monthlyRate / (1 - pow(1 + monthlyRate, Double(-months))))
                let totalInterest =  loanAmount * Double(months) - loanAmount
                
                valueToPass.cost = cost
                valueToPass.downPayment = downPayment
                valueToPass.months = months
                valueToPass.APR = APR
                valueToPass.monthlyPayment = monthlyPayment
                valueToPass.loanAmount = loanAmount
                valueToPass.totalInterest = totalInterest
                destVC.passedData = valueToPass
            }
        }
    }
}
