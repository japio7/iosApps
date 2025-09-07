//
//  Database_2020.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 6/18/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import Foundation
import UIKit

class Database_2020 {
    
    static let shared = Database_2020()
    
    var leagueNames: [String]
    var leagues: [[String]]
    
    var playerData = [PlayerData]()
    
    var objectsArray: [[String]] = [["Overall Top 200", "Top 30 Rookies"], ["Top 30 Quarterbacks", "Top 80 Running Backs", "Top 80 Wide Receivers", "Top 30 Tight Ends", "Top 20 Defenses", "Top 15 Kickers"], ["Depth Charts"], ["My Leagues"], ["Reset Draft"]
    ]
    
    func getRankings() -> [String] {
        var rankings = [String]()
        for player in playerList(topPlayer: true) {
            rankings.append("\(player.num).  \(player.name),  \(player.team) - \(player.position) (\(player.byeWeek))")
        }
        return rankings
    }
    
    func getTop(yyyy: Int, passed: RowSelected, label: UILabel) {
        if passed.year == yyyy {
            if passed.sec == 0 && passed.row == 0 {
                playerData = playerList(topPlayer: true)
                label.text = "Overall Top 200"
            } else if passed.sec == 0 && passed.row == 1 {
                playerData = playerList(rookie: true)
                label.text = "Top 30 Rookies"
            } else if passed.sec == 1 && passed.row == 0 {
                playerData = playerList(position: "QB", num: 30)
                label.text = "Top 30 Quarterbacks"
            } else if passed.sec == 1 && passed.row == 1 {
                playerData = playerList(position: "RB", num: 80)
                label.text = "Top 80 Running Backs"
            } else if passed.sec == 1 && passed.row == 2 {
                playerData = playerList(position: "WR", num: 80)
                label.text = "Top 80 Wide Receivers"
            } else if passed.sec == 1 && passed.row == 3 {
                playerData = playerList(position: "TE", num: 30)
                label.text = "Top 30 Tight Ends"
            } else if passed.sec == 1 && passed.row == 4 {
                playerData = playerList(position: "DST", num: 20)
                label.text = "Top 20 Defenses"
            } else if passed.sec == 1 && passed.row == 5 {
                playerData = playerList(position: "K", num: 15)
                label.text = "Top 15 Kickers"
            }
        }
    }
    
    // All players and leagues 2020
    fileprivate var allPlayers: [PlayerData]
    
