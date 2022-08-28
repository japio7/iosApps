//
//  AddUnlistedPlayer.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 8/12/22.
//  Copyright © 2022 Jared Pino. All rights reserved.
//

import UIKit

class AddUnlistedPlayer: UIViewController {
    
    var passedData = RowSelected()
    var stringToPass = SegueString()
    
    var playerName = ""
    var teamName = ""
    var position = ""
    
    var team = ""
    var bye = 0
    var playerString = ""
    
    var btnToTeam_isEnabled = false
    var btnToDraft_isEnabled = false
    var isValid = false
    
    @IBOutlet weak var txtPlayerName: UITextField!
    @IBOutlet weak var txtTeamName: UITextField!
    @IBOutlet weak var txtPosition: UITextField!
    @IBOutlet weak var lblMessage: UILabel!
    
    func setPlayerData() {
        playerName = txtPlayerName.text!
        teamName = txtTeamName.text!
        position = txtPosition.text!
    }
    
    func playerData_isValid() -> Bool {
        if playerName != "" && Database_2022.shared.isValidTeam(tn: teamName.lowercased()) && Database_2022.shared.isValidPos(pos: position.lowercased()) {
            return true
        }
        return false
    }
    
    func setDefaults() {
        lblMessage.text = ""
        btnToTeam.backgroundColor = .clear
        btnToDraft.backgroundColor = .clear
        btnToTeam.borderColor = .blue
        btnToDraft.borderColor = .blue
        btnToTeam.borderWidth = 1
        btnToDraft.borderWidth = 1
        btnToTeam.titleLabel?.textColor = .blue
        btnToDraft.titleLabel?.textColor = .blue
        btnToTeam_isEnabled = false
        btnToDraft_isEnabled = false
    }
    
    @IBAction func btnToTeam(_ sender: BorderedButton) {
        setPlayerData()
        if playerName != "" && playerData_isValid() {
            btnToTeam_isEnabled = true
            btnToDraft_isEnabled = false
            btnToTeam.backgroundColor = .blue
            btnToTeam.setTitleColor(.white, for: .normal)
            btnToDraft.backgroundColor = .clear
            btnToDraft.titleLabel?.textColor = .blue
            btnToTeam.borderWidth = 1
            btnToTeam.borderColor = .blue
            team = Database_2022.shared.convertTeam(tn: teamName, label: lblMessage).0
            bye = Database_2022.shared.convertTeam(tn: teamName, label: lblMessage).1
            playerString = "\(playerName), \(team) - \(position.uppercased()) (\(bye))"
            lblMessage.text = playerString
            lblMessage.textColor = .green
        } else {
            btnToTeam.setTitleColor(.blue, for: .normal)
            btnToTeam.backgroundColor = .clear
            btnToDraft.setTitleColor(.blue, for: .normal)
            btnToDraft.backgroundColor = .clear
            btnToTeam_isEnabled = false
            btnToDraft_isEnabled = false
            lblMessage.text = "Not Valid!"
            lblMessage.textColor = .red
        }
    }
    
    @IBAction func btnToDraft(_ sender: BorderedButton) {
        setPlayerData()
        if playerName != "" && playerData_isValid() {
            btnToTeam_isEnabled = false
            btnToDraft_isEnabled = true
            btnToDraft.backgroundColor = .blue
            btnToDraft.setTitleColor(.white, for: .normal)
            btnToTeam.backgroundColor = .clear
            btnToTeam.titleLabel?.textColor = .blue
            btnToTeam.borderWidth = 1
            btnToTeam.borderColor = .blue
            btnToDraft.titleLabel?.textColor = .blue
            team = Database_2022.shared.convertTeam(tn: teamName, label: lblMessage).0
            bye = Database_2022.shared.convertTeam(tn: teamName, label: lblMessage).1
            playerString = "\(playerName), \(team) - \(position.uppercased()) (\(bye))"
            lblMessage.text = playerString
            lblMessage.textColor = .green
        } else {
            btnToTeam.setTitleColor(.blue, for: .normal)
            btnToTeam.backgroundColor = .clear
            btnToDraft.setTitleColor(.blue, for: .normal)
            btnToDraft.backgroundColor = .clear
            btnToTeam_isEnabled = false
            btnToDraft_isEnabled = false
            lblMessage.text = "Not Valid!"
            lblMessage.textColor = .red
        }
    }
    
    @IBOutlet weak var btnToTeam: BorderedButton!
    @IBOutlet weak var btnToDraft: BorderedButton!
    
    @IBAction func add(_ sender: UIButton) {
        if btnToTeam_isEnabled {
            let player_data = PlayerData(num: 0, numPosPick: 0, numRookie: 0, name: playerName, team: team.uppercased(), position: position.uppercased(), byeWeek: bye, isTopPlayer: false, isRookie: false)
            Database_2022.shared.allPlayersAppend(playerData: player_data)
            Database_2022.shared.addToRosterList(player: player_data)
            Database_2022.shared.addToDraftList(player: player_data)
            Database_2022.shared.changeMade()
            setDefaults()
            performSegue(withIdentifier: "my team", sender: self)
        } else if btnToDraft_isEnabled {
            let player_data = PlayerData(num: 0, numPosPick: 0, numRookie: 0, name: playerName, team: team.uppercased(), position: position.uppercased(), byeWeek: bye, isTopPlayer: false, isRookie: false)
            Database_2022.shared.allPlayersAppend(playerData: player_data)
            Database_2022.shared.addToDraftList(player: player_data)
            Database_2022.shared.changeMade()
            setDefaults()
            performSegue(withIdentifier: "draft order", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var valueToPass = SegueString().str
        var rowsToPass = RowSelected()
        if segue.identifier == "my team" {
            if let destVC = segue.destination as? MyTeam {
                let str = "my team"
                valueToPass = str
                rowsToPass.year = passedData.year
                rowsToPass.row = passedData.row
                rowsToPass.sec = passedData.sec
                destVC.stringPassedData.str = valueToPass
                destVC.passedData = rowsToPass
            }
        } else if segue.identifier == "draft order" {
            if let destVC = segue.destination as? DraftOrder {
                let str = "draft order"
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
        lblMessage.text = ""
    }
}
