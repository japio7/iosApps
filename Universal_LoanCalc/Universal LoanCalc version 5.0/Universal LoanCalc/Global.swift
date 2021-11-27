//
//  Global.swift
//  Universal LoanCalc
//
//  Created by Jared Pino on 11/24/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import Foundation
import UIKit

class Data {
    
    static var shared = Data()
    
    var myLoans : [String] = []
    var myLoansData : [[String]] = []
    var myLoans_a : [[String : [String : String]]] = []
    var loanHist : [[String : [String : String]]] = []
    
    // Store loans in UserDefaults
    func storeLoans(loanNames: [String], loanData: [[String]], loans: [[String : [String : String]]]) {
        UserDefaults.standard.set(loanNames, forKey: "loanNames")
        UserDefaults.standard.set(loanData, forKey: "loanData")
        UserDefaults.standard.set(loans, forKey: "loans")
    }
    
    // load loans from UserDefaults
    func loadLoans() {
        myLoans = UserDefaults.standard.value(forKey: "loanNames") as! [String]
        myLoansData = UserDefaults.standard.value(forKey: "loanData") as! [[String]]
        myLoans_a = (UserDefaults.standard.object(forKey: "loans") as? [[String : [String : String]]])!
    }
    
    // Delete loan
    func deleteLoan(index: IndexPath) {
        if myLoans != [] {
            myLoans.remove(at: index.row)
            myLoansData.remove(at: index.row)
            myLoans_a.remove(at: index.row)
            storeLoans(loanNames: myLoans, loanData: myLoansData, loans: myLoans_a)
        } else {
            return
        }
    }
    
    // Store Loan history
    func storeLoanHist() {
        UserDefaults.standard.set(loanHist, forKey: "loanHist")
    }
    
    // Load Loan History
    func loadLoanHist() {
        loanHist = (UserDefaults.standard.object(forKey: "loanHist") as? [[String : [String : String]]])!
    }
}

struct DataToPassTo_PS_ADD {
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

struct RowSelected {
    var sec: Int?
    var row: Int?
}

extension UITableView {
    func setEmptyView(message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let messageLabel = UILabel()
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.textColor = .systemGray
        messageLabel.font = UIFont.boldSystemFont(ofSize: 35)
        emptyView.addSubview(messageLabel)
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        messageLabel.topAnchor.constraint(equalTo: emptyView.topAnchor, constant: 30).isActive = true
        messageLabel.text = message
        messageLabel.numberOfLines = 5
        messageLabel.textAlignment = .center
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}
