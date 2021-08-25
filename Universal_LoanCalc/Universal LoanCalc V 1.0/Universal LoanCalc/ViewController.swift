//
//  ViewController.swift
//  Universal LoanCalc
//
//  Created by Jared Pino on 3/27/18.
//  Copyright © 2018 Jared Pino. All rights reserved.
//

import  Foundation
import UIKit

private var __maxLengths = [UITextField: Int]()
extension UITextField {
    @IBInspectable var maxLength: Int {
        get {
            guard let l = __maxLengths[self] else {
                return 150 // (global default-limit. or just, Int.max)
            }
            return l
        }
        set {
            __maxLengths[self] = newValue
            addTarget(self, action: #selector(fix), for: .editingChanged)
        }
    }
    @objc func fix(textField: UITextField) {
        let t = textField.text
        textField.text = t?.safelyLimitedTo(length: maxLength)
    }
}

extension String
{
    func safelyLimitedTo(length n: Int)->String {
        if (self.count <= n) {
            return self
        }
        return String( Array(self).prefix(upTo: n) )
    }
}


// To not allow copy and paste.
class TextField: UITextField {
    
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        
        if action == #selector(copy(_:)) || action == #selector(selectAll(_:)) || action == #selector(paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}


class ViewController: UIViewController, UITextFieldDelegate {
    
    // Class-level constant to hold the months per year.
    let dblMONTHS_YEAR: Double = 12
    
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
    @IBAction func textFieldTax(_ sender: TextField) {
        func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            self.view.endEditing(true)
        }
    }
    
    // Text Field Outlets.
    @IBOutlet weak var txtCost: UITextField!
    @IBOutlet weak var txtDownPayment: UITextField!
    @IBOutlet weak var txtMonths: UITextField!
    @IBOutlet weak var txtAPR: UITextField!
    @IBOutlet weak var txtTax: UITextField!
    
    // Error Message.
    @IBOutlet weak var lblMessage: UILabel!
    
    // Labels with no values.
    @IBOutlet weak var lblCostNV: UILabel!
    @IBOutlet weak var lblDownPaymentNV: UILabel!
    @IBOutlet weak var lblMonthsNV: UILabel!
    @IBOutlet weak var lblLoanAmountNV: UILabel!
    @IBOutlet weak var lblMonthlyPaymentNV: UILabel!
    @IBOutlet weak var lblTotalInterestNV: UILabel!
    @IBOutlet weak var lblTotalTaxNV: UILabel!
    @IBOutlet weak var lblTotalAmountNV: UILabel!
    
    // Labels for text fields.
    @IBOutlet weak var lblAPR: UILabel!
    @IBOutlet weak var lblTax: UILabel!
    @IBOutlet weak var lblCost: UILabel!
    @IBOutlet weak var lblDownPayment: UILabel!
    @IBOutlet weak var lblMonths: UILabel!
    
    // Labels for Results
    @IBOutlet weak var lblLoanAmount: UILabel!
    @IBOutlet weak var lblMonthlyPayment: UILabel!
    @IBOutlet weak var lblTotalInterest: UILabel!
    @IBOutlet weak var lblTotalTax: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!
    
