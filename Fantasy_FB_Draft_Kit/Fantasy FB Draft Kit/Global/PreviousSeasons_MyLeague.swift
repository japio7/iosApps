//
//  MyLeagues.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 6/19/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import UIKit

class PreviousSeasons_MyLeague: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var passedData = RowSelected()
    var leagueName: String?
    var leaguePlayers: [String]?
    var year = 2020
    
    func set_db() {
        year = passedData.year!
        if year == 2020 {
            let database = Database_2020.shared
            leagueName = database.leagueNames[passedData.row!]
            leaguePlayers = database.leagues[passedData.row!]
        } else if year == 2021 {
            let database = Database_2021.shared
            leagueName = database.leagueNames[passedData.row!]
            leaguePlayers = database.leagues[passedData.row!]
        } else if year == 2022 {
            let database = Database_2022.shared
            leagueName = database.leagueNames[passedData.row!]
            leaguePlayers = database.leagues[passedData.row!]
        } else if year == 2023 {
            let database = Database_2023.shared
            leagueName = database.leagueNames[passedData.row!]
            leaguePlayers = database.leagues[passedData.row!]
        }
    }

    override func viewDidLoad() {
        set_db()
        league.text = leagueName
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leaguePlayers!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "league cell") as! Custom_Cell
        var array = [String.SubSequence]()
        array = leaguePlayers![indexPath.row].split(separator: ",")
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
