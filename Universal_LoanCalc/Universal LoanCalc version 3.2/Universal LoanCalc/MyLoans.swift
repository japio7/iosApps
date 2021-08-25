//
//  MyLoans.swift
//  Universal LoanCalc
//
//  Created by Jared Pino on 10/29/19.
//  Copyright © 2019 Jared Pino. All rights reserved.
//

import Foundation
import UIKit

class MyLoans: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var myLoans: [String] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myLoans.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = myLoansTable.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = myLoans[indexPath.row]
        return cell
    }
    
    @IBOutlet weak var myLoansTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
}
