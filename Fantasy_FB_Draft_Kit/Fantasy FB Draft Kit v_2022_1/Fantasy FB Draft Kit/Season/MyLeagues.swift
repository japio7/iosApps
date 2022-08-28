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
    var strPassed = SegueString()
    
    var leagues: [String]?
    var teamNames: [String]?
    var selectedRow = 0
    var year = ""
    
    func set_db() {
        if passedData.year == 0 {
            leagues = Database_2020.shared.leagueNames
            year = "2020"
        } else if passedData.year == 1 {
            leagues = Database_2021.shared.leagueNames
            teamNames = Database_2021.shared.teamNames
            year = "2021"
        } else if passedData.year == 2 {
            leagues = Database_2022.shared.leagueNames
            teamNames = Database_2022.shared.teamNames
            year = "2022"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        set_db()
        let str = strPassed.str
        if str == nil {
            currentSeason.title = ""
            currentSeason.isEnabled = false
        } else if str == "add league" {
            currentSeason.title = "\(year) Season"
            currentSeason.isEnabled = true
            self.navigationItem.setHidesBackButton(true, animated: true)
        }
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        selectedRow = indexPath.row
        performSegue(withIdentifier: "MyLeague", sender: self)
        table.deselectRow(at: indexPath, animated: true)
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.set_db()
        if leagues?.count == 0 {
            tableView.setEmptyView(message: "You Currently Do Not Have Any Leagues!")
            lblMyLeagues.isHidden = true
        } else {
            tableView.restore()
        }
        return leagues!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "leagues cell") as! LeaguesCustomCell
        if passedData.year == 0 {
            cell.teamName.isHidden = true
        } else {
            cell.teamName.text = teamNames![indexPath.row]
        }
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
                if self.passedData.year == 0 {
                    Database_2020.shared.deleteLeague(index: indexPath, _table: self.table)
                } else if self.passedData.year == 1 {
                    Database_2021.shared.deleteLeague(index: indexPath, _table: self.table)
                } else if self.passedData.year == 2 {
                    Database_2022.shared.deleteLeague(index: indexPath, _table: self.table)
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
        var strToPass = SegueString()
        if segue.identifier == "MyLeague" {
            if let destVC = segue.destination as? MyLeague {
                let row_selected = selectedRow
                valueToPass.year = passedData.year
                valueToPass.row = row_selected
                destVC.passedData = valueToPass
            }
        } else if segue.identifier == "current season" {
            if let destVC = segue.destination as? Season {
                let str = "add league"
                strToPass.str = str
                valueToPass.year = passedData.year
                valueToPass.row = passedData.row
                valueToPass.sec = passedData.sec
                destVC.passedData = valueToPass
                destVC.stringPassedData = strToPass
            }
        }
    }
    
    @IBOutlet weak var lblMyLeagues: UILabel!
    @IBOutlet weak var table: UITableView!
    @IBAction func currentSeason(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "current season", sender: self)
    }
    @IBOutlet weak var currentSeason: UIBarButtonItem!
    
    
    
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
    
    func set_db() {
        if passedData.year == 0 {
            leagues = Database_2020.shared.leagueNames
            roster = Database_2020.shared.roster_array()
        } else if passedData.year == 1 {
            leagues = Database_2021.shared.leagueNames
            teamNames = Database_2021.shared.teamNames
            roster = Database_2021.shared.roster_array()
        } else if passedData.year == 2 {
            leagues = Database_2022.shared.leagueNames
            teamNames = Database_2022.shared.teamNames
            roster = Database_2022.shared.roster_array()
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
            if passedData.year == 0 {
                Database_2020.shared.addToLeagues(league_name: leagueName)
            } else if passedData.year == 1 {
                Database_2021.shared.addToLeagues(league_name: leagueName, team_name: teamName)
            } else if passedData.year == 2 {
                Database_2022.shared.addToLeagues(league_name: leagueName, team_name: teamName)
            }
            let alert = UIAlertController(title: "Added League", message: "You added '\(leagueName)' to your leagues!", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (OkayAction) in
            self.myLeaguesSegue()
                if self.passedData.year == 0 {
                    Database_2020.shared.resetDraft()
                } else if self.passedData.year == 1 {
                    Database_2021.shared.resetDraft()
                } else if self.passedData.year == 2 {
                    Database_2022.shared.resetDraft()
                }
            }))
            self.present(alert, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var valueToPass = RowSelected()
        var strToPass = SegueString()
        if segue.identifier == "MyLeagues" {
            if let destVC = segue.destination as? MyLeagues {
                let str = "add league"
                strToPass.str = str
                valueToPass.year = passedData.year
                destVC.strPassed = strToPass
                destVC.passedData = valueToPass
            }
        }
    }
    
    override func viewDidLoad() {
        message.text = ""
        if passedData.year == 0 {
            txtTeamName.isHidden = true
        }
    }
}

class MyLeague: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var passedData = RowSelected()
    var leagueNames: [String]?
    var leagues: [[String]]?
    
    func set_db() {
        if passedData.year == 0 {
            leagueNames = Database_2020.shared.leagueNames
            leagues = Database_2020.shared.leagues
        } else if passedData.year == 1 {
            leagueNames = Database_2021.shared.leagueNames
            leagues = Database_2021.shared.leagues
        } else if passedData.year == 2 {
            leagueNames = Database_2022.shared.leagueNames
            leagues = Database_2022.shared.leagues
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
