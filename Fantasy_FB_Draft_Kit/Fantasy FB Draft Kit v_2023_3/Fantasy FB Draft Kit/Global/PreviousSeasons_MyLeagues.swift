//
//  MyLeagues_2023.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 6/19/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import UIKit

class PreviousSeasons_MyLeagues: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var passedData = RowSelected()
    
    var leagues: [String]?
    var teamNames: [String]?
    var selectedRow = 0
    let years = [2020, 2021, 2022]
    
    func set_db() {
        if passedData.year == years[0] {
            leagues = Database_2020.shared.leagueNames
        } else if passedData.year == years[1] {
            leagues = Database_2021.shared.leagueNames
            teamNames = Database_2021.shared.teamNames
        } else if passedData.year == years[2] {
            leagues = Database_2022.shared.leagueNames
            teamNames = Database_2022.shared.teamNames
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        set_db()
    }
        
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.selectRow(at: indexPath, animated: true, scrollPosition: .none)
        selectedRow = indexPath.row
        performSegue(withIdentifier: "myLeague", sender: self)
        table.deselectRow(at: indexPath, animated: true)
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if leagues!.count == 0 {
            tableView.setEmptyView(message: "You Currently Do Not Have Any Leagues!")
            lblMyLeagues.isHidden = true
        } else {
            tableView.restore()
        }
        return leagues!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if passedData.year != years[0] {
            let cell = table.dequeueReusableCell(withIdentifier: "leagues cell") as! LeaguesCustomCell
            cell.teamName.text = teamNames![indexPath.row]
            cell.num.text = "\(indexPath.row+1)."
            cell.leagueName.text = leagues![indexPath.row]
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
            return cell
        } else {
            let cell = table.dequeueReusableCell(withIdentifier: "leagues cell 2020") as! LeaguesCustomCell
            cell.num.text = "\(indexPath.row+1)."
            cell.leagueName.text = leagues![indexPath.row]
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let league = leagues![indexPath.row]
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (contextualAction, view, actionPerformed: @escaping (Bool) -> Void) in
            let alert = UIAlertController(title: "Delete League", message: "Are you sure you want to delete '\(league)'?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (alertAction) in
                if self.passedData.year == self.years[0] {
                    Database_2020.shared.deleteLeague(index: indexPath, _table: self.table)
                } else if self.passedData.year == self.years[1] {
                    Database_2021.shared.deleteLeague(index: indexPath, _table: self.table)
                } else if self.passedData.year == self.years[2] {
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
        if segue.identifier == "myLeague" {
            if let destVC = segue.destination as? PreviousSeasons_MyLeague {
                let row_selected = selectedRow
                valueToPass.year = passedData.year
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


