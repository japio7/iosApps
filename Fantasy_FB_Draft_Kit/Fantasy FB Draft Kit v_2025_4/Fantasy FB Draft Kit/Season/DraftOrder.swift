//
//  DraftOrder.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 6/19/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import UIKit

class DraftOrder: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var passedData = RowSelected()
    var stringPassedData = SegueString()
    var draftOrder = [PlayerData]()
    
    func set_db() {
        if passedData.year == currentYear {
            draftOrder = currentDatabase.draftList()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        set_db()
        print(currentDatabase.draftList().count)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if draftOrder.count == 0 {
            table.setEmptyView(message: "The \(currentYear) Fantasy Draft Has Not Started!")
            label.isHidden = true
        } else {
            table.restore()
        }
        return draftOrder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let player = draftOrder[indexPath.row]
            let str = "\(player.name),  \(player.team) - \(player.position)"
            let defOnly = "\(player.name) - \(player.position)"
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            if player.position == "DST" {
                cell.textLabel?.text = "\(indexPath.row+1).  \(defOnly)"
            } else {
                cell.textLabel?.text = "\(indexPath.row+1).  \(str)"
            }
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
            return cell
        }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var valueToPass = SegueString().str
        var rowsToPass = RowSelected()
        if segue.identifier == "done" {
            if let destVC = segue.destination as? Season {
                let str = "done"
                valueToPass = str
                rowsToPass.year = passedData.year
                rowsToPass.row = passedData.row
                rowsToPass.sec = passedData.sec
                destVC.stringPassedData.str = valueToPass
                destVC.passedData = rowsToPass
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentDatabase.isDone = false
        if stringPassedData.str == nil {
            btnDone.title = ""
            btnDone.isEnabled = false
        } else {
            self.navigationItem.setHidesBackButton(true, animated: true)
            btnDone.title = "Done"
            btnDone.isEnabled = true
        }
    }
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var table: UITableView!
    @IBAction func btnDone(_ sender: UIBarButtonItem) {
        currentDatabase.isDone = true
        performSegue(withIdentifier: "done", sender: self)
    }
    @IBOutlet weak var btnDone: UIBarButtonItem!
}