    // Buttons
    @IBAction func btnCalculate(_ sender: UIButton) {
        
        var dblAPR: Double = 0                         // To hold the Annual Rate.
        var dblTotalAmount: Double = 0                 // To hold the vehicle total cost.
        var dblCost: Double = 0                        // To hold vehicle cost.
        var dblDownPayment: Double = 0                 // To hold down payment.
        var intMonths: Int = 0                         // To hold number of months for the loan.
        var dblLoan: Double = 0                        // To hold the amount of the loan.
        var dblMonthlyPayment: Double = 0              // To hold the monthly payment.
        var dblTotalInterest: Double = 0               // To hold the total interest.
        var dblTaxRate: Double = 0                     // To hold the tax rate.
        var dblTotalTax: Double = 0                    // To hold the total tax.
        var dblMonthlyRate: Double = 0                 // To hold the monthly Rate.
        
        
        if txtCost.text == "" {
            lblMessage.text = "Enter the Cost!"
            
            // Clear all except text fields and the message.
            lblCost.text = ""
            lblDownPayment.text = ""
            lblLoanAmount.text = ""
            lblMonths.text = ""
            lblAPR.text = ""
            lblTax.text = ""
            lblMonthlyPayment.text = ""
            lblTotalInterest.text = ""
            lblTotalTax.text = ""
            lblTotalAmount.text = ""
            lblCostNV.text = ""
            lblDownPaymentNV.text = ""
            lblMonthsNV.text = ""
            lblLoanAmountNV.text = ""
            lblMonthlyPaymentNV.text = ""
            lblTotalInterestNV.text = ""
            lblTotalTaxNV.text = ""
            lblTotalAmountNV.text = ""
        }
        else if txtDownPayment.text == "" {
            lblMessage.text = "Enter Down Payment!"
            
            // Clear all except text fields and the message.
            lblCost.text = ""
            lblDownPayment.text = ""
            lblLoanAmount.text = ""
            lblMonths.text = ""
            lblAPR.text = ""
            lblTax.text = ""
            lblMonthlyPayment.text = ""
            lblTotalInterest.text = ""
            lblTotalTax.text = ""
            lblTotalAmount.text = ""
            lblCostNV.text = ""
            lblDownPaymentNV.text = ""
            lblMonthsNV.text = ""
            lblLoanAmountNV.text = ""
            lblMonthlyPaymentNV.text = ""
            lblTotalInterestNV.text = ""
            lblTotalTaxNV.text = ""
            lblTotalAmountNV.text = ""
        }
        else if txtMonths.text == "" {
            lblMessage.text = "Enter Months!"
            
            // Clear all except text fields and the message.
            lblCost.text = ""
            lblDownPayment.text = ""
            lblLoanAmount.text = ""
            lblMonths.text = ""
            lblAPR.text = ""
            lblTax.text = ""
            lblMonthlyPayment.text = ""
            lblTotalInterest.text = ""
            lblTotalTax.text = ""
            lblTotalAmount.text = ""
            lblCostNV.text = ""
            lblDownPaymentNV.text = ""
            lblMonthsNV.text = ""
            lblLoanAmountNV.text = ""
            lblMonthlyPaymentNV.text = ""
            lblTotalInterestNV.text = ""
            lblTotalTaxNV.text = ""
            lblTotalAmountNV.text = ""
        }
        else if txtAPR.text == "" {
            lblMessage.text = "Enter Annual % Rate!"
            
            // Clear all except text fields and the message.
            lblCost.text = ""
            lblDownPayment.text = ""
            lblLoanAmount.text = ""
            lblMonths.text = ""
            lblAPR.text = ""
            lblTax.text = ""
            lblMonthlyPayment.text = ""
            lblTotalInterest.text = ""
            lblTotalTax.text = ""
            lblTotalAmount.text = ""
            lblCostNV.text = ""
            lblDownPaymentNV.text = ""
            lblMonthsNV.text = ""
            lblLoanAmountNV.text = ""
            lblMonthlyPaymentNV.text = ""
            lblTotalInterestNV.text = ""
            lblTotalTaxNV.text = ""
            lblTotalAmountNV.text = ""
        }
        else if txtTax.text == "" {
            lblMessage.text = "Enter Tax!"
            
            // Clear all except text fields and the message.
            lblCost.text = ""
            lblDownPayment.text = ""
            lblLoanAmount.text = ""
            lblMonths.text = ""
            lblAPR.text = ""
            lblTax.text = ""
            lblMonthlyPayment.text = ""
            lblTotalInterest.text = ""
            lblTotalTax.text = ""
            lblTotalAmount.text = ""
            lblCostNV.text = ""
            lblDownPaymentNV.text = ""
            lblMonthsNV.text = ""
            lblLoanAmountNV.text = ""
            lblMonthlyPaymentNV.text = ""
            lblTotalInterestNV.text = ""
            lblTotalTaxNV.text = ""
            lblTotalAmountNV.text = ""
        }
        else if txtCost.text == "0" {
            lblMessage.text = "The Cost Cannot be 0!"
            
            // Clear all except text fields and the message.
            lblCost.text = ""
            lblDownPayment.text = ""
            lblLoanAmount.text = ""
            lblMonths.text = ""
            lblAPR.text = ""
            lblTax.text = ""
            lblMonthlyPayment.text = ""
            lblTotalInterest.text = ""
            lblTotalTax.text = ""
            lblTotalAmount.text = ""
            lblCostNV.text = ""
            lblDownPaymentNV.text = ""
            lblMonthsNV.text = ""
            lblLoanAmountNV.text = ""
            lblMonthlyPaymentNV.text = ""
            lblTotalInterestNV.text = ""
            lblTotalTaxNV.text = ""
            lblTotalAmountNV.text = ""
        }
        else if txtMonths.text == "0" || txtMonths.text == "00"  {
            lblMessage.text = "The Number of Months is Not Valid!"
            
            // Clear all except text fields and the message.
            lblCost.text = ""
            lblDownPayment.text = ""
            lblLoanAmount.text = ""
            lblMonths.text = ""
            lblAPR.text = ""
            lblTax.text = ""
            lblMonthlyPayment.text = ""
            lblTotalInterest.text = ""
            lblTotalTax.text = ""
            lblTotalAmount.text = ""
            lblCostNV.text = ""
            lblDownPaymentNV.text = ""
            lblMonthsNV.text = ""
            lblLoanAmountNV.text = ""
            lblMonthlyPaymentNV.text = ""
            lblTotalInterestNV.text = ""
            lblTotalTaxNV.text = ""
            lblTotalAmountNV.text = ""
        }
        else if txtAPR.text == "000" || txtAPR.text == "0000" || txtAPR.text == "000.0" || txtAPR.text == ".000" || txtAPR.text == ".00" || txtAPR.text == ".0" || txtAPR.text == "0." || txtAPR.text == "00." || txtAPR.text == "000." || txtAPR.text == "." {
            lblMessage.text = "The Annual % Rate is Not Valid!"
            
            // Clear all except text fields and the message.
            lblCost.text = ""
            lblDownPayment.text = ""
            lblLoanAmount.text = ""
            lblMonths.text = ""
            lblAPR.text = ""
            lblTax.text = ""
            lblMonthlyPayment.text = ""
            lblTotalInterest.text = ""
            lblTotalTax.text = ""
            lblTotalAmount.text = ""
            lblCostNV.text = ""
            lblDownPaymentNV.text = ""
            lblMonthsNV.text = ""
            lblLoanAmountNV.text = ""
            lblMonthlyPaymentNV.text = ""
            lblTotalInterestNV.text = ""
            lblTotalTaxNV.text = ""
            lblTotalAmountNV.text = ""
        }
        else if txtTax.text == "." {
            lblMessage.text = "The Tax % Rate is Not Valid!"
            
            // Clear all except text fields and the message.
            lblCost.text = ""
            lblDownPayment.text = ""
            lblLoanAmount.text = ""
            lblMonths.text = ""
            lblAPR.text = ""
            lblTax.text = ""
            lblMonthlyPayment.text = ""
            lblTotalInterest.text = ""
            lblTotalTax.text = ""
            lblTotalAmount.text = ""
            lblCostNV.text = ""
            lblDownPaymentNV.text = ""
            lblMonthsNV.text = ""
            lblLoanAmountNV.text = ""
            lblMonthlyPaymentNV.text = ""
            lblTotalInterestNV.text = ""
            lblTotalTaxNV.text = ""
            lblTotalAmountNV.text = ""
        }
        else if txtCost.text != nil && txtDownPayment.text != nil && txtMonths.text != nil && txtAPR.text == "0" && txtTax.text == "0" {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            dblTaxRate = Double(txtTax.text!)!
            
            // Get the amount of the loan.
            dblLoan = dblCost - dblDownPayment
            
            // Get the monthly payment.
            dblMonthlyPayment = dblLoan / Double(intMonths)
            
            // Get the Total Amount.
            dblTotalAmount = dblCost
            
            // Format the results.
            let fCost = NSNumber(value: dblCost)
            let fResultCost = NumberFormatter.localizedString(from: fCost, number: .currency)
            
            let fDownPayment = NSNumber(value: dblDownPayment)
            let fResultDownPayment = NumberFormatter.localizedString(from: fDownPayment, number: .currency)
            
            let fLoan = NSNumber(value: dblLoan)
            let fResultLoan = NumberFormatter.localizedString(from: fLoan, number: .currency)
            
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the labels of No Value.
            lblCostNV.text = "Cost:"
            lblDownPaymentNV.text = "Down Payment:"
            lblMonthsNV.text = "Months:"
            lblLoanAmountNV.text = "Loan Amount:"
            lblMonthlyPaymentNV.text = "Monthly Payment:"
            lblTotalInterestNV.text = "Total Interest:"
            lblTotalTaxNV.text = "Total Tax:"
            lblTotalAmountNV.text = "Total Amount:"
            
            // Print the Result labels.
            lblCost.text = fResultCost
            lblDownPayment.text = fResultDownPayment
            lblMonths.text = "\(intMonths)"
            lblAPR.text = "APR: 0%"
            lblTax.text = "Tax: 0%"
            lblLoanAmount.text = fResultLoan
            lblMonthlyPayment.text = fResultMonthkyPayment
            lblTotalInterest.text = "$0.00"
            lblTotalTax.text = "$0.00"
            lblTotalAmount.text = fResultTotalAmount
        }
        else if txtCost.text != nil && txtDownPayment.text != nil && txtMonths.text != nil && txtAPR.text == "0.0" && txtTax.text == "0.0" {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            dblTaxRate = Double(txtTax.text!)!
            
            // Get the amount of the loan.
            dblLoan = dblCost - dblDownPayment
            
            // Get the monthly payment.
            dblMonthlyPayment = dblLoan / Double(intMonths)
            
            // Get the Total Amount.
            dblTotalAmount = dblCost
            
            // Format the results.
            let fCost = NSNumber(value: dblCost)
            let fResultCost = NumberFormatter.localizedString(from: fCost, number: .currency)
            
            let fDownPayment = NSNumber(value: dblDownPayment)
            let fResultDownPayment = NumberFormatter.localizedString(from: fDownPayment, number: .currency)
            
            let fLoan = NSNumber(value: dblLoan)
            let fResultLoan = NumberFormatter.localizedString(from: fLoan, number: .currency)
            
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the labels of No Value.
            lblCostNV.text = "Cost:"
            lblDownPaymentNV.text = "Down Payment:"
            lblMonthsNV.text = "Months:"
            lblLoanAmountNV.text = "Loan Amount:"
            lblMonthlyPaymentNV.text = "Monthly Payment:"
            lblTotalInterestNV.text = "Total Interest:"
            lblTotalTaxNV.text = "Total Tax:"
            lblTotalAmountNV.text = "Total Amount:"
            
            // Print the Result labels.
            lblCost.text = fResultCost
            lblDownPayment.text = fResultDownPayment
            lblMonths.text = "\(intMonths)"
            lblAPR.text = "APR: 0%"
            lblTax.text = "Tax: 0%"
            lblLoanAmount.text = fResultLoan
            lblMonthlyPayment.text = fResultMonthkyPayment
            lblTotalInterest.text = "$0.00"
            lblTotalTax.text = "$0.00"
            lblTotalAmount.text = fResultTotalAmount
        }
        else if txtCost.text != nil && txtDownPayment.text != nil && txtMonths.text != nil && txtAPR.text == "0" && txtTax.text == "0.0" {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            dblTaxRate = Double(txtTax.text!)!
            
            // Get the amount of the loan.
            dblLoan = dblCost - dblDownPayment
            
            // Get the monthly payment.
            dblMonthlyPayment = dblLoan / Double(intMonths)
            
            // Get the Total Amount.
            dblTotalAmount = dblCost
            
            // Format the results.
            let fCost = NSNumber(value: dblCost)
            let fResultCost = NumberFormatter.localizedString(from: fCost, number: .currency)
            
            let fDownPayment = NSNumber(value: dblDownPayment)
            let fResultDownPayment = NumberFormatter.localizedString(from: fDownPayment, number: .currency)
            
            let fLoan = NSNumber(value: dblLoan)
            let fResultLoan = NumberFormatter.localizedString(from: fLoan, number: .currency)
            
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the labels of No Value.
            lblCostNV.text = "Cost:"
            lblDownPaymentNV.text = "Down Payment:"
            lblMonthsNV.text = "Months:"
            lblLoanAmountNV.text = "Loan Amount:"
            lblMonthlyPaymentNV.text = "Monthly Payment:"
            lblTotalInterestNV.text = "Total Interest:"
            lblTotalTaxNV.text = "Total Tax:"
            lblTotalAmountNV.text = "Total Amount:"
            
            // Print the Result labels.
            lblCost.text = fResultCost
            lblDownPayment.text = fResultDownPayment
            lblMonths.text = "\(intMonths)"
            lblAPR.text = "APR: 0%"
            lblTax.text = "Tax: 0%"
            lblLoanAmount.text = fResultLoan
            lblMonthlyPayment.text = fResultMonthkyPayment
            lblTotalInterest.text = "$0.00"
            lblTotalTax.text = "$0.00"
            lblTotalAmount.text = fResultTotalAmount
        }
        else if txtCost.text != nil && txtDownPayment.text != nil && txtMonths.text != nil && txtAPR.text == "0.0" && txtTax.text == "0" {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            dblTaxRate = Double(txtTax.text!)!
            
            // Get the amount of the loan.
            dblLoan = dblCost - dblDownPayment
            
            // Get the monthly payment.
            dblMonthlyPayment = dblLoan / Double(intMonths)
            
            // Get the Total Amount.
            dblTotalAmount = dblCost
            
            // Format the results.
            let fCost = NSNumber(value: dblCost)
            let fResultCost = NumberFormatter.localizedString(from: fCost, number: .currency)
            
            let fDownPayment = NSNumber(value: dblDownPayment)
            let fResultDownPayment = NumberFormatter.localizedString(from: fDownPayment, number: .currency)
            
            let fLoan = NSNumber(value: dblLoan)
            let fResultLoan = NumberFormatter.localizedString(from: fLoan, number: .currency)
            
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the labels of No Value.
            lblCostNV.text = "Cost:"
            lblDownPaymentNV.text = "Down Payment:"
            lblMonthsNV.text = "Months:"
            lblLoanAmountNV.text = "Loan Amount:"
            lblMonthlyPaymentNV.text = "Monthly Payment:"
            lblTotalInterestNV.text = "Total Interest:"
            lblTotalTaxNV.text = "Total Tax:"
            lblTotalAmountNV.text = "Total Amount:"
            
            // Print the Result labels.
            lblCost.text = fResultCost
            lblDownPayment.text = fResultDownPayment
            lblMonths.text = "\(intMonths)"
            lblAPR.text = "APR: 0%"
            lblTax.text = "Tax: 0%"
            lblLoanAmount.text = fResultLoan
            lblMonthlyPayment.text = fResultMonthkyPayment
            lblTotalInterest.text = "$0.00"
            lblTotalTax.text = "$0.00"
            lblTotalAmount.text = fResultTotalAmount
        }
        else if txtCost.text != nil && txtDownPayment.text != nil && txtMonths.text != nil && txtAPR.text == "0" && txtTax.text != nil {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            dblTaxRate = Double(txtTax.text!)!
            
            // Get the tax rate.
            dblTaxRate = dblTaxRate / 100
            
            // Get the total tax.
            dblTotalTax = (dblCost) * (dblTaxRate)
            
            // Get the amount of the loan.
            dblLoan = dblCost + dblTotalTax - dblDownPayment
            
            // Get the monthly payment.
            dblMonthlyPayment = ((dblCost + dblTotalTax) - dblDownPayment) / Double(intMonths)
            
            // Get the Total Amount.
            dblTotalAmount = dblCost + dblTotalInterest + dblTotalTax
            
            // Get the Vehicle Cost.
            dblCost = ((dblTotalAmount - dblTotalInterest) - dblTotalTax)
            
            // Format the results.
            let fCost = NSNumber(value: dblCost)
            let fResultCost = NumberFormatter.localizedString(from: fCost, number: .currency)
            
            let fDownPayment = NSNumber(value: dblDownPayment)
            let fResultDownPayment = NumberFormatter.localizedString(from: fDownPayment, number: .currency)
            
            let fLoan = NSNumber(value: dblLoan)
            let fResultLoan = NumberFormatter.localizedString(from: fLoan, number: .currency)
            
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let ftaxRate = NSNumber(value: dblTaxRate)
            let fResultTaxRate = NumberFormatter.localizedString(from: ftaxRate, number: .percent)
            
            let fTotalTax = NSNumber(value: dblTotalTax)
            let fResultTotalTax = NumberFormatter.localizedString(from: fTotalTax, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the labels of No Value.
            lblCostNV.text = "Cost:"
            lblDownPaymentNV.text = "Down Payment:"
            lblMonthsNV.text = "Months:"
            lblLoanAmountNV.text = "Loan Amount:"
            lblMonthlyPaymentNV.text = "Monthly Payment:"
            lblTotalInterestNV.text = "Total Interest:"
            lblTotalTaxNV.text = "Total Tax:"
            lblTotalAmountNV.text = "Total Amount:"
            
            // Print the Result labels.
            lblCost.text = fResultCost
            lblDownPayment.text = fResultDownPayment
            lblMonths.text = "\(intMonths)"
            lblAPR.text = "APR: 0%"
            lblTax.text = "Tax: \(fResultTaxRate)"
            lblLoanAmount.text = fResultLoan
            lblMonthlyPayment.text = fResultMonthkyPayment
            lblTotalInterest.text = "$0.00"
            lblTotalTax.text = fResultTotalTax
            lblTotalAmount.text = fResultTotalAmount
        }
        else if txtCost.text != nil && txtDownPayment.text != nil && txtMonths.text != nil && txtAPR.text == "00" && txtTax.text != nil {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            dblTaxRate = Double(txtTax.text!)!
            
            // Get the tax rate.
            dblTaxRate = dblTaxRate / 100
            
            // Get the total tax.
            dblTotalTax = (dblCost) * (dblTaxRate)
            
            // Get the amount of the loan.
            dblLoan = dblCost + dblTotalTax - dblDownPayment
            
            // Get the monthly payment.
            dblMonthlyPayment = ((dblCost + dblTotalTax) - dblDownPayment) / Double(intMonths)
            
            // Get the Total Amount.
            dblTotalAmount = dblCost + dblTotalInterest + dblTotalTax
            
            // Get the Vehicle Cost.
            dblCost = ((dblTotalAmount - dblTotalInterest) - dblTotalTax)
            
            // Format the results.
            let fCost = NSNumber(value: dblCost)
            let fResultCost = NumberFormatter.localizedString(from: fCost, number: .currency)
            
            let fDownPayment = NSNumber(value: dblDownPayment)
            let fResultDownPayment = NumberFormatter.localizedString(from: fDownPayment, number: .currency)
            
            let fLoan = NSNumber(value: dblLoan)
            let fResultLoan = NumberFormatter.localizedString(from: fLoan, number: .currency)
            
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let ftaxRate = NSNumber(value: dblTaxRate)
            let fResultTaxRate = NumberFormatter.localizedString(from: ftaxRate, number: .percent)
            
            let fTotalTax = NSNumber(value: dblTotalTax)
            let fResultTotalTax = NumberFormatter.localizedString(from: fTotalTax, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the labels of No Value.
            lblCostNV.text = "Cost:"
            lblDownPaymentNV.text = "Down Payment:"
            lblMonthsNV.text = "Months:"
            lblLoanAmountNV.text = "Loan Amount:"
            lblMonthlyPaymentNV.text = "Monthly Payment:"
            lblTotalInterestNV.text = "Total Interest:"
            lblTotalTaxNV.text = "Total Tax:"
            lblTotalAmountNV.text = "Total Amount:"
            
            // Print the Result labels.
            lblCost.text = fResultCost
            lblDownPayment.text = fResultDownPayment
            lblMonths.text = "\(intMonths)"
            lblAPR.text = "APR: 0%"
            lblTax.text = "Tax: \(fResultTaxRate)"
            lblLoanAmount.text = fResultLoan
            lblMonthlyPayment.text = fResultMonthkyPayment
            lblTotalInterest.text = "$0.00"
            lblTotalTax.text = fResultTotalTax
            lblTotalAmount.text = fResultTotalAmount
        }
        else if txtCost.text != nil && txtDownPayment.text != nil && txtMonths.text != nil && txtAPR.text == "00.0" && txtTax.text != nil {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            dblTaxRate = Double(txtTax.text!)!
            
            // Get the tax rate.
            dblTaxRate = dblTaxRate / 100
            
            // Get the total tax.
            dblTotalTax = (dblCost) * (dblTaxRate)
            
            // Get the amount of the loan.
            dblLoan = dblCost + dblTotalTax - dblDownPayment
            
            // Get the monthly payment.
            dblMonthlyPayment = ((dblCost + dblTotalTax) - dblDownPayment) / Double(intMonths)
            
            // Get the Total Amount.
            dblTotalAmount = dblCost + dblTotalInterest + dblTotalTax
            
            // Get the Vehicle Cost.
            dblCost = ((dblTotalAmount - dblTotalInterest) - dblTotalTax)
            
            // Format the results.
            let fCost = NSNumber(value: dblCost)
            let fResultCost = NumberFormatter.localizedString(from: fCost, number: .currency)
            
            let fDownPayment = NSNumber(value: dblDownPayment)
            let fResultDownPayment = NumberFormatter.localizedString(from: fDownPayment, number: .currency)
            
            let fLoan = NSNumber(value: dblLoan)
            let fResultLoan = NumberFormatter.localizedString(from: fLoan, number: .currency)
            
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let ftaxRate = NSNumber(value: dblTaxRate)
            let fResultTaxRate = NumberFormatter.localizedString(from: ftaxRate, number: .percent)
            
            let fTotalTax = NSNumber(value: dblTotalTax)
            let fResultTotalTax = NumberFormatter.localizedString(from: fTotalTax, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the labels of No Value.
            lblCostNV.text = "Cost:"
            lblDownPaymentNV.text = "Down Payment:"
            lblMonthsNV.text = "Months:"
            lblLoanAmountNV.text = "Loan Amount:"
            lblMonthlyPaymentNV.text = "Monthly Payment:"
            lblTotalInterestNV.text = "Total Interest:"
            lblTotalTaxNV.text = "Total Tax:"
            lblTotalAmountNV.text = "Total Amount:"
            
            // Print the Result labels.
            lblCost.text = fResultCost
            lblDownPayment.text = fResultDownPayment
            lblMonths.text = "\(intMonths)"
            lblAPR.text = "APR: 0%"
            lblTax.text = "Tax: \(fResultTaxRate)"
            lblLoanAmount.text = fResultLoan
            lblMonthlyPayment.text = fResultMonthkyPayment
            lblTotalInterest.text = "$0.00"
            lblTotalTax.text = fResultTotalTax
            lblTotalAmount.text = fResultTotalAmount
        }
        else if txtCost.text != nil && txtDownPayment.text != nil && txtMonths.text != nil && txtAPR.text == "0.00" && txtTax.text != nil {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            dblTaxRate = Double(txtTax.text!)!
            
            // Get the tax rate.
            dblTaxRate = dblTaxRate / 100
            
            // Get the total tax.
            dblTotalTax = (dblCost) * (dblTaxRate)
            
            // Get the amount of the loan.
            dblLoan = dblCost + dblTotalTax - dblDownPayment
            
            // Get the monthly payment.
            dblMonthlyPayment = ((dblCost + dblTotalTax) - dblDownPayment) / Double(intMonths)
            
            // Get the Total Amount.
            dblTotalAmount = dblCost + dblTotalInterest + dblTotalTax
            
            // Get the Vehicle Cost.
            dblCost = ((dblTotalAmount - dblTotalInterest) - dblTotalTax)
            
            // Format the results.
            let fCost = NSNumber(value: dblCost)
            let fResultCost = NumberFormatter.localizedString(from: fCost, number: .currency)
            
            let fDownPayment = NSNumber(value: dblDownPayment)
            let fResultDownPayment = NumberFormatter.localizedString(from: fDownPayment, number: .currency)
            
            let fLoan = NSNumber(value: dblLoan)
            let fResultLoan = NumberFormatter.localizedString(from: fLoan, number: .currency)
            
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let ftaxRate = NSNumber(value: dblTaxRate)
            let fResultTaxRate = NumberFormatter.localizedString(from: ftaxRate, number: .percent)
            
            let fTotalTax = NSNumber(value: dblTotalTax)
            let fResultTotalTax = NumberFormatter.localizedString(from: fTotalTax, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the labels of No Value.
            lblCostNV.text = "Cost:"
            lblDownPaymentNV.text = "Down Payment:"
            lblMonthsNV.text = "Months:"
            lblLoanAmountNV.text = "Loan Amount:"
            lblMonthlyPaymentNV.text = "Monthly Payment:"
            lblTotalInterestNV.text = "Total Interest:"
            lblTotalTaxNV.text = "Total Tax:"
            lblTotalAmountNV.text = "Total Amount:"
            
            // Print the Result labels.
            lblCost.text = fResultCost
            lblDownPayment.text = fResultDownPayment
            lblMonths.text = "\(intMonths)"
            lblAPR.text = "APR: 0%"
            lblTax.text = "Tax: \(fResultTaxRate)"
            lblLoanAmount.text = fResultLoan
            lblMonthlyPayment.text = fResultMonthkyPayment
            lblTotalInterest.text = "$0.00"
            lblTotalTax.text = fResultTotalTax
            lblTotalAmount.text = fResultTotalAmount
        }
        else if txtCost.text != nil && txtDownPayment.text != nil && txtMonths.text != nil && txtAPR.text == "0.0" && txtTax.text != nil {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            dblTaxRate = Double(txtTax.text!)!
            
            // Get the tax rate.
            dblTaxRate = dblTaxRate / 100
            
            // Get the total tax.
            dblTotalTax = (dblCost) * (dblTaxRate)
            
            // Get the amount of the loan.
            dblLoan = dblCost + dblTotalTax - dblDownPayment
            
            // Get the monthly payment.
            dblMonthlyPayment = ((dblCost + dblTotalTax) - dblDownPayment) / Double(intMonths)
            
            // Get the Total Amount.
            dblTotalAmount = dblCost + dblTotalInterest + dblTotalTax
            
            // Get the Vehicle Cost.
            dblCost = ((dblTotalAmount - dblTotalInterest) - dblTotalTax)
            
            // Format the results.
            let fCost = NSNumber(value: dblCost)
            let fResultCost = NumberFormatter.localizedString(from: fCost, number: .currency)
            
            let fDownPayment = NSNumber(value: dblDownPayment)
            let fResultDownPayment = NumberFormatter.localizedString(from: fDownPayment, number: .currency)
            
            let fLoan = NSNumber(value: dblLoan)
            let fResultLoan = NumberFormatter.localizedString(from: fLoan, number: .currency)
            
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let ftaxRate = NSNumber(value: dblTaxRate)
            let fResultTaxRate = NumberFormatter.localizedString(from: ftaxRate, number: .percent)
            
            let fTotalTax = NSNumber(value: dblTotalTax)
            let fResultTotalTax = NumberFormatter.localizedString(from: fTotalTax, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the labels of No Value.
            lblCostNV.text = "Cost:"
            lblDownPaymentNV.text = "Down Payment:"
            lblMonthsNV.text = "Months:"
            lblLoanAmountNV.text = "Loan Amount:"
            lblMonthlyPaymentNV.text = "Monthly Payment:"
            lblTotalInterestNV.text = "Total Interest:"
            lblTotalTaxNV.text = "Total Tax:"
            lblTotalAmountNV.text = "Total Amount:"
            
            // Print the Result labels.
            lblCost.text = fResultCost
            lblDownPayment.text = fResultDownPayment
            lblMonths.text = "\(intMonths)"
            lblAPR.text = "APR: 0%"
            lblTax.text = "Tax: \(fResultTaxRate)"
            lblLoanAmount.text = fResultLoan
            lblMonthlyPayment.text = fResultMonthkyPayment
            lblTotalInterest.text = "$0.00"
            lblTotalTax.text = fResultTotalTax
            lblTotalAmount.text = fResultTotalAmount
        }
        else if txtCost.text != nil && txtDownPayment.text != nil && txtMonths.text != nil && txtAPR.text != nil && txtTax.text == "0" {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            dblTaxRate = Double(txtTax.text!)!
            
            // Get the APR rate.
            dblAPR = dblAPR / 100
            
            // Get the monthly rate.
            dblMonthlyRate = dblAPR / dblMONTHS_YEAR
            
            // Get the amount of the loan.
            dblLoan = dblCost - dblDownPayment
            
            // Get the monthly payment.
            dblMonthlyPayment = (dblCost - dblDownPayment) * (dblMonthlyRate / (1 - pow(1 + dblMonthlyRate, Double(-intMonths))))
            
            // Get the total interest.
            dblTotalInterest = dblMonthlyPayment * Double(intMonths) - dblLoan
            
            // Get the Total Amount.
            dblTotalAmount = dblCost + dblTotalInterest + dblTotalTax
            
            // Get the Vehicle Cost.
            dblCost = ((dblTotalAmount - dblTotalInterest) - dblTotalTax)
            
            // Format the results.
            let fCost = NSNumber(value: dblCost)
            let fResultCost = NumberFormatter.localizedString(from: fCost, number: .currency)
            
            let fDownPayment = NSNumber(value: dblDownPayment)
            let fResultDownPayment = NumberFormatter.localizedString(from: fDownPayment, number: .currency)
            
            let fLoan = NSNumber(value: dblLoan)
            let fResultLoan = NumberFormatter.localizedString(from: fLoan, number: .currency)
            
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fAPR = NSNumber(value: dblAPR)
            let fResultAPR = NumberFormatter.localizedString(from: fAPR, number: .percent)
            
            let fTotalInterest = NSNumber(value: dblTotalInterest)
            let fResultTotalInterest = NumberFormatter.localizedString(from: fTotalInterest, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the labels of No Value.
            lblCostNV.text = "Cost:"
            lblDownPaymentNV.text = "Down Payment:"
            lblMonthsNV.text = "Months:"
            lblLoanAmountNV.text = "Loan Amount:"
            lblMonthlyPaymentNV.text = "Monthly Payment:"
            lblTotalInterestNV.text = "Total Interest:"
            lblTotalTaxNV.text = "Total Tax:"
            lblTotalAmountNV.text = "Total Amount:"
            
            // Print the Result labels.
            lblCost.text = fResultCost
            lblDownPayment.text = fResultDownPayment
            lblMonths.text = "\(intMonths)"
            lblAPR.text = "APR: \(fResultAPR)"
            lblTax.text = "Tax % 0%"
            lblLoanAmount.text = fResultLoan
            lblMonthlyPayment.text = fResultMonthkyPayment
            lblTotalInterest.text = fResultTotalInterest
            lblTotalTax.text = "$0.00"
            lblTotalAmount.text = fResultTotalAmount
        }
        else if txtCost.text != nil && txtDownPayment.text != nil && txtMonths.text != nil && txtAPR.text != nil && txtTax.text == "0.0" {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            dblTaxRate = Double(txtTax.text!)!
            
            // Get the APR rate.
            dblAPR = dblAPR / 100
            
            // Get the monthly rate.
            dblMonthlyRate = dblAPR / dblMONTHS_YEAR
            
            // Get the amount of the loan.
            dblLoan = dblCost - dblDownPayment
            
            // Get the monthly payment.
            dblMonthlyPayment = (dblCost - dblDownPayment) * (dblMonthlyRate / (1 - pow(1 + dblMonthlyRate, Double(-intMonths))))
            
            // Get the total interest.
            dblTotalInterest = dblMonthlyPayment * Double(intMonths) - dblLoan
            
            // Get the Total Amount.
            dblTotalAmount = dblCost + dblTotalInterest + dblTotalTax
            
            // Get the Vehicle Cost.
            dblCost = ((dblTotalAmount - dblTotalInterest) - dblTotalTax)
            
            // Format the results.
            let fCost = NSNumber(value: dblCost)
            let fResultCost = NumberFormatter.localizedString(from: fCost, number: .currency)
            
            let fDownPayment = NSNumber(value: dblDownPayment)
            let fResultDownPayment = NumberFormatter.localizedString(from: fDownPayment, number: .currency)
            
            let fLoan = NSNumber(value: dblLoan)
            let fResultLoan = NumberFormatter.localizedString(from: fLoan, number: .currency)
            
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fAPR = NSNumber(value: dblAPR)
            let fResultAPR = NumberFormatter.localizedString(from: fAPR, number: .percent)
            
            let fTotalInterest = NSNumber(value: dblTotalInterest)
            let fResultTotalInterest = NumberFormatter.localizedString(from: fTotalInterest, number: .currency)
            
            let ftaxRate = NSNumber(value: dblTaxRate)
            let fResultTaxRate = NumberFormatter.localizedString(from: ftaxRate, number: .percent)
            
            let fTotalTax = NSNumber(value: dblTotalTax)
            let fResultTotalTax = NumberFormatter.localizedString(from: fTotalTax, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the labels of No Value.
            lblCostNV.text = "Cost:"
            lblDownPaymentNV.text = "Down Payment:"
            lblMonthsNV.text = "Months:"
            lblLoanAmountNV.text = "Loan Amount:"
            lblMonthlyPaymentNV.text = "Monthly Payment:"
            lblTotalInterestNV.text = "Total Interest:"
            lblTotalTaxNV.text = "Total Tax:"
            lblTotalAmountNV.text = "Total Amount:"
            
            // Print the Result labels.
            lblCost.text = fResultCost
            lblDownPayment.text = fResultDownPayment
            lblMonths.text = "\(intMonths)"
            lblAPR.text = "APR: \(fResultAPR)"
            lblTax.text = "Tax: \(fResultTaxRate)"
            lblLoanAmount.text = fResultLoan
            lblMonthlyPayment.text = fResultMonthkyPayment
            lblTotalInterest.text = fResultTotalInterest
            lblTotalTax.text = fResultTotalTax
            lblTotalAmount.text = fResultTotalAmount
        }
        else if txtCost.text != nil && txtDownPayment.text != nil && txtMonths.text != nil && txtAPR.text != nil && txtTax.text != nil {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            dblTaxRate = Double(txtTax.text!)!
            
            // Get the tax rate.
            dblTaxRate = dblTaxRate / 100
            
            // Get the APR rate.
            dblAPR = dblAPR / 100
            
            // Get the monthly rate.
            dblMonthlyRate = dblAPR / dblMONTHS_YEAR
            
            // Get the total tax.
            dblTotalTax = (dblCost) * (dblTaxRate)
            
            // Get the monthly payment.
            dblMonthlyPayment = ((dblCost + dblTotalTax) - dblDownPayment) * (dblMonthlyRate / (1 - pow(1 + dblMonthlyRate, Double(-intMonths))))
            
            // Get the amount of the loan.
            dblLoan = dblCost + dblTotalTax - dblDownPayment
            
            // Get the total interest.
            dblTotalInterest = dblMonthlyPayment * Double(intMonths) - dblLoan
            
            // Get the Total Amount.
            dblTotalAmount = dblCost + dblTotalInterest + dblTotalTax
            
            // Get the Vehicle Cost.
            dblCost = ((dblTotalAmount - dblTotalInterest) - dblTotalTax)
            
            // Format the results.
            let fCost = NSNumber(value: dblCost)
            let fResultCost = NumberFormatter.localizedString(from: fCost, number: .currency)
            
            let fDownPayment = NSNumber(value: dblDownPayment)
            let fResultDownPayment = NumberFormatter.localizedString(from: fDownPayment, number: .currency)
            
            let fLoan = NSNumber(value: dblLoan)
            let fResultLoan = NumberFormatter.localizedString(from: fLoan, number: .currency)
            
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fAPR = NSNumber(value: dblAPR)
            let fResultAPR = NumberFormatter.localizedString(from: fAPR, number: .percent)
            
            let ftaxRate = NSNumber(value: dblTaxRate)
            let fResultTaxRate = NumberFormatter.localizedString(from: ftaxRate, number: .percent)
            
            let fTotalInterest = NSNumber(value: dblTotalInterest)
            let fResultTotalInterest = NumberFormatter.localizedString(from: fTotalInterest, number: .currency)
            
            let fTotalTax = NSNumber(value: dblTotalTax)
            let fResultTotalTax = NumberFormatter.localizedString(from: fTotalTax, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the labels of No Value.
            lblCostNV.text = "Cost:"
            lblDownPaymentNV.text = "Down Payment:"
            lblMonthsNV.text = "Months:"
            lblLoanAmountNV.text = "Loan Amount:"
            lblMonthlyPaymentNV.text = "Monthly Payment:"
            lblTotalInterestNV.text = "Total Interest:"
            lblTotalTaxNV.text = "Total Tax:"
            lblTotalAmountNV.text = "Total Amount:"
            
            // Print the Result labels.
            lblCost.text = fResultCost
            lblDownPayment.text = fResultDownPayment
            lblMonths.text = "\(intMonths)"
            lblAPR.text = "APR: \(fResultAPR)"
            lblTax.text = "Tax: \(fResultTaxRate)"
            lblLoanAmount.text = fResultLoan
            lblMonthlyPayment.text = fResultMonthkyPayment
            lblTotalInterest.text = fResultTotalInterest
            lblTotalTax.text = fResultTotalTax
            lblTotalAmount.text = fResultTotalAmount
        }
    }
    @IBAction func btnClear(_ sender: UIButton) {
        // Clear the form.
        txtCost.text = ""
        txtDownPayment.text = ""
        txtMonths.text = ""
        txtAPR.text = ""
        txtTax.text = ""
        lblMessage.text = ""
        lblCost.text = ""
        lblDownPayment.text = ""
        lblLoanAmount.text = ""
        lblMonths.text = ""
        lblAPR.text = ""
        lblTax.text = ""
        lblMonthlyPayment.text = ""
        lblTotalInterest.text = ""
        lblTotalTax.text = ""
        lblTotalAmount.text = ""
        lblCostNV.text = ""
        lblDownPaymentNV.text = ""
        lblMonthsNV.text = ""
        lblLoanAmountNV.text = ""
        lblMonthlyPaymentNV.text = ""
        lblTotalInterestNV.text = ""
        lblTotalTaxNV.text = ""
        lblTotalAmountNV.text = ""
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        txtCost.delegate = self
        txtDownPayment.delegate = self
        txtMonths.delegate = self
        txtAPR.delegate = self
        txtTax.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtCost.resignFirstResponder()
        txtDownPayment.resignFirstResponder()
        txtMonths.resignFirstResponder()
        txtAPR.resignFirstResponder()
        txtTax.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    
}

