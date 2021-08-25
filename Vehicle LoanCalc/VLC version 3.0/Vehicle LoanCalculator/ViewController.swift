//
//  ViewController.swift
//  Vehicle LoanCalculator
//
//  Created by Jared Pino on 3/7/18.
//  Copyright © 2018 Jared Pino. All rights reserved.
//

import Foundation
import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource {
    
    var data: [String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        return cell
    }
    
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
    @IBOutlet weak var txtTax: UITextField!
    
    // Message Label
    @IBOutlet weak var lblMessage: UILabel!
    
    // Result labels
    @IBOutlet weak var lblMonthlyPaymentLabel: UILabel!
    @IBOutlet weak var lblTotalInterestLabel: UILabel!
    @IBOutlet weak var lblTotalTaxLabel: UILabel!
    @IBOutlet weak var lblTotalAmountLabel: UILabel!
    
    @IBOutlet weak var lblMonthlyPayment: UILabel!
    @IBOutlet weak var lblTotalInterest: UILabel!
    @IBOutlet weak var lblTotalTax: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!
    
    @IBOutlet weak var lblPaymentStructure: UILabel!
    @IBOutlet weak var table: UITableView!
    @IBOutlet var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    
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
        var dblMonthlyRate: Double = 0                 // To hold the Monthly Rate.
        var dblTaxRate: Double = 0                     // To hold the Tax Rate.
        var dblTotalTax: Double = 0                    // To hold the Total Tax.
        
        var principal: Double = 0
        var balance: Double = 0
        var monthlyInterest: Double = 0
        var paymentNumber: Int = 0
        
        // Payment Structure Function
        func paymentStructure() {
            
            data = []
            table.reloadData()
            balance = dblLoan
          
            for _ in 1...intMonths {
                paymentNumber+=1
                
                lblPaymentStructure.text = "↓ Payment Structure ↓"
                dblCost = Double(txtVehicleCost.text!)!
                dblDownPayment = Double(txtDownPayment.text!)!
                intMonths = Int(txtNumberOfMonths.text!)!
                dblAPR = Double(txtAPR.text!)!
                
                monthlyInterest = balance * ((dblAPR/100)/12)
                principal = dblMonthlyPayment - monthlyInterest
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
        
        if txtVehicleCost.text == "" {
            lblMessage.text = "Enter the Vehicle Cost Amount!"
            lblPaymentStructure.text = ""
            // Clear the result labels
            lblMonthlyPayment.text = ""
            lblTotalInterest.text = ""
            lblTotalTax.text = ""
            lblTotalAmount.text = ""
        }
        else if txtDownPayment.text == "" {
            lblMessage.text = "Enter the Down Payment Amount!"
            lblPaymentStructure.text = ""
            // Clear the result labels
            lblMonthlyPayment.text = ""
            lblTotalInterest.text = ""
            lblTotalTax.text = ""
            lblTotalAmount.text = ""
        }
        else if txtNumberOfMonths.text == "" {
            lblMessage.text = "Enter the Number of Months!"
            lblPaymentStructure.text = ""
            // Clear the result labels
            lblMonthlyPayment.text = ""
            lblTotalInterest.text = ""
            lblTotalTax.text = ""
            lblTotalAmount.text = ""
        }
        else if txtAPR.text == "" {
            lblMessage.text = "Enter the APR % Rate!"
            lblPaymentStructure.text = ""
            // Clear the result labels
            lblMonthlyPayment.text = ""
            lblTotalInterest.text = ""
            lblTotalTax.text = ""
            lblTotalAmount.text = ""
        }
        else if txtTax.text == "" {
            lblMessage.text = "Enter the Tax % Rate!"
            lblPaymentStructure.text = ""
            // Clear the result labels
            lblMonthlyPayment.text = ""
            lblTotalInterest.text = ""
            lblTotalTax.text = ""
            lblTotalAmount.text = ""
        }
        else if txtVehicleCost.text == "0" {
            lblMessage.text = "The Vehicle Amount Cannot be 0!"
            lblPaymentStructure.text = ""
            // Clear the result labels
            lblMonthlyPayment.text = ""
            lblTotalInterest.text = ""
            lblTotalTax.text = ""
            lblTotalAmount.text = ""
        }
        else if txtNumberOfMonths.text == "0" || txtNumberOfMonths.text == "00"  {
            lblMessage.text = "The Number of Months is Not Valid!"
            lblPaymentStructure.text = ""
            // Clear the result labels
            lblMonthlyPayment.text = ""
            lblTotalInterest.text = ""
            lblTotalTax.text = ""
            lblTotalAmount.text = ""
        }
        else if txtNumberOfMonths.text! > "84" {
            lblMessage.text = "The Number of Months is Not Valid!"
            lblPaymentStructure.text = ""
            // Clear the result labels
            lblMonthlyPayment.text = ""
            lblTotalInterest.text = ""
            lblTotalTax.text = ""
            lblTotalAmount.text = ""
        }
        else if txtAPR.text == "000" || txtAPR.text == "0000" || txtAPR.text == "00000" || txtAPR.text == "00.00" || txtAPR.text == "0.000" || txtAPR.text == "000.0" || txtAPR.text == ".000" || txtAPR.text == ".00" || txtAPR.text == ".0" || txtAPR.text == "0." || txtAPR.text == "00." || txtAPR.text == "000." || txtAPR.text == "." {
            lblMessage.text = "The APR % Rate is Not Valid!"
            lblPaymentStructure.text = ""
            // Clear the result labels
            lblMonthlyPayment.text = ""
            lblTotalInterest.text = ""
            lblTotalAmount.text = ""
        }
        else if txtDownPayment.text == txtVehicleCost.text {
            lblMessage.text = "The Down Payment cannot be = to the Vehicle Cost!"
            lblPaymentStructure.text = ""
            // Clear the result labels
            lblMonthlyPayment.text = ""
            lblTotalInterest.text = ""
            lblTotalTax.text = ""
            lblTotalAmount.text = ""
        }
        else if txtVehicleCost.text! < txtDownPayment.text! {
            lblMessage.text = "The Down Payment cannot be > than the Vehicle Cost!"
            lblPaymentStructure.text = ""
            // Clear the result labels
            lblMonthlyPayment.text = ""
            lblTotalInterest.text = ""
            lblTotalTax.text = ""
            lblTotalAmount.text = ""
        }
        else if txtVehicleCost.text != nil && txtDownPayment.text != nil && txtNumberOfMonths.text != nil && txtAPR.text == "0" && txtTax.text != nil {
            
            dblCost = Double(txtVehicleCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtNumberOfMonths.text!)!
            dblTaxRate = Double(txtTax.text!)!
            dblAPR = Double(txtAPR.text!)!
            
            // Clear the message.
            lblMessage.text = ""
            
            // Get the Total Tax.
            dblTotalTax = ((dblTaxRate/100) * dblCost)
            
            // Get the amount of the loan.
            dblLoan = ((dblCost + dblTotalTax) - dblDownPayment)
            
            // Get the monthly payment.
            dblMonthlyPayment = dblLoan / Double(intMonths)
            
            // Get the Total Amount.
            dblTotalAmount = dblCost + dblTotalTax
            
            // Format the results.
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fTotalTax = NSNumber(value: dblTotalTax)
            let fResultTotalTax = NumberFormatter.localizedString(from: fTotalTax, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the Result labels.
            lblMonthlyPayment.text = fResultMonthkyPayment
            lblTotalInterest.text = "$0.00"
            lblTotalTax.text = fResultTotalTax
            lblTotalAmount.text = fResultTotalAmount
            
            paymentStructure()
        }
        else if txtVehicleCost.text != nil && txtDownPayment.text != nil && txtNumberOfMonths.text != nil && txtAPR.text == "0.0" && txtTax.text != nil {
            
            dblCost = Double(txtVehicleCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtNumberOfMonths.text!)!
            dblTaxRate = Double(txtTax.text!)!
            dblAPR = Double(txtAPR.text!)!
            
            // Clear the message.
            lblMessage.text = ""
            
            // Get the Total Tax.
            dblTotalTax = ((dblTaxRate/100) * dblCost)
            
            // Get the amount of the loan.
            dblLoan = ((dblCost + dblTotalTax) - dblDownPayment)
            
            // Get the monthly payment.
            dblMonthlyPayment = dblLoan / Double(intMonths)
            
            // Get the Total Amount.
            dblTotalAmount = dblCost + dblTotalTax
            
            // Format the results.
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fTotalTax = NSNumber(value: dblTotalTax)
            let fResultTotalTax = NumberFormatter.localizedString(from: fTotalTax, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the Result labels.
            lblMonthlyPayment.text = fResultMonthkyPayment
            lblTotalInterest.text = "$0.00"
            lblTotalTax.text = fResultTotalTax
            lblTotalAmount.text = fResultTotalAmount
            
            paymentStructure()
        }
        else if txtVehicleCost.text != nil && txtDownPayment.text != nil && txtNumberOfMonths.text != nil && txtAPR.text == "00" && txtTax.text != nil {
            
            dblCost = Double(txtVehicleCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtNumberOfMonths.text!)!
            dblTaxRate = Double(txtTax.text!)!
            dblAPR = Double(txtAPR.text!)!
            
            // Clear the message.
            lblMessage.text = ""
            
            // Get the Total Tax.
            dblTotalTax = ((dblTaxRate/100) * dblCost)
            
            // Get the amount of the loan.
            dblLoan = ((dblCost + dblTotalTax) - dblDownPayment)
            
            // Get the monthly payment.
            dblMonthlyPayment = dblLoan / Double(intMonths)
            
            // Get the Total Amount.
            dblTotalAmount = dblCost + dblTotalTax
            
            // Format the results.
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fTotalTax = NSNumber(value: dblTotalTax)
            let fResultTotalTax = NumberFormatter.localizedString(from: fTotalTax, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the Result labels.
            lblMonthlyPayment.text = fResultMonthkyPayment
            lblTotalInterest.text = "$0.00"
            lblTotalTax.text = fResultTotalTax
            lblTotalAmount.text = fResultTotalAmount
            
            paymentStructure()
        }
        else if txtVehicleCost.text != nil && txtDownPayment.text != nil && txtNumberOfMonths.text != nil && txtAPR.text == "00.0" && txtTax.text != nil {
            
            dblCost = Double(txtVehicleCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtNumberOfMonths.text!)!
            dblTaxRate = Double(txtTax.text!)!
            dblAPR = Double(txtAPR.text!)!
            
            // Clear the message.
            lblMessage.text = ""
            
            // Get the Total Tax.
            dblTotalTax = ((dblTaxRate/100) * dblCost)
            
            // Get the amount of the loan.
            dblLoan = ((dblCost + dblTotalTax) - dblDownPayment)
            
            // Get the monthly payment.
            dblMonthlyPayment = dblLoan / Double(intMonths)
            
            // Get the Total Amount.
            dblTotalAmount = dblCost + dblTotalTax
            
            // Format the results.
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fTotalTax = NSNumber(value: dblTotalTax)
            let fResultTotalTax = NumberFormatter.localizedString(from: fTotalTax, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the Result labels.
            lblMonthlyPayment.text = fResultMonthkyPayment
            lblTotalInterest.text = "$0.00"
            lblTotalTax.text = fResultTotalTax
            lblTotalAmount.text = fResultTotalAmount
            
            paymentStructure()
        }
        else if txtVehicleCost.text != nil && txtDownPayment.text != nil && txtNumberOfMonths.text != nil && txtAPR.text != nil && txtTax.text == "0" {
            
            dblCost = Double(txtVehicleCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtNumberOfMonths.text!)!
            dblTaxRate = Double(txtTax.text!)!
            dblAPR = Double(txtAPR.text!)!
            
            // Clear the message.
            lblMessage.text = ""
            
            // Get the APR rate.
            dblAPR = dblAPR / 100
            
            // Get the monthly rate.
            dblMonthlyRate = dblAPR / dblMONTHS_YEAR
            
            // Get the amount of the loan.
            dblLoan = dblCost - dblDownPayment
            
            // Get the monthly payment.
            dblMonthlyPayment = (dblLoan * (dblMonthlyRate / (1 - pow(1 + dblMonthlyRate, Double(-intMonths)))))
            
            // Get the total interest.
            dblTotalInterest = dblMonthlyPayment * Double(intMonths) - dblLoan
            
            // Get the Total Amount.
            dblTotalAmount = dblCost + dblTotalInterest
            
            // Get the Vehicle Cost.
            dblCost = dblTotalAmount - dblTotalInterest
            
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
            
            paymentStructure()
        }
        else if txtVehicleCost.text != nil && txtDownPayment.text != nil && txtNumberOfMonths.text != nil && txtAPR.text != nil && txtTax.text == "0.0" {
            
            dblCost = Double(txtVehicleCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtNumberOfMonths.text!)!
            dblTaxRate = Double(txtTax.text!)!
            dblAPR = Double(txtAPR.text!)!
            
            // Clear the message.
            lblMessage.text = ""
            
            // Get the APR rate.
            dblAPR = dblAPR / 100
            
            // Get the monthly rate.
            dblMonthlyRate = dblAPR / dblMONTHS_YEAR
            
            // Get the amount of the loan.
            dblLoan = dblCost - dblDownPayment
            
            // Get the monthly payment.
            dblMonthlyPayment = (dblLoan * (dblMonthlyRate / (1 - pow(1 + dblMonthlyRate, Double(-intMonths)))))
            
            // Get the total interest.
            dblTotalInterest = dblMonthlyPayment * Double(intMonths) - dblLoan
            
            // Get the Total Amount.
            dblTotalAmount = dblCost + dblTotalInterest
            
            // Get the Vehicle Cost.
            dblCost = dblTotalAmount - dblTotalInterest
            
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
            
            paymentStructure()
        } 
        else if txtVehicleCost.text != nil && txtDownPayment.text != nil && txtNumberOfMonths.text != nil && txtAPR != nil && txtTax.text != nil {
            
            dblCost = Double(txtVehicleCost.text!)!
            dblDownPayment = Double(txtDownPayment.text!)!
            intMonths = Int(txtNumberOfMonths.text!)!
            dblTaxRate = Double(txtTax.text!)!
            dblAPR = Double(txtAPR.text!)!
            
            // Clear the message.
            lblMessage.text = ""
            
            // Get the APR rate.
            dblAPR = dblAPR / 100
            
            // Get the monthly rate.
            dblMonthlyRate = dblAPR / dblMONTHS_YEAR
            
            // Get the Total Tax.
            dblTotalTax = ((dblTaxRate / 100) * dblCost)
            
            // Get the amount of the loan.
            dblLoan = ((dblCost + dblTotalTax) - dblDownPayment)
            
            // Get the monthly payment.
            dblMonthlyPayment = (dblLoan * (dblMonthlyRate / (1 - pow(1 + dblMonthlyRate, Double(-intMonths)))))
            
            // Get the total interest.
            dblTotalInterest = dblMonthlyPayment * Double(intMonths) - dblLoan
            
            // Get the Total Amount.
            dblTotalAmount = dblCost + dblTotalTax + dblTotalInterest
            
            // Format the results.
            let fMonthlyPayment = NSNumber(value: dblMonthlyPayment)
            let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
            
            let fTotalInterest = NSNumber(value: dblTotalInterest)
            let fResultTotalInterest = NumberFormatter.localizedString(from: fTotalInterest, number: .currency)
            
            let fTotalTax = NSNumber(value: dblTotalTax)
            let fResultTotalTax = NumberFormatter.localizedString(from: fTotalTax, number: .currency)
            
            let fTotalAmount = NSNumber(value: dblTotalAmount)
            let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
            
            // Print the Result labels.
            lblMonthlyPayment.text = fResultMonthkyPayment
            lblTotalInterest.text = fResultTotalInterest
            lblTotalTax.text = fResultTotalTax
            lblTotalAmount.text = fResultTotalAmount
            
            paymentStructure()
        }
    }
    @IBAction func btnClear(_ sender: UIButton) {
        txtVehicleCost.text = ""
        txtDownPayment.text = ""
        txtNumberOfMonths.text = ""
        txtAPR.text = ""
        txtTax.text = ""
        lblMessage.text = ""
        lblMonthlyPayment.text = ""
        lblTotalInterest.text = ""
        lblTotalTax.text = ""
        lblTotalAmount.text = ""
        lblPaymentStructure.text = ""
        data = []
        table.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtVehicleCost.delegate = self
        txtDownPayment.delegate = self
        txtNumberOfMonths.delegate = self
        txtAPR.delegate = self
        txtTax.delegate = self
        lblMonthlyPaymentLabel.text = "Monthly Payment:"
        lblTotalInterestLabel.text = "Total Interest:"
        lblTotalTaxLabel.text = "Total Tax:"
        lblTotalAmountLabel.text = "Total Amount:"
        lblMessage.text = ""
        lblMonthlyPayment.text = ""
        lblTotalInterest.text = ""
        lblTotalTax.text = ""
        lblTotalAmount.text = ""
        lblPaymentStructure.text = ""
        table.delegate = self
        table.dataSource = self
        view1.backgroundColor = .systemGroupedBackground
        table.backgroundColor = .systemBackground
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
        txtTax.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

