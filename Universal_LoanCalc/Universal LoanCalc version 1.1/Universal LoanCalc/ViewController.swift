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


class ViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
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
    
    @IBOutlet weak var txtViewLabels: UITextView!
    @IBOutlet weak var txtViewResults: UITextView!
    
    // Text Field Outlets.
    @IBOutlet weak var txtCost: UITextField!
    @IBOutlet weak var txtDownPayment: UITextField!
    @IBOutlet weak var txtMonths: UITextField!
    @IBOutlet weak var txtAPR: UITextField!
    
    // Error Message.
    @IBOutlet weak var lblMessage: UILabel!
    
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
        var dblMonthlyRate: Double = 0                 // To hold the monthly Rate.
        var dblTaxRate: Double = 0
        var dblTotalTax: Double = 0
        
        
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
        else if txtTax.text == "." {
            lblMessage.text = "The Tax % Rate is Not Valid!"
            
            
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
            
            txtViewLabels.text = " APR:\n Tax%:\n Months:\n Cost:\n Total Tax:\n Down Payment:\n Loan Amount\n Monthly Payment:\n Total Interest:\n Total Amount:\n"
            
            txtViewResults.text = " 0%\n 0%\n \(intMonths)\n \(fResultCost)\n $0.00\n \(fResultDownPayment)\n \(fResultLoan)\n \(fResultMonthkyPayment)\n $0.00\n \(fResultTotalAmount)"
            
            
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
            
            txtViewLabels.text = " APR:\n Tax%:\n Months:\n Cost:\n Total Tax:\n Down Payment:\n Loan Amount\n Monthly Payment:\n Total Interest:\n Total Amount:\n"
            
            txtViewResults.text = " 0%\n 0%\n \(intMonths)\n \(fResultCost)\n $0.00\n \(fResultDownPayment)\n \(fResultLoan)\n \(fResultMonthkyPayment)\n $0.00\n \(fResultTotalAmount)"

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
            
            txtViewLabels.text = " APR:\n Tax%:\n Months:\n Cost:\n Total Tax:\n Down Payment:\n Loan Amount\n Monthly Payment:\n Total Interest:\n Total Amount:\n"
            
            txtViewResults.text = " 0%\n 0%\n \(intMonths)\n \(fResultCost)\n $0.00\n \(fResultDownPayment)\n \(fResultLoan)\n \(fResultMonthkyPayment)\n $0.00\n \(fResultTotalAmount)"
            
            
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
            
            txtViewLabels.text = " APR:\n Tax%:\n Months:\n Cost:\n Total Tax:\n Down Payment:\n Loan Amount\n Monthly Payment:\n Total Interest:\n Total Amount:\n"
            
            txtViewResults.text = " 0%\n 0%\n \(intMonths)\n \(fResultCost)\n $0.00\n \(fResultDownPayment)\n \(fResultLoan)\n \(fResultMonthkyPayment)\n $0.00\n \(fResultTotalAmount)"
            
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
            
            txtViewLabels.text = " APR:\n Tax%:\n Months:\n Cost:\n Total Tax:\n Down Payment:\n Loan Amount\n Monthly Payment:\n Total Interest:\n Total Amount:\n"
            
            txtViewResults.text = " 0%\n \(fResultTaxRate)\n \(intMonths)\n \(fResultCost)\n $0.00\(fResultTotalTax)\n \(fResultDownPayment)\n \(fResultLoan)\n \(fResultMonthkyPayment)\n $0.00\n \(fResultTotalAmount)"
            
            
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
            
            txtViewLabels.text = " APR:\n Tax%:\n Months:\n Cost:\n Total Tax:\n Down Payment:\n Loan Amount\n Monthly Payment:\n Total Interest:\n Total Amount:\n"
            
            txtViewResults.text = " 0%\n \(fResultTaxRate)\n \(intMonths)\n \(fResultCost)\n \(fResultTotalTax)\n \(fResultDownPayment)\n \(fResultLoan)\n \(fResultMonthkyPayment)\n $0.00\n \(fResultTotalAmount)"
            
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
            
            txtViewLabels.text = " APR:\n Tax%:\n Months:\n Cost:\n Total Tax:\n Down Payment:\n Loan Amount\n Monthly Payment:\n Total Interest:\n Total Amount:\n"
            
            txtViewResults.text = " 0%\n \(fResultTaxRate)\n \(intMonths)\n \(fResultCost)\n \(fResultTotalTax)\n \(fResultDownPayment)\n \(fResultLoan)\n \(fResultMonthkyPayment)\n $0.00\n \(fResultTotalAmount)"
            
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
            
            txtViewLabels.text = " APR:\n Tax%:\n Months:\n Cost:\n Total Tax:\n Down Payment:\n Loan Amount\n Monthly Payment:\n Total Interest:\n Total Amount:\n"
            
            txtViewResults.text = " 0%\n \(fResultTaxRate)\n \(intMonths)\n \(fResultCost)\n \(fResultTotalTax)\n \(fResultDownPayment)\n \(fResultLoan)\n \(fResultMonthkyPayment)\n $0.00\n \(fResultTotalAmount)"
            
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
            
            txtViewLabels.text = " APR:\n Tax%:\n Months:\n Cost:\n Total Tax:\n Down Payment:\n Loan Amount\n Monthly Payment:\n Total Interest:\n Total Amount:\n"
            
            txtViewResults.text = " 0%\n \(fResultTaxRate)\n \(intMonths)\n \(fResultCost)\n \(fResultTotalTax)\n \(fResultDownPayment)\n \(fResultLoan)\n \(fResultMonthkyPayment)\n $0.00\n \(fResultTotalAmount)"
            
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
            
            txtViewLabels.text = " APR:\n Tax%:\n Months:\n Cost:\n Total Tax:\n Down Payment:\n Loan Amount\n Monthly Payment:\n Total Interest:\n Total Amount:\n"
            
            txtViewResults.text = " \(fResultAPR)\n 0%\n \(intMonths)\n \(fResultCost)\n $0.00\n \(fResultDownPayment)\n \(fResultLoan)\n \(fResultMonthkyPayment)\n \(fResultTotalInterest)\n \(fResultTotalAmount)"
            
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
            
            txtViewLabels.text = " APR:\n Tax%:\n Months:\n Cost:\n Total Tax:\n Down Payment:\n Loan Amount\n Monthly Payment:\n Total Interest:\n Total Amount:\n"
            
            txtViewResults.text = " \(fResultAPR)\n \(fResultTaxRate)\n \(intMonths)\n \(fResultCost)\n \(fResultTotalTax)\n \(fResultDownPayment)\n \(fResultLoan)\n \(fResultMonthkyPayment)\n \(fResultTotalInterest)\n \(fResultTotalAmount)"
            
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
            
            txtViewLabels.text = " APR:\n Tax%:\n Months:\n Cost:\n Total Tax:\n Down Payment:\n Loan Amount\n Monthly Payment:\n Total Interest:\n Total Amount:\n"
            
            txtViewResults.text = " \(fResultAPR)\n \(fResultTaxRate)\n \(intMonths)\n \(fResultCost)\n \(fResultTotalTax)\n \(fResultDownPayment)\n \(fResultLoan)\n \(fResultMonthkyPayment)\n \(fResultTotalInterest)\n \(fResultTotalAmount)"
            
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
        txtViewLabels.text = ""
        txtViewResults.text = ""
        
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

