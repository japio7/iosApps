//
//  MyLoans2.swift
//  Universal LoanCalc
//
//  Created by Jared Pino on 11/26/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import UIKit

struct BackToMain {
    var cost = ""
    var downPayment = ""
    var months = ""
    var APR = ""
    var labels = ""
    var results = ""
}

class MyLoans2: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var selectedRow: Int = 0
    
    var myLoansData = [[String]]()
    var myLoanNames = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Data.shared.myLoans.count == 0 {
            tableView.setEmptyView(message: "You Currently Do Not Have Any Loans!")
        }
        else {
            tableView.restore()
        }
        return Data.shared.myLoans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = Data.shared.myLoans[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        selectedRow = indexPath.row
        performSegue(withIdentifier: "loans data", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let loan = Data.shared.myLoans[indexPath.row]
        
        let delete = UIContextualAction(style: .destructive, title: "Delete Loan") { (contextualAction, view, actionPerformed: @escaping (Bool) -> Void) in
            let alert = UIAlertController(title: "Delete Loan", message: "Are you sure you want to delete '\(loan)'?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (alertAction) in
                    actionPerformed(false)
            }))
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (alertAction) in
                Data.shared.deleteLoan(index: indexPath)
                tableView.reloadData()
                let okayAlert = UIAlertController(title: "Loan Deleted!", message: "You deleted '\(loan)'!", preferredStyle: .alert)
                okayAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alertAction) in
                        actionPerformed(true)
                }))
                    self.present(okayAlert, animated: true)
                }))
                self.present(alert, animated: true)
            }
            delete.backgroundColor = .systemRed
            let config = UISwipeActionsConfiguration(actions: [delete])
            config.performsFirstActionWithFullSwipe = false
        return config
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loans data" {
            if let destVC = segue.destination as? LoansData {
                var valueToPass = RowSelected()
                let row_selected = selectedRow
                valueToPass.row = row_selected
                destVC.passedData = valueToPass
            }
        }
        if segue.identifier == "done" {
            if let destVC = segue.destination as? ViewController {
                var valueToPass = BackToMain()
                valueToPass.APR = ""
                valueToPass.cost = ""
                valueToPass.downPayment = ""
                valueToPass.labels = ""
                valueToPass.results = ""
                destVC.passedData_2 = valueToPass
            }
        }
    }
    
    

    @IBOutlet weak var table: UITableView!
    @IBAction func done(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "done", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(true, animated: true)
    }

}
