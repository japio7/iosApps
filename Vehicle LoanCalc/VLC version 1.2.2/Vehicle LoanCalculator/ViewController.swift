//
//  ViewController.swift
//  Vehicle LoanCalculator
//
//  Created by Jared Pino on 3/7/18.
//  Copyright © 2018 Jared Pino. All rights reserved.
//

import Foundation
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
    
    // Text Field Actions to not allow copy and paste.
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
    @IBOutlet weak var txtVehicleCost: UITextField!
    @IBOutlet weak var txtDownPayment: UITextField!
    @IBOutlet weak var txtNumberOfMonths: UITextField!
    @IBOutlet weak var txtAPR: UITextField!
    @IBOutlet weak var txtTaxRate: UITextField!
    
    // Message Label
    @IBOutlet weak var lblMessage: UILabel!
    
    // Result labels
    @IBOutlet weak var lblMonthlyPayment: UILabel!
    @IBOutlet weak var lblTotalInterest: UILabel!
    @IBOutlet weak var lblTotalTax: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!
    
    
    // Buttons
    @IBAction func btnCalculate(_ sender: UIButton) {
        
        var dblAPR: Double = 0
        var dblTotalAmount: Double = 0                 // To hold the vehicle total cost.
        var dblCost: Double = 0                        // To hold vehicle cost.
        var dblDownPayment: Double = 0                 // To hold down payment.
        var intMonths: Int = 0                         // To hold number of months for the loan.
        var dblLoan: Double = 0                        // To hold the amount of the loan.
        var dblMonthlyPayment: Double = 0              // To hold the monthly payment.
        var dblTotalInterest: Double = 0               // To hold the total interest.
        var dblTaxRate: Double = 0                     // To hold the tax rate.
        var dblTotalTax: Double = 0                    // To hold the total tax.
        var dblMonthlyRate: Double = 0
        
        
        
        
        
        if txtVehicleCost.text == "" {
            lblMessage.text = "Enter the Vehicle Cost Amount!"
            
            // Clear the result labels
            lblMonthlyPayment.text = "Monthly Payment:"
            lblTotalInterest.text = "Total Interest:"
            lblTotalTax.text = "Total Tax:"
            lblTotalAmount.text = "Total Amount:"
        }
        else if txtDownPayment.text == "" {
            lblMessage.text = "Enter the Down Payment Amount!"
            
            // Clear the result labels
            lblMonthlyPayment.text = "Monthly Payment:"
            lblTotalInterest.text = "Total Interest:"
            lblTotalTax.text = "Total Tax:"
            lblTotalAmount.text = "Total Amount:"
        }
        else if txtNumberOfMonths.text == "" {
            lblMessage.text = "Enter the Number of Months!"
            
            // Clear the result labels
            lblMonthlyPayment.text = "Monthly Payment:"
            lblTotalInterest.text = "Total Interest:"
            lblTotalTax.text = "Total Tax:"
            lblTotalAmount.text = "Total Amount:"
        }
        else if txtAPR.text == "" {
            lblMessage.text = "Enter the APR % Rate!"
            
            // Clear the result labels
            lblMonthlyPayment.text = "Monthly Payment:"
            lblTotalInterest.text = "Total Interest:"
            lblTotalTax.text = "Total Tax:"
            lblTotalAmount.text = "Total Amount:"
        }
        else if txtTaxRate.text == "" {
            lblMessage.text = "Enter the Tax % Rate!"
            
            // Clear the result labels
            lblMonthlyPayment.text = "Monthly Payment:"
            lblTotalInterest.text = "Total Interest:"
            lblTotalTax.text = "Total Tax:"
            lblTotalAmount.text = "Total Amount:"
        }
        else if txtVehicleCost.text == "0" {
            lblMessage.text = "The Vehicle Amount Cannot be 0!"
            
            // Clear the result labels
            lblMonthlyPayment.text = "Monthly Payment:"
            lblTotalInterest.text = "Total Interest:"
            lblTotalTax.text = "Total Tax:"
            lblTotalAmount.text = "Total Amount:"
        }
        else if txtNumberOfMonths.text == "0" || txtNumberOfMonths.text == "00"  {
            lblMessage.text = "The Number of Months is Not Valid!"
            
            // Clear the result labels
            lblMonthlyPayment.text = "Monthly Payment:"
            lblTotalInterest.text = "Total Interest:"
            lblTotalTax.text = "Total Tax:"
            lblTotalAmount.text = "Total Amount:"
        }
        else if txtNumberOfMonths.text! > "84" {
            lblMessage.text = "The Number of Months is Not Valid!"
            
            // Clear the result labels
            lblMonthlyPayment.text = "Monthly Payment:"
            lblTotalInterest.text = "Total Interest:"
            lblTotalTax.text = "Total Tax:"
            lblTotalAmount.text = "Total Amount:"
        }
        else if txtAPR.text == "000" || txtAPR.text == "0000" || txtAPR.text == "00000" || txtAPR.text == "00.00" || txtAPR.text == "0.000" || txtAPR.text == "000.0" || txtAPR.text == ".000" || txtAPR.text == ".00" || txtAPR.text == ".0" || txtAPR.text == "0." || txtAPR.text == "00." || txtAPR.text == "000." || txtAPR.text == "." {
            lblMessage.text = "The APR % Rate is Not Valid!"
            
            // Clear the result labels
            lblMonthlyPayment.text = "Monthly Payment:"
            lblTotalInterest.text = "Total Interest:"
            lblTotalTax.text = "Total Tax:"
            lblTotalAmount.text = "Total Amount:"
        }
        else if txtVehicleCost.text != nil && txtDownPayment.text != nil && txtNumberOfMonths.text != nil && txtAPR.text == "0" && txtTaxRate.text == "0" {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtVehicleCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtNumberOfMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            dblTaxRate = Double(txtTaxRate.text!)!
            
            // Get the amount of the loan.
            dblLoan = dblCost - dblDownPayment
            
            // Get the monthly payment.
            dblMonthlyPayment = dblLoan / Double(intMonths)
            
            // Get the Total Amount.
            dblTotalAmount = dblCost
            
            // Get the Vehicle Cost.
            dblCost = dblTotalAmount
            
            // Format the results.
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the Result labels.
            lblMonthlyPayment.text = fResultMonthkyPayment
            lblTotalInterest.text = "$0.00"
            lblTotalTax.text = "$0.00"
            lblTotalAmount.text = fResultTotalAmount
        }
        else if txtVehicleCost.text != nil && txtDownPayment.text != nil && txtNumberOfMonths.text != nil && txtAPR.text == "0.0" && txtTaxRate.text == "0.0" {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtVehicleCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtNumberOfMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            dblTaxRate = Double(txtTaxRate.text!)!
            
            // Get the amount of the loan.
            dblLoan = dblCost - dblDownPayment
            
            // Get the monthly payment.
            dblMonthlyPayment = dblLoan / Double(intMonths)
            
            // Get the Total Amount.
            dblTotalAmount = dblCost
            
            // Get the Vehicle Cost.
            dblCost = dblTotalAmount
            
            // Format the results.
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the Result labels.
            lblMonthlyPayment.text = "Monthly Payment: \(fResultMonthkyPayment)"
            lblTotalInterest.text = "Total Interest: $0.00"
            lblTotalTax.text = "Total Tax: $0.00"
            lblTotalAmount.text = "Total Amount: \(fResultTotalAmount)"
        }
            
        else if txtVehicleCost.text != nil && txtDownPayment.text != nil && txtNumberOfMonths.text != nil && txtAPR.text == "0" && txtTaxRate.text == "0.0" {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtVehicleCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtNumberOfMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            dblTaxRate = Double(txtTaxRate.text!)!
            
            // Get the amount of the loan.
            dblLoan = dblCost - dblDownPayment
            
            // Get the monthly payment.
            dblMonthlyPayment = dblLoan / Double(intMonths)
            
            // Get the Total Amount.
            dblTotalAmount = dblCost
            
            // Get the Vehicle Cost.
            dblCost = dblTotalAmount
            
            // Format the results.
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the Result labels.
            lblMonthlyPayment.text = "Monthly Payment: \(fResultMonthkyPayment)"
            lblTotalInterest.text = "Total Interest: $0.00"
            lblTotalTax.text = "Total Tax: $0.00"
            lblTotalAmount.text = "Total Amount: \(fResultTotalAmount)"
        }
        else if txtVehicleCost.text != nil && txtDownPayment.text != nil && txtNumberOfMonths.text != nil && txtAPR.text == "0.0" && txtTaxRate.text == "0" {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtVehicleCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtNumberOfMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            dblTaxRate = Double(txtTaxRate.text!)!
            
            // Get the amount of the loan.
            dblLoan = dblCost - dblDownPayment
            
            // Get the monthly payment.
            dblMonthlyPayment = dblLoan / Double(intMonths)
            
            // Get the Total Amount.
            dblTotalAmount = dblCost
            
            // Get the Vehicle Cost.
            dblCost = dblTotalAmount
            
            // Format the results.
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the Result labels.
            lblMonthlyPayment.text = fResultMonthkyPayment
            lblTotalInterest.text = "$0.00"
            lblTotalTax.text = "$0.00"
            lblTotalAmount.text = fResultTotalAmount
        }
        else if txtVehicleCost.text != nil && txtDownPayment.text != nil && txtNumberOfMonths.text != nil && txtAPR.text == "0" && txtTaxRate.text != nil {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtVehicleCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtNumberOfMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            dblTaxRate = Double(txtTaxRate.text!)!
            
            // Get the tax rate.
            dblTaxRate = dblTaxRate / 100
            
            // Get the amount of the loan.
            dblLoan = dblCost - dblDownPayment
            
            // Get the monthly payment.
            dblMonthlyPayment = ((dblCost + dblTotalTax) - dblDownPayment) / Double(intMonths)
            
            // Get the total tax.
            dblTotalTax = (dblLoan + dblDownPayment) * (dblTaxRate)
            
            // Get the Total Amount.
            dblTotalAmount = dblCost + dblTotalInterest + dblTotalTax
            
            // Get the Vehicle Cost.
            dblCost = ((dblTotalAmount - dblTotalInterest) - dblTotalTax)
            
            // Format the results.
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fTotalVehicleTax = NSNumber(value: dblTotalTax)
            let fResultTotalTax = NumberFormatter.localizedString(from: fTotalVehicleTax, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the Result labels.
            lblMonthlyPayment.text = fResultMonthkyPayment
            lblTotalInterest.text = "$0.00"
            lblTotalTax.text = fResultTotalTax
            lblTotalAmount.text = fResultTotalAmount
        }
        else if txtVehicleCost.text != nil && txtDownPayment.text != nil && txtNumberOfMonths.text != nil && txtAPR.text == "00" && txtTaxRate.text != nil {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtVehicleCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtNumberOfMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            dblTaxRate = Double(txtTaxRate.text!)!
            
            // Get the tax rate.
            dblTaxRate = dblTaxRate / 100
            
            // Get the amount of the loan.
            dblLoan = dblCost - dblDownPayment
            
            // Get the monthly payment.
            dblMonthlyPayment = ((dblCost + dblTotalTax) - dblDownPayment) / Double(intMonths)
            
            // Get the total tax.
            dblTotalTax = (dblLoan + dblDownPayment) * (dblTaxRate)
            
            // Get the Total Amount.
            dblTotalAmount = dblCost + dblTotalInterest + dblTotalTax
            
            // Get the Vehicle Cost.
            dblCost = ((dblTotalAmount - dblTotalInterest) - dblTotalTax)
            
            // Format the results.
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fTotalVehicleTax = NSNumber(value: dblTotalTax)
            let fResultTotalTax = NumberFormatter.localizedString(from: fTotalVehicleTax, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the Result labels.
            lblMonthlyPayment.text = fResultMonthkyPayment
            lblTotalInterest.text = "$0.00"
            lblTotalTax.text = fResultTotalTax
            lblTotalAmount.text = fResultTotalAmount
        }
        else if txtVehicleCost.text != nil && txtDownPayment.text != nil && txtNumberOfMonths.text != nil && txtAPR.text == "00.0" && txtTaxRate.text != nil {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtVehicleCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtNumberOfMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            dblTaxRate = Double(txtTaxRate.text!)!
            
            // Get the tax rate.
            dblTaxRate = dblTaxRate / 100
            
            // Get the amount of the loan.
            dblLoan = dblCost - dblDownPayment
            
            // Get the monthly payment.
            dblMonthlyPayment = ((dblCost + dblTotalTax) - dblDownPayment) / Double(intMonths)
            
            // Get the total tax.
            dblTotalTax = (dblLoan + dblDownPayment) * (dblTaxRate)
            
            // Get the Total Amount.
            dblTotalAmount = dblCost + dblTotalInterest + dblTotalTax
            
            // Get the Vehicle Cost.
            dblCost = ((dblTotalAmount - dblTotalInterest) - dblTotalTax)
            
            // Format the results.
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fTotalVehicleTax = NSNumber(value: dblTotalTax)
            let fResultTotalTax = NumberFormatter.localizedString(from: fTotalVehicleTax, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the Result labels.
            lblMonthlyPayment.text = fResultMonthkyPayment
            lblTotalInterest.text = "$0.00"
            lblTotalTax.text = fResultTotalTax
            lblTotalAmount.text = fResultTotalAmount
        }
        else if txtVehicleCost.text != nil && txtDownPayment.text != nil && txtNumberOfMonths.text != nil && txtAPR.text == "0.00" && txtTaxRate.text != nil {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtVehicleCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtNumberOfMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            dblTaxRate = Double(txtTaxRate.text!)!
            
            // Get the tax rate.
            dblTaxRate = dblTaxRate / 100
            
            // Get the amount of the loan.
            dblLoan = dblCost - dblDownPayment
            
            // Get the monthly payment.
            dblMonthlyPayment = ((dblCost + dblTotalTax) - dblDownPayment) / Double(intMonths)
            
            // Get the total tax.
            dblTotalTax = (dblLoan + dblDownPayment) * (dblTaxRate)
            
            // Get the Total Amount.
            dblTotalAmount = dblCost + dblTotalInterest + dblTotalTax
            
            // Get the Vehicle Cost.
            dblCost = ((dblTotalAmount - dblTotalInterest) - dblTotalTax)
            
            // Format the results.
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fTotalVehicleTax = NSNumber(value: dblTotalTax)
            let fResultTotalTax = NumberFormatter.localizedString(from: fTotalVehicleTax, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the Result labels.
            lblMonthlyPayment.text = fResultMonthkyPayment
            lblTotalInterest.text = "$0.00"
            lblTotalTax.text = fResultTotalTax
            lblTotalAmount.text = fResultTotalAmount
        }
        else if txtVehicleCost.text != nil && txtDownPayment.text != nil && txtNumberOfMonths.text != nil && txtAPR.text == "0.0" && txtTaxRate.text != nil {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtVehicleCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtNumberOfMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            dblTaxRate = Double(txtTaxRate.text!)!
            
            // Get the tax rate.
            dblTaxRate = dblTaxRate / 100
            
            // Get the amount of the loan.
            dblLoan = dblCost - dblDownPayment
            
            // Get the monthly payment.
            dblMonthlyPayment = ((dblCost + dblTotalTax) - dblDownPayment) / Double(intMonths)
            
            // Get the total tax.
            dblTotalTax = (dblLoan + dblDownPayment) * (dblTaxRate)
            
            // Get the Total Amount.
            dblTotalAmount = dblCost + dblTotalInterest + dblTotalTax
            
            // Get the Vehicle Cost.
            dblCost = ((dblTotalAmount - dblTotalInterest) - dblTotalTax)
            
            // Format the results.
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fTotalVehicleTax = NSNumber(value: dblTotalTax)
            let fResultTotalTax = NumberFormatter.localizedString(from: fTotalVehicleTax, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the Result labels.
            lblMonthlyPayment.text = fResultMonthkyPayment
            lblTotalInterest.text = "$0.00"
            lblTotalTax.text = fResultTotalTax
            lblTotalAmount.text = fResultTotalAmount
        }
            
        else if txtVehicleCost.text != nil && txtDownPayment.text != nil && txtNumberOfMonths.text != nil && txtAPR.text != nil && txtTaxRate.text == "0" {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtVehicleCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtNumberOfMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            dblTaxRate = Double(txtTaxRate.text!)!
            
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
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fTotalInterest = NSNumber(value: dblTotalInterest)
            let fResultTotalInterest = NumberFormatter.localizedString(from: fTotalInterest, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the Result labels.
            lblMonthlyPayment.text = fResultMonthkyPayment
            lblTotalInterest.text = fResultTotalInterest
            lblTotalTax.text = "$0.00"
            lblTotalAmount.text = fResultTotalAmount
        }
        else if txtVehicleCost.text != nil && txtDownPayment.text != nil && txtNumberOfMonths.text != nil && txtAPR.text != nil && txtTaxRate.text == "0.0" {
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtVehicleCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtNumberOfMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            dblTaxRate = Double(txtTaxRate.text!)!
            
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
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fTotalInterest = NSNumber(value: dblTotalInterest)
            let fResultTotalInterest = NumberFormatter.localizedString(from: fTotalInterest, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the Result labels.
            lblMonthlyPayment.text = fResultMonthkyPayment
            lblTotalInterest.text = fResultTotalInterest
            lblTotalTax.text = "$0.00"
            lblTotalAmount.text = fResultTotalAmount
        } 
        else if txtVehicleCost.text != nil && txtDownPayment.text != nil && txtNumberOfMonths.text != nil && txtAPR != nil && txtTaxRate.text != nil {
            
            // Clear the message.
            lblMessage.text = ""
            
            dblCost = Double(txtVehicleCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtNumberOfMonths.text!)!
            dblAPR = Double(txtAPR.text!)!
            dblTaxRate = Double(txtTaxRate.text!)!
            
            // Get the tax rate.
            dblTaxRate = dblTaxRate / 100
            
            // Get the APR rate.
            dblAPR = dblAPR / 100
            
            // Get the monthly rate.
            dblMonthlyRate = dblAPR / dblMONTHS_YEAR
            
            // Get the amount of the loan.
            dblLoan = dblCost - dblDownPayment
            
            // Get the total tax.
            dblTotalTax = (dblLoan + dblDownPayment) * (dblTaxRate)
            
            // Get the monthly payment.
            dblMonthlyPayment = ((dblCost + dblTotalTax) - dblDownPayment) * (dblMonthlyRate / (1 - pow(1 + dblMonthlyRate, Double(-intMonths))))
            
            // Get the total interest.
            dblTotalInterest = dblMonthlyPayment * Double(intMonths) - dblLoan
            
            // Get the Total Amount.
            dblTotalAmount = dblCost + dblTotalInterest + dblTotalTax
            
            // Get the Vehicle Cost.
            dblCost = ((dblTotalAmount - dblTotalInterest) - dblTotalTax)
            
            // Format the results.
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fTotalInterest = NSNumber(value: dblTotalInterest)
            let fResultTotalInterest = NumberFormatter.localizedString(from: fTotalInterest, number: .currency)
            
            let fTotalVehicleTax = NSNumber(value: dblTotalTax)
            let fResultTotalTax = NumberFormatter.localizedString(from: fTotalVehicleTax, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the Result labels.
            lblMonthlyPayment.text = fResultMonthkyPayment
            lblTotalInterest.text = fResultTotalInterest
            lblTotalTax.text = fResultTotalTax
            lblTotalAmount.text = fResultTotalAmount
        }
    }
    @IBAction func btnClear(_ sender: UIButton) {
        
        txtVehicleCost.text = ""
        txtDownPayment.text = ""
        txtNumberOfMonths.text = ""
        txtAPR.text = ""
        txtTaxRate.text = ""
        lblMessage.text = ""
        lblMonthlyPayment.text = ""
        lblTotalInterest.text = ""
        lblTotalTax.text = ""
        lblTotalAmount.text = ""
        
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        txtVehicleCost.delegate = self
        txtDownPayment.delegate = self
        txtNumberOfMonths.delegate = self
        txtAPR.delegate = self
        txtTaxRate.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        txtVehicleCost.resignFirstResponder()
        txtDownPayment.resignFirstResponder()
        txtNumberOfMonths.resignFirstResponder()
        txtAPR.resignFirstResponder()
        txtTaxRate.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }


}

