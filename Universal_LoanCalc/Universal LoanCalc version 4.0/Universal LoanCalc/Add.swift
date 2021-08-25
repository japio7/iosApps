//
//  Add.swift
//  Universal LoanCalc
//
//  Created by Jared Pino on 10/30/19.
//  Copyright © 2019 Jared Pino. All rights reserved.
//

import Foundation
import UIKit

class Add: UIViewController, UITextFieldDelegate {
    var passedData = DataToPassTo_PS_ADD()
    
    var loanName: String = ""
    var date : String = ""
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
    
    var apr = ""
    var mon = ""
    var cos = ""
    var dp = ""
    var la = ""
    var m_pmt = ""
    var int = ""
    var tot_amt = ""
    
    var loanDict = [String:String]()
    var loanDict2 = [String:[String:String]]()
    var loan_data: [String] = []
    
    var histLoan1 = [String:String]()
    var histLoan2 = [String:[String:String]]()
    
    func formatResults() {
        loanName = txtLoanName.text!
        // Format the results.
        let fCost = NSNumber(value: passedData.cost)
        let fResultCost = NumberFormatter.localizedString(from: fCost, number: .currency)
        cos = fResultCost
        
        let fDownPayment = NSNumber(value: passedData.downPayment)
        let fResultDownPayment = NumberFormatter.localizedString(from: fDownPayment, number: .currency)
        dp = fResultDownPayment
        
        let fLoan = NSNumber(value: passedData.loanAmount)
        let fResultLoan = NumberFormatter.localizedString(from: fLoan, number: .currency)
        la = fResultLoan
        
        let fMonthlyPayment = NSNumber(value: passedData.monthlyPayment)
        let fResultMonthkyPayment = NumberFormatter.localizedString(from: fMonthlyPayment, number: .currency)
        m_pmt = fResultMonthkyPayment
        
        let percentFormatter = NumberFormatter()
        percentFormatter.usesGroupingSeparator = true
        percentFormatter.numberStyle = .percent
        percentFormatter.minimumFractionDigits = 0
        percentFormatter.maximumFractionDigits = 5
        percentFormatter.locale = Locale.current
        let fResultAPR = percentFormatter.string(from: NSNumber(value: passedData.APR))!
        apr = fResultAPR
        
        let fTotalInterest = NSNumber(value: passedData.totalInterest)
        let fResultTotalInterest = NumberFormatter.localizedString(from: fTotalInterest, number: .currency)
        int = fResultTotalInterest
        
        let fTotalAmount = NSNumber(value: passedData.totalAmount)
        let fResultTotalAmount = NumberFormatter.localizedString(from: fTotalAmount, number: .currency)
        tot_amt = fResultTotalAmount
        lblAPR.text = "APR:"
        lblAPR_Result.text = fResultAPR
        lblMonths.text = "Months:"
        lblMonths_Result.text = String(passedData.months)
        lblCost.text = "Cost:"
        lblCost_Result.text = fResultCost
        lblDownPayment.text = "Down Payment:"
        lblDownPayment_Result.text = fResultDownPayment
        lblLoanAmount.text = "Loan Amount:"
        lblLoanAmount_Result.text = fResultLoan
        lblMonthlyPayment.text = "Monthly Payment:"
        lblMonthlyPayment_Result.text = fResultMonthkyPayment
        lblTotalInterest.text = "Total Interest:"
        lblTotalInterest_Result.text = fResultTotalInterest
        lblTotalAmount.text = "Total Amount:"
        lblTotalAmount_Result.text = fResultTotalAmount
        
        mon = lblMonths_Result.text!
    }
    
    @IBAction func btnConfirm(_ sender: UIBarButtonItem) {
        loanName = txtLoanName.text!
        if loanName == "" {
            return
        }
        else if Data.shared.myLoans.contains(loanName.uppercased()) {
            message.text = "You cannot duplicate loan names!"
        }
        else {
            message.text = ""
            loan_data = [apr, mon, cos, dp, la, m_pmt, int, tot_amt]
            Data.shared.myLoans.insert(loanName.uppercased(), at: 0)
            Data.shared.myLoansData.insert(loan_data, at: 0)
            loanDict = ["date":self.date, "APR":self.apr, "months":self.mon, "cost":self.cos, "down payment":self.dp, "loan amount":self.la, "monthly payment":self.m_pmt, "total interest":self.int, "total amount":self.tot_amt]
            loanDict2 = [loanName : loanDict]
            date = DateFormatter.localizedString(from: Date(), dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none)
            histLoan1 = ["APR":self.apr, "months":self.mon, "cost":self.cos, "down payment":self.dp, "loan amount":self.la, "monthly payment":self.m_pmt, "total interest":self.int, "total amount":self.tot_amt]
            histLoan2 = [loanName : histLoan1]
            Data.shared.myLoans_a.insert(loanDict2, at: 0)
            Data.shared.storeLoans(loanNames: Data.shared.myLoans, loanData: Data.shared.myLoansData, loans: Data.shared.myLoans_a)
            Data.shared.loanHist.insert(histLoan2, at: 0)
            Data.shared.storeLoanHist()
            let alert = UIAlertController(title: "Loan Added!", message: "You added '\(loanName.uppercased())' to your loans!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (OkayAction) in
                self.performSegue(withIdentifier: "my loans 2", sender: self)
            }))
            self.present(alert, animated: true)
        }
    }
    
    @IBOutlet weak var txtLoanName: UITextField!
    @IBOutlet weak var lblAPR: UILabel!
    @IBOutlet weak var lblAPR_Result: UILabel!
    @IBOutlet weak var lblMonths: UILabel!
    @IBOutlet weak var lblMonths_Result: UILabel!
    @IBOutlet weak var lblCost: UILabel!
    @IBOutlet weak var lblCost_Result: UILabel!
    @IBOutlet weak var lblDownPayment: UILabel!
    @IBOutlet weak var lblDownPayment_Result: UILabel!
    @IBOutlet weak var lblLoanAmount: UILabel!
    @IBOutlet weak var lblLoanAmount_Result: UILabel!
    @IBOutlet weak var lblMonthlyPayment: UILabel!
    @IBOutlet weak var lblMonthlyPayment_Result: UILabel!
    @IBOutlet weak var lblTotalInterest: UILabel!
    @IBOutlet weak var lblTotalInterest_Result: UILabel!
    @IBOutlet weak var lblTotalAmount: UILabel!
    @IBOutlet weak var lblTotalAmount_Result: UILabel!
    @IBOutlet weak var message: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatResults()
        message.text = ""
        message.textColor = .red
    }
    
}
