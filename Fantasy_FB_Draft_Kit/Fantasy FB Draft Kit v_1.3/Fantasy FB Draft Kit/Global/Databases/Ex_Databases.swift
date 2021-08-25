//
//  Ex_Databases.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 6/18/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import Foundation
import UIKit

extension Database_2020 {
    
    func roster_array() -> [String] {
        let roster = rosterArray()
        var newArray: [String] = []
        var index = 1
        for player in roster {
            newArray.append("\(index).  \(player.name), \(player.team) - \(player.position)   (\(player.byeWeek))")
            index+=1
        }
        return newArray
    }
    
    func addToLeagues(league_name: String) {
        leagueNames.insert(league_name, at: 0)
        leagues.insert(roster_array(), at: 0)
        changeMade()
    }
    
    func deleteLeague(index: IndexPath, _table: UITableView) {
        if leagues != [] {
            leagueNames.remove(at: index.row)
            leagues.remove(at: index.row)
            _table.reloadData()
        } else {
            return
        }
        changeMade()
    }
}
