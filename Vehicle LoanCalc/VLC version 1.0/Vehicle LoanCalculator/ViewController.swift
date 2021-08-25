//
//  ViewController.swift
//  Vehicle LoanCalculator
//
//  Created by Jared Pino on 3/7/18.
//  Copyright © 2018 Jared Pino. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    // Class-level constant to hold the months per year.
    let dblMONTHS_YEAR: Double = 12
    
    func textField(_ textField: UITextField,shouldChangeCharactersIn range: NSRange,replacementString string: String) -> Bool
    {
        let countdots = (textField.text?.components(separatedBy: ".").count)! - 1
        
        if countdots > 0 && string == "."
        {
            return false
        }
        return true
    }
    
    // Text Fields
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
        var intMonths: Int = 0                        // To hold number of months for the loan.
        var dblLoan: Double = 0                        // To hold the amount of the loan.
        var dblMonthlyPayment: Double = 0              // To hold the monthly payment.
        var dblTotalInterest: Double = 0              // To hold the total interest.
        var dblTaxRate: Double = 0                     // To hold the tax rate.
        var dblTotalTax: Double = 0                    // To hold the total tax.
        var dblMonthlyRate: Double = 0
        
        if txtVehicleCost.text == "" || txtVehicleCost.text == "0" {
            lblMessage.text = "Enter Vehicle and/or Loan Information!"
        }
        else if txtDownPayment.text == "" {
            lblMessage.text = "Enter Vehicle and/or Loan Information!"
        }
        else if txtNumberOfMonths.text == "" {
            lblMessage.text = "Enter Vehicle and/or Loan Information!"
        }
        else if txtAPR.text == "" {
            lblMessage.text = "Enter Vehicle and/or Loan Information!"
        }
        else if txtTaxRate.text == "" {
            lblMessage.text = "Enter Vehicle and/or Loan Information!"
        }
        else if txtNumberOfMonths.text == "0" {
            lblMessage.text = "Enter Vehicle and/or Loan Information!"
        }
        else if txtVehicleCost.text != nil && txtDownPayment.text != nil && txtNumberOfMonths.text != nil && txtAPR.text == "0" || txtTaxRate.text == "0" {
            lblMessage.text = "APR % Rate or Tax % Rate cannot be 0!"
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

