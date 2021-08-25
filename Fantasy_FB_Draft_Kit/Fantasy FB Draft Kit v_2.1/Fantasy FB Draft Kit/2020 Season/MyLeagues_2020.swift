//
//  MyLeagues_2020.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 6/19/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import UIKit

class MyLeagues_2020: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myLeagues: [String]?
    var selectedRow: Int = 0
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        selectedRow = indexPath.row
        performSegue(withIdentifier: "MyLeague_2020", sender: self)
        table.deselectRow(at: indexPath, animated: true)
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Database_2020.shared.leagueNames.count == 0 {
            tableView.setEmptyView(message: "You Currently Do Not Have Any Leagues!")
            lblMyLeagues.isHidden = true
        }
        else {
            tableView.restore()
        }
        return Database_2020.shared.leagueNames.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let league = Database_2020.shared.leagueNames[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row+1).  \(league)"
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let league = Database_2020.shared.leagueNames[indexPath.row]
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, actionPerformed: @escaping (Bool) -> Void) in
            let alert = UIAlertController(title: "Delete League", message: "Are you sure you want to delete '\(league)'?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (alertAction) in
                Database_2020.shared.deleteLeague(index: indexPath, _table: self.table)
                actionPerformed(true)
                if Database_2020.shared.leagueNames == [] {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
                    let noLeaguesMessage: [String] = ["", "You Currently Do Not Have Any Leagues!"]
                    cell.textLabel?.text = noLeaguesMessage[indexPath.row]
                    cell.textLabel?.font = .systemFont(ofSize: 35)
                    cell.textLabel?.numberOfLines = 3
                    cell.textLabel?.adjustsFontSizeToFitWidth = true
                    cell.textLabel?.textAlignment = .center
                    tableView.reloadData()
                }
            }))
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (alertAction) in
                actionPerformed(false)
            }))
            self.present(alert, animated: true)
        }
        let config = UISwipeActionsConfiguration(actions: [delete])
        config.performsFirstActionWithFullSwipe = false
        return config
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MyLeague_2020" {
            if let destVC = segue.destination as? MyLeague_2020 {
                var valueToPass = RowSelected()
                let row_selected = selectedRow
                valueToPass.row = row_selected
                destVC.passedData = valueToPass
            }
        }
    }
    
    @IBOutlet weak var lblMyLeagues: UILabel!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class AddLeague_2020: UIViewController {
    var leagueName: String = ""
    func myLeaguesSegue() {
        performSegue(withIdentifier: "MyLeagues_2020", sender: UIAlertAction.self)
    }
    
    @IBOutlet weak var txtLeagueName: UITextField!
    @IBOutlet weak var message: UILabel!
    @IBAction func btnAdd(_ sender: UIButton) {
        leagueName = txtLeagueName.text!
        if txtLeagueName.text == "" {
            message.text = ""
            return
        }
        if Database_2020.shared.leagueNames.contains(leagueName) {
            message.text = "You cannot duplicate league names!"
        }
        else if Database_2020.shared.roster_array() == [] {
            message.text = ""
            let okayAlert = UIAlertController(title: "Empty Team!", message: "You cannot add an empty team to a league!", preferredStyle: .alert)
            okayAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (OkayAction) in
            }))
            self.present(okayAlert, animated: true)
            
        }
        else {
            message.text = ""
            Database_2020.shared.addToLeagues(league_name: leagueName)
            let alert = UIAlertController(title: "Added League", message: "You added '\(leagueName)' to your leagues!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (OkayAction) in
            self.myLeaguesSegue()
                Database_2020.shared.resetDraft()
            }))
            self.present(alert, animated: true)
        }
    }
    
    override func viewDidLoad() {
        message.text = ""
    }
}

class MyLeague_2020: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var passedData = RowSelected()
    var data = [Custom_Cell]()

    override func viewDidLoad() {
        league.text = Database_2020.shared.leagueNames[passedData.row!]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Database_2020.shared.leagues[passedData.row!].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "league cell") as! Custom_Cell
        let array = Database_2020.shared.leagues[passedData.row!][indexPath.row].split(separator: ",")
        let newArray = array[1].split(separator: "-")
        let newestArray = newArray[1].split(separator: " ")
        let player = String(array[0])
        let team = String(newArray[0])
        let position = String(newestArray[0])
        let bye = String(newestArray[1])
        
        cell.player.text = player
        cell.team.text = team
        cell.position.text = position
        cell.bye.text = bye
        cell.player.font.withSize(22)
        cell.team.font.withSize(22)
        cell.position.font.withSize(22)
        cell.bye.font.withSize(22)
        cell.player.adjustsFontSizeToFitWidth = true
        cell.team.adjustsFontSizeToFitWidth = true
        cell.position.adjustsFontSizeToFitWidth = true
        cell.bye.adjustsFontSizeToFitWidth = true
        
        return cell
    }
    @IBOutlet weak var league: UILabel!
    @IBOutlet weak var table: UITableView!
    
}
