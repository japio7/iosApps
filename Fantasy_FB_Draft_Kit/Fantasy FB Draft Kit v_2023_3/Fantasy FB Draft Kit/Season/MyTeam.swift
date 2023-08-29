//
//  MyTeam.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 6/19/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import UIKit

class MyTeam: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var passedData = RowSelected()
    var stringPassedData = SegueString()
    var myRoster = [PlayerData]()
    let year = Int(currentYear)
    
    func set_db() {
        if passedData.year == year {
            myRoster = Database_2023.shared.rosterList()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        set_db()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if myRoster.count == 0 {
            table.setEmptyView(message: "You Currently Do Not Have Any Players On Your Team!")
            lblMyTeam.isHidden = true
        }
        else {
            table.restore()
        }
        return myRoster.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let player = myRoster[indexPath.row]
        let str = "\(player.name),  \(player.team) - \(player.position) (\(player.byeWeek))"
        let defOnly = "\(player.name) - \(player.position) (\(player.byeWeek))"
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
        if stringPassedData.str == nil {
            btnDone.title = ""
            btnDone.isEnabled = false
        } else {
            self.navigationItem.setHidesBackButton(true, animated: true)
            btnDone.title = "Done"
            btnDone.isEnabled = true
        }
    }
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var lblMyTeam: UILabel!
    @IBAction func btnDone(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "done", sender: self)
    }
    
    @IBOutlet weak var btnDone: UIBarButtonItem!
    
}
