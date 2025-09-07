//
//  MyLeagues.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 6/19/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import UIKit

class MyLeagues: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var passedData = RowSelected()
    var passedLeagueAdded = LeagueAddedStruct()
    var leagues: [String]?
    var teamNames: [String]?
    var selectedRow = 0
    var leagueAdded: Bool = false
    
    func set_db() {
        if passedData.year == currentYear {
            leagues = currentDatabase.leagueNames
            teamNames = currentDatabase.teamNames
            leagueAdded = passedLeagueAdded.leagueAdded
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        set_db()
        if leagueAdded == true {
                   self.navigationItem.setHidesBackButton(true, animated: true)
            self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Home",
                style: .plain, target: self, action: #selector(home))
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        selectedRow = indexPath.row
        performSegue(withIdentifier: "MyLeague", sender: self)
        table.deselectRow(at: indexPath, animated: true)
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        set_db()
        if leagues!.count == 0 {
            tableView.setEmptyView(message: "You Currently Do Not Have Any Leagues!")
            lblMyLeagues.isHidden = true
        } else {
            tableView.restore()
        }
        return leagues!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "leagues cell") as! LeaguesCustomCell
        cell.teamName.text = teamNames![indexPath.row]
        cell.num.text = "\(indexPath.row+1)."
        cell.leagueName.text = leagues![indexPath.row]
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let league = leagues![indexPath.row]
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, actionPerformed: @escaping (Bool) -> Void) in
            let alert = UIAlertController(title: "Delete League", message: "Are you sure you want to delete '\(league)'?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (alertAction) in
                if self.passedData.year == currentYear {
                    currentDatabase.deleteLeague(index: indexPath, _table: self.table)
                }
                actionPerformed(true)
                self.set_db()
                if self.leagues == [] {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "leagues cell", for: indexPath)
                    let noLeaguesMessage: [String] = ["", "You Currently Do Not Have Any Leagues!"]
                    cell.textLabel?.text = noLeaguesMessage[indexPath.row]
                    cell.textLabel?.font = .systemFont(ofSize: 35)
                    cell.textLabel?.numberOfLines = 3
                    cell.textLabel?.adjustsFontSizeToFitWidth = true
                    cell.textLabel?.textAlignment = .center
                    self.table.reloadData()
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
        var valueToPass = RowSelected()
        if segue.identifier == "MyLeague" {
            if let destVC = segue.destination as? MyLeague {
                let row_selected = selectedRow
                valueToPass.year = passedData.year
                valueToPass.row = row_selected
                destVC.passedData = valueToPass
            }
        }
    }
    
    @objc
    func home() {
        self.performSegue(withIdentifier: "unwind to main", sender: self)
    }
    
    @IBOutlet weak var lblMyLeagues: UILabel!
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class AddLeague: UIViewController {
    var passedData = RowSelected()
    var leagues: [String]?
    var teamNames: [String]?
    var roster: [String]?
    var leagueName = ""
    var teamName = ""
    var leagueAdded: Bool = false
    var hasTeamName: Bool = false
    
    func set_db() {
        if passedData.year == currentYear {
            leagues = currentDatabase.leagueNames
            roster = currentDatabase.roster_array()
        }
    }
    
    func myLeaguesSegue() {
        performSegue(withIdentifier: "MyLeagues", sender: UIAlertAction.self)
    }
    
    @IBOutlet weak var txtLeagueName: UITextField!
    @IBOutlet weak var txtTeamName: UITextField!
    @IBOutlet weak var message: UILabel!
    @IBAction func btnAdd(_ sender: UIButton) {
        leagueName = txtLeagueName.text!
        teamName = txtTeamName.text!
        if teamName == "" {
            hasTeamName = false
        } else {
            hasTeamName = true
        }
        if leagueName == "" {
            message.text = ""
            return
        }
        set_db()
        if leagues!.contains(leagueName) {
            message.text = "You cannot duplicate league names!"
        } else if roster == [] {
            message.text = ""
            let okayAlert = UIAlertController(title: "Empty Team!", message: "You cannot add an empty team to a league!", preferredStyle: .alert)
            okayAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (OkayAction) in
            }))
            self.present(okayAlert, animated: true)
        } else {
            message.text = ""
            if passedData.year == currentYear {
                currentDatabase.addToLeagues(league_name: leagueName, team_name: teamName)
            }
            let alert = UIAlertController(title: "Added League", message: "You added '\(leagueName)' to your leagues!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (OkayAction) in
            self.myLeaguesSegue()
                if self.passedData.year == currentYear {
                    currentDatabase.resetDraft()
                }
            }))
            self.present(alert, animated: true)
            leagueAdded = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var valueToPass = RowSelected()
        var leagueAddedToPass = LeagueAddedStruct()
        if segue.identifier == "MyLeagues" {
            if let destVC = segue.destination as? MyLeagues {
                valueToPass.year = passedData.year
                leagueAddedToPass.leagueAdded = leagueAdded
                destVC.passedData = valueToPass
                destVC.passedLeagueAdded = leagueAddedToPass
            }
        }
    }
    
    override func viewDidLoad() {
        message.text = ""
    }
}

class MyLeague: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var passedData = RowSelected()
    var leagueNames: [String]?
    var leagues: [[String]]?
    
    func set_db() {
        if passedData.year == currentYear {
            leagueNames = currentDatabase.leagueNames
            leagues = currentDatabase.leagues
        }
    }

    override func viewDidLoad() {
        set_db()
        league.text = leagueNames![passedData.row!]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues![passedData.row!].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "league cell") as! Custom_Cell
        var array = [String.SubSequence]()
        array = leagues![passedData.row!][indexPath.row].split(separator: ",")
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
