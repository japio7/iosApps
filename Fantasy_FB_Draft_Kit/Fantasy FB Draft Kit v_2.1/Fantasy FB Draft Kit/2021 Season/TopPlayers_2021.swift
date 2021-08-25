//
//  TopPlayers_2021.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 9/7/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import UIKit

class TopPlayers_2021: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var passedData = RowSelected()
    
    var objectsArray = [PlayerData]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if passedData.sec == 0 && passedData.row == 0 {
            return Database_2021.shared.playerList(topPlayer: true).count
        }
        if passedData.sec == 0 && passedData.row == 1 {
            return Database_2021.shared.playerList(rookie: true).count
        }
        if passedData.sec == 1 && passedData.row == 0 {
            return Database_2021.shared.playerList(position: "QB").count-2
        }
        if passedData.sec == 1 && passedData.row == 1 {
            return Database_2021.shared.playerList(position: "RB").count
        }
        if passedData.sec == 1 && passedData.row == 2 {
            return Database_2021.shared.playerList(position: "WR").count-8
        }
        if passedData.sec == 1 && passedData.row == 3 {
            return Database_2021.shared.playerList(position: "TE").count-1
        }
        if passedData.sec == 1 && passedData.row == 4 {
            return Database_2021.shared.playerList(position: "DST").count
        }
        if passedData.sec == 1 && passedData.row == 5 {
            return Database_2021.shared.playerList(position: "K").count
        }
        return 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if passedData.sec == 0 && passedData.row == 0 {
            objectsArray = Database_2021.shared.playerList(topPlayer: true)
            label.text = "Overall Top 200"
        }
        if passedData.sec == 0 && passedData.row == 1 {
            objectsArray = Database_2021.shared.playerList(rookie: true)
            label.text = "Top 30 Rookies"
        }
        if passedData.sec == 1 && passedData.row == 0 {
            objectsArray = Database_2021.shared.playerList(position: "QB")
            label.text = "Top 30 Quarterbacks"
        }
        if passedData.sec == 1 && passedData.row == 1 {
            objectsArray = Database_2021.shared.playerList(position: "RB")
            label.text = "Top 80 Running Backs"
        }
        if passedData.sec == 1 && passedData.row == 2 {
            objectsArray = Database_2021.shared.playerList(position: "WR")
            label.text = "Top 80 Wide Receivers"
        }
        if passedData.sec == 1 && passedData.row == 3 {
            objectsArray = Database_2021.shared.playerList(position: "TE")
            label.text = "Top 30 Tight Ends"
        }
        if passedData.sec == 1 && passedData.row == 4 {
            objectsArray = Database_2021.shared.playerList(position: "DST")
            label.text = "Top 20 Defenses"
        }
        if passedData.sec == 1 && passedData.row == 5 {
            objectsArray = Database_2021.shared.playerList(position: "K")
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let player = objectsArray[indexPath.row]
        var str = ""
        if passedData.sec == 1 && passedData.row == 4 {
            str = "\(indexPath.row+1).  \(player.name) - \(player.position) (\(player.byeWeek))"
        } else {
            str = "\(indexPath.row+1).  \(player.name),  \(player.team) - \(player.position) (\(player.byeWeek))"
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
        Database_2021.shared.addToRosterList(player: player)
        Database_2021.shared.addToDraftList(player: player)
        table.beginUpdates()
        table.reloadRows(at: [index], with: .automatic)
        table.endUpdates()
        Database_2021.shared.changeMade()
    }
    
    func markAsTaken(index: IndexPath) {
        let player = objectsArray[index.row]
        Database_2021.shared.addToDraftList(player: player)
        table.beginUpdates()
        table.reloadRows(at: [index], with: .automatic)
        table.endUpdates()
        Database_2021.shared.changeMade()
    }
    
    func removePlayer(index: IndexPath) {
        let player = objectsArray[index.row]
        Database_2021.shared.removeFromLists(player: player)
        table.beginUpdates()
        table.reloadRows(at: [index], with: .automatic)
        table.endUpdates()
        Database_2021.shared.changeMade()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var table: UITableView!
    
}
