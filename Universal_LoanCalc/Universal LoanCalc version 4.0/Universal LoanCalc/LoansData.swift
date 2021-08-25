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
    @IBOutlet weak var date: UILabel!
}
