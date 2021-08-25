//
//  ViewController.swift
//  Universal LoanCalc
//
//  Created by Jared Pino on 3/27/18.
//  Copyright © 2018 Jared Pino. All rights reserved.
//

import Foundation
import UIKit

struct DataToPass {
    var APR: Double = 0
    var months: Int = 0
    var cost: Double = 0
    var downPayment: Double = 0
    var loanAmount: Double = 0
    var monthlyPayment: Double = 0
    var totalInterest: Double = 0
    var totalAmount: Double = 0
    var monthlyRate: Double = 0
    var MONTHS_YEAR: Int = 12
}

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var passedData = DataToPass()

    var dblAPR: Double = 0                         // To hold the Annual Rate.
    var intMonths: Int = 0                         // To hold number of months for the loan.
    var dblCost: Double = 0                        // To hold vehicle cost.
    var dblDownPayment: Double = 0                 // To hold down payment.
    var dblLoanAmount: Double = 0                  // To hold the amount of the loan.
    var dblMonthlyPayment: Double = 0              // To hold the monthly payment.
    var dblTotalInterest: Double = 0               // To hold the total interest.
    var dblTotalAmount: Double = 0                 // To hold the vehicle total cost.
    
    var dblMonthlyRate: Double = 0                 // To hold the monthly Rate.
    
    // Class-level constant to hold the months per year.
    let intMONTHS_YEAR: Int = 12
    
    @IBAction func textFieldCost(_ sender: TextField) {
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    }
    @IBAction func textFieldDownPayment(_ sender: TextField) {
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    }
    @IBAction func textFieldMonths(_ sender: TextField) {
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    }
    @IBAction func textFieldAPR(_ sender: TextField) {
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    }
    
    @IBOutlet weak var txtViewLabels: UITextView!
    @IBOutlet weak var txtViewResults: UITextView!
    
    // Text Field Outlets.
    @IBOutlet weak var txtCost: UITextField!
    @IBOutlet weak var txtDownPayment: UITextField!
    @IBOutlet weak var txtMonths: UITextField!
    @IBOutlet weak var txtAPR: UITextField!
    
    // Error Message.
    @IBOutlet weak var lblMessage: UILabel!
    
    func calculate() {
        // Clear the message.
        lblMessage.text = ""
        
        dblCost = Double(txtCost.text!)!
        dblDownPayment = Double(txtDownPayment.text!)!
        intMonths = Int(txtMonths.text!)!
        dblAPR = Double(txtAPR.text!)!
        
        // Get the APR rate.
        dblAPR = dblAPR / 100
        
        // Get the monthly rate.
        dblMonthlyRate = dblAPR / Double(intMONTHS_YEAR)
        
        // Get the monthly payment.
        dblMonthlyPayment = (dblCost - dblDownPayment) * (dblMonthlyRate / (1 - pow(1 + dblMonthlyRate, Double(-intMonths))))
        
        // Get the amount of the loan.
        dblLoanAmount = dblCost - dblDownPayment
        
        // Get the total interest.
        dblTotalInterest = dblMonthlyPayment * Double(intMonths) - dblLoanAmount
        
        // Get the Total Amount.
        dblTotalAmount = dblCost + dblTotalInterest
        
        // Get the Vehicle Cost.
        dblCost = dblTotalAmount - dblTotalInterest
        
        var valueToPass = DataToPass()
        
        let APR_Passed: Double = dblAPR
        let monthsPassed: Int = intMonths
        let costPassed: Double = dblCost
        let downPaymentPassed: Double = dblDownPayment
        let loanAmountPassed: Double = dblLoanAmount
        let monthlyPaymentPassed: Double = dblMonthlyPayment
        let totalInterestPassed: Double = dblTotalInterest
        let totalAmountPassed: Double = dblTotalAmount
        let monthlyRatePassed: Double = dblMonthlyRate
        
        let MONTHS_YEAR_passed: Int = intMONTHS_YEAR
        
        valueToPass.APR = APR_Passed
        valueToPass.months = monthsPassed
        valueToPass.cost = costPassed
        valueToPass.downPayment = downPaymentPassed
        valueToPass.loanAmount = loanAmountPassed
        valueToPass.monthlyPayment = monthlyPaymentPassed
        valueToPass.totalInterest = totalInterestPassed
        valueToPass.totalAmount = totalAmountPassed
        valueToPass.monthlyRate = monthlyRatePassed
        valueToPass.MONTHS_YEAR = MONTHS_YEAR_passed
        
        // Format the results.
        let fCost = NSNumber(value: dblCost)
        let fResultCost = NumberFormatter.localizedString(from: fCost, number: .currency)
        
        let fDownPayment = NSNumber(value: dblDownPayment)
        let fResultDownPayment = NumberFormatter.localizedString(from: fDownPayment, number: .currency)
        
        let fLoan = NSNumber(value: dblLoanAmount)
        let fResultLoan = NumberFormatter.localizedString(from: fLoan, number: .currency)
        
        let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
        let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
        
        let percentFormatter = NumberFormatter()
        percentFormatter.usesGroupingSeparator = true
        percentFormatter.numberStyle = .percent
        percentFormatter.minimumFractionDigits = 0
        percentFormatter.maximumFractionDigits = 5
        percentFormatter.locale = Locale.current
        let fResultAPR = percentFormatter.string(from: NSNumber(value: dblAPR))!
        
        let fTotalInterest = NSNumber(value: dblTotalInterest)
        let fResultTotalInterest = NumberFormatter.localizedString(from: fTotalInterest, number: .currency)
        
        let fTotalAmount = NSNumber(value: dblTotalAmount)
        let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
        
        txtViewLabels.text = " APR:\n Months: \n Cost:\n Down Payment:\n Loan Amount:\n Monthly Payment:\n Total Interest:\n Total Amount:\n"
        
        txtViewResults.text = " \(fResultAPR)\n \(intMonths)\n \(fResultCost)\n \(fResultDownPayment)\n \(fResultLoan)\n \(fResultMonthkyPayment)\n \(fResultTotalInterest)\n \(fResultTotalAmount)"
    }
    
    // Buttons
    @IBAction func btnCalculate(_ sender: BorderedButton) {
        
        if txtCost.text == "" {
            lblMessage.text = "Enter the Cost!"
        }
        else if txtDownPayment.text == "" {
            lblMessage.text = "Enter Down Payment!"
        }
        else if txtMonths.text == "" {
            lblMessage.text = "Enter Months!"
        }
        else if txtAPR.text == "" {
            lblMessage.text = "Enter Annual % Rate!"
        }
        else if txtCost.text == "0" {
            lblMessage.text = "The Cost Cannot be 0!"
        }
        else if txtMonths.text == "0" || txtMonths.text == "00"  {
            lblMessage.text = "The Number of Months is Not Valid!"
        }
        else if txtAPR.text == "000" || txtAPR.text == "0000" || txtAPR.text == "00000" || txtAPR.text == "000.0" || txtAPR.text == "0000." || txtAPR.text == "0.000" || txtAPR.text == "00.00" || txtAPR.text == ".0000" || txtAPR.text == ".000" || txtAPR.text == ".00" || txtAPR.text == ".0" || txtAPR.text == "0." || txtAPR.text == "00." || txtAPR.text == "000." || txtAPR.text == "." {
            lblMessage.text = "The Annual % Rate is Not Valid!"
        }
        else if txtCost.text != nil && txtDownPayment.text != nil && txtMonths.text != nil && txtAPR.text == "0" {
            
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            
            // Get the amount of the loan.
            dblLoanAmount = dblCost - dblDownPayment
            
            // Get the monthly payment.
            dblMonthlyPayment = (dblCost - dblDownPayment) / Double(intMonths)
            
            // Get the Total Amount.
            dblTotalAmount = dblCost + dblTotalInterest
            
            // Get the Vehicle Cost.
            dblCost = dblTotalAmount - dblTotalInterest
            
            // Format the results.
            let fCost = NSNumber(value: dblCost)
            let fResultCost = NumberFormatter.localizedString(from: fCost, number: .currency)
            
            let fDownPayment = NSNumber(value: dblDownPayment)
            let fResultDownPayment = NumberFormatter.localizedString(from: fDownPayment, number: .currency)
            
            let fLoan = NSNumber(value: dblLoanAmount)
            let fResultLoan = NumberFormatter.localizedString(from: fLoan, number: .currency)
            
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            txtViewLabels.text = " APR:\n Months:\n Cost:\n Down Payment:\n Loan Amount\n Monthly Payment:\n Total Interest:\n Total Amount:\n"
            
            txtViewResults.text = " 0%\n \(intMonths)\n \(fResultCost)\n \(fResultDownPayment)\n \(fResultLoan)\n \(fResultMonthkyPayment)\n $0.00\n \(fResultTotalAmount)"
            
        }
        else if txtCost.text != nil && txtDownPayment.text != nil && txtMonths.text != nil && txtAPR.text == "00" {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            
            // Get the amount of the loan.
            dblLoanAmount = dblCost - dblDownPayment
            
            // Get the monthly payment.
            dblMonthlyPayment = (dblCost - dblDownPayment) / Double(intMonths)
            
            // Get the Total Amount.
            dblTotalAmount = dblCost + dblTotalInterest
            
            // Get the Vehicle Cost.
            dblCost = dblTotalAmount - dblTotalInterest
            
            // Format the results.
            let fCost = NSNumber(value: dblCost)
            let fResultCost = NumberFormatter.localizedString(from: fCost, number: .currency)
            
            let fDownPayment = NSNumber(value: dblDownPayment)
            let fResultDownPayment = NumberFormatter.localizedString(from: fDownPayment, number: .currency)
            
            let fLoan = NSNumber(value: dblLoanAmount)
            let fResultLoan = NumberFormatter.localizedString(from: fLoan, number: .currency)
            
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            txtViewLabels.text = " APR:\n Months:\n Cost:\n Down Payment:\n Loan Amount\n Monthly Payment:\n Total Interest:\n Total Amount:\n"
            
            txtViewResults.text = " 0%\n \(intMonths)\n \(fResultCost)\n \(fResultDownPayment)\n \(fResultLoan)\n \(fResultMonthkyPayment)\n $0.00\n \(fResultTotalAmount)"
        }
        else if txtCost.text != nil && txtDownPayment.text != nil && txtMonths.text != nil && txtAPR.text == "00.0" {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            
            // Get the amount of the loan.
            dblLoanAmount = dblCost - dblDownPayment
            
            // Get the monthly payment.
            dblMonthlyPayment = (dblCost - dblDownPayment) / Double(intMonths)
            
            // Get the Total Amount.
            dblTotalAmount = dblCost + dblTotalInterest
            
            // Get the Vehicle Cost.
            dblCost = dblTotalAmount - dblTotalInterest
            
            // Format the results.
            let fCost = NSNumber(value: dblCost)
            let fResultCost = NumberFormatter.localizedString(from: fCost, number: .currency)
            
            let fDownPayment = NSNumber(value: dblDownPayment)
            let fResultDownPayment = NumberFormatter.localizedString(from: fDownPayment, number: .currency)
            
            let fLoan = NSNumber(value: dblLoanAmount)
            let fResultLoan = NumberFormatter.localizedString(from: fLoan, number: .currency)
            
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            txtViewLabels.text = " APR:\n Months:\n Cost:\n Down Payment:\n Loan Amount\n Monthly Payment:\n Total Interest:\n Total Amount:\n"
            
            txtViewResults.text = " 0%\n \(intMonths)\n \(fResultCost)\n \(fResultDownPayment)\n \(fResultLoan)\n \(fResultMonthkyPayment)\n $0.00\n \(fResultTotalAmount)"
            
            
        }
        else if txtCost.text != nil && txtDownPayment.text != nil && txtMonths.text != nil && txtAPR.text == "0.00" {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            
            // Get the amount of the loan.
            dblLoanAmount = dblCost - dblDownPayment
            
            // Get the monthly payment.
            dblMonthlyPayment = (dblCost - dblDownPayment) / Double(intMonths)
            
            // Get the Total Amount.
            dblTotalAmount = dblCost + dblTotalInterest
            
            // Get the Vehicle Cost.
            dblCost = dblTotalAmount - dblTotalInterest
            
            // Format the results.
            let fCost = NSNumber(value: dblCost)
            let fResultCost = NumberFormatter.localizedString(from: fCost, number: .currency)
            
            let fDownPayment = NSNumber(value: dblDownPayment)
            let fResultDownPayment = NumberFormatter.localizedString(from: fDownPayment, number: .currency)
            
            let fLoan = NSNumber(value: dblLoanAmount)
            let fResultLoan = NumberFormatter.localizedString(from: fLoan, number: .currency)
            
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            txtViewLabels.text = " APR:\n Months:\n Cost:\n Down Payment:\n Loan Amount\n Monthly Payment:\n Total Interest:\n Total Amount:\n"
            
            txtViewResults.text = " 0%\n \(intMonths)\n \(fResultCost)\n \(fResultDownPayment)\n \(fResultLoan)\n \(fResultMonthkyPayment)\n $0.00\n \(fResultTotalAmount)"
        }
        else if txtCost.text != nil && txtDownPayment.text != nil && txtMonths.text != nil && txtAPR.text == "0.0" {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            
            // Get the amount of the loan.
            dblLoanAmount = dblCost - dblDownPayment
            
            // Get the monthly payment.
            dblMonthlyPayment = (dblCost - dblDownPayment) / Double(intMonths)
            
            // Get the Total Amount.
            dblTotalAmount = dblCost + dblTotalInterest
            
            // Get the Vehicle Cost.
            dblCost = dblTotalAmount - dblTotalInterest
            
            // Format the results.
            let fCost = NSNumber(value: dblCost)
            let fResultCost = NumberFormatter.localizedString(from: fCost, number: .currency)
            
            let fDownPayment = NSNumber(value: dblDownPayment)
            let fResultDownPayment = NumberFormatter.localizedString(from: fDownPayment, number: .currency)
            
            let fLoan = NSNumber(value: dblLoanAmount)
            let fResultLoan = NumberFormatter.localizedString(from: fLoan, number: .currency)
            
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            txtViewLabels.text = " APR:\n Months:\n Cost:\n Down Payment:\n Loan Amount\n Monthly Payment:\n Total Interest:\n Total Amount:\n"
            
            txtViewResults.text = " 0%\n \(intMonths)\n \(fResultCost)\n \(fResultDownPayment)\n \(fResultLoan)\n \(fResultMonthkyPayment)\n $0.00\n \(fResultTotalAmount)"
        }
        else if txtCost.text != nil && txtDownPayment.text != nil && txtMonths.text != nil && txtAPR.text != nil {
            calculate()
        }
    }
    @IBAction func btnClear(_ sender: BorderedButton) {
        // Clear the form.
        txtCost.text = ""
        txtDownPayment.text = ""
        txtMonths.text = ""
        txtAPR.text = ""
        lblMessage.text = ""
        txtViewLabels.text = ""
        txtViewResults.text = ""
    }
    
    @IBAction func btnPaymentStructure(_ sender: BorderedButton) {
        
        if txtCost.text!.isEmpty || txtDownPayment.text!.isEmpty || txtMonths.text!.isEmpty || txtAPR.text!.isEmpty {
            return
        }
        if txtAPR.text == "0" || txtAPR.text == "00" || txtAPR.text == "000" || txtAPR.text == "0000" || txtAPR.text == "00000" || txtAPR.text == "0.0" || txtAPR.text == "0.00" || txtAPR.text == "0.000" || txtAPR.text == "00.0" || txtAPR.text == "00.00" || txtAPR.text == "000.0" || txtAPR.text == "0000." || txtAPR.text == "000." || txtAPR.text == "00." || txtAPR.text == "0." || txtAPR.text == "." {
            lblMessage.text = "Payment Structure Not Available!"
        }
        else {
            calculate()
            performSegue(withIdentifier: "payment structure", sender: self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtCost.delegate = self
        txtDownPayment.delegate = self
        txtMonths.delegate = self
        txtAPR.delegate = self
        lblMessage.text = ""
        txtViewLabels.text = ""
        txtViewResults.text = ""
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // To not allow more than 1 decimal point.
    func textField(_ textField: UITextField,shouldChangeCharactersIn range: NSRange,replacementString string: String) -> Bool
    {
        let countdots = (textField.text?.components(separatedBy: ".").count)! - 1
        
        if countdots > 0 && string == "."
        {
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtCost.resignFirstResponder()
        txtDownPayment.resignFirstResponder()
        txtMonths.resignFirstResponder()
        txtAPR.resignFirstResponder()
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "payment structure" {
            if let destVC = segue.destination as? PaymentStructure {
                var valueToPass = DataToPass()
                let dblCost = Double(txtCost.text ?? "") ?? 0.0
                let dblDownPayment = Double(txtDownPayment.text ?? "") ?? 0.0
                let intMonths = Int(txtMonths.text ?? "") ?? 0
                let dblAPR = Double(txtAPR.text ?? "") ?? 0.0
                let monthlyRate = ((dblAPR/100)/12)
                let loanAmount = dblCost - dblDownPayment
                let monthlyPayment = (dblCost - dblDownPayment) * (monthlyRate / (1 - pow(1 + monthlyRate, Double(-intMonths))))
                let totalInterest = loanAmount * Double(intMonths) - loanAmount
                
                valueToPass.months = intMonths
                valueToPass.monthlyPayment = monthlyPayment
                valueToPass.loanAmount = loanAmount
                valueToPass.totalInterest = totalInterest
                valueToPass.APR = dblAPR
                destVC.passedData = valueToPass
            }
        }
    }
}