    // All Players Save, Write and Read
    fileprivate func playerDataURL() -> URL {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in:.userDomainMask).last!
        return documentDirectoryURL.appendingPathComponent("playerData_2020.json")
    }
    
    fileprivate func playersWriteToDisk() {
        do {
            let data = try JSONEncoder().encode(allPlayers)
            try data.write(to: playerDataURL())
        } catch let error as NSError {
            NSLog("Error reading file: \(error.localizedDescription)")
        }
    }
    
    fileprivate func playersReadFromDisk() -> [PlayerData]? {
        let filePlayerURL = playerDataURL()
        guard FileManager.default.fileExists(atPath: filePlayerURL.path) else {
            return nil
        }
        do {
            let fileContents = try Data(contentsOf: filePlayerURL)
            let list = try JSONDecoder().decode([PlayerData].self, from: fileContents)
            return list
        } catch let error as NSError {
            NSLog("Error reading file: \(error.localizedDescription)")
        }
        return nil
    }
    
    // Added League Names Save, Write, and Read
    fileprivate func leagueNamesDataURL() -> URL {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in:.userDomainMask).last!
        return documentDirectoryURL.appendingPathComponent("leagueNamesData_2020.json")
    }
    
    fileprivate func leagueNamesWriteToDisk() {
        do {
            let dataNames = try JSONEncoder().encode(leagueNames)
            try dataNames.write(to: leagueNamesDataURL())
        } catch let error as NSError {
            NSLog("Error reading file: \(error.localizedDescription)")
        }
    }
    
    fileprivate func leagueNamesReadFromDisk() -> [String]? {
        let fileLeagueNamesURL = leagueNamesDataURL()
        guard FileManager.default.fileExists(atPath: fileLeagueNamesURL.path) else {
            return nil
        }
        do {
            let fileContents = try Data(contentsOf: fileLeagueNamesURL)
            let list = try JSONDecoder().decode([String].self, from: fileContents)
            return list
        } catch let error as NSError {
            NSLog("Error reading file: \(error.localizedDescription)")
        }
        return nil
    }
    
    // Added League Data Players Save, Write, and Read
    fileprivate func leaguesDataURL() -> URL {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in:.userDomainMask).last!
        return documentDirectoryURL.appendingPathComponent("leaguesData_2020.json")
    }

    fileprivate func leaguesDataWriteToDisk() {
        do {
            let dataLeagues = try JSONEncoder().encode(leagues)
            try dataLeagues.write(to: leaguesDataURL())
        } catch let error as NSError {
            NSLog("Error reading file: \(error.localizedDescription)")
        }
    }
    
    fileprivate func leaguesDataReadFromDisk() -> [[String]]? {
        let fileLeaguesDataURL = leaguesDataURL()
        guard FileManager.default.fileExists(atPath: fileLeaguesDataURL.path) else {
            return nil
        }
        do {
            let fileContents = try Data(contentsOf: fileLeaguesDataURL)
            let list = try JSONDecoder().decode([[String]].self, from: fileContents)
            return list
        } catch let error as NSError {
            NSLog("Error reading file: \(error.localizedDescription)")
        }
        return nil
    }
    
    // Player lists
    func playerList(position: String, num: Int) -> [PlayerData] {
        return allPlayers.filter({$0.position == position}).filter({$0.numPosPick <= num}).filter({$0.numPosPick != 0})
    }
    
    func playerList(topPlayer: Bool) -> [PlayerData] {
        return allPlayers.filter({ $0.isTopPlayer == topPlayer })
    }
    
    func playerList(rookie: Bool) -> [PlayerData] {
        return allPlayers.filter({ $0.isRookie == rookie })
    }
    
    // Roster lists/My team lists
    func rosterList() -> [PlayerData] {
        let rosteredPlayers = allPlayers.filter { ($0.rosterPosition >= 0)}
        return rosteredPlayers.sorted(by: { $0.rosterPosition < $1.rosterPosition })
    }
    
    func rosterArray() -> [PlayerData] {
        let roster = rosterList()
        return roster
    }
    
    func addToRosterList(player: PlayerData) {
        let maxRosteredIndex = allPlayers.map({ $0.rosterPosition }).max()!
        player.rosterPosition = maxRosteredIndex + 1
    }
    
    fileprivate func removeFromRosterList(player: PlayerData) {
        let currentRosterPosition = player.rosterPosition
        player.rosterPosition = -1 // No longer on the rosterList. Gets all players on roster at a higher index.
        let higherNumberedRosterPlayers = allPlayers.filter({ $0.rosterPosition > currentRosterPosition}) // Their rosterPositions have now gone down by one.
        
        for otherPlayer in higherNumberedRosterPlayers {
            otherPlayer.rosterPosition -= 1 // Decrease position by 1.
        }
    }
    
    // draft List
    func draftList() -> [PlayerData] {
        let draftedPlayers = allPlayers.filter({ $0.draftPosition >= 0 })
        return draftedPlayers.sorted(by: { $0.draftPosition < $1.draftPosition })
    }
    
    func addToDraftList(player: PlayerData) {
        let maxDraftedIndex = allPlayers.map({ $0.draftPosition }).max()!
        player.draftPosition = maxDraftedIndex + 1
    }
    
    fileprivate func removeFromDraftList(player: PlayerData) {
        let currentDraftPosition = player.draftPosition
        player.draftPosition = -1 // No longer on the rosterList. Gets all players on roster at a higher index.
        let higherNumberedRosterPlayers = allPlayers.filter({ $0.draftPosition > currentDraftPosition}) // Their rosterPositions have now gone down by one.
                
        for otherPlayer in higherNumberedRosterPlayers {
            otherPlayer.draftPosition-=1 // Decrease position by 1.
        }
    }
    
    func removeFrom_RosterList(player: PlayerData) {
        removeFromRosterList(player: player)
    }
    
    func removeFrom_DraftList(player: PlayerData) {
        removeFromDraftList(player: player)
    }
    
    func removeFromLists(player: PlayerData) {
        removeFromRosterList(player: player)
        removeFromDraftList(player: player)
    }
    
    // Executed when a change is made
    func changeMade() {
        playersWriteToDisk()
        leagueNamesWriteToDisk()
        leaguesDataWriteToDisk()
    }
    
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
    
    // Reset the draft
    func resetDraft() {
        
        allPlayers = [
            PlayerData(num: 1, numPosPick: 1, numRookie: 0, name: "Christian McCaffrey", team: "CAR", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 2, numPosPick: 2, numRookie: 0, name: "Saquon Barkley", team: "NYG", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 3, numPosPick: 3, numRookie: 0, name: "Ezekiel Elliott", team: "DAL", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 4, numPosPick: 4, numRookie: 0, name: "Alvin Kamara", team: "NO", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 5, numPosPick: 1, numRookie: 0, name: "Michael Thomas", team: "NO", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 6, numPosPick: 5, numRookie: 0, name: "Dalvin Cook", team: "MIN", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 7, numPosPick: 2, numRookie: 0, name: "Davante Adams", team: "GB", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 8, numPosPick: 3, numRookie: 0, name: "Julio Jones", team: "ATL", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 9, numPosPick: 6, numRookie: 0, name: "Derrick Henry", team: "TEN", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 10, numPosPick: 7, numRookie: 1, name: "Clyde Edwards-Helaire", team: "KC", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: true),
            PlayerData(num: 11, numPosPick: 4, numRookie: 0, name: "Tyreek Hill", team: "KC", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 12, numPosPick: 8, numRookie: 0, name: "Miles Sanders", team: "PHI", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 13, numPosPick: 9, numRookie: 0, name: "Kenyan Drake", team: "ARI", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 14, numPosPick: 10, numRookie: 0, name: "Joe Mixon", team: "CIN", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 15, numPosPick: 5, numRookie: 0, name: "DeAndre Hopkins", team: "ARI", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 16, numPosPick: 11, numRookie: 0, name: "Austin Ekeler", team: "LAC", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 17, numPosPick: 6, numRookie: 0, name: "Chris Godwin", team: "TB", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 18, numPosPick: 1, numRookie: 0, name: "Travis Kelce", team: "KC", position: "TE", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 19, numPosPick: 2, numRookie: 0, name: "George Kittle", team: "SF", position: "TE", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 20, numPosPick: 7, numRookie: 0, name: "Allen Robinson II", team: "CHI", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 21, numPosPick: 12, numRookie: 0, name: "Josh Jacobs", team: "LV", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 22, numPosPick: 13, numRookie: 0, name: "Aaron Jones", team: "GB", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 23, numPosPick: 8, numRookie: 0, name: "Kenny Golladay", team: "DET", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 24, numPosPick: 14, numRookie: 0, name: "Nick Chubb", team: "CLE", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 25, numPosPick: 1, numRookie: 0, name: "Patrick Mahomes", team: "KC", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 26, numPosPick: 9, numRookie: 0, name: "DJ Moore", team: "CAR", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 27, numPosPick: 10, numRookie: 0, name: "JuJu Smith-Schuster", team: "PIT", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 28, numPosPick: 11, numRookie: 0, name: "Mike Evans", team: "TB", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 29, numPosPick: 12, numRookie: 0, name: "Adam Thielen", team: "MIN", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 30, numPosPick: 2, numRookie: 0, name: "Lamar Jackson", team: "BAL", position: "QB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 31, numPosPick: 13, numRookie: 0, name: "Amari Cooper", team: "DAL", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 32, numPosPick: 14, numRookie: 0, name: "Odell Beckham Jr.", team: "CLE", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 33, numPosPick: 15, numRookie: 0, name: "Robert Woods", team: "LAR", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 34, numPosPick: 3, numRookie: 0, name: "Mark Andrews", team: "BAL", position: "TE", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 35, numPosPick: 16, numRookie: 0, name: "Cooper Kupp", team: "LAR", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 36, numPosPick: 17, numRookie: 0, name: "Calvin Ridley", team: "ATL", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 37, numPosPick: 15, numRookie: 0, name: "Leonard Fournette", team: "JAC", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 38, numPosPick: 16, numRookie: 0, name: "Todd Gurley II", team: "ATL", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 39, numPosPick: 17, numRookie: 0, name: "Chris Carson", team: "SEA", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 40, numPosPick: 4, numRookie: 0, name: "Zach Ertz", team: "PHI", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 41, numPosPick: 18, numRookie: 0, name: "A.J. Brown", team: "TEN", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 42, numPosPick: 18, numRookie: 0, name: "James Connor", team: "PIT", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 43, numPosPick: 19, numRookie: 0, name: "Le'Veon Bell", team: "NYJ", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 44, numPosPick: 19, numRookie: 0, name: "DJ Chark Jr.", team: "JAC", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 45, numPosPick: 20, numRookie: 0, name: "Melvin Gordon", team: "DEN", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 46, numPosPick: 20, numRookie: 0, name: "Tyler Lockett", team: "SEA", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 47, numPosPick: 21, numRookie: 0, name: "Terry McLaurin", team: "WAS", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 48, numPosPick: 22, numRookie: 0, name: "Keenan Allen", team: "LAC", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 49, numPosPick: 21, numRookie: 0, name: "David Johnson", team: "HOU", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 50, numPosPick: 23, numRookie: 0, name: "Courtland Sutton", team: "DEN", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 51, numPosPick: 22, numRookie: 2, name: "Jonathan Taylor", team: "IND", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: true),
            PlayerData(num: 52, numPosPick: 24, numRookie: 0, name: "DK Metcalf", team: "SEA", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 53, numPosPick: 25, numRookie: 0, name: "DeVante Parker", team: "MIA", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 54, numPosPick: 3, numRookie: 0, name: "Dak Prescott", team: "DAL", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 55, numPosPick: 26, numRookie: 0, name: "T.Y. Hilton", team: "IND", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 56, numPosPick: 5, numRookie: 0, name: "Darren Waller", team: "LV", position: "TE", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 57, numPosPick: 23, numRookie: 0, name: "Mark Ingram II", team: "BAL", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 58, numPosPick: 4, numRookie: 0, name: "Russell Wilson", team: "SEA", position: "QB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 59, numPosPick: 5, numRookie: 0, name: "Kyler Murray", team: "ARI", position: "QB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 60, numPosPick: 27, numRookie: 0, name: "Stefon Diggs", team: "BUF", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 61, numPosPick: 24, numRookie: 0, name: "David Montgomery", team: "CHI", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 62, numPosPick: 25, numRookie: 0, name: "Kareem Hunt", team: "CLE", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 63, numPosPick: 6, numRookie: 0, name: "Deshaun Watson", team: "HOU", position: "QB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 64, numPosPick: 28, numRookie: 0, name: "Tyler Boyd", team: "CIN", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 65, numPosPick: 29, numRookie: 0, name: "Jarvis Landry", team: "CLE", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 66, numPosPick: 26, numRookie: 0, name: "Devin Singletary", team: "BUF", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 67, numPosPick: 30, numRookie: 0, name: "A.J. Green", team: "CIN", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 68, numPosPick: 31, numRookie: 0, name: "Michael Gallup", team: "DAL", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 69, numPosPick: 27, numRookie: 3, name: "D'Andre Swift", team: "DET", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: true),
            PlayerData(num: 70, numPosPick: 32, numRookie: 0, name: "Julian Edelman", team: "NE", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 71, numPosPick: 33, numRookie: 0, name: "Marquise Brown", team: "BAL", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 72, numPosPick: 28, numRookie: 0, name: "Raheem Mostert", team: "SF", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 73, numPosPick: 6, numRookie: 0, name: "Evan Engram", team: "NYG", position: "TE", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 74, numPosPick: 29, numRookie: 4, name: "Cam Akers", team: "LAR", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: true),
            PlayerData(num: 75, numPosPick: 30, numRookie: 0, name: "James White", team: "NE", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 76, numPosPick: 7, numRookie: 0, name: "Josh Allen", team: "BUF", position: "QB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 77, numPosPick: 34, numRookie: 0, name: "Marvin Jones Jr.", team: "DET", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 78, numPosPick: 7, numRookie: 0, name: "Tyler Higbee", team: "LAR", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 79, numPosPick: 8, numRookie: 0, name: "Matt Ryan", team: "ATL", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 80, numPosPick: 8, numRookie: 0, name: "Hunter Henry", team: "LAC", position: "TE", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 81, numPosPick: 35, numRookie: 0, name: "Will Fuller", team: "HOU", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 82, numPosPick: 36, numRookie: 0, name: "Brandin Cooks", team: "HOU", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 83, numPosPick: 31, numRookie: 0, name: "Ronald Jones II", team: "TB", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 84, numPosPick: 32, numRookie: 0, name: "Tarik Cohen", team: "CHI", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 85, numPosPick: 37, numRookie: 0, name: "Diontae Johnson", team: "PIT", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 86, numPosPick: 9, numRookie: 0, name: "Carson Wentz", team: "PHI", position: "QB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 87, numPosPick: 10, numRookie: 0, name: "Drew Brees", team: "NO", position: "QB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 88, numPosPick: 38, numRookie: 0, name: "Jamison Crowder", team: "NYJ", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 89, numPosPick: 39, numRookie: 0, name: "Christian Kirk", team: "ARI", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 90, numPosPick: 11, numRookie: 0, name: "Tom Brady", team: "TB", position: "QB", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 91, numPosPick: 33, numRookie: 0, name: "Jordan Howard", team: "MIA", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 92, numPosPick: 34, numRookie: 0, name: "Matt Breida", team: "MIA", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 93, numPosPick: 40, numRookie: 0, name: "Sterling Shepard", team: "NYG", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 94, numPosPick: 12, numRookie: 0, name: "Matthew Stafford", team: "DET", position: "QB", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 95, numPosPick: 9, numRookie: 0, name: "Hayden Hurst", team: "ATL", position: "TE", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 96, numPosPick: 35, numRookie: 0, name: "Phillip Lindsay", team: "DEN", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 97, numPosPick: 36, numRookie: 5, name: "J.K. Dobbins", team: "BAL", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: true),
            PlayerData(num: 98, numPosPick: 41, numRookie: 0, name: "John Brown", team: "BUF", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 99, numPosPick: 13, numRookie: 0, name: "Aaron Rodgers", team: "GB", position: "QB", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 100, numPosPick: 10, numRookie: 0, name: "Mike Gesicki", team: "MIA", position: "TE", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 101, numPosPick: 42, numRookie: 0, name: "Anthony Miller", team: "CHI", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 102, numPosPick: 11, numRookie: 0, name: "Austin Hooper", team: "CLE", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 103, numPosPick: 43, numRookie: 0, name: "Darius Slayton", team: "NYG", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 104, numPosPick: 37, numRookie: 0, name: "Tevin Coleman", team: "SF", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 105, numPosPick: 38, numRookie: 0, name: "Kerryon Johnson", team: "DET", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 106, numPosPick: 12, numRookie: 0, name: "Jared Cook", team: "NO", position: "TE", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 107, numPosPick: 44, numRookie: 6, name: "CeeDee Lamb", team: "DAL", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: true),
            PlayerData(num: 108, numPosPick: 45, numRookie: 0, name: "Mike Williams", team: "LAC", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 109, numPosPick: 46, numRookie: 0, name: "Deebo Samuel", team: "SF", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 110, numPosPick: 47, numRookie: 0, name: "Emmanuel Sanders", team: "NO", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 111, numPosPick: 13, numRookie: 0, name: "Rob Gronkowski", team: "TB", position: "TE", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 112, numPosPick: 39, numRookie: 0, name: "Latavius Murray", team: "NO", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 113, numPosPick: 14, numRookie: 0, name: "Daniel Jones", team: "NYG", position: "QB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 114, numPosPick: 40, numRookie: 0, name: "Marlon Mack", team: "IND", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 115, numPosPick: 15, numRookie: 0, name: "Ben Roethlisberger", team: "PIT", position: "QB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 116, numPosPick: 48, numRookie: 0, name: "Golden Tate", team: "NYG", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 117, numPosPick: 41, numRookie: 0, name: "Duke Johnson", team: "HOU", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 118, numPosPick: 14, numRookie: 0, name: "T.J. Hockenson", team: "DET", position: "TE", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 119, numPosPick: 16, numRookie: 0, name: "Jared Goff", team: "LAR", position: "QB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 120, numPosPick: 49, numRookie: 0, name: "Preston Williams", team: "MIA", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 121, numPosPick: 42, numRookie: 0, name: "Darrell Henderson Jr.", team: "LAR", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 122, numPosPick: 50, numRookie: 7, name: "Jalen Reagor", team: "PHI", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: true),
            PlayerData(num: 123, numPosPick: 15, numRookie: 0, name: "Noah Fant", team: "DEN", position: "TE", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 124, numPosPick: 17, numRookie: 0, name: "Cam Newton", team: "NE", position: "QB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 125, numPosPick: 43, numRookie: 8, name: "Zack Moss", team: "BUF", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: true),
            PlayerData(num: 126, numPosPick: 44, numRookie: 0, name: "Sony Michel", team: "NE", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 127, numPosPick: 16, numRookie: 0, name: "Jonnu Smith", team: "TEN", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 128, numPosPick: 18, numRookie: 0, name: "Ryan Tannehill", team: "TEN", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 129, numPosPick: 48, numRookie: 9, name: "Jerry Jeudy", team: "DEN", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: true),
            PlayerData(num: 130, numPosPick: 19, numRookie: 0, name: "Baker Mayfield", team: "CLE", position: "QB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 131, numPosPick: 17, numRookie: 0, name: "Dallas Goedert", team: "PHI", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 132, numPosPick: 45, numRookie: 0, name: "Alexander Mattison", team: "MIN", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 133, numPosPick: 46, numRookie: 10, name: "Ke'Shawn Vaughn", team: "TB", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: true),
            PlayerData(num: 134, numPosPick: 52, numRookie: 11, name: "Justin Jefferson", team: "MIN", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: true),
            PlayerData(num: 135, numPosPick: 18, numRookie: 0, name: "Jack Doyle", team: "IND", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 136, numPosPick: 47, numRookie: 0, name: "Adrian Peterson", team: "WAS", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 137, numPosPick: 53, numRookie: 12, name: "Henry Ruggs III", team: "LV", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: true),
            PlayerData(num: 138, numPosPick: 48, numRookie: 0, name: "Nyheim Hines", team: "IND", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 139, numPosPick: 49, numRookie: 0, name: "Tony Pollard", team: "DAL", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 140, numPosPick: 50, numRookie: 13, name: "Antonio Gibson", team: "WAS", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: true),
            PlayerData(num: 141, numPosPick: 51, numRookie: 0, name: "Boston Scott", team: "PHI", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 142, numPosPick: 20, numRookie: 14, name: "Joe Burrow", team: "CIN", position: "QB", byeWeek: 9, isTopPlayer: true, isRookie: true),
            PlayerData(num: 143, numPosPick: 19, numRookie: 0, name: "Blake Jarwin", team: "DAL", position: "TE", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 144, numPosPick: 54, numRookie: 0, name: "Mecole Hardman", team: "KC", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 145, numPosPick: 55, numRookie: 0, name: "N'Keal Harry", team: "NE", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 146, numPosPick: 56, numRookie: 0, name: "Robby Anderson", team: "CAR", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 147, numPosPick: 21, numRookie: 0, name: "Kirk Cousins", team: "MIN", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 148, numPosPick: 57, numRookie: 0, name: "Breshad Perriman", team: "NYJ", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 149, numPosPick: 58, numRookie: 0, name: "Allen Lazard", team: "GB", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 150, numPosPick: 59, numRookie: 0, name: "Curtis Samuel", team: "CAR", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 151, numPosPick: 52, numRookie: 0, name: "Chase Edmonds", team: "ARI", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 152, numPosPick: 22, numRookie: 0, name: "Gardner Minshew II", team: "JAC", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 153, numPosPick: 60, numRookie: 15, name: "Brandon Aiyuk", team: "SF", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: true),
            PlayerData(num: 154, numPosPick: 23, numRookie: 0, name: "Jimmy Garoppolo", team: "SF", position: "QB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 155, numPosPick: 20, numRookie: 0, name: "Chris Herndon", team: "NYJ", position: "TE", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 156, numPosPick: 21, numRookie: 0, name: "Eric Ebron", team: "PIT", position: "TE", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 157, numPosPick: 61, numRookie: 0, name: "Sammy Watkins", team: "KC", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 158, numPosPick: 62, numRookie: 0, name: "DeSean Jackson", team: "PHI", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 159, numPosPick: 22, numRookie: 0, name: "Ian Thomas", team: "CAR", position: "TE", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 160, numPosPick: 24, numRookie: 0, name: "Drew Lock", team: "DEN", position: "QB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 161, numPosPick: 25, numRookie: 0, name: "Philip Rivers", team: "IND", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 162, numPosPick: 53, numRookie: 0, name: "Justin Jackson", team: "LAC", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 163, numPosPick: 63, numRookie: 0, name: "Parris Campbell", team: "IND", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 164, numPosPick: 26, numRookie: 0, name: "Teddy Bridgewater", team: "CAR", position: "QB", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 165, numPosPick: 64, numRookie: 16, name: "Michael Pittman Jr.", team: "IND", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: true),
            PlayerData(num: 166, numPosPick: 54, numRookie: 17, name: "AJ Dillon", team: "GB", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: true),
            PlayerData(num: 167, numPosPick: 65, numRookie: 0, name: "Larry Fitzgerald", team: "ARI", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 168, numPosPick: 55, numRookie: 0, name: "Damien Harris", team: "NE", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 169, numPosPick: 23, numRookie: 0, name: "Irv Smith Jr.", team: "MIN", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 170, numPosPick: 66, numRookie: 0, name: "Dede Westbrook", team: "JAC", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 171, numPosPick: 56, numRookie: 0, name: "Jamaal Williams", team: "GB", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 172, numPosPick: 67, numRookie: 0, name: "Alshon Jeffery", team: "PHI", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 173, numPosPick: 27, numRookie: 0, name: "Sam Darnold", team: "NYJ", position: "QB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 174, numPosPick: 68, numRookie: 0, name: "Hunter Renfrow", team: "LV", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 175, numPosPick: 28, numRookie: 0, name: "Derek Carr", team: "LV", position: "QB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 176, numPosPick: 69, numRookie: 0, name: "James Washington", team: "PIT", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 177, numPosPick: 57, numRookie: 0, name: "Carlos Hyde", team: "SEA", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 178, numPosPick: 70, numRookie: 0, name: "Corey Davis", team: "TEN", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 179, numPosPick: 58, numRookie: 18, name: "Darrynton Evans", team: "TEN", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: true),
            PlayerData(num: 180, numPosPick: 71, numRookie: 19, name: "Denzel Mims", team: "NYJ", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: true),
            PlayerData(num: 181, numPosPick: 59, numRookie: 0, name: "Chris Thompson", team: "JAC", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 182, numPosPick: 72, numRookie: 0, name: "Randall Cobb", team: "HOU", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 183, numPosPick: 60, numRookie: 0, name: "Giovani Bernard", team: "CIN", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 184, numPosPick: 24, numRookie: 0, name: "Greg Olsen", team: "SEA", position: "TE", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 185, numPosPick: 73, numRookie: 0, name: "Cole Beasley", team: "BUF", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 186, numPosPick: 74, numRookie: 0, name: "Tyrell Williams", team: "LV", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 187, numPosPick: 61, numRookie: 0, name: "Joshua Kelley", team: "LAC", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 188, numPosPick: 62, numRookie: 20, name: "Anthony McFarland Jr.", team: "PIT", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: true),
            PlayerData(num: 189, numPosPick: 63, numRookie: 0, name: "Deandre Washington", team: "KC", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 190, numPosPick: 75, numRookie: 0, name: "Steven Sims", team: "WAS", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 191, numPosPick: 76, numRookie: 21, name: "Laviska Shenault Jr.", team: "JAC", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: true),
            PlayerData(num: 192, numPosPick: 77, numRookie: 0, name: "John Ross", team: "CIN", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 193, numPosPick: 25, numRookie: 0, name: "Jace Sternberger", team: "GB", position: "TE", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 194, numPosPick: 64, numRookie: 0, name: "Jalen Richard", team: "LV", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 195, numPosPick: 78, numRookie: 22, name: "Tee Higgins", team: "CIN", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: true),
            PlayerData(num: 196, numPosPick: 79, numRookie: 0, name: "Mohamed Sanu", team: "NE", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 197, numPosPick: 80, numRookie: 0, name: "Kenny Stills", team: "HOU", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 198, numPosPick: 26, numRookie: 0, name: "O.J. Howard", team: "TB", position: "TE", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 199, numPosPick: 65, numRookie: 0, name: "Ryquell Armstead", team: "JAC", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 200, numPosPick: 81, numRookie: 0, name: "Danny Amendola", team: "DET", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
            
            // Not top 200 but still top in position.
            // Rest of Quarterbacks.
            PlayerData(num: 0, numPosPick: 29, numRookie: 0, name: "Dwayne Haskins Jr.", team: "WAS", position: "QB", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 30, numRookie: 23, name: "Tyrod Taylor", team: "LAC", position: "QB", byeWeek: 10, isTopPlayer: false, isRookie: true),
            
            // Rest of Running Backs.
            PlayerData(num: 0, numPosPick: 66, numRookie: 0, name: "Malcolm Brown", team: "LAR", position: "RB", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 67, numRookie: 0, name: "Bryce Love", team: "Was", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 68, numRookie: 0, name: "Ito Smith", team: "ATL", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 69, numRookie: 0, name: "Benny Snell Jr.", team: "PIT", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 70, numRookie: 0, name: "Jerick McKinnon", team: "SF", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 71, numRookie: 0, name: "Rashaad Penny", team: "SEA", position: "RB", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 72, numRookie: 0, name: "Royce Freeman", team: "DEN", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 73, numRookie: 24, name: "Rico Dowdle", team: "DAL", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 74, numRookie: 0, name: "Jaylen Samuels", team: "PIT", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 75, numRookie: 0, name: "Rex Burkhead", team: "NE", position: "RB", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 76, numRookie: 25, name: "Jonathan Ward", team: "ARI", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 77, numRookie: 0, name: "Justice Hill", team: "BAL", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 78, numRookie: 0, name: "Dion Lewis", team: "NYG", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 79, numRookie: 0, name: "Gus Edwards", team: "BAL", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 80, numRookie: 0, name: "Peyton Barber", team: "WAS", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
            
            // Rest of Tight Ends.
            PlayerData(num: 0, numPosPick: 27, numRookie: 0, name: "Kyle Rudolph", team: "MIN", position: "TE", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 28, numRookie: 0, name: "Dawson Knox", team: "BUF", position: "TE", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 29, numRookie: 0, name: "Gerald Everett", team: "LAR", position: "TE", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 30, numRookie: 0, name: "Will Dissly", team: "SEA", position: "TE", byeWeek: 6, isTopPlayer: false, isRookie: false),
            
            // Rest of Rookies
            PlayerData(num: 0, numPosPick: 0, numRookie: 26, name: "Lynn Bowden Jr.", team: "LV", position: "RB", byeWeek: 6, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 0, numRookie: 27, name: "Bryan Edwards", team: "LV", position: "WR", byeWeek: 6, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 0, numRookie: 28, name: "Van Jefferson", team: "LAR", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 0, numRookie: 29, name: "Justin Herbert", team: "LAC", position: "QB", byeWeek: 10, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 0, numRookie: 30, name: "Jordan Love", team: "GB", position: "QB", byeWeek: 5, isTopPlayer: false, isRookie: true),
            
            // Top 20 Defenses
            PlayerData(num: 0, numPosPick: 1, numRookie: 0, name: "San Francisco 49ers", team: "SF", position: "DST", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 2, numRookie: 0, name: "Pittsburgh Steelers", team: "PIT", position: "DST", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 3, numRookie: 0, name: "Baltimore Ravens", team: "BAL", position: "DST", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 4, numRookie: 0, name: "Buffalo Bills", team: "BUF", position: "DST", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 5, numRookie: 0, name: "New England Patriots", team: "NE", position: "DST", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 6, numRookie: 0, name: "Chicago Bears", team: "CHI", position: "DST", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 7, numRookie: 0, name: "New Orleans Saints", team: "NO", position: "DST", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 8, numRookie: 0, name: "Kansas City Chiefs", team: "KC", position: "DST", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 9, numRookie: 0, name: "Minnesota Vikings", team: "MIN", position: "DST", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 10, numRookie: 0, name: "Los Angeles Rams", team: "LAR", position: "DST", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 11, numRookie: 0, name: "Denver Broncos", team: "DEN", position: "DST", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 12, numRookie: 0, name: "Philadelphia Eagles", team: "PHI", position: "DST", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 13, numRookie: 0, name: "Los Angeles Chargers", team: "LAC", position: "DST", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 14, numRookie: 0, name: "Tennessee Titans", team: "TEN", position: "DST", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 15, numRookie: 0, name: "Seattle Seahawks", team: "SEA", position: "DST", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 16, numRookie: 0, name: "Green Bay Packers", team: "GB", position: "DST", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 17, numRookie: 0, name: "Indianapolis Colts", team: "IND", position: "DST", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 18, numRookie: 0, name: "Tampa Bay Buccaneers", team: "TB", position: "DST", byeWeek: 13, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 19, numRookie: 0, name: "Cleveland Browns", team: "CLE", position: "DST", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 20, numRookie: 0, name: "Dallas Cowboys", team: "DAL", position: "DST", byeWeek: 10, isTopPlayer: false, isRookie: false),
            
            // Top 15 Kickers
            PlayerData(num: 0, numPosPick: 1, numRookie: 0, name: "Harrison Butker", team: "KC", position: "K", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 2, numRookie: 0, name: "Justin Tucker", team: "BAL", position: "K", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 3, numRookie: 0, name: "Wil Lutz", team: "NO", position: "K", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 4, numRookie: 0, name: "Greg Zuerlein", team: "DAL", position: "K", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 5, numRookie: 0, name: "Robbie Gould", team: "SF", position: "K", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 6, numRookie: 0, name: "Matt Gay", team: "TB", position: "K", byeWeek: 13, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 7, numRookie: 0, name: "Matt Prater", team: "DET", position: "K", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 8, numRookie: 0, name: "Jake Elliott", team: "PHI", position: "K", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 9, numRookie: 0, name: "Zane Gonzalez", team: "ARI", position: "K", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 10, numRookie: 0, name: "Ka'imi Fairbairn", team: "HOU", position: "K", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 11, numRookie: 0, name: "Mike Badgley", team: "LAC", position: "K", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 12, numRookie: 0, name: "Mason Crosby", team: "GB", position: "K", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 13, numRookie: 0, name: "Dan Bailey", team: "MIN", position: "K", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 14, numRookie: 0, name: "Younghoe Koo", team: "ATL", position: "K", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 15, numRookie: 0, name: "Brandon Mcmanus", team: "DEN", position: "K", byeWeek: 8, isTopPlayer: false, isRookie: false),
        ]
        changeMade()
    }
    
    init() {
        allPlayers = [PlayerData]()
        leagueNames = [String]()
        leagues = [[String]]()
        
        if let league_names = leagueNamesReadFromDisk() {
            leagueNames = league_names
        }
        if let _leagues = leaguesDataReadFromDisk() {
            leagues = _leagues
        }
        if let _allPlayers = playersReadFromDisk() {
            allPlayers = _allPlayers
        } else {
            allPlayers = [
                PlayerData(num: 1, numPosPick: 1, numRookie: 0, name: "Christian McCaffrey", team: "CAR", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 2, numPosPick: 2, numRookie: 0, name: "Saquon Barkley", team: "NYG", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 3, numPosPick: 3, numRookie: 0, name: "Ezekiel Elliott", team: "DAL", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 4, numPosPick: 4, numRookie: 0, name: "Alvin Kamara", team: "NO", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 5, numPosPick: 1, numRookie: 0, name: "Michael Thomas", team: "NO", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 6, numPosPick: 5, numRookie: 0, name: "Dalvin Cook", team: "MIN", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 7, numPosPick: 2, numRookie: 0, name: "Davante Adams", team: "GB", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 8, numPosPick: 3, numRookie: 0, name: "Julio Jones", team: "ATL", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 9, numPosPick: 6, numRookie: 0, name: "Derrick Henry", team: "TEN", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 10, numPosPick: 7, numRookie: 1, name: "Clyde Edwards-Helaire", team: "KC", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: true),
                PlayerData(num: 11, numPosPick: 4, numRookie: 0, name: "Tyreek Hill", team: "KC", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 12, numPosPick: 8, numRookie: 0, name: "Miles Sanders", team: "PHI", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 13, numPosPick: 9, numRookie: 0, name: "Kenyan Drake", team: "ARI", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 14, numPosPick: 10, numRookie: 0, name: "Joe Mixon", team: "CIN", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 15, numPosPick: 5, numRookie: 0, name: "DeAndre Hopkins", team: "ARI", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 16, numPosPick: 11, numRookie: 0, name: "Austin Ekeler", team: "LAC", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 17, numPosPick: 6, numRookie: 0, name: "Chris Godwin", team: "TB", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 18, numPosPick: 1, numRookie: 0, name: "Travis Kelce", team: "KC", position: "TE", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 19, numPosPick: 2, numRookie: 0, name: "George Kittle", team: "SF", position: "TE", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 20, numPosPick: 7, numRookie: 0, name: "Allen Robinson II", team: "CHI", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 21, numPosPick: 12, numRookie: 0, name: "Josh Jacobs", team: "LV", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 22, numPosPick: 13, numRookie: 0, name: "Aaron Jones", team: "GB", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 23, numPosPick: 8, numRookie: 0, name: "Kenny Golladay", team: "DET", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 24, numPosPick: 14, numRookie: 0, name: "Nick Chubb", team: "CLE", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 25, numPosPick: 1, numRookie: 0, name: "Patrick Mahomes", team: "KC", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 26, numPosPick: 9, numRookie: 0, name: "DJ Moore", team: "CAR", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 27, numPosPick: 10, numRookie: 0, name: "JuJu Smith-Schuster", team: "PIT", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 28, numPosPick: 11, numRookie: 0, name: "Mike Evans", team: "TB", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 29, numPosPick: 12, numRookie: 0, name: "Adam Thielen", team: "MIN", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 30, numPosPick: 2, numRookie: 0, name: "Lamar Jackson", team: "BAL", position: "QB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 31, numPosPick: 13, numRookie: 0, name: "Amari Cooper", team: "DAL", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 32, numPosPick: 14, numRookie: 0, name: "Odell Beckham Jr.", team: "CLE", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 33, numPosPick: 15, numRookie: 0, name: "Robert Woods", team: "LAR", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 34, numPosPick: 3, numRookie: 0, name: "Mark Andrews", team: "BAL", position: "TE", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 35, numPosPick: 16, numRookie: 0, name: "Cooper Kupp", team: "LAR", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 36, numPosPick: 17, numRookie: 0, name: "Calvin Ridley", team: "ATL", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 37, numPosPick: 15, numRookie: 0, name: "Leonard Fournette", team: "JAC", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 38, numPosPick: 16, numRookie: 0, name: "Todd Gurley II", team: "ATL", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 39, numPosPick: 17, numRookie: 0, name: "Chris Carson", team: "SEA", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 40, numPosPick: 4, numRookie: 0, name: "Zach Ertz", team: "PHI", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 41, numPosPick: 18, numRookie: 0, name: "A.J. Brown", team: "TEN", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 42, numPosPick: 18, numRookie: 0, name: "James Connor", team: "PIT", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 43, numPosPick: 19, numRookie: 0, name: "Le'Veon Bell", team: "NYJ", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 44, numPosPick: 19, numRookie: 0, name: "DJ Chark Jr.", team: "JAC", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 45, numPosPick: 20, numRookie: 0, name: "Melvin Gordon", team: "DEN", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 46, numPosPick: 20, numRookie: 0, name: "Tyler Lockett", team: "SEA", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 47, numPosPick: 21, numRookie: 0, name: "Terry McLaurin", team: "WAS", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 48, numPosPick: 22, numRookie: 0, name: "Keenan Allen", team: "LAC", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 49, numPosPick: 21, numRookie: 0, name: "David Johnson", team: "HOU", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 50, numPosPick: 23, numRookie: 0, name: "Courtland Sutton", team: "DEN", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 51, numPosPick: 22, numRookie: 2, name: "Jonathan Taylor", team: "IND", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: true),
                PlayerData(num: 52, numPosPick: 24, numRookie: 0, name: "DK Metcalf", team: "SEA", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 53, numPosPick: 25, numRookie: 0, name: "DeVante Parker", team: "MIA", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 54, numPosPick: 3, numRookie: 0, name: "Dak Prescott", team: "DAL", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 55, numPosPick: 26, numRookie: 0, name: "T.Y. Hilton", team: "IND", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 56, numPosPick: 5, numRookie: 0, name: "Darren Waller", team: "LV", position: "TE", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 57, numPosPick: 23, numRookie: 0, name: "Mark Ingram II", team: "BAL", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 58, numPosPick: 4, numRookie: 0, name: "Russell Wilson", team: "SEA", position: "QB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 59, numPosPick: 5, numRookie: 0, name: "Kyler Murray", team: "ARI", position: "QB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 60, numPosPick: 27, numRookie: 0, name: "Stefon Diggs", team: "BUF", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 61, numPosPick: 24, numRookie: 0, name: "David Montgomery", team: "CHI", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 62, numPosPick: 25, numRookie: 0, name: "Kareem Hunt", team: "CLE", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 63, numPosPick: 6, numRookie: 0, name: "Deshaun Watson", team: "HOU", position: "QB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 64, numPosPick: 28, numRookie: 0, name: "Tyler Boyd", team: "CIN", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 65, numPosPick: 29, numRookie: 0, name: "Jarvis Landry", team: "CLE", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 66, numPosPick: 26, numRookie: 0, name: "Devin Singletary", team: "BUF", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 67, numPosPick: 30, numRookie: 0, name: "A.J. Green", team: "CIN", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 68, numPosPick: 31, numRookie: 0, name: "Michael Gallup", team: "DAL", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 69, numPosPick: 27, numRookie: 3, name: "D'Andre Swift", team: "DET", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: true),
                PlayerData(num: 70, numPosPick: 32, numRookie: 0, name: "Julian Edelman", team: "NE", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 71, numPosPick: 33, numRookie: 0, name: "Marquise Brown", team: "BAL", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 72, numPosPick: 28, numRookie: 0, name: "Raheem Mostert", team: "SF", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 73, numPosPick: 6, numRookie: 0, name: "Evan Engram", team: "NYG", position: "TE", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 74, numPosPick: 29, numRookie: 4, name: "Cam Akers", team: "LAR", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: true),
                PlayerData(num: 75, numPosPick: 30, numRookie: 0, name: "James White", team: "NE", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 76, numPosPick: 7, numRookie: 0, name: "Josh Allen", team: "BUF", position: "QB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 77, numPosPick: 34, numRookie: 0, name: "Marvin Jones Jr.", team: "DET", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 78, numPosPick: 7, numRookie: 0, name: "Tyler Higbee", team: "LAR", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 79, numPosPick: 8, numRookie: 0, name: "Matt Ryan", team: "ATL", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 80, numPosPick: 8, numRookie: 0, name: "Hunter Henry", team: "LAC", position: "TE", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 81, numPosPick: 35, numRookie: 0, name: "Will Fuller", team: "HOU", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 82, numPosPick: 36, numRookie: 0, name: "Brandin Cooks", team: "HOU", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 83, numPosPick: 31, numRookie: 0, name: "Ronald Jones II", team: "TB", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 84, numPosPick: 32, numRookie: 0, name: "Tarik Cohen", team: "CHI", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 85, numPosPick: 37, numRookie: 0, name: "Diontae Johnson", team: "PIT", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 86, numPosPick: 9, numRookie: 0, name: "Carson Wentz", team: "PHI", position: "QB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 87, numPosPick: 10, numRookie: 0, name: "Drew Brees", team: "NO", position: "QB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 88, numPosPick: 38, numRookie: 0, name: "Jamison Crowder", team: "NYJ", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 89, numPosPick: 39, numRookie: 0, name: "Christian Kirk", team: "ARI", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 90, numPosPick: 11, numRookie: 0, name: "Tom Brady", team: "TB", position: "QB", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 91, numPosPick: 33, numRookie: 0, name: "Jordan Howard", team: "MIA", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 92, numPosPick: 34, numRookie: 0, name: "Matt Breida", team: "MIA", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 93, numPosPick: 40, numRookie: 0, name: "Sterling Shepard", team: "NYG", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 94, numPosPick: 12, numRookie: 0, name: "Matthew Stafford", team: "DET", position: "QB", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 95, numPosPick: 9, numRookie: 0, name: "Hayden Hurst", team: "ATL", position: "TE", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 96, numPosPick: 35, numRookie: 0, name: "Phillip Lindsay", team: "DEN", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 97, numPosPick: 36, numRookie: 5, name: "J.K. Dobbins", team: "BAL", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: true),
                PlayerData(num: 98, numPosPick: 41, numRookie: 0, name: "John Brown", team: "BUF", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 99, numPosPick: 13, numRookie: 0, name: "Aaron Rodgers", team: "GB", position: "QB", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 100, numPosPick: 10, numRookie: 0, name: "Mike Gesicki", team: "MIA", position: "TE", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 101, numPosPick: 42, numRookie: 0, name: "Anthony Miller", team: "CHI", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 102, numPosPick: 11, numRookie: 0, name: "Austin Hooper", team: "CLE", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 103, numPosPick: 43, numRookie: 0, name: "Darius Slayton", team: "NYG", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 104, numPosPick: 37, numRookie: 0, name: "Tevin Coleman", team: "SF", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 105, numPosPick: 38, numRookie: 0, name: "Kerryon Johnson", team: "DET", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 106, numPosPick: 12, numRookie: 0, name: "Jared Cook", team: "NO", position: "TE", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 107, numPosPick: 44, numRookie: 6, name: "CeeDee Lamb", team: "DAL", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: true),
                PlayerData(num: 108, numPosPick: 45, numRookie: 0, name: "Mike Williams", team: "LAC", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 109, numPosPick: 46, numRookie: 0, name: "Deebo Samuel", team: "SF", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 110, numPosPick: 47, numRookie: 0, name: "Emmanuel Sanders", team: "NO", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 111, numPosPick: 13, numRookie: 0, name: "Rob Gronkowski", team: "TB", position: "TE", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 112, numPosPick: 39, numRookie: 0, name: "Latavius Murray", team: "NO", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 113, numPosPick: 14, numRookie: 0, name: "Daniel Jones", team: "NYG", position: "QB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 114, numPosPick: 40, numRookie: 0, name: "Marlon Mack", team: "IND", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 115, numPosPick: 15, numRookie: 0, name: "Ben Roethlisberger", team: "PIT", position: "QB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 116, numPosPick: 48, numRookie: 0, name: "Golden Tate", team: "NYG", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 117, numPosPick: 41, numRookie: 0, name: "Duke Johnson", team: "HOU", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 118, numPosPick: 14, numRookie: 0, name: "T.J. Hockenson", team: "DET", position: "TE", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 119, numPosPick: 16, numRookie: 0, name: "Jared Goff", team: "LAR", position: "QB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 120, numPosPick: 49, numRookie: 0, name: "Preston Williams", team: "MIA", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 121, numPosPick: 42, numRookie: 0, name: "Darrell Henderson Jr.", team: "LAR", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 122, numPosPick: 50, numRookie: 7, name: "Jalen Reagor", team: "PHI", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: true),
                PlayerData(num: 123, numPosPick: 15, numRookie: 0, name: "Noah Fant", team: "DEN", position: "TE", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 124, numPosPick: 17, numRookie: 0, name: "Cam Newton", team: "NE", position: "QB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 125, numPosPick: 43, numRookie: 8, name: "Zack Moss", team: "BUF", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: true),
                PlayerData(num: 126, numPosPick: 44, numRookie: 0, name: "Sony Michel", team: "NE", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 127, numPosPick: 16, numRookie: 0, name: "Jonnu Smith", team: "TEN", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 128, numPosPick: 18, numRookie: 0, name: "Ryan Tannehill", team: "TEN", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 129, numPosPick: 48, numRookie: 9, name: "Jerry Jeudy", team: "DEN", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: true),
                PlayerData(num: 130, numPosPick: 19, numRookie: 0, name: "Baker Mayfield", team: "CLE", position: "QB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 131, numPosPick: 17, numRookie: 0, name: "Dallas Goedert", team: "PHI", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 132, numPosPick: 45, numRookie: 0, name: "Alexander Mattison", team: "MIN", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 133, numPosPick: 46, numRookie: 10, name: "Ke'Shawn Vaughn", team: "TB", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: true),
                PlayerData(num: 134, numPosPick: 52, numRookie: 11, name: "Justin Jefferson", team: "MIN", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: true),
                PlayerData(num: 135, numPosPick: 18, numRookie: 0, name: "Jack Doyle", team: "IND", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 136, numPosPick: 47, numRookie: 0, name: "Adrian Peterson", team: "WAS", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 137, numPosPick: 53, numRookie: 12, name: "Henry Ruggs III", team: "LV", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: true),
                PlayerData(num: 138, numPosPick: 48, numRookie: 0, name: "Nyheim Hines", team: "IND", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 139, numPosPick: 49, numRookie: 0, name: "Tony Pollard", team: "DAL", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 140, numPosPick: 50, numRookie: 13, name: "Antonio Gibson", team: "WAS", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: true),
                PlayerData(num: 141, numPosPick: 51, numRookie: 0, name: "Boston Scott", team: "PHI", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 142, numPosPick: 20, numRookie: 14, name: "Joe Burrow", team: "CIN", position: "QB", byeWeek: 9, isTopPlayer: true, isRookie: true),
                PlayerData(num: 143, numPosPick: 19, numRookie: 0, name: "Blake Jarwin", team: "DAL", position: "TE", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 144, numPosPick: 54, numRookie: 0, name: "Mecole Hardman", team: "KC", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 145, numPosPick: 55, numRookie: 0, name: "N'Keal Harry", team: "NE", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 146, numPosPick: 56, numRookie: 0, name: "Robby Anderson", team: "CAR", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 147, numPosPick: 21, numRookie: 0, name: "Kirk Cousins", team: "MIN", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 148, numPosPick: 57, numRookie: 0, name: "Breshad Perriman", team: "NYJ", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 149, numPosPick: 58, numRookie: 0, name: "Allen Lazard", team: "GB", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 150, numPosPick: 59, numRookie: 0, name: "Curtis Samuel", team: "CAR", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 151, numPosPick: 52, numRookie: 0, name: "Chase Edmonds", team: "ARI", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 152, numPosPick: 22, numRookie: 0, name: "Gardner Minshew II", team: "JAC", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 153, numPosPick: 60, numRookie: 15, name: "Brandon Aiyuk", team: "SF", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: true),
                PlayerData(num: 154, numPosPick: 23, numRookie: 0, name: "Jimmy Garoppolo", team: "SF", position: "QB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 155, numPosPick: 20, numRookie: 0, name: "Chris Herndon", team: "NYJ", position: "TE", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 156, numPosPick: 21, numRookie: 0, name: "Eric Ebron", team: "PIT", position: "TE", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 157, numPosPick: 61, numRookie: 0, name: "Sammy Watkins", team: "KC", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 158, numPosPick: 62, numRookie: 0, name: "DeSean Jackson", team: "PHI", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 159, numPosPick: 22, numRookie: 0, name: "Ian Thomas", team: "CAR", position: "TE", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 160, numPosPick: 24, numRookie: 0, name: "Drew Lock", team: "DEN", position: "QB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 161, numPosPick: 25, numRookie: 0, name: "Philip Rivers", team: "IND", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 162, numPosPick: 53, numRookie: 0, name: "Justin Jackson", team: "LAC", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 163, numPosPick: 63, numRookie: 0, name: "Parris Campbell", team: "IND", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 164, numPosPick: 26, numRookie: 0, name: "Teddy Bridgewater", team: "CAR", position: "QB", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 165, numPosPick: 64, numRookie: 16, name: "Michael Pittman Jr.", team: "IND", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: true),
                PlayerData(num: 166, numPosPick: 54, numRookie: 17, name: "AJ Dillon", team: "GB", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: true),
                PlayerData(num: 167, numPosPick: 65, numRookie: 0, name: "Larry Fitzgerald", team: "ARI", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 168, numPosPick: 55, numRookie: 0, name: "Damien Harris", team: "NE", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 169, numPosPick: 23, numRookie: 0, name: "Irv Smith Jr.", team: "MIN", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 170, numPosPick: 66, numRookie: 0, name: "Dede Westbrook", team: "JAC", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 171, numPosPick: 56, numRookie: 0, name: "Jamaal Williams", team: "GB", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 172, numPosPick: 67, numRookie: 0, name: "Alshon Jeffery", team: "PHI", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 173, numPosPick: 27, numRookie: 0, name: "Sam Darnold", team: "NYJ", position: "QB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 174, numPosPick: 68, numRookie: 0, name: "Hunter Renfrow", team: "LV", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 175, numPosPick: 28, numRookie: 0, name: "Derek Carr", team: "LV", position: "QB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 176, numPosPick: 69, numRookie: 0, name: "James Washington", team: "PIT", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 177, numPosPick: 57, numRookie: 0, name: "Carlos Hyde", team: "SEA", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 178, numPosPick: 70, numRookie: 0, name: "Corey Davis", team: "TEN", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 179, numPosPick: 58, numRookie: 18, name: "Darrynton Evans", team: "TEN", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: true),
                PlayerData(num: 180, numPosPick: 71, numRookie: 19, name: "Denzel Mims", team: "NYJ", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: true),
                PlayerData(num: 181, numPosPick: 59, numRookie: 0, name: "Chris Thompson", team: "JAC", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 182, numPosPick: 72, numRookie: 0, name: "Randall Cobb", team: "HOU", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 183, numPosPick: 60, numRookie: 0, name: "Giovani Bernard", team: "CIN", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 184, numPosPick: 24, numRookie: 0, name: "Greg Olsen", team: "SEA", position: "TE", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 185, numPosPick: 73, numRookie: 0, name: "Cole Beasley", team: "BUF", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 186, numPosPick: 74, numRookie: 0, name: "Tyrell Williams", team: "LV", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 187, numPosPick: 61, numRookie: 0, name: "Joshua Kelley", team: "LAC", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 188, numPosPick: 62, numRookie: 20, name: "Anthony McFarland Jr.", team: "PIT", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: true),
                PlayerData(num: 189, numPosPick: 63, numRookie: 0, name: "Deandre Washington", team: "KC", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 190, numPosPick: 75, numRookie: 0, name: "Steven Sims", team: "WAS", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 191, numPosPick: 76, numRookie: 21, name: "Laviska Shenault Jr.", team: "JAC", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: true),
                PlayerData(num: 192, numPosPick: 77, numRookie: 0, name: "John Ross", team: "CIN", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 193, numPosPick: 25, numRookie: 0, name: "Jace Sternberger", team: "GB", position: "TE", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 194, numPosPick: 64, numRookie: 0, name: "Jalen Richard", team: "LV", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 195, numPosPick: 78, numRookie: 22, name: "Tee Higgins", team: "CIN", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: true),
                PlayerData(num: 196, numPosPick: 79, numRookie: 0, name: "Mohamed Sanu", team: "NE", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 197, numPosPick: 80, numRookie: 0, name: "Kenny Stills", team: "HOU", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 198, numPosPick: 26, numRookie: 0, name: "O.J. Howard", team: "TB", position: "TE", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 199, numPosPick: 65, numRookie: 0, name: "Ryquell Armstead", team: "JAC", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 200, numPosPick: 81, numRookie: 0, name: "Danny Amendola", team: "DET", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
                
                // Not top 200 but still top in position.
                // Rest of Quarterbacks.
                PlayerData(num: 0, numPosPick: 29, numRookie: 0, name: "Dwayne Haskins Jr.", team: "WAS", position: "QB", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 30, numRookie: 23, name: "Tyrod Taylor", team: "LAC", position: "QB", byeWeek: 10, isTopPlayer: false, isRookie: true),
                
                // Rest of Running Backs.
                PlayerData(num: 0, numPosPick: 66, numRookie: 0, name: "Malcolm Brown", team: "LAR", position: "RB", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 67, numRookie: 0, name: "Bryce Love", team: "Was", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 68, numRookie: 0, name: "Ito Smith", team: "ATL", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 69, numRookie: 0, name: "Benny Snell Jr.", team: "PIT", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 70, numRookie: 0, name: "Jerick McKinnon", team: "SF", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 71, numRookie: 0, name: "Rashaad Penny", team: "SEA", position: "RB", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 72, numRookie: 0, name: "Royce Freeman", team: "DEN", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 73, numRookie: 24, name: "Rico Dowdle", team: "DAL", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 74, numRookie: 0, name: "Jaylen Samuels", team: "PIT", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 75, numRookie: 0, name: "Rex Burkhead", team: "NE", position: "RB", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 76, numRookie: 25, name: "Jonathan Ward", team: "ARI", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 77, numRookie: 0, name: "Justice Hill", team: "BAL", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 78, numRookie: 0, name: "Dion Lewis", team: "NYG", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 79, numRookie: 0, name: "Gus Edwards", team: "BAL", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 80, numRookie: 0, name: "Peyton Barber", team: "WAS", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
                
                // Rest of Tight Ends.
                PlayerData(num: 0, numPosPick: 27, numRookie: 0, name: "Kyle Rudolph", team: "MIN", position: "TE", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 28, numRookie: 0, name: "Dawson Knox", team: "BUF", position: "TE", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 29, numRookie: 0, name: "Gerald Everett", team: "LAR", position: "TE", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 30, numRookie: 0, name: "Will Dissly", team: "SEA", position: "TE", byeWeek: 6, isTopPlayer: false, isRookie: false),
                
                // Rest of Rookies
                PlayerData(num: 0, numPosPick: 0, numRookie: 26, name: "Lynn Bowden Jr.", team: "LV", position: "RB", byeWeek: 6, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 0, numRookie: 27, name: "Bryan Edwards", team: "LV", position: "WR", byeWeek: 6, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 0, numRookie: 28, name: "Van Jefferson", team: "LAR", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 0, numRookie: 29, name: "Justin Herbert", team: "LAC", position: "QB", byeWeek: 10, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 0, numRookie: 30, name: "Jordan Love", team: "GB", position: "QB", byeWeek: 5, isTopPlayer: false, isRookie: true),
                
                // Top 20 Defenses
                PlayerData(num: 0, numPosPick: 1, numRookie: 0, name: "San Francisco 49ers", team: "SF", position: "DST", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 2, numRookie: 0, name: "Pittsburgh Steelers", team: "PIT", position: "DST", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 3, numRookie: 0, name: "Baltimore Ravens", team: "BAL", position: "DST", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 4, numRookie: 0, name: "Buffalo Bills", team: "BUF", position: "DST", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 5, numRookie: 0, name: "New England Patriots", team: "NE", position: "DST", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 6, numRookie: 0, name: "Chicago Bears", team: "CHI", position: "DST", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 7, numRookie: 0, name: "New Orleans Saints", team: "NO", position: "DST", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 8, numRookie: 0, name: "Kansas City Chiefs", team: "KC", position: "DST", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 9, numRookie: 0, name: "Minnesota Vikings", team: "MIN", position: "DST", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 10, numRookie: 0, name: "Los Angeles Rams", team: "LAR", position: "DST", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 11, numRookie: 0, name: "Denver Broncos", team: "DEN", position: "DST", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 12, numRookie: 0, name: "Philadelphia Eagles", team: "PHI", position: "DST", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 13, numRookie: 0, name: "Los Angeles Chargers", team: "LAC", position: "DST", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 14, numRookie: 0, name: "Tennessee Titans", team: "TEN", position: "DST", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 15, numRookie: 0, name: "Seattle Seahawks", team: "SEA", position: "DST", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 16, numRookie: 0, name: "Green Bay Packers", team: "GB", position: "DST", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 17, numRookie: 0, name: "Indianapolis Colts", team: "IND", position: "DST", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 18, numRookie: 0, name: "Tampa Bay Buccaneers", team: "TB", position: "DST", byeWeek: 13, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 19, numRookie: 0, name: "Cleveland Browns", team: "CLE", position: "DST", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 20, numRookie: 0, name: "Dallas Cowboys", team: "DAL", position: "DST", byeWeek: 10, isTopPlayer: false, isRookie: false),
                
                // Top 15 Kickers
                PlayerData(num: 0, numPosPick: 1, numRookie: 0, name: "Harrison Butker", team: "KC", position: "K", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 2, numRookie: 0, name: "Justin Tucker", team: "BAL", position: "K", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 3, numRookie: 0, name: "Wil Lutz", team: "NO", position: "K", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 4, numRookie: 0, name: "Greg Zuerlein", team: "DAL", position: "K", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 5, numRookie: 0, name: "Robbie Gould", team: "SF", position: "K", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 6, numRookie: 0, name: "Matt Gay", team: "TB", position: "K", byeWeek: 13, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 7, numRookie: 0, name: "Matt Prater", team: "DET", position: "K", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 8, numRookie: 0, name: "Jake Elliott", team: "PHI", position: "K", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 9, numRookie: 0, name: "Zane Gonzalez", team: "ARI", position: "K", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 10, numRookie: 0, name: "Ka'imi Fairbairn", team: "HOU", position: "K", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 11, numRookie: 0, name: "Mike Badgley", team: "LAC", position: "K", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 12, numRookie: 0, name: "Mason Crosby", team: "GB", position: "K", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 13, numRookie: 0, name: "Dan Bailey", team: "MIN", position: "K", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 14, numRookie: 0, name: "Younghoe Koo", team: "ATL", position: "K", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 15, numRookie: 0, name: "Brandon Mcmanus", team: "DEN", position: "K", byeWeek: 8, isTopPlayer: false, isRookie: false),
            ]
        }
    }
    
    // Depth Charts
    var data: [Cell] = []
    
    let depthChartTeamDivision: [String] = ["AFC EAST", "AFC NORTH", "AFC SOUTH", "AFC WEST", "NFC EAST", "NFC NORTH", "NFC SOUTH", "NFC WEST"]
    
    let depthChartTeams: [[String]] = [
        //AFC East
        ["Buffalo Bills", "Miami Dolphins", "New York Jets", "New England Patriots",],
        //AFC North
        ["Cincinatti Bengals", "Cleveland Browns", "Baltimore Ravens", "Pittsburgh Steelers"],
        //AFC South
        ["Indianapolis Colts", "Jacksonville Jaguars", "Houston Texans", "Tennessee Titans"],
        //AFC West
        ["Denver Broncos", "Los Angeles Chargers", "Kansas City Chiefs", "Las Vegas Raiders"],
        //NFC East
        ["Dallas Cowboys", "Philadelphia Eagles", "New York Giants", "Washington Redskins"],
        //NFC North
        ["Chicago Bears", "Detroit Lions", "Green Bay Packers", "Minnesota Vikings"],
        //NFC South
        ["Tampa Bay Buccaneers", "Atlanta Falcons", "Carolina Panthers", "New Orleans Saints"],
        //NFC West
        ["San Francisco 49ers", "Arizona Cardinals", "Los Angeles Rams", "Seattle Seahawks"]
    ]
    
    func loadTeamData(sec:Int, row:Int, view1:UIView, view2:UIView, label:UILabel, table:UITableView) {
        if sec == 0 && row == 0 {
            data = billsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.01938016217, green: 0.2123703163, blue: 0.5529411765, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.04705882353, blue: 0.1882352941, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.04705882353, blue: 0.1882352941, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.04705882353, blue: 0.1882352941, alpha: 1)
            label.textColor = .white
            label.text = "Buffalo Bills"
        }
        if sec == 0 && row == 1 {
            data = dolphinsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0.3411764706, blue: 0.4705882353, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.2980392157, blue: 0.007843137255, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.2980392157, blue: 0.007843137255, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.2980392157, blue: 0.007843137255, alpha: 1)
            label.textColor = .black
            label.text = "Miami Dolphins"
        }
        if sec == 0 && row == 2 {
            data = jetsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.3411764706, blue: 0.2509803922, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            label.textColor = .black
            label.text = "New York Jets"
        }
        if sec == 0 && row == 3 {
            data = patriotsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.04705882353, blue: 0.1882352941, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            label.textColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
            label.text = "New England Patriots"
        }
        
        if sec == 1 && row == 0 {
            data = bengalsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.textColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            label.text = "Cincinatti Bengals"
        }
        if sec == 1 && row == 1 {
            data = brownsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 1, green: 0.2352941176, blue: 0, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.1137254902, blue: 0, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.1137254902, blue: 0, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.1137254902, blue: 0, alpha: 1)
            label.textColor = .white
            label.text = "Cleveland Browns"
        }
        if sec == 1 && row == 2 {
            data = ravensArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.09803921569, blue: 0.3725490196, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.09803921569, blue: 0.3725490196, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.09803921569, blue: 0.3725490196, alpha: 1)
            label.textColor = #colorLiteral(red: 0.6196078431, green: 0.4862745098, blue: 0.04705882353, alpha: 1)
            label.text = "Baltimore Ravens"
        }
        if sec == 1 && row == 3 {
            data = steelersArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.textColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.text = "Pittsburgh Steelers"
        }
        
        if sec == 2 && row == 0 {
            data = coltsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0.1725490196, blue: 0.3725490196, alpha: 1)
            view2.backgroundColor = .white
            label.backgroundColor = .white
            table.backgroundColor = .white
            label.textColor = #colorLiteral(red: 0, green: 0.1725490196, blue: 0.3725490196, alpha: 1)
            label.text = "Indianapolis Colts"
        }
        if sec == 2 && row == 1 {
            data = jaguarsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.6235294118, green: 0.4745098039, blue: 0.1725490196, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            label.textColor = .white
            label.text = "Jacksonville Jaguars"
        }
        if sec == 2 && row == 2 {
            data = texansArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.1254901961, blue: 0.1843137255, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            label.textColor = .white
            label.text = "Houston Texans"
        }
        if sec == 2 && row == 3 {
            data = titansArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.5411764706, green: 0.5529411765, blue: 0.5607843137, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.06274509804, blue: 0.1803921569, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.06274509804, blue: 0.1803921569, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.06274509804, blue: 0.1803921569, alpha: 1)
            label.textColor = #colorLiteral(red: 0.04705882353, green: 0.137254902, blue: 0.2509803922, alpha: 1)
            label.text = "Tennessee Titans"
        }
        
        if sec == 3 && row == 0 {
            data = broncosArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            label.textColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            label.text = "Denver Broncos"
        }
        if sec == 3 && row == 1 {
            data = chargersArray_2020()
            view1.backgroundColor = #colorLiteral(red: 1, green: 0.7607843137, blue: 0.05490196078, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0.7764705882, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0.7764705882, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0.7764705882, alpha: 1)
            label.textColor = #colorLiteral(red: 1, green: 0.7607843137, blue: 0.05490196078, alpha: 1)
            label.text = "Los Angeles Chargers"
        }
        if sec == 3 && row == 2 {
            data = chiefsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.09411764706, blue: 0.2156862745, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            label.textColor = .black
            label.text = "Kansas City Chiefs"
        }
        if sec == 3 && row == 3 {
            data = raidersArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            view2.backgroundColor = .black
            label.backgroundColor = .black
            table.backgroundColor = .black
            label.textColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            label.text = "Las Vegas Raiders"
        }
        
        if sec == 4 && row == 0 {
            data = cowboysArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.4980392157, green: 0.5882352941, blue: 0.5843137255, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0.2078431373, blue: 0.5803921569, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0.2078431373, blue: 0.5803921569, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0.2078431373, blue: 0.5803921569, alpha: 1)
            label.textColor = .white
            label.text = "Dallas Cowboys"
        }
        if sec == 4 && row == 1 {
            data = eaglesArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.3725490196, green: 0.3764705882, blue: 0.3843137255, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.textColor = #colorLiteral(red: 0.7294117647, green: 0.7921568627, blue: 0.8274509804, alpha: 1)
            label.text = "Philadelphia Eagles"
        }
        if sec == 4 && row == 2 {
            data = giantsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.137254902, blue: 0.3215686275, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6392156863, green: 0.05098039216, blue: 0.1764705882, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6392156863, green: 0.05098039216, blue: 0.1764705882, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6392156863, green: 0.05098039216, blue: 0.1764705882, alpha: 1)
            label.textColor = #colorLiteral(red: 0.003921568627, green: 0.137254902, blue: 0.3215686275, alpha: 1)
            label.text = "New York Giants"
        }
        if sec == 4 && row == 3 {
            data = redskinsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.2470588235, green: 0.06274509804, blue: 0.06274509804, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.textColor = #colorLiteral(red: 0.2470588235, green: 0.06274509804, blue: 0.06274509804, alpha: 1)
            label.text = "Washington Redskins"
        }
        
        if sec == 5 && row == 0 {
            data = bearsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.0431372549, green: 0.0862745098, blue: 0.1647058824, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.2196078431, blue: 0.01176470588, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.2196078431, blue: 0.01176470588, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.2196078431, blue: 0.01176470588, alpha: 1)
            label.textColor = #colorLiteral(red: 0.0431372549, green: 0.0862745098, blue: 0.1647058824, alpha: 1)
            label.text = "Chicago Bears"
        }
        if sec == 5 && row == 1 {
            data = lionsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
            label.textColor = .white
            label.text = "Detroit Lions"
        }
        if sec == 5 && row == 2 {
            data = packersArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.1882352941, blue: 0.1568627451, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            label.textColor = #colorLiteral(red: 0.09411764706, green: 0.1882352941, blue: 0.1568627451, alpha: 1)
            label.text = "Green Bay Packers"
        }
        if sec == 5 && row == 3 {
            data = vikingsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.3098039216, green: 0.1490196078, blue: 0.5137254902, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7764705882, blue: 0.1843137255, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7764705882, blue: 0.1843137255, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7764705882, blue: 0.1843137255, alpha: 1)
            label.textColor = #colorLiteral(red: 0.3098039216, green: 0.1490196078, blue: 0.5137254902, alpha: 1)
            label.text = "Minnesota Vikings"
        }
        
        if sec == 6 && row == 0 {
            data = buccaneersArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.1882352941, blue: 0.168627451, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.03921568627, blue: 0.03137254902, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.03921568627, blue: 0.03137254902, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.03921568627, blue: 0.03137254902, alpha: 1)
            label.textColor = #colorLiteral(red: 0.6941176471, green: 0.7294117647, blue: 0.7490196078, alpha: 1)
            label.text = "Tampa Bay Buccaneers"
        }
        if sec == 6 && row == 1 {
            data = falconsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.text = "Atlanta Falcons"
        }
        if sec == 6 && row == 2 {
            data = panthersArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.7529411765, blue: 0.7490196078, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0.5215686275, blue: 0.7921568627, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0.5215686275, blue: 0.7921568627, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0.5215686275, blue: 0.7921568627, alpha: 1)
            label.textColor = #colorLiteral(red: 0.7490196078, green: 0.7529411765, blue: 0.7490196078, alpha: 1)
            label.text = "Carolina Panthers"
        }
        if sec == 6 && row == 3 {
            data = saintsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.8274509804, green: 0.737254902, blue: 0.5529411765, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1215686275, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1215686275, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1215686275, alpha: 1)
            label.textColor = #colorLiteral(red: 0.8274509804, green: 0.737254902, blue: 0.5529411765, alpha: 1)
            label.text = "New Orleans Saints"
        }
        
        if sec == 7 && row == 0 {
            data = _49ersArray_2020()
            view1.backgroundColor = .black
            view2.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.6, blue: 0.3647058824, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.6, blue: 0.3647058824, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.6, blue: 0.3647058824, alpha: 1)
            label.textColor = .white
            label.text = "San Francisco 49ers"
        }
        if sec == 7 && row == 1 {
            data = cardinalsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.textColor = .white
            label.text = "Arizona Cardinals"
        }
        if sec == 7 && row == 2 {
            data = ramsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.5254901961, green: 0.4274509804, blue: 0.2941176471, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.5254901961, green: 0.4274509804, blue: 0.2941176471, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.5254901961, green: 0.4274509804, blue: 0.2941176471, alpha: 1)
            label.textColor = .white
            label.text = "Los Angeles Rams"
        }
        if sec == 7 && row == 3 {
            data = seahawksArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.4117647059, green: 0.7450980392, blue: 0.1568627451, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            label.textColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            label.text = "Seattle Seahawks"
        }
    }
    
    // AFC East
    func billsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Josh Allen")
        let qb2 = Cell(pos: "QB2", play: "Matt Barkley")
        let qb3 = Cell(pos: "QB3", play: "Jake Fromm", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Devin Singletary")
        let rb2 = Cell(pos: "RB2", play: "Zack Moss", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "T.J. Yeldon")
        let wr1 = Cell(pos: "WR1", play: "Stefon Diggs")
        let wr2 = Cell(pos: "WR2", play: "John Brown")
        let wr3 = Cell(pos: "WR3", play: "Cole Beasley")
        let wr4 = Cell(pos: "WR4", play: "Gabriel Davis", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Dawson Knox")
        let te2 = Cell(pos: "TE2", play: "Tyler Kroft")
        let k = Cell(pos: "K", play: "Stephen Hauschka")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(qb3)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func dolphinsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Ryan Fitzpatrick")
        let qb2 = Cell(pos: "QB2", play: "Tua Tagovailoa", rookie: "R")
        let qb3 = Cell(pos: "QB3", play: "Josh Rosen")
        let rb1 = Cell(pos: "RB1", play: "Jordan Howard")
        let rb2 = Cell(pos: "RB2", play: "Matt Breida")
        let rb3 = Cell(pos: "RB3", play: "Patrick Laird")
        let wr1 = Cell(pos: "WR1", play: "DeVante Parker")
        let wr2 = Cell(pos: "WR2", play: "Preston Williams")
        let wr3 = Cell(pos: "WR3", play: "Jakeem Grant")
        let wr4 = Cell(pos: "WR4", play: "Isaiah Ford")
        let te1 = Cell(pos: "TE1", play: "Mike Gesicki")
        let te2 = Cell(pos: "TE2", play: "Durham Smythe")
        let k = Cell(pos: "K", play: "Jason Sanders")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(qb3)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func jetsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Sam Darnold")
        let qb2 = Cell(pos: "QB2", play: "Joe Flacco")
        let qb3 = Cell(pos: "QB3", play: "Trevor Siemian")
        let rb1 = Cell(pos: "RB1", play: "Le'Veon Bell")
        let rb2 = Cell(pos: "RB2", play: "Frank Gore")
        let rb3 = Cell(pos: "RB3", play: "Kenneth Dixon")
        let wr1 = Cell(pos: "WR1", play: "Jamison Crowder")
        let wr2 = Cell(pos: "WR2", play: "Breshad Perriman")
        let wr3 = Cell(pos: "WR3", play: "Denzel Mims", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Josh Doctson")
        let te1 = Cell(pos: "TE1", play: "Chris Herndon")
        let te2 = Cell(pos: "TE2", play: "Ryan Griffin")
        let k = Cell(pos: "K", play: "Sam Ficken")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(qb3)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func patriotsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Jarrett Stidham")
        let qb2 = Cell(pos: "QB2", play: "Brian Hoyer")
        let rb1 = Cell(pos: "RB1", play: "Sony Michel")
        let rb2 = Cell(pos: "RB2", play: "James White")
        let rb3 = Cell(pos: "RB3", play: "Rex Burkhead")
        let wr1 = Cell(pos: "WR1", play: "Julian Edelman")
        let wr2 = Cell(pos: "WR2", play: "N'keal Harry")
        let wr3 = Cell(pos: "WR3", play: "Mohamed Sanu Sr.")
        let wr4 = Cell(pos: "WR4", play: "Jakobi Meyers")
        let te1 = Cell(pos: "TE1", play: "Matt LaCosse")
        let te2 = Cell(pos: "TE2", play: "Ryan Izzo")
        let k = Cell(pos: "K", play: "Justin Rohrwasser", rookie: "R")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // AFC North
    func bengalsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Joe Burrow", rookie: "R")
        let qb2 = Cell(pos: "QB2", play: "Ryan Finley")
        let rb1 = Cell(pos: "RB1", play: "Joe Mixon")
        let rb2 = Cell(pos: "RB2", play: "Giovani Bernard")
        let rb3 = Cell(pos: "RB3", play: "Trayveon Williams")
        let wr1 = Cell(pos: "WR1", play: "A.J. Green")
        let wr2 = Cell(pos: "WR2", play: "Tyler Boyd")
        let wr3 = Cell(pos: "WR3", play: "Tee Higgins", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "John Ross")
        let te1 = Cell(pos: "TE1", play: "C.J. Uzomah")
        let te2 = Cell(pos: "TE2", play: "Drew Sample")
        let k = Cell(pos: "K", play: "Randy Bullock")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func brownsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Baker Mayfield")
        let qb2 = Cell(pos: "QB2", play: "Garrett Gilbert")
        let rb1 = Cell(pos: "RB1", play: "Nick Chub")
        let rb2 = Cell(pos: "RB2", play: "Kareem Hunt")
        let rb3 = Cell(pos: "RB3", play: "D'Ernest Johnson")
        let rb4 = Cell(pos: "RB4", play: "Dontrell Hilliard")
        let wr1 = Cell(pos: "WR1", play: "Odell Beckham Jr.")
        let wr2 = Cell(pos: "WR2", play: "Jarvis Landry")
        let wr3 = Cell(pos: "WR3", play: "Rashard Higgins")
        let wr4 = Cell(pos: "WR4", play: "Taywan Taylor")
        let te1 = Cell(pos: "TE1", play: "Austin Hooper")
        let te2 = Cell(pos: "TE2", play: "David Njoku")
        let k = Cell(pos: "K", play: "Austin Seibert")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(rb4)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func ravensArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Lamar Jackson")
        let qb2 = Cell(pos: "QB2", play: "Robert Griffin III")
        let rb1 = Cell(pos: "RB1", play: "Mark Ingram")
        let rb2 = Cell(pos: "RB2", play: "J.K. Dobbins", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "Gus Edwards")
        let wr1 = Cell(pos: "WR1", play: "Marquise Brown")
        let wr2 = Cell(pos: "WR2", play: "Willie Snead lV")
        let wr3 = Cell(pos: "WR3", play: "Miles Boykin")
        let wr4 = Cell(pos: "WR4", play: "Devin Duvernay", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Mark Andrews")
        let te2 = Cell(pos: "TE2", play: "Nick Boyle")
        let k = Cell(pos: "K", play: "Justin Tucker")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func steelersArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Ben Roethlisberger")
        let qb2 = Cell(pos: "QB2", play: "Mason Rudolph")
        let rb1 = Cell(pos: "RB1", play: "James Conner")
        let rb2 = Cell(pos: "RB2", play: "Jaylen Samuels")
        let rb3 = Cell(pos: "RB3", play: "Anthony McFarland Jr.", rookie: "R")
        let rb4 = Cell(pos: "RB4", play: "Benny Snell Jr.")
        let wr1 = Cell(pos: "WR1", play: "JuJu Smith-Schuster")
        let wr2 = Cell(pos: "WR2", play: "Diontae Johnson")
        let wr3 = Cell(pos: "WR3", play: "James Washington")
        let wr4 = Cell(pos: "WR4", play: "Chase Claypool", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Eric Ebron")
        let te2 = Cell(pos: "TE2", play: "Vance McDonald")
        let k = Cell(pos: "K", play: "Chris Boswell")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(rb4)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // AFC South
    func coltsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Philip Rivers")
        let qb2 = Cell(pos: "QB2", play: "Jacoby Brissett")
        let qb3 = Cell(pos: "QB3", play: "Jacob Eason", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Marlon Mack")
        let rb2 = Cell(pos: "RB2", play: "Jonathan Taylor", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "Nyheim Hines")
        let rb4 = Cell(pos: "RB4", play: "Jordan Wilkins")
        let wr1 = Cell(pos: "WR1", play: "T.Y. Hilton")
        let wr2 = Cell(pos: "WR2", play: "Zach Pascal")
        let wr3 = Cell(pos: "WR3", play: "Parris Campbell")
        let wr4 = Cell(pos: "WR4", play: "Michael Pittman Jr.", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Jack Doyle")
        let te2 = Cell(pos: "TE2", play: "Trey Burton")
        let k = Cell(pos: "K", play: "Chase McLaughlin")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(qb3)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(rb4)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func jaguarsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Gardner Minshew II")
        let qb2 = Cell(pos: "QB2", play: "Mike Glennon")
        let qb3 = Cell(pos: "QB3", play: "Jake Luton", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Leonard Fournette")
        let rb2 = Cell(pos: "RB2", play: "Ryquell Armstead")
        let rb3 = Cell(pos: "RB3", play: "Chris Thompson")
        let wr1 = Cell(pos: "WR1", play: "DJ Chark Jr.")
        let wr2 = Cell(pos: "WR2", play: "Dede Westbrook")
        let wr3 = Cell(pos: "WR3", play: "Laviska Shenault Jr.", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Chris Conley")
        let te1 = Cell(pos: "TE1", play: "Tyler Eifert")
        let te2 = Cell(pos: "TE2", play: "Josh Oliver")
        let k = Cell(pos: "K", play: "Josh Lambo")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(qb3)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func texansArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Deshaun Watson")
        let qb2 = Cell(pos: "QB2", play: "AJ McCarron")
        let rb1 = Cell(pos: "RB1", play: "David Johnson")
        let rb2 = Cell(pos: "RB2", play: "Duke Johnson Jr.")
        let rb3 = Cell(pos: "RB3", play: "Gregory Howell Jr.")
        let wr1 = Cell(pos: "WR1", play: "Will Fuller V")
        let wr2 = Cell(pos: "WR2", play: "Brandin Cooks")
        let wr3 = Cell(pos: "WR3", play: "Kenny Stills")
        let wr4 = Cell(pos: "WR4", play: "Randall Cobb")
        let te1 = Cell(pos: "TE1", play: "Darren Fells")
        let te2 = Cell(pos: "TE2", play: "Jordan Akins")
        let k = Cell(pos: "K", play: "Ka'imi Fairbairn")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func titansArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Ryan Tannehill")
        let qb2 = Cell(pos: "QB2", play: "Logan Woodside")
        let qb3 = Cell(pos: "QB3", play: "Cole McDonald", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Derrick Henry")
        let rb2 = Cell(pos: "RB2", play: "Darrynton Evans", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "David Fluellen")
        let wr1 = Cell(pos: "WR1", play: "A.J. Brown")
        let wr2 = Cell(pos: "WR2", play: "Adam Humphries")
        let wr3 = Cell(pos: "WR3", play: "Corey Davis")
        let wr4 = Cell(pos: "WR4", play: "Kalif Raymond")
        let te1 = Cell(pos: "TE1", play: "Jonnu Smith")
        let te2 = Cell(pos: "TE2", play: "Anthony Firkser")
        let k = Cell(pos: "K", play: "Greg Joseph")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(qb3)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // AFC West
    func broncosArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Drew Lock")
        let qb2 = Cell(pos: "QB2", play: "Brandon Allen")
        let rb1 = Cell(pos: "RB1", play: "Melvin Gordon III")
        let rb2 = Cell(pos: "RB2", play: "Phillip Lindsay")
        let rb3 = Cell(pos: "RB3", play: "Royce Freeman")
        let wr1 = Cell(pos: "WR1", play: "Courtland Sutton")
        let wr2 = Cell(pos: "WR2", play: "Jerry Jeudy", rookie: "R")
        let wr3 = Cell(pos: "WR3", play: "DaeSean Hamilton")
        let wr4 = Cell(pos: "WR4", play: "KJ Hamler", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Noah Fant")
        let te2 = Cell(pos: "TE2", play: "Jeff Hauerman")
        let k = Cell(pos: "K", play: "Brandon McManus")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func chargersArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Tyrod Taylor")
        let qb2 = Cell(pos: "QB2", play: "Easton Stick")
        let qb3 = Cell(pos: "QB3", play: "Justin Herbert", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Austin Ekeler")
        let rb2 = Cell(pos: "RB2", play: "Justin Jackson")
        let rb3 = Cell(pos: "RB3", play: "Joshua Kelley", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Keenan Allen")
        let wr2 = Cell(pos: "WR2", play: "Mike Williams")
        let wr3 = Cell(pos: "WR3", play: "Andre Patton")
        let wr4 = Cell(pos: "WR4", play: "Joe Reed", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Hunter Henry")
        let te2 = Cell(pos: "TE2", play: "Virgil Green")
        let k = Cell(pos: "K", play: "Michael Badgley")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(qb3)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func chiefsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Patrick Mahomes")
        let qb2 = Cell(pos: "QB2", play: "Chad Henne")
        let rb1 = Cell(pos: "RB1", play: "Damien Williams")
        let rb2 = Cell(pos: "RB2", play: "Clyde Edwards-Helaire", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "Darwin Thompson")
        let wr1 = Cell(pos: "WR1", play: "Tyreek Hill")
        let wr2 = Cell(pos: "WR2", play: "Sammy Watkins")
        let wr3 = Cell(pos: "WR3", play: "Mecole Hardman")
        let wr4 = Cell(pos: "WR4", play: "Byron Pringle")
        let te1 = Cell(pos: "TE1", play: "Travis Kelce")
        let te2 = Cell(pos: "TE2", play: "Deon Yelder")
        let k = Cell(pos: "K", play: "Harrison Butker")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func raidersArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Derek Carr")
        let qb2 = Cell(pos: "QB2", play: "Marcus Mariota")
        let rb1 = Cell(pos: "RB1", play: "Josh Jacobs")
        let rb2 = Cell(pos: "RB2", play: "Jalen Richard")
        let rb3 = Cell(pos: "RB3", play: "Lynn Bowden Jr.", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Tyrell Williams")
        let wr2 = Cell(pos: "WR2", play: "Henry Ruggs III", rookie: "R")
        let wr3 = Cell(pos: "WR3", play: "Hunter Renfrow")
        let wr4 = Cell(pos: "WR4", play: "Nelson Agholor")
        let te1 = Cell(pos: "TE1", play: "Darren Waller")
        let te2 = Cell(pos: "TE2", play: "Foster Moreau")
        let k = Cell(pos: "K", play: "Daniel Carlson")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // NFC East
    func cowboysArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Dak Prescott")
        let qb2 = Cell(pos: "QB2", play: "Andy Dalton")
        let qb3 = Cell(pos: "QB3", play: "Ben Dinucci", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Ezekiel Elliott")
        let rb2 = Cell(pos: "RB2", play: "Tony Pollard")
        let rb3 = Cell(pos: "RB3", play: "Jamize Olawale")
        let wr1 = Cell(pos: "WR1", play: "Amari Cooper")
        let wr2 = Cell(pos: "WR2", play: "Michael Gallup")
        let wr3 = Cell(pos: "WR3", play: "CeeCee Lamb", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Devin Smith")
        let te1 = Cell(pos: "TE1", play: "Blake Jarwin")
        let te2 = Cell(pos: "TE2", play: "Dalton Schultz")
        let k = Cell(pos: "K", play: "Greg Zuerlein")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(qb3)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func eaglesArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Carson Wentz")
        let qb2 = Cell(pos: "QB2", play: "Jalen Hurts", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Miles Sanders")
        let rb2 = Cell(pos: "RB2", play: "Boston Scott")
        let rb3 = Cell(pos: "RB3", play: "Elijah Holyfield")
        let wr1 = Cell(pos: "WR1", play: "Alshon Jeffery")
        let wr2 = Cell(pos: "WR2", play: "DeSean Jackson")
        let wr3 = Cell(pos: "WR3", play: "Marquise Goodwin")
        let wr4 = Cell(pos: "WR4", play: "Jalen Reagor", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Zach Ertz")
        let te2 = Cell(pos: "TE2", play: "Dallas Goedert")
        let k = Cell(pos: "K", play: "Jake Elliott")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func giantsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Daniel Jones")
        let qb2 = Cell(pos: "QB2", play: "Cooper Rush")
        let rb1 = Cell(pos: "RB1", play: "Saquon Barkley")
        let rb2 = Cell(pos: "RB2", play: "Elijhaa Penny")
        let rb3 = Cell(pos: "RB3", play: "Wayne Gallman Jr.")
        let wr1 = Cell(pos: "WR1", play: "Sterling Shepard")
        let wr2 = Cell(pos: "WR2", play: "Golden Tate")
        let wr3 = Cell(pos: "WR3", play: "Darius Slayton")
        let wr4 = Cell(pos: "WR4", play: "Cody Core")
        let te1 = Cell(pos: "TE1", play: "Evan Engram")
        let te2 = Cell(pos: "TE2", play: "Kaden Smith")
        let k = Cell(pos: "K", play: "Aldrick Rosas")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func redskinsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Dwayne Haskins")
        let qb2 = Cell(pos: "QB2", play: "Kyle Allen")
        let rb1 = Cell(pos: "RB1", play: "Derrius Guice")
        let rb2 = Cell(pos: "RB2", play: "Adrian Peterson")
        let rb3 = Cell(pos: "RB3", play: "Peyton Barber")
        let wr1 = Cell(pos: "WR1", play: "Terry McLaurin")
        let wr2 = Cell(pos: "WR2", play: "Kelvin Harmon")
        let wr3 = Cell(pos: "WR3", play: "Trey Quinn")
        let wr4 = Cell(pos: "WR4", play: "Steven Sims Jr.")
        let te1 = Cell(pos: "TE1", play: "Jeremy Sprinkle")
        let te2 = Cell(pos: "TE2", play: "Thaddeus Moss")
        let k = Cell(pos: "K", play: "Dustin Hopkins")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // NFC North
    func bearsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Mitchell Trubisky")
        let qb2 = Cell(pos: "QB2", play: "Nick Foles")
        let rb1 = Cell(pos: "RB1", play: "David Montgomery")
        let rb2 = Cell(pos: "RB2", play: "Tarik Cohen")
        let rb3 = Cell(pos: "RB3", play: "Ryan Nall")
        let wr1 = Cell(pos: "WR1", play: "Allen Robinson II")
        let wr2 = Cell(pos: "WR2", play: "Anthony Miller")
        let wr3 = Cell(pos: "WR3", play: "Javon Wims")
        let wr4 = Cell(pos: "WR4", play: "Cordarrelle Patterson")
        let te1 = Cell(pos: "TE1", play: "Jimmy Graham")
        let te2 = Cell(pos: "TE2", play: "Cole Kmet", rookie: "R")
        let k = Cell(pos: "K", play: "Eddy Pineiro")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func lionsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Matthew Stafford")
        let qb2 = Cell(pos: "QB2", play: "Chase Daniel")
        let rb1 = Cell(pos: "RB1", play: "Kerryon Johnson")
        let rb2 = Cell(pos: "RB2", play: "D'Andre Swift", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "Jason Huntley", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Kenny Golladay")
        let wr2 = Cell(pos: "WR2", play: "Marvin Jones Jr.")
        let wr3 = Cell(pos: "WR3", play: "Danny Amendola")
        let wr4 = Cell(pos: "WR4", play: "Geronimo Allison")
        let te1 = Cell(pos: "TE1", play: "T.J. Hockenson")
        let te2 = Cell(pos: "TE2", play: "Jesse James")
        let k = Cell(pos: "K", play: "Matt Prater")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func packersArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Aaron Rodgers")
        let qb2 = Cell(pos: "QB2", play: "Jordan Love", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Aaron Jones")
        let rb2 = Cell(pos: "RB2", play: "A.J. Dillon", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "Jamaal Williams")
        let wr1 = Cell(pos: "WR1", play: "Davante Adams")
        let wr2 = Cell(pos: "WR2", play: "Devin Funchess")
        let wr3 = Cell(pos: "WR3", play: "Alan Lazard")
        let wr4 = Cell(pos: "WR4", play: "Marquez Valdes-Scantling")
        let te1 = Cell(pos: "TE1", play: "Jace Sternberger")
        let te2 = Cell(pos: "TE2", play: "Marcedes Lewis")
        let k = Cell(pos: "K", play: "Mason Crosby")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func vikingsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Kirk Cousins")
        let qb2 = Cell(pos: "QB2", play: "Sean Mannion")
        let qb3 = Cell(pos: "QB3", play: "Nate Stanley", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Dalvin Cook")
        let rb2 = Cell(pos: "RB2", play: "Alexander Mattison")
        let rb3 = Cell(pos: "RB3", play: "Mike Boone")
        let wr1 = Cell(pos: "WR1", play: "Adam Thielen")
        let wr2 = Cell(pos: "WR2", play: "Justin Jefferson", rookie: "R")
        let wr3 = Cell(pos: "WR3", play: "Bisi Johnson")
        let wr4 = Cell(pos: "WR4", play: "Tajae Sharpe")
        let te1 = Cell(pos: "TE1", play: "Kyle Rudolph")
        let te2 = Cell(pos: "TE2", play: "Irv Smith Jr.")
        let k = Cell(pos: "K", play: "Dan Bailey")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(qb3)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // NFC South
    func buccaneersArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Tom Brady")
        let qb2 = Cell(pos: "QB2", play: "Blaine Gabbert")
        let rb1 = Cell(pos: "RB1", play: "Ronald Jones II")
        let rb2 = Cell(pos: "RB2", play: "Ke'Shawn Vaughn", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "Dare Ogunbowale")
        let wr1 = Cell(pos: "WR1", play: "Mike Evans")
        let wr2 = Cell(pos: "WR2", play: "Chris Godwin")
        let wr3 = Cell(pos: "WR3", play: "Scotty Miller")
        let wr4 = Cell(pos: "WR4", play: "Justin Watson")
        let te1 = Cell(pos: "TE1", play: "Rob Gronkowski")
        let te2 = Cell(pos: "TE2", play: "O.J. Howard")
        let k = Cell(pos: "K", play: "Matt Gay")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func falconsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Matt Ryan")
        let qb2 = Cell(pos: "QB2", play: "Matt Schaub")
        let qb3 = Cell(pos: "QB3", play: "Kurt Benkert")
        let rb1 = Cell(pos: "RB1", play: "Todd Gurley")
        let rb2 = Cell(pos: "RB2", play: "Ito Smith")
        let rb3 = Cell(pos: "RB3", play: "Brian Hill")
        let rb4 = Cell(pos: "RB4", play: "Qadree Ollison")
        let wr1 = Cell(pos: "WR1", play: "Julio Jones")
        let wr2 = Cell(pos: "WR2", play: "Calvin Ridley")
        let wr3 = Cell(pos: "WR3", play: "Russell Gage")
        let wr4 = Cell(pos: "WR4", play: "Laquon Treadwell")
        let te1 = Cell(pos: "TE1", play: "Hayden Hurst")
        let te2 = Cell(pos: "TE2", play: "Khari Lee")
        let te3 = Cell(pos: "TE3", play: "Jaeden Graham")
        let te4 = Cell(pos: "TE4", play: "Luke Stocker")
        let k = Cell(pos: "K", play: "Younghoe Koo")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(qb3)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(rb4)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(te4)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func panthersArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Teddy Bridgewater")
        let qb2 = Cell(pos: "QB2", play: "Will Grier")
        let rb1 = Cell(pos: "RB1", play: "Christian McCaffrey")
        let rb2 = Cell(pos: "RB2", play: "Jordan Scarlett")
        let rb3 = Cell(pos: "RB3", play: "Reggie Bonnafon")
        let wr1 = Cell(pos: "WR1", play: "DJ Moore")
        let wr2 = Cell(pos: "WR2", play: "Robby Anderson")
        let wr3 = Cell(pos: "WR3", play: "Curtis Samuel")
        let wr4 = Cell(pos: "WR4", play: "Pharoh Cooper")
        let te1 = Cell(pos: "TE1", play: "Ian Thomas")
        let te2 = Cell(pos: "TE2", play: "Chris Manhertz")
        let k = Cell(pos: "K", play: "Joey Slye")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func saintsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Drew Brees")
        let qb2 = Cell(pos: "QB2", play: "Taysom Hill")
        let rb1 = Cell(pos: "RB1", play: "Alvin Kamara")
        let rb2 = Cell(pos: "RB2", play: "Latavius Murray")
        let rb3 = Cell(pos: "RB3", play: "Dwayne Washington")
        let wr1 = Cell(pos: "WR1", play: "Michael Thomas")
        let wr2 = Cell(pos: "WR2", play: "Emmanuel Sanders")
        let wr3 = Cell(pos: "WR3", play: "Tre'Quan Smith")
        let wr4 = Cell(pos: "WR4", play: "Deonte Harris")
        let te1 = Cell(pos: "TE1", play: "Jared Cook")
        let te2 = Cell(pos: "TE2", play: "Josh Hill")
        let k = Cell(pos: "K", play: "Wil Lutz")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // NFC West
    func _49ersArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Jimmy Garoppolo")
        let qb2 = Cell(pos: "QB2", play: "Nick Mullens")
        let rb1 = Cell(pos: "RB1", play: "Raheem Mostert")
        let rb2 = Cell(pos: "RB2", play: "Tevin Coleman")
        let rb3 = Cell(pos: "RB3", play: "Jerick McKinnon")
        let wr1 = Cell(pos: "WR1", play: "Deebo Samuel")
        let wr2 = Cell(pos: "WR2", play: "Brandon Aiyuk", rookie: "R")
        let wr3 = Cell(pos: "WR3", play: "Kendrick Bourne")
        let wr4 = Cell(pos: "WR4", play: "Jalen Hurd")
        let te1 = Cell(pos: "TE1", play: "George Kittle")
        let te2 = Cell(pos: "TE2", play: "Ross Dwelley")
        let k = Cell(pos: "K", play: "Robbie Gould")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func cardinalsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Kyler Murray")
        let qb2 = Cell(pos: "QB2", play: "Brett Hundley")
        let qb3 = Cell(pos: "QB3", play: "Chris Streveler")
        let rb1 = Cell(pos: "RB1", play: "Kenyan Drake")
        let rb2 = Cell(pos: "RB2", play: "Chase Edmonds")
        let rb3 = Cell(pos: "RB3", play: "Eno Benjamin")
        let rb4 = Cell(pos: "RB4", play: "D.J. Foster")
        let wr1 = Cell(pos: "WR1", play: "DeAndre Hopkins")
        let wr2 = Cell(pos: "WR2", play: "Christian Kirk")
        let wr3 = Cell(pos: "WR3", play: "Larry Fitzgerald")
        let wr4 = Cell(pos: "WR4", play: "KeeSean Johnson")
        let te1 = Cell(pos: "TE1", play: "Maxx Williams")
        let te2 = Cell(pos: "TE2", play: "Dan Arnold")
        let te3 = Cell(pos: "TE3", play: "Darrell Daniels")
        let te4 = Cell(pos: "TE4", play: "Ryan Becker")
        let k = Cell(pos: "K", play: "Zane Gonzalez")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(qb3)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(rb4)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(te4)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func ramsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Jared Goff")
        let qb2 = Cell(pos: "QB2", play: "John Wolford")
        let rb1 = Cell(pos: "RB1", play: "Cam Akers", rookie: "R")
        let rb2 = Cell(pos: "RB2", play: "Malcolm Brown")
        let rb3 = Cell(pos: "RB3", play: "Darrell Henderson")
        let wr1 = Cell(pos: "WR1", play: "Cooper Kupp")
        let wr2 = Cell(pos: "WR2", play: "Robert Woods")
        let wr3 = Cell(pos: "WR3", play: "Josh Reynolds")
        let wr4 = Cell(pos: "WR4", play: "Van Jefferson", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Tyler Higbee")
        let te2 = Cell(pos: "TE2", play: "Gerald Everett")
        let k = Cell(pos: "K", play: "Sam Sloman")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func seahawksArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Russell Wilson")
        let qb2 = Cell(pos: "QB2", play: "Geno Smith")
        let rb1 = Cell(pos: "RB1", play: "Chris Carson")
        let rb2 = Cell(pos: "RB2", play: "Carlos Hyde")
        let rb3 = Cell(pos: "RB3", play: "Rashaad Penny")
        let wr1 = Cell(pos: "WR1", play: "Tyler Lockett")
        let wr2 = Cell(pos: "WR2", play: "DK Metcalf")
        let wr3 = Cell(pos: "WR3", play: "David Moore")
        let wr4 = Cell(pos: "WR4", play: "Phillip Dorsett II")
        let te1 = Cell(pos: "TE1", play: "Greg Olsen")
        let te2 = Cell(pos: "TE2", play: "Jacob Hollister")
        let k = Cell(pos: "K", play: "Jason Myers")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
}

