//
//  TopPlayers.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 6/19/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import UIKit

class TopPlayers: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var passedData = RowSelected()
    
    var objectsArray = [PlayerData]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if passedData.year == currentYear {
            if passedData.sec == 0 && passedData.row == 0 {
                return currentDatabase.playerList(topPlayer: true).count
            } else if passedData.sec == 0 && passedData.row == 1 {
                return currentDatabase.playerList(rookie: true, num: 30).count
            } else if passedData.sec == 1 && passedData.row == 0 {
                return currentDatabase.playerList(position: "QB", num: 30).count
            } else if passedData.sec == 1 && passedData.row == 1 {
                return currentDatabase.playerList(position: "RB", num: 80).count
            } else if passedData.sec == 1 && passedData.row == 2 {
                return currentDatabase.playerList(position: "WR", num: 80).count
            } else if passedData.sec == 1 && passedData.row == 3 {
                return currentDatabase.playerList(position: "TE", num: 30).count
            } else if passedData.sec == 1 && passedData.row == 4 {
                return currentDatabase.playerList(position: "DST", num: 20).count
            } else if passedData.sec == 1 && passedData.row == 5 {
                return currentDatabase.playerList(position: "K", num: 15).count
            }
        }
        return 0
    }
    
    @IBOutlet weak var lblPlayers: UILabel!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if currentDatabase.draftList().count == 0 {
            currentDatabase.resetDraft()
        }
        if passedData.year == currentYear {
            currentDatabase.getTop(yyyy: currentYear, passed: passedData, label: label)
            objectsArray = currentDatabase.playerData
        }
        if passedData.sec == 0 && passedData.row == 1 {
            objectsArray = objectsArray.sorted(by: { $0.numRookie < $1.numRookie})
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let player = objectsArray[indexPath.row]
        var str = ""
        if passedData.sec == 0 && passedData.row == 0 {
            str = "\(player.num).  \(player.name),  \(player.team) - \(player.position) (\(player.byeWeek))"
        }
        else if passedData.sec == 0 && passedData.row == 1 {
            str = "\(player.numRookie).  \(player.name),  \(player.team) - \(player.position) (\(player.byeWeek))"
        }
        else if passedData.sec == 1 && passedData.row == 4 {
            str = "\(player.numPosPick).  \(player.name) - \(player.position) (\(player.byeWeek))"
        } else {
            str = "\(player.numPosPick).  \(player.name),  \(player.team) - \(player.position) (\(player.byeWeek))"
        }
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
        if !player.isRostered && !player.isDrafted {
                cell.textLabel?.attributedText = noStrikeThroughText(str)
                cell.accessoryType = UITableViewCell.AccessoryType.none
                cell.backgroundColor = .none
            }
            else if player.isRostered && player.isDrafted {
                cell.textLabel?.attributedText = strikeThroughText(str)
                cell.accessoryType = UITableViewCell.AccessoryType.checkmark
                cell.backgroundColor = .systemGray3
            } else {
                cell.textLabel?.attributedText = strikeThroughText(str)
                cell.accessoryType = UITableViewCell.AccessoryType.none
                cell.backgroundColor = .systemGray2
            } 
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let player = objectsArray[indexPath.row]
        let playerName = objectsArray[indexPath.row].name

        if !player.isRostered && !player.isDrafted {
            let add = UIContextualAction(style: .normal, title: "Add") { (contextualAction, view, actionPerformed: @escaping (Bool) -> Void) in
                let alert = UIAlertController(title: "Add Player", message: "Are you sure you want to add '\(playerName)' to your roster?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (alertAction) in
                    actionPerformed(false)
                }))
                alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (alertAction) in
                    self.addPlayer(index: indexPath)
                    let okayAlert = UIAlertController(title: "Player Added!", message: "You added '\(playerName)' to your roster!", preferredStyle: .alert)
                    okayAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alertAction) in
                        actionPerformed(true)
                    }))
                    self.present(okayAlert, animated: true)
                }))
                self.present(alert, animated: true)
            }
            add.backgroundColor = .systemGreen
            let taken = UIContextualAction(style: .normal, title: "Taken") { (contextualAction, view, actionPerformed: @escaping (Bool) -> Void) in
                let alert = UIAlertController(title: "Mark As Taken", message: "Are you sure you want to mark '\(playerName)' as taken and not available?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (alertAction) in
                    actionPerformed(false)
                }))
                alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (alertAction) in
                    self.markAsTaken(index: indexPath)
                    let okayAlert = UIAlertController(title: "Player Taken!", message: "You marked '\(playerName)' as taken and not available!", preferredStyle: .alert)
                    okayAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alertAction) in
                        actionPerformed(true)
                    }))
                    self.present(okayAlert, animated: true)
                }))
                self.present(alert, animated: true)
            }
            taken.backgroundColor = .systemRed
            let config = UISwipeActionsConfiguration(actions: [taken, add])
            config.performsFirstActionWithFullSwipe = false
            return config
        }
            let undo = UIContextualAction(style: .normal, title: "Undo") { (contextualAction, view, actionPerformed: @escaping (Bool) -> Void) in
                let alert = UIAlertController(title: "Undo", message: "Are you sure you want to undo the action for '\(playerName)'?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (alertAction) in
                    actionPerformed(false)
                }))
                alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (alertAction) in
                    self.removePlayer(index: indexPath)
                    let okayAlert = UIAlertController(title: "Action Undone!", message: "The previous action for '\(playerName)' has been undone!", preferredStyle: .alert)
                    okayAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (alertAction) in
                        actionPerformed(true)
                    }))
                    self.present(okayAlert, animated: true)
                }))
                self.present(alert, animated: true)
            }
            undo.backgroundColor = .systemBlue
            let config = UISwipeActionsConfiguration(actions: [undo])
            config.performsFirstActionWithFullSwipe = false
            return config
    }
    
    func addPlayer(index: IndexPath) {
        let player = objectsArray[index.row]
        if passedData.year == currentYear {
            currentDatabase.addToRosterList(player: player)
            currentDatabase.addToDraftList(player: player)
            currentDatabase.changeMade()
        }
        table.beginUpdates()
        table.reloadRows(at: [index], with: .automatic)
        table.endUpdates()
    }
    
    func markAsTaken(index: IndexPath) {
        let player = objectsArray[index.row]
        if passedData.year == currentYear {
            currentDatabase.addToDraftList(player: player)
            currentDatabase.changeMade()
        }
        table.beginUpdates()
        table.reloadRows(at: [index], with: .automatic)
        table.endUpdates()
    }
    
    func removePlayer(index: IndexPath) {
        let player = objectsArray[index.row]
        let team = Array(arrayLiteral: player.isRostered)
        let draft = Array(arrayLiteral: player.isDrafted)
        var playerOnTeam = false
        for d_player in draft {
            for t_player in team {
                if d_player == t_player {
                    playerOnTeam = true
                }
            }
        }
        if passedData.year == currentYear {
            if playerOnTeam == true {
                currentDatabase.removeFrom_RosterList(player: player)
                currentDatabase.removeFrom_DraftList(player: player)
            } else {
                currentDatabase.removeFrom_DraftList(player: player)
            }
            currentDatabase.changeMade()
        }
        table.beginUpdates()
        table.reloadRows(at: [index], with: .automatic)
        table.endUpdates()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var yearToPass = RowSelected().year
        if segue.identifier == "add unlisted player" {
            if let destVC = segue.destination as? AddUnlistedPlayer {
                yearToPass = passedData.year
                destVC.passedData.year = yearToPass
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if passedData.year == currentYear {
            currentDatabase.getTop(yyyy: currentYear, passed: passedData, label: label)
            objectsArray = currentDatabase.playerData
        }
        if passedData.sec == 0 && passedData.row == 1 {
            objectsArray = objectsArray.sorted(by: { $0.numRookie < $1.numRookie})
        }
    }
    
    @IBOutlet weak var label: UILabel!
    
    @IBAction func addUnlistedPlayer(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "add unlisted player", sender: UIAlertAction.self)
    }
    @IBOutlet weak var table: UITableView!
}
