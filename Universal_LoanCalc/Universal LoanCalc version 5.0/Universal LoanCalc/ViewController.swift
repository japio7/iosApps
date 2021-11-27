//
//  ViewController.swift
//  Universal LoanCalc
//
//  Created by Jared Pino on 3/27/18.
//  Copyright © 2018 Jared Pino. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var passedData_1 = DataToPassTo_PS_ADD()
    var passedData_2 = BackToMain()
    
    // Used for passedData-1
    var dblAPR: Double = 0                         // To hold the Annual Rate.
    var intMonths: Int = 0                         // To hold number of months for the loan.
    var dblCost: Double = 0                        // To hold vehicle cost.
    var dblDownPayment: Double = 0                 // To hold down payment.
    var dblLoanAmount: Double = 0                  // To hold the amount of the loan.
    var dblMonthlyPayment: Double = 0              // To hold the monthly payment.
    var dblTotalInterest: Double = 0               // To hold the total interest.
    var dblTotalAmount: Double = 0                 // To hold the vehicle total cost.
    
    var dblMonthlyRate: Double = 0                 // To hold the monthly Rate.
    
    // Used for passedData_2
    var data: [String] = []
    
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
        
        var valueToPass = DataToPassTo_PS_ADD()
        
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
            lblMessage.text = "Enter Cost!"
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
            
            if dblDownPayment >= dblCost {
                lblMessage.text = "The Down Payment is Not Valid!"
                txtViewLabels.text = ""
                txtViewResults.text = ""
            } else {
                
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
        }
        else if txtCost.text != nil && txtDownPayment.text != nil && txtMonths.text != nil && txtAPR.text == "00" {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            
            if dblDownPayment >= dblCost {
                lblMessage.text = "The Down Payment is Not Valid!"
                txtViewLabels.text = ""
                txtViewResults.text = ""
            } else {
            
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
        }
        else if txtCost.text != nil && txtDownPayment.text != nil && txtMonths.text != nil && txtAPR.text == "00.0" {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            
            if dblDownPayment >= dblCost {
                lblMessage.text = "The Down Payment is Not Valid!"
                txtViewLabels.text = ""
                txtViewResults.text = ""
            } else {
            
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
        }
        else if txtCost.text != nil && txtDownPayment.text != nil && txtMonths.text != nil && txtAPR.text == "0.00" {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            
            if dblDownPayment >= dblCost {
                lblMessage.text = "The Down Payment is Not Valid!"
                txtViewLabels.text = ""
                txtViewResults.text = ""
            } else {
            
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
        }
        else if txtCost.text != nil && txtDownPayment.text != nil && txtMonths.text != nil && txtAPR.text == "0.0" {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            
            if dblDownPayment >= dblCost {
                lblMessage.text = "The Down Payment is Not Valid!"
                txtViewLabels.text = ""
                txtViewResults.text = ""
            } else {
            
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
        }
        else if txtCost.text != nil && txtDownPayment.text != nil && txtMonths.text != nil && txtAPR.text != nil {
            dblCost = Double(txtCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            
            if dblDownPayment >= dblCost {
                lblMessage.text = "The Down Payment is Not Valid!"
                txtViewLabels.text = ""
                txtViewResults.text = ""
            } else {
            calculate()
            }
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
    
    @IBAction func myLoans(_ sender: UIBarButtonItem) {
        if Data.shared.myLoans == [] {
            lblMessage.text = "You do not have any loans!"
        } else {
            performSegue(withIdentifier: "my loans", sender: self)
        }
    }
    
    @IBAction func add(_ sender: UIBarButtonItem) {
        
        if txtCost.text!.isEmpty || txtDownPayment.text!.isEmpty || txtMonths.text!.isEmpty || txtAPR.text!.isEmpty {
            lblMessage.text = "Loan Data Must be Entered!"
        }
        else if txtViewLabels.text == "" && txtViewResults.text == "" {
            lblMessage.text = "Loan Must be Calculated First!"
        }
        else {
            calculate()
            performSegue(withIdentifier: "add", sender: self)
        }
    }
    
    @IBAction func btnPaymentStructure(_ sender: BorderedButton) {
        
        if txtCost.text!.isEmpty || txtDownPayment.text!.isEmpty || txtMonths.text!.isEmpty || txtAPR.text!.isEmpty {
            return
        }
        if txtAPR.text == "0" || txtAPR.text == "00" || txtAPR.text == "000" || txtAPR.text == "0000" || txtAPR.text == "00000" || txtAPR.text == "0.0" || txtAPR.text == "0.00" || txtAPR.text == "0.000" || txtAPR.text == "00.0" || txtAPR.text == "00.00" || txtAPR.text == "000.0" || txtAPR.text == "0000." || txtAPR.text == "000." || txtAPR.text == "00." || txtAPR.text == "0." || txtAPR.text == "." {
            lblMessage.text = "Payment Structure Not Available!"
        }
        else {
            dblCost = Double(txtCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            
            if dblDownPayment >= dblCost {
                lblMessage.text = "The Down Payment is Not Valid!"
                txtViewLabels.text = ""
                txtViewResults.text = ""
            } else {
            calculate()
            performSegue(withIdentifier: "payment structure", sender: self)
            }
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
    
    override func viewWillAppear(_ animated: Bool) {
        let defaults = UserDefaults.standard
        if defaults.value(forKey: "loanNames") != nil {
            Data.shared.loadLoans()
        }
        if defaults.value(forKey: "loanHist") != nil {
            Data.shared.loadLoanHist()
        }
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
                var valueToPass = DataToPassTo_PS_ADD()
                let dbl_Cost = Double(txtCost.text ?? "") ?? 0.0
                let dbl_DownPayment = Double(txtDownPayment.text ?? "") ?? 0.0
                let int_Months = Int(txtMonths.text ?? "") ?? 0
                let dbl_APR = Double(txtAPR.text ?? "") ?? 0.0
                let dbl_MonthlyRate = ((dbl_APR/100)/12)
                let dbl_LoanAmount = dbl_Cost - dbl_DownPayment
                let dbl_MonthlyPayment = (dbl_Cost - dbl_DownPayment) * (dbl_MonthlyRate / (1 - pow(1 + dbl_MonthlyRate, Double(-int_Months))))
                let dbl_TotalInterest = dbl_LoanAmount * Double(int_Months) - dbl_LoanAmount
       
                valueToPass.cost = dbl_Cost
                valueToPass.downPayment = dbl_DownPayment
                valueToPass.months = int_Months
                valueToPass.APR = dbl_APR
                valueToPass.monthlyPayment = dbl_MonthlyPayment
                valueToPass.loanAmount = dbl_LoanAmount
                valueToPass.totalInterest = dbl_TotalInterest
                destVC.passedData = valueToPass
            }
        }
        if segue.identifier == "add" {
            if let destVC = segue.destination as? Add {
                var valueToPass = DataToPassTo_PS_ADD()
                valueToPass.cost = dblCost
                valueToPass.downPayment = dblDownPayment
                valueToPass.months = intMonths
                valueToPass.APR = dblAPR
                valueToPass.monthlyRate = dblMonthlyRate
                valueToPass.loanAmount = dblLoanAmount
                valueToPass.monthlyPayment = dblMonthlyPayment
                valueToPass.totalInterest = dblTotalInterest
                valueToPass.totalAmount = dblTotalAmount
                destVC.passedData = valueToPass
            }
        }
    }
}

