//
//  Database_2021.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 9/7/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import Foundation
import UIKit

class Database_2021 {
    
    static let shared = Database_2021()
    
    var leagueNames: [String]
    var teamNames: [String]
    var leagues: [[String]]
    
    var objectsArray: [[String]] = [["Overall Top 200", "Top 30 Rookies"], ["Top 30 Quarterbacks", "Top 80 Running Backs", "Top 80 Wide Receivers", "Top 30 Tight Ends", "Top 20 Defenses", "Top 15 Kickers"], ["Depth Charts"], ["My Leagues"], ["Reset Draft"]
    ]
    
    func createDict(_leagueNames: [String], _leagues: [[String]]) -> [String : [String]] {
        var storedDict = [String : [String]]()
        var i = 0
        for ln in _leagueNames {
            storedDict[ln] = _leagues[i]
            i+=1
        }
        return storedDict
    }
    
    // All players and leagues 2021
    fileprivate var allPlayers: [PlayerData]
    
    // All Players Save, Write and Read
    fileprivate func playerDataURL() -> URL {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in:.userDomainMask).last!
        return documentDirectoryURL.appendingPathComponent("playerData_2021.json")
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
        return documentDirectoryURL.appendingPathComponent("leagueNamesData_2021.json")
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
    
    // Added Team Names Save, Write, and Read
    fileprivate func teamNamesDataURL() -> URL {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in:.userDomainMask).last!
        return documentDirectoryURL.appendingPathComponent("teamNamesData_2021.json")
    }
    
    fileprivate func teamNamesWriteToDisk() {
        do {
            let dataNames = try JSONEncoder().encode(teamNames)
            try dataNames.write(to: teamNamesDataURL())
        } catch let error as NSError {
            NSLog("Error reading file: \(error.localizedDescription)")
        }
    }
    
    fileprivate func teamNamesReadFromDisk() -> [String]? {
        let fileTeamNamesURL = teamNamesDataURL()
        guard FileManager.default.fileExists(atPath: fileTeamNamesURL.path) else {
            return nil
        }
        do {
            let fileContents = try Data(contentsOf: fileTeamNamesURL)
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
        return documentDirectoryURL.appendingPathComponent("leaguesData_2021.json")
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
    
    // Executed when a change is made
    func changeMade() {
        playersWriteToDisk()
        leagueNamesWriteToDisk()
        teamNamesWriteToDisk()
        leaguesDataWriteToDisk()
    }
    
    // Reset the draft
    func resetDraft() {
        allPlayers = [
            PlayerData(num: 1, numPosPick: 1, numRookie: 0, name: "Christian McCaffrey", team: "CAR", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 2, numPosPick: 2, numRookie: 0, name: "Dalvin Cook", team: "MIN", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 3, numPosPick: 3, numRookie: 0, name: "Saquon Barkley", team: "NYG", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 4, numPosPick: 4, numRookie: 0, name: "Derrick Henry", team: "TEN", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 5, numPosPick: 1, numRookie: 0, name: "Tyreek Hill", team: "KC", position: "WR", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 6, numPosPick: 5, numRookie: 0, name: "Alvin Kamara", team: "NO", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 7, numPosPick: 2, numRookie: 0, name: "Stefon Diggs", team: "BUF", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 8, numPosPick: 6, numRookie: 0, name: "Nick Chubb", team: "CLE", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 9, numPosPick: 7, numRookie: 0, name: "Jonathan Taylor", team: "IND", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 10, numPosPick: 3, numRookie: 0, name: "DeAndre Hopkins", team: "ARI", position: "WR", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 11, numPosPick: 1, numRookie: 0, name: "Travis Kelce", team: "KC", position: "TE", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 12, numPosPick: 4, numRookie: 0, name: "Davante Adams", team: "GB", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 13, numPosPick: 8, numRookie: 0, name: "Ezekiel Elliott", team: "DAL", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 14, numPosPick: 9, numRookie: 0, name: "Aaron Jones", team: "GB", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 15, numPosPick: 10, numRookie: 0, name: "Austin Ekeler", team: "LAC", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 16, numPosPick: 5, numRookie: 0, name: "Calvin Ridley", team: "ATL", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 17, numPosPick: 11, numRookie: 1, name: "Najee Harris", team: "PIT", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: true),
            PlayerData(num: 18, numPosPick: 12, numRookie: 0, name: "Joe Mixon", team: "CIN", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 19, numPosPick: 6, numRookie: 0, name: "D.K. Metcalf", team: "SEA", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 20, numPosPick: 2, numRookie: 0, name: "George Kittle", team: "SF", position: "TE", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 21, numPosPick: 1, numRookie: 0, name: "Patrick Mahomes", team: "KC", position: "QB", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 22, numPosPick: 13, numRookie: 0, name: "Cam Akers", team: "LAR", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 23, numPosPick: 7, numRookie: 0, name: "Justin Jefferson", team: "MIN", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 24, numPosPick: 8, numRookie: 0, name: "Keenan Allen", team: "LAC", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 25, numPosPick: 14, numRookie: 0, name: "Antonio Gibson", team: "WAS", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 26, numPosPick: 15, numRookie: 0, name: "Clyde Edwards-Helaire", team: "KC", position: "RB", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 27, numPosPick: 2, numRookie: 0, name: "Josh Allen", team: "BUF", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 28, numPosPick: 9, numRookie: 0, name: "Chris Godwin", team: "TB", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 29, numPosPick: 3, numRookie: 0, name: "Kyler Murray", team: "ARI", position: "QB", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 30, numPosPick: 16, numRookie: 0, name: "Miles Sanders", team: "PHI", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 31, numPosPick: 10, numRookie: 0, name: "Terry McLaurin", team: "WAS", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 32, numPosPick: 11, numRookie: 0, name: "A.J. Brown", team: "TEN", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 33, numPosPick: 4, numRookie: 0, name: "Dak Prescott", team: "DAL", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 34, numPosPick: 3, numRookie: 0, name: "Darren Waller", team: "LV", position: "TE", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 35, numPosPick: 17, numRookie: 0, name: "D'Andre Swift", team: "DET", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 36, numPosPick: 12, numRookie: 0, name: "Allen Robinson II", team: "CHI", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 37, numPosPick: 18, numRookie: 0, name: "J.K. Dobbins", team: "BAL", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 38, numPosPick: 5, numRookie: 0, name: "Lamar Jackson", team: "BAL", position: "QB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 39, numPosPick: 19, numRookie: 0, name: "Chris Carson", team: "SEA", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 40, numPosPick: 13, numRookie: 0, name: "Julio Jones", team: "TEN", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 41, numPosPick: 14, numRookie: 0, name: "Mike Evans", team: "TB", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 42, numPosPick: 15, numRookie: 0, name: "Michael Thomas", team: "NO", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 43, numPosPick: 20, numRookie: 0, name: "Raheem Mostert", team: "SF", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 44, numPosPick: 16, numRookie: 0, name: "CeeDee Lamb", team: "DAL", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 45, numPosPick: 17, numRookie: 0, name: "Robert Woods", team: "LAR", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 46, numPosPick: 6, numRookie: 0, name: "Russell Wilson", team: "SEA", position: "QB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 47, numPosPick: 18, numRookie: 0, name: "D.J. Moore", team: "CAR", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 48, numPosPick: 7, numRookie: 0, name: "Aaron Rodgers", team: "GB", position: "QB", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 49, numPosPick: 19, numRookie: 0, name: "Amari Cooper", team: "DAL", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 50, numPosPick: 21, numRookie: 0, name: "David Montgomery", team: "CH", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 51, numPosPick: 22, numRookie: 0, name: "Josh Jacobs", team: "LV", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 52, numPosPick: 20, numRookie: 0, name: "Adam Thielen", team: "MIN", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 53, numPosPick: 21, numRookie: 0, name: "Cooper Kupp", team: "LAR", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 54, numPosPick: 22, numRookie: 0, name: "Kenny Golladay", team: "NYG", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 55, numPosPick: 4, numRookie: 0, name: "Mark Andrews", team: "BAL", position: "TE", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 56, numPosPick: 23, numRookie: 0, name: "Myles Gaskin", team: "MIA", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 57, numPosPick: 23, numRookie: 0, name: "D.J. Chark Jr.", team: "JAC", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 58, numPosPick: 5, numRookie: 0, name: "T.J. Hockenson", team: "DET", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 59, numPosPick: 8, numRookie: 0, name: "Deshaun Watson", team: "HOU", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 60, numPosPick: 24, numRookie: 0, name: "Diontae Johnson", team: "PIT", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 61, numPosPick: 24, numRookie: 0, name: "Kareem Hunt", team: "CLE", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 62, numPosPick: 25, numRookie: 0, name: "Tee Higgins", team: "CIN", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 63, numPosPick: 26, numRookie: 0, name: "Brandon Aiyuk", team: "SF", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 64, numPosPick: 25, numRookie: 0, name: "Chase Edmonds", team: "ARI", position: "RB", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 65, numPosPick: 26, numRookie: 2, name: "Travis Etienne", team: "JAC", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: true),
            PlayerData(num: 66, numPosPick: 9, numRookie: 0, name: "Justin Herbert", team: "LAC", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 67, numPosPick: 27, numRookie: 0, name: "Melvin Gordon III", team: "DEN", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 68, numPosPick: 10, numRookie: 0, name: "Matthew Stafford", team: "LAR", position: "QB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 69, numPosPick: 28, numRookie: 0, name: "James Robinson", team: "JAC", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 70, numPosPick: 27, numRookie: 0, name: "Tyler Lockett", team: "SEA", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 71, numPosPick: 28, numRookie: 0, name: "Odell Beckham Jr.", team: "CLE", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 72, numPosPick: 29, numRookie: 0, name: "Courtland Sutton", team: "DEN", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 73, numPosPick: 11, numRookie: 0, name: "Tom Brady", team: "TB", position: "QB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 74, numPosPick: 30, numRookie: 0, name: "Chase Claypool", team: "PIT", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 75, numPosPick: 31, numRookie: 0, name: "JuJu Smith-Schuster", team: "PIT", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 76, numPosPick: 32, numRookie: 3, name: "Ja'Marr Chase", team: "CIN", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: true),
            PlayerData(num: 77, numPosPick: 29, numRookie: 0, name: "Mike Davis", team: "ATL", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 78, numPosPick: 30, numRookie: 0, name: "Gus Edwards", team: "BAL", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 79, numPosPick: 31, numRookie: 0, name: "Damien Harris", team: "NE", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 80, numPosPick: 32, numRookie: 0, name: "Ronald Jones II", team: "TB", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 81, numPosPick: 6, numRookie: 0, name: "Dallas Goedert", team: "PHI", position: "TE", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 82, numPosPick: 33, numRookie: 4, name: "Trey Sermon", team: "SF", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: true),
            PlayerData(num: 83, numPosPick: 7, numRookie: 0, name: "Noah Fant", team: "DEN", position: "TE", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 84, numPosPick: 34, numRookie: 0, name: "Zack Moss", team: "BUF", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 85, numPosPick: 35, numRookie: 5, name: "Javonte Williams", team: "DEN", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: true),
            PlayerData(num: 86, numPosPick: 33, numRookie: 0, name: "Will Fuller V", team: "MIA", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 87, numPosPick: 36, numRookie: 0, name: "James Conner", team: "ARI", position: "RB", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 88, numPosPick: 34, numRookie: 0, name: "Robby Anderson", team: "CAR", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 89, numPosPick: 35, numRookie: 0, name: "Brandin Cooks", team: "HOU", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 90, numPosPick: 36, numRookie: 0, name: "Tyler Boyd", team: "CIN", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 91, numPosPick: 8, numRookie: 6, name: "Kyle Pitts", team: "ATL", position: "TE", byeWeek: 6, isTopPlayer: true, isRookie: true),
            PlayerData(num: 92, numPosPick: 37, numRookie: 0, name: "Curtis Samuel", team: "WAS", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 93, numPosPick: 9, numRookie: 0, name: "Tyler Higbee", team: "LAR", position: "TE", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 94, numPosPick: 37, numRookie: 0, name: "Leonard Fournette", team: "TB", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 95, numPosPick: 38, numRookie: 0, name: "Deebo Samuel", team: "SF", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 96, numPosPick: 39, numRookie: 0, name: "Jerry Jeudy", team: "DEN", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 97, numPosPick: 38, numRookie: 0, name: "Tony Pollard", team: "DAL", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 98, numPosPick: 39, numRookie: 0, name: "Giovani Bernard", team: "TB", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 99, numPosPick: 40, numRookie: 0, name: "David Johnson", team: "HOU", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 100, numPosPick: 41, numRookie: 0, name: "Devin Singletary", team: "BUF", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 101, numPosPick: 40, numRookie: 0, name: "Jarvis Landry", team: "CLE", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 102, numPosPick: 10, numRookie: 0, name: "Irv Smith Jr.", team: "MIN", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 103, numPosPick: 11, numRookie: 0, name: "Logan Thomas", team: "WAS", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 104, numPosPick: 12, numRookie: 0, name: "Jalen Hurts", team: "PHI", position: "QB", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 105, numPosPick: 13, numRookie: 0, name: "Ryan Tannehill", team: "TEN", position: "QB", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 106, numPosPick: 41, numRookie: 0, name: "Marquise Brown", team: "BAL", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 107, numPosPick: 42, numRookie: 0, name: "AJ Dillon", team: "GB", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 108, numPosPick: 42, numRookie: 0, name: "DeVante Parker", team: "MIA", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 109, numPosPick: 43, numRookie: 0, name: "Michael Pittman Jr.", team: "IND", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 110, numPosPick: 43, numRookie: 7, name: "Michael Carter", team: "NYJ", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: true),
            PlayerData(num: 111, numPosPick: 12, numRookie: 0, name: "Robert Tonyan", team: "GB", position: "TE", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 112, numPosPick: 44, numRookie: 8, name: "DeVonta Smith", team: "PHI", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: true),
            PlayerData(num: 113, numPosPick: 45, numRookie: 0, name: "T.Y. Hilton", team: "IND", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 114, numPosPick: 46, numRookie: 0, name: "Laviska Shenault Jr.", team: "JAC", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 115, numPosPick: 44, numRookie: 0, name: "Kenyan Drake", team: "LV", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 116, numPosPick: 47, numRookie: 0, name: "Michael Gallup", team: "DAL", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 117, numPosPick: 14, numRookie: 0, name: "Kirk Cousins", team: "MIN", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 118, numPosPick: 15, numRookie: 0, name: "Joe Burrow", team: "CIN", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 119, numPosPick: 13, numRookie: 0, name: "Mike Gesicki", team: "MIA", position: "TE", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 120, numPosPick: 48, numRookie: 0, name: "Mecole Hardman", team: "KC", position: "WR", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 121, numPosPick: 45, numRookie: 0, name: "Rashaad Penny", team: "SEA", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 122, numPosPick: 14, numRookie: 0, name: "Hunter Henry", team: "NE", position: "TE", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 123, numPosPick: 46, numRookie: 0, name: "Jamaal Williams", team: "DET", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 124, numPosPick: 16, numRookie: 9, name: "Trevor Lawrence", team: "JAC", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: true),
            PlayerData(num: 125, numPosPick: 47, numRookie: 0, name: "Nyheim Hines", team: "IND", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 126, numPosPick: 17, numRookie: 0, name: "Matt Ryan", team: "ATL", position: "QB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 127, numPosPick: 49, numRookie: 0, name: "Corey Davis", team: "NYJ", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 128, numPosPick: 50, numRookie: 0, name: "Mike Williams", team: "LAC", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 129, numPosPick: 51, numRookie: 0, name: "Marvin Jones Jr.", team: "JAC", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 130, numPosPick: 48, numRookie: 0, name: "Latavius Murray", team: "NO", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 131, numPosPick: 52, numRookie: 0, name: "Antonio Brown", team: "TB", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 132, numPosPick: 49, numRookie: 0, name: "Darrell Henderson", team: "LAR", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 133, numPosPick: 15, numRookie: 0, name: "Evan Engram", team: "NYG", position: "TE", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 134, numPosPick: 18, numRookie: 0, name: "Daniel Jones", team: "NYG", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 135, numPosPick: 19, numRookie: 0, name: "Ben Roethlisberger", team: "PIT", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 136, numPosPick: 53, numRookie: 0, name: "John Brown", team: "LV", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 137, numPosPick: 50, numRookie: 0, name: "Phillip Lindsay", team: "HOU", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 138, numPosPick: 16, numRookie: 0, name: "Jonnu Smith", team: "NE", position: "TE", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 139, numPosPick: 54, numRookie: 0, name: "Henry Ruggs III", team: "LV", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 140, numPosPick: 55, numRookie: 0, name: "Jalen Reagor", team: "PHI", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 141, numPosPick: 56, numRookie: 10, name: "Jaylen Waddle", team: "MIA", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: true),
            PlayerData(num: 142, numPosPick: 17, numRookie: 0, name: "Blake Jarwin", team: "DAL", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 143, numPosPick: 20, numRookie: 0, name: "Ryan Fitzpatrick", team: "WASH", position: "QB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 144, numPosPick: 51, numRookie: 0, name: "Tarik Cohen", team: "CHI", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 145, numPosPick: 57, numRookie: 0, name: "Cole Beasley", team: "BUF", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 146, numPosPick: 52, numRookie: 0, name: "J.D. McKissic", team: "WAS", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 147, numPosPick: 58, numRookie: 0, name: "Nelson Agholor", team: "NE", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 148, numPosPick: 53, numRookie: 0, name: "Alexander Mattison", team: "MIN", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 149, numPosPick: 59, numRookie: 0, name: "Darnell Mooney", team: "CHI", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 150, numPosPick: 18, numRookie: 0, name: "Jared Cook", team: "LAC", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 151, numPosPick: 60, numRookie: 0, name: "Jamison Crowder", team: "NYJ", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 152, numPosPick: 61, numRookie: 0, name: "Christian Kirk", team: "ARI", position: "WR", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 153, numPosPick: 19, numRookie: 0, name: "Hayden Hurst", team: "ATL", position: "TE", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 154, numPosPick: 54, numRookie: 0, name: "James White", team: "NE", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 155, numPosPick: 55, numRookie: 0, name: "Tevin Coleman", team: "NYJ", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 156, numPosPick: 21, numRookie: 0, name: "Carson Wentz", team: "IND", position: "QB", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 157, numPosPick: 62, numRookie: 0, name: "Parris Campbell", team: "IND", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 158, numPosPick: 1, numRookie: 0, name: "Los Angeles Rams", team: "LAR", position: "DST", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 159, numPosPick: 22, numRookie: 0, name: "Baker Mayfield", team: "CLE", position: "QB", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 160, numPosPick: 2, numRookie: 0, name: "Washington Football Team", team: "WAS", position: "DST", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 161, numPosPick: 63, numRookie: 0, name: "Sterling Shepard", team: "NYG", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 162, numPosPick: 3, numRookie: 0, name: "Pittsburgh Steelers", team: "PIT", position: "DST", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 163, numPosPick: 20, numRookie: 0, name: "Rob Gronkowski", team: "TB", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 164, numPosPick: 56, numRookie: 0, name: "Darrel Williams", team: "KC", position: "RB", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 165, numPosPick: 64, numRookie: 0, name: "Darius Slayton", team: "NYG", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 166, numPosPick: 65, numRookie: 11, name: "Rashod Bateman", team: "BAL", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: true),
            PlayerData(num: 167, numPosPick: 4, numRookie: 0, name: "Baltimore Ravens", team: "BALT", position: "DST", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 168, numPosPick: 66, numRookie: 0, name: "Denzel Mims", team: "NYJ", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 169, numPosPick: 67, numRookie: 0, name: "Josh Reynolds", team: "TEN", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 170, numPosPick: 23, numRookie: 0, name: "Tua Tagovailoa", team: "MIA", position: "QB", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 171, numPosPick: 24, numRookie: 0, name: "Derek Carr", team: "LV", position: "QB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 172, numPosPick: 21, numRookie: 0, name: "Cole Kmet", team: "CHI", position: "TE", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 173, numPosPick: 68, numRookie: 0, name: "Breshad Perriman", team: "DET", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 174, numPosPick: 5, numRookie: 0, name: "San Francisco 49ers", team: "SF", position: "DST", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 175, numPosPick: 22, numRookie: 0, name: "Dawson Knox", team: "BUF", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 176, numPosPick: 6, numRookie: 0, name: "Tampa Bay Buccaneers", team: "TB", position: "DST", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 177, numPosPick: 23, numRookie: 0, name: "Austin Hooper", team: "CLE", position: "TE", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 178, numPosPick: 1, numRookie: 0, name: "Justin Tucker", team: "BAL", position: "K", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 179, numPosPick: 69, numRookie: 0, name: "Emmanuel Sanders", team: "BUF", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 180, numPosPick: 2, numRookie: 0, name: "Younghoe Koo", team: "ATL", position: "K", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 181, numPosPick: 25, numRookie: 0, name: "Sam Darnold", team: "CAR", position: "QB", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 182, numPosPick: 26, numRookie: 12, name: "Trey Lance", team: "SF", position: "QB", byeWeek: 6, isTopPlayer: true, isRookie: true),
            PlayerData(num: 183, numPosPick: 70, numRookie: 13, name: "Elijah Moore", team: "NYJ", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: true),
            PlayerData(num: 184, numPosPick: 71, numRookie: 0, name: "Tim Patrick", team: "DEN", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 185, numPosPick: 27, numRookie: 14, name: "Justin Fields", team: "CHI", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: true),
            PlayerData(num: 186, numPosPick: 24, numRookie: 0, name: "Gerald Everett", team: "SEA", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 187, numPosPick: 3, numRookie: 0, name: "Harrison Butker", team: "KC", position: "K", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 188, numPosPick: 28, numRookie: 0, name: "Jameis Winston", team: "NO", position: "QB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 189, numPosPick: 72, numRookie: 0, name: "Tyrell Williams", team: "DET", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 190, numPosPick: 57, numRookie: 0, name: "Marlon Mack", team: "IND", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 191, numPosPick: 73, numRookie: 0, name: "Jalen Guyton", team: "LAC", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 192, numPosPick: 25, numRookie: 0, name: "Zach Ertz", team: "PHI", position: "TE", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 193, numPosPick: 7, numRookie: 0, name: "Indianapolis Colts", team: "IND", position: "DST", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 194, numPosPick: 4, numRookie: 0, name: "Greg Zuerlein", team: "DAL", position: "K", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 195, numPosPick: 8, numRookie: 0, name: "New Orleans Saints", team: "NO", position: "DST", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 196, numPosPick: 29, numRookie: 0, name: "Teddy Bridgewater", team: "DEN", position: "QB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 197, numPosPick: 58, numRookie: 0, name: "Benny Snell Jr.", team: "PIT", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 198, numPosPick: 74, numRookie: 0, name: "Gabriel Davis", team: "BUF", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 199, numPosPick: 5, numRookie: 0, name: "Jason Sanders", team: "MIA", position: "K", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 200, numPosPick: 26, numRookie: 0, name: "Eric Ebron", team: "PIT", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
            
            // Not top 200 but still top in position.
            // Rest of Quarterbacks.
            PlayerData(num: 0, numPosPick: 30, numRookie: 0, name: "Cam Newton", team: "NE", position: "QB", byeWeek: 14, isTopPlayer: false, isRookie: false),
            
            // Rest of Running Backs.
            PlayerData(num: 0, numPosPick: 59, numRookie: 15, name: "Rhamondre Stevenson", team: "NE", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 60, numRookie: 16, name: "Kenneth Gainwell", team: "PHI", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 61, numRookie: 0, name: "Mark Ingram II", team: "HOU", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 62, numRookie: 0, name: "Salvon Ahmed", team: "MIA", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 63, numRookie: 0, name: "Carlos Hyde", team: "JAC", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 64, numRookie: 0, name: "Jeff Wilson Jr.", team: "SF", position: "RB", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 65, numRookie: 0, name: "Sony Michel", team: "NE", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 66, numRookie: 0, name: "Joshua Kelley", team: "LAC", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 67, numRookie: 0, name: "Justin Jackson", team: "LAC", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 68, numRookie: 0, name: "Justice Hill", team: "BAL", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 69, numRookie: 17, name: "Javian Hawkins", team: "ATL", position: "RB", byeWeek: 6, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 70, numRookie: 0, name: "Darrynton Evans", team: "TEN", position: "RB", byeWeek: 13, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 71, numRookie: 0, name: "Adrian Peterson", team: "DET", position: "RB", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 72, numRookie: 0, name: "Ke'Shawn Vaughn", team: "TB", position: "RB", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 73, numRookie: 18, name: "Chuba Hubbard", team: "CAR", position: "RB", byeWeek: 13, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 74, numRookie: 0, name: "Todd Gurley II", team: "FA", position: "RB", byeWeek: 0, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 75, numRookie: 0, name: "Wayne Gallman", team: "SF", position: "RB", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 76, numRookie: 0, name: "Kylin Hill", team: "GB", position: "RB", byeWeek: 13, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 77, numRookie: 0, name: "Larry Rountree III", team: "LAC", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 78, numRookie: 0, name: "Elijah Mitchell", team: "SF", position: "RB", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 79, numRookie: 0, name: "Le'Veon Bell", team: "KC", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 80, numRookie: 0, name: "Boston Scott", team: "PHI", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: false),
            
            // Rest of Wide Receivers.
            PlayerData(num: 0, numPosPick: 75, numRookie: 0, name: "Bryan Edwards", team: "LV", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 76, numRookie: 0, name: "Allen Lazard", team: "GB", position: "WR", byeWeek: 13, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 77, numRookie: 0, name: "KJ Hamler", team: "DEN", position: "WR", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 78, numRookie: 19, name: "Rondale Moore", team: "ARI", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 79, numRookie: 0, name: "Marquez Valdes-Scantling", team: "GB", position: "WR", byeWeek: 13, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 80, numRookie: 0, name: "Sammy Watkins", team: "BAL", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
            
            // Rest of Tight Ends.
            PlayerData(num: 0, numPosPick: 27, numRookie: 0, name: "Adam Trautman", team: "NO", position: "TE", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 28, numRookie: 0, name: "Anthony Firkser", team: "TEN", position: "TE", byeWeek: 13, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 29, numRookie: 0, name: "Dan Arnold", team: "CAR", position: "TE", byeWeek: 13, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 30, numRookie: 0, name: "Mo Alie-Cox", team: "IND", position: "TE", byeWeek: 14, isTopPlayer: false, isRookie: false),
            
            // Rest of Defenses
            PlayerData(num: 0, numPosPick: 9, numRookie: 0, name: "New England Patriots", team: "NE", position: "DST", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 10, numRookie: 0, name: "Buffalo Bills", team: "BUF", position: "DST", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 11, numRookie: 0, name: "Miami Dolphins", team: "MIA", position: "DST", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 12, numRookie: 0, name: "Cleveland Browns", team: "CLE", position: "DST", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 13, numRookie: 0, name: "Kansas City Chiefs", team: "KC", position: "DST", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 14, numRookie: 0, name: "Los Angeles Chargers", team: "LAC", position: "DST", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 15, numRookie: 0, name: "Denver Broncos", team: "DEN", position: "DST", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 16, numRookie: 0, name: "Chicago Bears", team: "CHI", position: "DST", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 17, numRookie: 0, name: "Green Bay Packers", team: "GB", position: "DST", byeWeek: 13, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 18, numRookie: 0, name: "Minnesota Vikings", team: "MIN", position: "DST", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 19, numRookie: 0, name: "Seattle Seahawks", team: "SEA", position: "DST", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 20, numRookie: 0, name: "New York Giants", team: "NYG", position: "DST", byeWeek: 10, isTopPlayer: false, isRookie: false),
            
            // Rest of Kickers
            PlayerData(num: 0, numPosPick: 6, numRookie: 0, name: "Wil Lutz", team: "NO", position: "K", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 7, numRookie: 0, name: "Rodrigo Blankenship", team: "IND", position: "K", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 8, numRookie: 0, name: "Matt Prater", team: "ARI", position: "K", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 9, numRookie: 0, name: "Tyler Bass", team: "BUF", position: "K", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 10, numRookie: 0, name: "Robbie Gould", team: "SF", position: "K", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 11, numRookie: 0, name: "Jason Myers", team: "SEA", position: "K", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 12, numRookie: 0, name: "Ryan Succop", team: "TB", position: "K", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 13, numRookie: 0, name: "Michael Badgley", team: "LAC", position: "K", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 14, numRookie: 0, name: "Mason Crosby", team: "GB", position: "K", byeWeek: 13, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 15, numRookie: 0, name: "Jake Elliott", team: "PHI", position: "K", byeWeek: 14, isTopPlayer: false, isRookie: false),
            
            // Rest of Rookies
            PlayerData(num: 0, numPosPick: 0, numRookie: 20, name: "Zach Wilson", team: "NYJ", position: "QB", byeWeek: 6, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 0, numRookie: 21, name: "Amon-Ra St. Brown", team: "DET", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 0, numRookie: 22, name: "Nico Collins", team: "HOU", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 0, numRookie: 23, name: "Terrace Marshall Jr.", team: "CAR", position: "WR", byeWeek: 13, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 0, numRookie: 24, name: "Kadarius Toney", team: "NYG", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 0, numRookie: 25, name: "Amari Rodgers", team: "GB", position: "WR", byeWeek: 13, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 0, numRookie: 26, name: "Josh Palmer", team: "LAC", position: "WR", byeWeek: 7, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 0, numRookie: 27, name: "Dyami Brown", team: "WAS", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 0, numRookie: 28, name: "D’Wayne Eskridge", team: "SEA", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 0, numRookie: 29, name: "Pat Freiermuth", team: "PIT", position: "TE", byeWeek: 7, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 0, numRookie: 30, name: "Mac Jones", team: "NE", position: "QB", byeWeek: 14, isTopPlayer: false, isRookie: true)
        ]
        changeMade()
    }
    
    init() {
        allPlayers = [PlayerData]()
        leagueNames = [String]()
        teamNames = [String]()
        leagues = [[String]]()
        
        if let league_names = leagueNamesReadFromDisk() {
            leagueNames = league_names
        }
        
        if let team_names = teamNamesReadFromDisk() {
            teamNames = team_names
        }
        
        if let _leagues = leaguesDataReadFromDisk() {
            leagues = _leagues
        }
        
        if let _allPlayers = playersReadFromDisk() {
            allPlayers = _allPlayers
        } else {
            allPlayers = [
                PlayerData(num: 1, numPosPick: 1, numRookie: 0, name: "Christian McCaffrey", team: "CAR", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 2, numPosPick: 2, numRookie: 0, name: "Dalvin Cook", team: "MIN", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 3, numPosPick: 3, numRookie: 0, name: "Saquon Barkley", team: "NYG", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 4, numPosPick: 4, numRookie: 0, name: "Derrick Henry", team: "TEN", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 5, numPosPick: 1, numRookie: 0, name: "Tyreek Hill", team: "KC", position: "WR", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 6, numPosPick: 5, numRookie: 0, name: "Alvin Kamara", team: "NO", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 7, numPosPick: 2, numRookie: 0, name: "Stefon Diggs", team: "BUF", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 8, numPosPick: 6, numRookie: 0, name: "Nick Chubb", team: "CLE", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 9, numPosPick: 7, numRookie: 0, name: "Jonathan Taylor", team: "IND", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 10, numPosPick: 3, numRookie: 0, name: "DeAndre Hopkins", team: "ARI", position: "WR", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 11, numPosPick: 1, numRookie: 0, name: "Travis Kelce", team: "KC", position: "TE", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 12, numPosPick: 4, numRookie: 0, name: "Davante Adams", team: "GB", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 13, numPosPick: 8, numRookie: 0, name: "Ezekiel Elliott", team: "DAL", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 14, numPosPick: 9, numRookie: 0, name: "Aaron Jones", team: "GB", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 15, numPosPick: 10, numRookie: 0, name: "Austin Ekeler", team: "LAC", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 16, numPosPick: 5, numRookie: 0, name: "Calvin Ridley", team: "ATL", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 17, numPosPick: 11, numRookie: 1, name: "Najee Harris", team: "PIT", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: true),
                PlayerData(num: 18, numPosPick: 12, numRookie: 0, name: "Joe Mixon", team: "CIN", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 19, numPosPick: 6, numRookie: 0, name: "D.K. Metcalf", team: "SEA", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 20, numPosPick: 2, numRookie: 0, name: "George Kittle", team: "SF", position: "TE", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 21, numPosPick: 1, numRookie: 0, name: "Patrick Mahomes", team: "KC", position: "QB", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 22, numPosPick: 13, numRookie: 0, name: "Cam Akers", team: "LAR", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 23, numPosPick: 7, numRookie: 0, name: "Justin Jefferson", team: "MIN", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 24, numPosPick: 8, numRookie: 0, name: "Keenan Allen", team: "LAC", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 25, numPosPick: 14, numRookie: 0, name: "Antonio Gibson", team: "WAS", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 26, numPosPick: 15, numRookie: 0, name: "Clyde Edwards-Helaire", team: "KC", position: "RB", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 27, numPosPick: 2, numRookie: 0, name: "Josh Allen", team: "BUF", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 28, numPosPick: 9, numRookie: 0, name: "Chris Godwin", team: "TB", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 29, numPosPick: 3, numRookie: 0, name: "Kyler Murray", team: "ARI", position: "QB", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 30, numPosPick: 16, numRookie: 0, name: "Miles Sanders", team: "PHI", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 31, numPosPick: 10, numRookie: 0, name: "Terry McLaurin", team: "WAS", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 32, numPosPick: 11, numRookie: 0, name: "A.J. Brown", team: "TEN", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 33, numPosPick: 4, numRookie: 0, name: "Dak Prescott", team: "DAL", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 34, numPosPick: 3, numRookie: 0, name: "Darren Waller", team: "LV", position: "TE", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 35, numPosPick: 17, numRookie: 0, name: "D'Andre Swift", team: "DET", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 36, numPosPick: 12, numRookie: 0, name: "Allen Robinson II", team: "CHI", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 37, numPosPick: 18, numRookie: 0, name: "J.K. Dobbins", team: "BAL", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 38, numPosPick: 5, numRookie: 0, name: "Lamar Jackson", team: "BAL", position: "QB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 39, numPosPick: 19, numRookie: 0, name: "Chris Carson", team: "SEA", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 40, numPosPick: 13, numRookie: 0, name: "Julio Jones", team: "TEN", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 41, numPosPick: 14, numRookie: 0, name: "Mike Evans", team: "TB", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 42, numPosPick: 15, numRookie: 0, name: "Michael Thomas", team: "NO", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 43, numPosPick: 20, numRookie: 0, name: "Raheem Mostert", team: "SF", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 44, numPosPick: 16, numRookie: 0, name: "CeeDee Lamb", team: "DAL", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 45, numPosPick: 17, numRookie: 0, name: "Robert Woods", team: "LAR", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 46, numPosPick: 6, numRookie: 0, name: "Russell Wilson", team: "SEA", position: "QB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 47, numPosPick: 18, numRookie: 0, name: "D.J. Moore", team: "CAR", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 48, numPosPick: 7, numRookie: 0, name: "Aaron Rodgers", team: "GB", position: "QB", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 49, numPosPick: 19, numRookie: 0, name: "Amari Cooper", team: "DAL", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 50, numPosPick: 21, numRookie: 0, name: "David Montgomery", team: "CH", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 51, numPosPick: 22, numRookie: 0, name: "Josh Jacobs", team: "LV", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 52, numPosPick: 20, numRookie: 0, name: "Adam Thielen", team: "MIN", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 53, numPosPick: 21, numRookie: 0, name: "Cooper Kupp", team: "LAR", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 54, numPosPick: 22, numRookie: 0, name: "Kenny Golladay", team: "NYG", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 55, numPosPick: 4, numRookie: 0, name: "Mark Andrews", team: "BAL", position: "TE", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 56, numPosPick: 23, numRookie: 0, name: "Myles Gaskin", team: "MIA", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 57, numPosPick: 23, numRookie: 0, name: "D.J. Chark Jr.", team: "JAC", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 58, numPosPick: 5, numRookie: 0, name: "T.J. Hockenson", team: "DET", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 59, numPosPick: 8, numRookie: 0, name: "Deshaun Watson", team: "HOU", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 60, numPosPick: 24, numRookie: 0, name: "Diontae Johnson", team: "PIT", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 61, numPosPick: 24, numRookie: 0, name: "Kareem Hunt", team: "CLE", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 62, numPosPick: 25, numRookie: 0, name: "Tee Higgins", team: "CIN", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 63, numPosPick: 26, numRookie: 0, name: "Brandon Aiyuk", team: "SF", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 64, numPosPick: 25, numRookie: 0, name: "Chase Edmonds", team: "ARI", position: "RB", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 65, numPosPick: 26, numRookie: 2, name: "Travis Etienne", team: "JAC", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: true),
                PlayerData(num: 66, numPosPick: 9, numRookie: 0, name: "Justin Herbert", team: "LAC", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 67, numPosPick: 27, numRookie: 0, name: "Melvin Gordon III", team: "DEN", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 68, numPosPick: 10, numRookie: 0, name: "Matthew Stafford", team: "LAR", position: "QB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 69, numPosPick: 28, numRookie: 0, name: "James Robinson", team: "JAC", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 70, numPosPick: 27, numRookie: 0, name: "Tyler Lockett", team: "SEA", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 71, numPosPick: 28, numRookie: 0, name: "Odell Beckham Jr.", team: "CLE", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 72, numPosPick: 29, numRookie: 0, name: "Courtland Sutton", team: "DEN", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 73, numPosPick: 11, numRookie: 0, name: "Tom Brady", team: "TB", position: "QB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 74, numPosPick: 30, numRookie: 0, name: "Chase Claypool", team: "PIT", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 75, numPosPick: 31, numRookie: 0, name: "JuJu Smith-Schuster", team: "PIT", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 76, numPosPick: 32, numRookie: 3, name: "Ja'Marr Chase", team: "CIN", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: true),
                PlayerData(num: 77, numPosPick: 29, numRookie: 0, name: "Mike Davis", team: "ATL", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 78, numPosPick: 30, numRookie: 0, name: "Gus Edwards", team: "BAL", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 79, numPosPick: 31, numRookie: 0, name: "Damien Harris", team: "NE", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 80, numPosPick: 32, numRookie: 0, name: "Ronald Jones II", team: "TB", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 81, numPosPick: 6, numRookie: 0, name: "Dallas Goedert", team: "PHI", position: "TE", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 82, numPosPick: 33, numRookie: 4, name: "Trey Sermon", team: "SF", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: true),
                PlayerData(num: 83, numPosPick: 7, numRookie: 0, name: "Noah Fant", team: "DEN", position: "TE", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 84, numPosPick: 34, numRookie: 0, name: "Zack Moss", team: "BUF", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 85, numPosPick: 35, numRookie: 5, name: "Javonte Williams", team: "DEN", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: true),
                PlayerData(num: 86, numPosPick: 33, numRookie: 0, name: "Will Fuller V", team: "MIA", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 87, numPosPick: 36, numRookie: 0, name: "James Conner", team: "ARI", position: "RB", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 88, numPosPick: 34, numRookie: 0, name: "Robby Anderson", team: "CAR", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 89, numPosPick: 35, numRookie: 0, name: "Brandin Cooks", team: "HOU", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 90, numPosPick: 36, numRookie: 0, name: "Tyler Boyd", team: "CIN", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 91, numPosPick: 8, numRookie: 6, name: "Kyle Pitts", team: "ATL", position: "TE", byeWeek: 6, isTopPlayer: true, isRookie: true),
                PlayerData(num: 92, numPosPick: 37, numRookie: 0, name: "Curtis Samuel", team: "WAS", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 93, numPosPick: 9, numRookie: 0, name: "Tyler Higbee", team: "LAR", position: "TE", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 94, numPosPick: 37, numRookie: 0, name: "Leonard Fournette", team: "TB", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 95, numPosPick: 38, numRookie: 0, name: "Deebo Samuel", team: "SF", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 96, numPosPick: 39, numRookie: 0, name: "Jerry Jeudy", team: "DEN", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 97, numPosPick: 38, numRookie: 0, name: "Tony Pollard", team: "DAL", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 98, numPosPick: 39, numRookie: 0, name: "Giovani Bernard", team: "TB", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 99, numPosPick: 40, numRookie: 0, name: "David Johnson", team: "HOU", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 100, numPosPick: 41, numRookie: 0, name: "Devin Singletary", team: "BUF", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 101, numPosPick: 40, numRookie: 0, name: "Jarvis Landry", team: "CLE", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 102, numPosPick: 10, numRookie: 0, name: "Irv Smith Jr.", team: "MIN", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 103, numPosPick: 11, numRookie: 0, name: "Logan Thomas", team: "WAS", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 104, numPosPick: 12, numRookie: 0, name: "Jalen Hurts", team: "PHI", position: "QB", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 105, numPosPick: 13, numRookie: 0, name: "Ryan Tannehill", team: "TEN", position: "QB", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 106, numPosPick: 41, numRookie: 0, name: "Marquise Brown", team: "BAL", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 107, numPosPick: 42, numRookie: 0, name: "AJ Dillon", team: "GB", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 108, numPosPick: 42, numRookie: 0, name: "DeVante Parker", team: "MIA", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 109, numPosPick: 43, numRookie: 0, name: "Michael Pittman Jr.", team: "IND", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 110, numPosPick: 43, numRookie: 7, name: "Michael Carter", team: "NYJ", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: true),
                PlayerData(num: 111, numPosPick: 12, numRookie: 0, name: "Robert Tonyan", team: "GB", position: "TE", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 112, numPosPick: 44, numRookie: 8, name: "DeVonta Smith", team: "PHI", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: true),
                PlayerData(num: 113, numPosPick: 45, numRookie: 0, name: "T.Y. Hilton", team: "IND", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 114, numPosPick: 46, numRookie: 0, name: "Laviska Shenault Jr.", team: "JAC", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 115, numPosPick: 44, numRookie: 0, name: "Kenyan Drake", team: "LV", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 116, numPosPick: 47, numRookie: 0, name: "Michael Gallup", team: "DAL", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 117, numPosPick: 14, numRookie: 0, name: "Kirk Cousins", team: "MIN", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 118, numPosPick: 15, numRookie: 0, name: "Joe Burrow", team: "CIN", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 119, numPosPick: 13, numRookie: 0, name: "Mike Gesicki", team: "MIA", position: "TE", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 120, numPosPick: 48, numRookie: 0, name: "Mecole Hardman", team: "KC", position: "WR", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 121, numPosPick: 45, numRookie: 0, name: "Rashaad Penny", team: "SEA", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 122, numPosPick: 14, numRookie: 0, name: "Hunter Henry", team: "NE", position: "TE", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 123, numPosPick: 46, numRookie: 0, name: "Jamaal Williams", team: "DET", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 124, numPosPick: 16, numRookie: 9, name: "Trevor Lawrence", team: "JAC", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: true),
                PlayerData(num: 125, numPosPick: 47, numRookie: 0, name: "Nyheim Hines", team: "IND", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 126, numPosPick: 17, numRookie: 0, name: "Matt Ryan", team: "ATL", position: "QB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 127, numPosPick: 49, numRookie: 0, name: "Corey Davis", team: "NYJ", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 128, numPosPick: 50, numRookie: 0, name: "Mike Williams", team: "LAC", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 129, numPosPick: 51, numRookie: 0, name: "Marvin Jones Jr.", team: "JAC", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 130, numPosPick: 48, numRookie: 0, name: "Latavius Murray", team: "NO", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 131, numPosPick: 52, numRookie: 0, name: "Antonio Brown", team: "TB", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 132, numPosPick: 49, numRookie: 0, name: "Darrell Henderson", team: "LAR", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 133, numPosPick: 15, numRookie: 0, name: "Evan Engram", team: "NYG", position: "TE", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 134, numPosPick: 18, numRookie: 0, name: "Daniel Jones", team: "NYG", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 135, numPosPick: 19, numRookie: 0, name: "Ben Roethlisberger", team: "PIT", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 136, numPosPick: 53, numRookie: 0, name: "John Brown", team: "LV", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 137, numPosPick: 50, numRookie: 0, name: "Phillip Lindsay", team: "HOU", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 138, numPosPick: 16, numRookie: 0, name: "Jonnu Smith", team: "NE", position: "TE", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 139, numPosPick: 54, numRookie: 0, name: "Henry Ruggs III", team: "LV", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 140, numPosPick: 55, numRookie: 0, name: "Jalen Reagor", team: "PHI", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 141, numPosPick: 56, numRookie: 10, name: "Jaylen Waddle", team: "MIA", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: true),
                PlayerData(num: 142, numPosPick: 17, numRookie: 0, name: "Blake Jarwin", team: "DAL", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 143, numPosPick: 20, numRookie: 0, name: "Ryan Fitzpatrick", team: "WASH", position: "QB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 144, numPosPick: 51, numRookie: 0, name: "Tarik Cohen", team: "CHI", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 145, numPosPick: 57, numRookie: 0, name: "Cole Beasley", team: "BUF", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 146, numPosPick: 52, numRookie: 0, name: "J.D. McKissic", team: "WAS", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 147, numPosPick: 58, numRookie: 0, name: "Nelson Agholor", team: "NE", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 148, numPosPick: 53, numRookie: 0, name: "Alexander Mattison", team: "MIN", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 149, numPosPick: 59, numRookie: 0, name: "Darnell Mooney", team: "CHI", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 150, numPosPick: 18, numRookie: 0, name: "Jared Cook", team: "LAC", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 151, numPosPick: 60, numRookie: 0, name: "Jamison Crowder", team: "NYJ", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 152, numPosPick: 61, numRookie: 0, name: "Christian Kirk", team: "ARI", position: "WR", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 153, numPosPick: 19, numRookie: 0, name: "Hayden Hurst", team: "ATL", position: "TE", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 154, numPosPick: 54, numRookie: 0, name: "James White", team: "NE", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 155, numPosPick: 55, numRookie: 0, name: "Tevin Coleman", team: "NYJ", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 156, numPosPick: 21, numRookie: 0, name: "Carson Wentz", team: "IND", position: "QB", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 157, numPosPick: 62, numRookie: 0, name: "Parris Campbell", team: "IND", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 158, numPosPick: 1, numRookie: 0, name: "Los Angeles Rams", team: "LAR", position: "DST", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 159, numPosPick: 22, numRookie: 0, name: "Baker Mayfield", team: "CLE", position: "QB", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 160, numPosPick: 2, numRookie: 0, name: "Washington Football Team", team: "WAS", position: "DST", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 161, numPosPick: 63, numRookie: 0, name: "Sterling Shepard", team: "NYG", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 162, numPosPick: 3, numRookie: 0, name: "Pittsburgh Steelers", team: "PIT", position: "DST", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 163, numPosPick: 20, numRookie: 0, name: "Rob Gronkowski", team: "TB", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 164, numPosPick: 56, numRookie: 0, name: "Darrel Williams", team: "KC", position: "RB", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 165, numPosPick: 64, numRookie: 0, name: "Darius Slayton", team: "NYG", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 166, numPosPick: 65, numRookie: 11, name: "Rashod Bateman", team: "BAL", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: true),
                PlayerData(num: 167, numPosPick: 4, numRookie: 0, name: "Baltimore Ravens", team: "BALT", position: "DST", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 168, numPosPick: 66, numRookie: 0, name: "Denzel Mims", team: "NYJ", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 169, numPosPick: 67, numRookie: 0, name: "Josh Reynolds", team: "TEN", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 170, numPosPick: 23, numRookie: 0, name: "Tua Tagovailoa", team: "MIA", position: "QB", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 171, numPosPick: 24, numRookie: 0, name: "Derek Carr", team: "LV", position: "QB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 172, numPosPick: 21, numRookie: 0, name: "Cole Kmet", team: "CHI", position: "TE", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 173, numPosPick: 68, numRookie: 0, name: "Breshad Perriman", team: "DET", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 174, numPosPick: 5, numRookie: 0, name: "San Francisco 49ers", team: "SF", position: "DST", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 175, numPosPick: 22, numRookie: 0, name: "Dawson Knox", team: "BUF", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 176, numPosPick: 6, numRookie: 0, name: "Tampa Bay Buccaneers", team: "TB", position: "DST", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 177, numPosPick: 23, numRookie: 0, name: "Austin Hooper", team: "CLE", position: "TE", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 178, numPosPick: 1, numRookie: 0, name: "Justin Tucker", team: "BAL", position: "K", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 179, numPosPick: 69, numRookie: 0, name: "Emmanuel Sanders", team: "BUF", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 180, numPosPick: 2, numRookie: 0, name: "Younghoe Koo", team: "ATL", position: "K", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 181, numPosPick: 25, numRookie: 0, name: "Sam Darnold", team: "CAR", position: "QB", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 182, numPosPick: 26, numRookie: 12, name: "Trey Lance", team: "SF", position: "QB", byeWeek: 6, isTopPlayer: true, isRookie: true),
                PlayerData(num: 183, numPosPick: 70, numRookie: 13, name: "Elijah Moore", team: "NYJ", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: true),
                PlayerData(num: 184, numPosPick: 71, numRookie: 0, name: "Tim Patrick", team: "DEN", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 185, numPosPick: 27, numRookie: 14, name: "Justin Fields", team: "CHI", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: true),
                PlayerData(num: 186, numPosPick: 24, numRookie: 0, name: "Gerald Everett", team: "SEA", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 187, numPosPick: 3, numRookie: 0, name: "Harrison Butker", team: "KC", position: "K", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 188, numPosPick: 28, numRookie: 0, name: "Jameis Winston", team: "NO", position: "QB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 189, numPosPick: 72, numRookie: 0, name: "Tyrell Williams", team: "DET", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 190, numPosPick: 57, numRookie: 0, name: "Marlon Mack", team: "IND", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 191, numPosPick: 73, numRookie: 0, name: "Jalen Guyton", team: "LAC", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 192, numPosPick: 25, numRookie: 0, name: "Zach Ertz", team: "PHI", position: "TE", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 193, numPosPick: 7, numRookie: 0, name: "Indianapolis Colts", team: "IND", position: "DST", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 194, numPosPick: 4, numRookie: 0, name: "Greg Zuerlein", team: "DAL", position: "K", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 195, numPosPick: 8, numRookie: 0, name: "New Orleans Saints", team: "NO", position: "DST", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 196, numPosPick: 29, numRookie: 0, name: "Teddy Bridgewater", team: "DEN", position: "QB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 197, numPosPick: 58, numRookie: 0, name: "Benny Snell Jr.", team: "PIT", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 198, numPosPick: 74, numRookie: 0, name: "Gabriel Davis", team: "BUF", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 199, numPosPick: 5, numRookie: 0, name: "Jason Sanders", team: "MIA", position: "K", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 200, numPosPick: 26, numRookie: 0, name: "Eric Ebron", team: "PIT", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
                
                // Not top 200 but still top in position.
                // Rest of Quarterbacks.
                PlayerData(num: 0, numPosPick: 30, numRookie: 0, name: "Cam Newton", team: "NE", position: "QB", byeWeek: 14, isTopPlayer: false, isRookie: false),
                
                // Rest of Running Backs.
                PlayerData(num: 0, numPosPick: 59, numRookie: 15, name: "Rhamondre Stevenson", team: "NE", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 60, numRookie: 16, name: "Kenneth Gainwell", team: "PHI", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 61, numRookie: 0, name: "Mark Ingram II", team: "HOU", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 62, numRookie: 0, name: "Salvon Ahmed", team: "MIA", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 63, numRookie: 0, name: "Carlos Hyde", team: "JAC", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 64, numRookie: 0, name: "Jeff Wilson Jr.", team: "SF", position: "RB", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 65, numRookie: 0, name: "Sony Michel", team: "NE", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 66, numRookie: 0, name: "Joshua Kelley", team: "LAC", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 67, numRookie: 0, name: "Justin Jackson", team: "LAC", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 68, numRookie: 0, name: "Justice Hill", team: "BAL", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 69, numRookie: 17, name: "Javian Hawkins", team: "ATL", position: "RB", byeWeek: 6, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 70, numRookie: 0, name: "Darrynton Evans", team: "TEN", position: "RB", byeWeek: 13, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 71, numRookie: 0, name: "Adrian Peterson", team: "DET", position: "RB", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 72, numRookie: 0, name: "Ke'Shawn Vaughn", team: "TB", position: "RB", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 73, numRookie: 18, name: "Chuba Hubbard", team: "CAR", position: "RB", byeWeek: 13, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 74, numRookie: 0, name: "Todd Gurley II", team: "FA", position: "RB", byeWeek: 0, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 75, numRookie: 0, name: "Wayne Gallman", team: "SF", position: "RB", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 76, numRookie: 0, name: "Kylin Hill", team: "GB", position: "RB", byeWeek: 13, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 77, numRookie: 0, name: "Larry Rountree III", team: "LAC", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 78, numRookie: 0, name: "Elijah Mitchell", team: "SF", position: "RB", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 79, numRookie: 0, name: "Le'Veon Bell", team: "KC", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 80, numRookie: 0, name: "Boston Scott", team: "PHI", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: false),
                
                // Rest of Wide Receivers.
                PlayerData(num: 0, numPosPick: 75, numRookie: 0, name: "Bryan Edwards", team: "LV", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 76, numRookie: 0, name: "Allen Lazard", team: "GB", position: "WR", byeWeek: 13, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 77, numRookie: 0, name: "KJ Hamler", team: "DEN", position: "WR", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 78, numRookie: 19, name: "Rondale Moore", team: "ARI", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 79, numRookie: 0, name: "Marquez Valdes-Scantling", team: "GB", position: "WR", byeWeek: 13, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 80, numRookie: 0, name: "Sammy Watkins", team: "BAL", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
                
                // Rest of Tight Ends.
                PlayerData(num: 0, numPosPick: 27, numRookie: 0, name: "Adam Trautman", team: "NO", position: "TE", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 28, numRookie: 0, name: "Anthony Firkser", team: "TEN", position: "TE", byeWeek: 13, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 29, numRookie: 0, name: "Dan Arnold", team: "CAR", position: "TE", byeWeek: 13, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 30, numRookie: 0, name: "Mo Alie-Cox", team: "IND", position: "TE", byeWeek: 14, isTopPlayer: false, isRookie: false),
                
                // Rest of Defenses
                PlayerData(num: 0, numPosPick: 9, numRookie: 0, name: "New England Patriots", team: "NE", position: "DST", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 10, numRookie: 0, name: "Buffalo Bills", team: "BUF", position: "DST", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 11, numRookie: 0, name: "Miami Dolphins", team: "MIA", position: "DST", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 12, numRookie: 0, name: "Cleveland Browns", team: "CLE", position: "DST", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 13, numRookie: 0, name: "Kansas City Chiefs", team: "KC", position: "DST", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 14, numRookie: 0, name: "Los Angeles Chargers", team: "LAC", position: "DST", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 15, numRookie: 0, name: "Denver Broncos", team: "DEN", position: "DST", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 16, numRookie: 0, name: "Chicago Bears", team: "CHI", position: "DST", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 17, numRookie: 0, name: "Green Bay Packers", team: "GB", position: "DST", byeWeek: 13, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 18, numRookie: 0, name: "Minnesota Vikings", team: "MIN", position: "DST", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 19, numRookie: 0, name: "Seattle Seahawks", team: "SEA", position: "DST", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 20, numRookie: 0, name: "New York Giants", team: "NYG", position: "DST", byeWeek: 10, isTopPlayer: false, isRookie: false),
                
                // Rest of Kickers
                PlayerData(num: 0, numPosPick: 6, numRookie: 0, name: "Wil Lutz", team: "NO", position: "K", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 7, numRookie: 0, name: "Rodrigo Blankenship", team: "IND", position: "K", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 8, numRookie: 0, name: "Matt Prater", team: "ARI", position: "K", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 9, numRookie: 0, name: "Tyler Bass", team: "BUF", position: "K", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 10, numRookie: 0, name: "Robbie Gould", team: "SF", position: "K", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 11, numRookie: 0, name: "Jason Myers", team: "SEA", position: "K", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 12, numRookie: 0, name: "Ryan Succop", team: "TB", position: "K", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 13, numRookie: 0, name: "Michael Badgley", team: "LAC", position: "K", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 14, numRookie: 0, name: "Mason Crosby", team: "GB", position: "K", byeWeek: 13, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 15, numRookie: 0, name: "Jake Elliott", team: "PHI", position: "K", byeWeek: 14, isTopPlayer: false, isRookie: false),
                
                // Rest of Rookies
                PlayerData(num: 0, numPosPick: 0, numRookie: 20, name: "Zach Wilson", team: "NYJ", position: "QB", byeWeek: 6, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 0, numRookie: 21, name: "Amon-Ra St. Brown", team: "DET", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 0, numRookie: 22, name: "Nico Collins", team: "HOU", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 0, numRookie: 23, name: "Terrace Marshall Jr.", team: "CAR", position: "WR", byeWeek: 13, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 0, numRookie: 24, name: "Kadarius Toney", team: "NYG", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 0, numRookie: 25, name: "Amari Rodgers", team: "GB", position: "WR", byeWeek: 13, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 0, numRookie: 26, name: "Josh Palmer", team: "LAC", position: "WR", byeWeek: 7, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 0, numRookie: 27, name: "Dyami Brown", team: "WAS", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 0, numRookie: 28, name: "D’Wayne Eskridge", team: "SEA", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 0, numRookie: 29, name: "Pat Freiermuth", team: "PIT", position: "TE", byeWeek: 7, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 0, numRookie: 30, name: "Mac Jones", team: "NE", position: "QB", byeWeek: 14, isTopPlayer: false, isRookie: true)
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
        ["Dallas Cowboys", "Philadelphia Eagles", "New York Giants", "Washington Football Team"],
        //NFC North
        ["Chicago Bears", "Detroit Lions", "Green Bay Packers", "Minnesota Vikings"],
        //NFC South
        ["Tampa Bay Buccaneers", "Atlanta Falcons", "Carolina Panthers", "New Orleans Saints"],
        //NFC West
        ["San Francisco 49ers", "Arizona Cardinals", "Los Angeles Rams", "Seattle Seahawks"]
    ]
    
    func loadTeamData(sec:Int, row:Int, view1:UIView, view2:UIView, label:UILabel, table:UITableView) {
        if sec == 0 && row == 0 {
            data = billsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.01938016217, green: 0.2123703163, blue: 0.5529411765, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.04705882353, blue: 0.1882352941, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.04705882353, blue: 0.1882352941, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.04705882353, blue: 0.1882352941, alpha: 1)
            label.textColor = .white
            label.text = "Buffalo Bills"
        }
        if sec == 0 && row == 1 {
            data = dolphinsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0.3411764706, blue: 0.4705882353, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.2980392157, blue: 0.007843137255, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.2980392157, blue: 0.007843137255, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.2980392157, blue: 0.007843137255, alpha: 1)
            label.textColor = .black
            label.text = "Miami Dolphins"
        }
        if sec == 0 && row == 2 {
            data = jetsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.3411764706, blue: 0.2509803922, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            label.textColor = .black
            label.text = "New York Jets"
        }
        if sec == 0 && row == 3 {
            data = patriotsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.04705882353, blue: 0.1882352941, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            label.textColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
            label.text = "New England Patriots"
        }
        
        if sec == 1 && row == 0 {
            data = bengalsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.textColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            label.text = "Cincinatti Bengals"
        }
        if sec == 1 && row == 1 {
            data = brownsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 1, green: 0.2352941176, blue: 0, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.1137254902, blue: 0, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.1137254902, blue: 0, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.1137254902, blue: 0, alpha: 1)
            label.textColor = .white
            label.text = "Cleveland Browns"
        }
        if sec == 1 && row == 2 {
            data = ravensArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.09803921569, blue: 0.3725490196, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.09803921569, blue: 0.3725490196, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.09803921569, blue: 0.3725490196, alpha: 1)
            label.textColor = #colorLiteral(red: 0.6196078431, green: 0.4862745098, blue: 0.04705882353, alpha: 1)
            label.text = "Baltimore Ravens"
        }
        if sec == 1 && row == 3 {
            data = steelersArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.textColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.text = "Pittsburgh Steelers"
        }
        
        if sec == 2 && row == 0 {
            data = coltsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0.1725490196, blue: 0.3725490196, alpha: 1)
            view2.backgroundColor = .white
            label.backgroundColor = .white
            table.backgroundColor = .white
            label.textColor = #colorLiteral(red: 0, green: 0.1725490196, blue: 0.3725490196, alpha: 1)
            label.text = "Indianapolis Colts"
        }
        if sec == 2 && row == 1 {
            data = jaguarsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.6235294118, green: 0.4745098039, blue: 0.1725490196, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            label.textColor = .white
            label.text = "Jacksonville Jaguars"
        }
        if sec == 2 && row == 2 {
            data = texansArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.1254901961, blue: 0.1843137255, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            label.textColor = .white
            label.text = "Houston Texans"
        }
        if sec == 2 && row == 3 {
            data = titansArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.5411764706, green: 0.5529411765, blue: 0.5607843137, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.06274509804, blue: 0.1803921569, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.06274509804, blue: 0.1803921569, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.06274509804, blue: 0.1803921569, alpha: 1)
            label.textColor = #colorLiteral(red: 0.04705882353, green: 0.137254902, blue: 0.2509803922, alpha: 1)
            label.text = "Tennessee Titans"
        }
        
        if sec == 3 && row == 0 {
            data = broncosArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            label.textColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            label.text = "Denver Broncos"
        }
        if sec == 3 && row == 1 {
            data = chargersArray_2021()
            view1.backgroundColor = #colorLiteral(red: 1, green: 0.7607843137, blue: 0.05490196078, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0.7764705882, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0.7764705882, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0.7764705882, alpha: 1)
            label.textColor = #colorLiteral(red: 1, green: 0.7607843137, blue: 0.05490196078, alpha: 1)
            label.text = "Los Angeles Chargers"
        }
        if sec == 3 && row == 2 {
            data = chiefsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.09411764706, blue: 0.2156862745, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            label.textColor = .black
            label.text = "Kansas City Chiefs"
        }
        if sec == 3 && row == 3 {
            data = raidersArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            view2.backgroundColor = .black
            label.backgroundColor = .black
            table.backgroundColor = .black
            label.textColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            label.text = "Las Vegas Raiders"
        }
        
        if sec == 4 && row == 0 {
            data = cowboysArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.4980392157, green: 0.5882352941, blue: 0.5843137255, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0.2078431373, blue: 0.5803921569, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0.2078431373, blue: 0.5803921569, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0.2078431373, blue: 0.5803921569, alpha: 1)
            label.textColor = .white
            label.text = "Dallas Cowboys"
        }
        if sec == 4 && row == 1 {
            data = eaglesArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.3725490196, green: 0.3764705882, blue: 0.3843137255, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.textColor = #colorLiteral(red: 0.7294117647, green: 0.7921568627, blue: 0.8274509804, alpha: 1)
            label.text = "Philadelphia Eagles"
        }
        if sec == 4 && row == 2 {
            data = giantsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.137254902, blue: 0.3215686275, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6392156863, green: 0.05098039216, blue: 0.1764705882, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6392156863, green: 0.05098039216, blue: 0.1764705882, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6392156863, green: 0.05098039216, blue: 0.1764705882, alpha: 1)
            label.textColor = #colorLiteral(red: 0.003921568627, green: 0.137254902, blue: 0.3215686275, alpha: 1)
            label.text = "New York Giants"
        }
        if sec == 4 && row == 3 {
            data = footballTeamArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.2470588235, green: 0.06274509804, blue: 0.06274509804, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.textColor = #colorLiteral(red: 0.2470588235, green: 0.06274509804, blue: 0.06274509804, alpha: 1)
            label.text = "Washington Football Team"
        }
        
        if sec == 5 && row == 0 {
            data = bearsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.0431372549, green: 0.0862745098, blue: 0.1647058824, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.2196078431, blue: 0.01176470588, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.2196078431, blue: 0.01176470588, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.2196078431, blue: 0.01176470588, alpha: 1)
            label.textColor = #colorLiteral(red: 0.0431372549, green: 0.0862745098, blue: 0.1647058824, alpha: 1)
            label.text = "Chicago Bears"
        }
        if sec == 5 && row == 1 {
            data = lionsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
            label.textColor = .white
            label.text = "Detroit Lions"
        }
        if sec == 5 && row == 2 {
            data = packersArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.1882352941, blue: 0.1568627451, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            label.textColor = #colorLiteral(red: 0.09411764706, green: 0.1882352941, blue: 0.1568627451, alpha: 1)
            label.text = "Green Bay Packers"
        }
        if sec == 5 && row == 3 {
            data = vikingsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.3098039216, green: 0.1490196078, blue: 0.5137254902, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7764705882, blue: 0.1843137255, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7764705882, blue: 0.1843137255, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7764705882, blue: 0.1843137255, alpha: 1)
            label.textColor = #colorLiteral(red: 0.3098039216, green: 0.1490196078, blue: 0.5137254902, alpha: 1)
            label.text = "Minnesota Vikings"
        }
        
        if sec == 6 && row == 0 {
            data = buccaneersArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.1882352941, blue: 0.168627451, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.03921568627, blue: 0.03137254902, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.03921568627, blue: 0.03137254902, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.03921568627, blue: 0.03137254902, alpha: 1)
            label.textColor = #colorLiteral(red: 0.6941176471, green: 0.7294117647, blue: 0.7490196078, alpha: 1)
            label.text = "Tampa Bay Buccaneers"
        }
        if sec == 6 && row == 1 {
            data = falconsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.text = "Atlanta Falcons"
        }
        if sec == 6 && row == 2 {
            data = panthersArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.7529411765, blue: 0.7490196078, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0.5215686275, blue: 0.7921568627, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0.5215686275, blue: 0.7921568627, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0.5215686275, blue: 0.7921568627, alpha: 1)
            label.textColor = #colorLiteral(red: 0.7490196078, green: 0.7529411765, blue: 0.7490196078, alpha: 1)
            label.text = "Carolina Panthers"
        }
        if sec == 6 && row == 3 {
            data = saintsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.8274509804, green: 0.737254902, blue: 0.5529411765, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1215686275, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1215686275, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1215686275, alpha: 1)
            label.textColor = #colorLiteral(red: 0.8274509804, green: 0.737254902, blue: 0.5529411765, alpha: 1)
            label.text = "New Orleans Saints"
        }
        
        if sec == 7 && row == 0 {
            data = _49ersArray_2021()
            view1.backgroundColor = .black
            view2.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.6, blue: 0.3647058824, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.6, blue: 0.3647058824, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.6, blue: 0.3647058824, alpha: 1)
            label.textColor = .white
            label.text = "San Francisco 49ers"
        }
        if sec == 7 && row == 1 {
            data = cardinalsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.textColor = .white
            label.text = "Arizona Cardinals"
        }
        if sec == 7 && row == 2 {
            data = ramsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.5254901961, green: 0.4274509804, blue: 0.2941176471, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.5254901961, green: 0.4274509804, blue: 0.2941176471, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.5254901961, green: 0.4274509804, blue: 0.2941176471, alpha: 1)
            label.textColor = .white
            label.text = "Los Angeles Rams"
        }
        if sec == 7 && row == 3 {
            data = seahawksArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.4117647059, green: 0.7450980392, blue: 0.1568627451, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            label.textColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            label.text = "Seattle Seahawks"
        }
    }
    
    // AFC East
    func billsArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Josh Allen")
        let qb2 = Cell(pos: "QB2", play: "Mitchell Trubisky")
        let rb1 = Cell(pos: "RB1", play: "Zack Moss")
        let rb2 = Cell(pos: "RB2", play: "Devin Singletary")
        let rb3 = Cell(pos: "RB3", play: "Matt Breida")
        let rb4 = Cell(pos: "RB4", play: "Antonio Williams", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Stefon Diggs")
        let wr2 = Cell(pos: "WR2", play: "Cole Beasley")
        let wr3 = Cell(pos: "WR3", play: "Emmanuel Sanders")
        let wr4 = Cell(pos: "WR4", play: "Gabriel Davis")
        let wr5 = Cell(pos: "WR5", play: "Isaiah McKenzie")
        let te1 = Cell(pos: "TE1", play: "Dawson Knox")
        let te2 = Cell(pos: "TE2", play: "Jacob Hollister")
        let te3 = Cell(pos: "TE3", play: "Tommy Sweeney")
        let k = Cell(pos: "K", play: "Tyler Bass")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func dolphinsArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Tua Tagovailoa")
        let qb2 = Cell(pos: "QB2", play: "Jacoby Brissett")
        let rb1 = Cell(pos: "RB1", play: "Myles Gaskin")
        let rb2 = Cell(pos: "RB2", play: "Salvon Ahmed")
        let rb3 = Cell(pos: "RB3", play: "Malcolm Brown")
        let rb4 = Cell(pos: "RB4", play: "Gerrid Doaks", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Will Fuller V")
        let wr2 = Cell(pos: "WR2", play: "DeVante Parker")
        let wr3 = Cell(pos: "WR3", play: "Jaylen Waddle", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Preston Williams")
        let wr5 = Cell(pos: "WR5", play: "Lynn Bowden Jr.")
        let te1 = Cell(pos: "TE1", play: "Mike Gesicki")
        let te2 = Cell(pos: "TE2", play: "Durham Smythe")
        let te3 = Cell(pos: "TE2", play: "Cethan Carter")
        let k = Cell(pos: "K", play: "Jason Sanders")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func jetsArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Zach Wilson", rookie: "R")
        let qb2 = Cell(pos: "QB2", play: "James Morgan")
        let rb1 = Cell(pos: "RB1", play: "Michael Carter", rookie: "R")
        let rb2 = Cell(pos: "RB2", play: "Tevin Coleman")
        let rb3 = Cell(pos: "RB3", play: "Ty Johnson")
        let rb4 = Cell(pos: "RB4", play: "La'Mical Perine")
        let wr1 = Cell(pos: "WR1", play: "Corey Davis")
        let wr2 = Cell(pos: "WR2", play: "Elijah Moore", rookie: "R")
        let wr3 = Cell(pos: "WR3", play: "Jamison Crowder")
        let wr4 = Cell(pos: "WR4", play: "Keelan Cole")
        let wr5 = Cell(pos: "WR5", play: "Denzel Mims")
        let te1 = Cell(pos: "TE1", play: "Tyler Kroft")
        let te2 = Cell(pos: "TE2", play: "Chris Herndon")
        let te3 = Cell(pos: "TE3", play: "Trevon Wesco")
        let k = Cell(pos: "K", play: "Chris Naggar", rookie: "R")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func patriotsArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Cam Newton")
        let qb2 = Cell(pos: "QB2", play: "Mac Jones", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Damien Harris")
        let rb2 = Cell(pos: "RB2", play: "Sony Michel")
        let rb3 = Cell(pos: "RB3", play: "James White")
        let rb4 = Cell(pos: "RB4", play: "Rhamondre Stevenson", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Nelson Agholor")
        let wr2 = Cell(pos: "WR2", play: "Jakobi Meyers")
        let wr3 = Cell(pos: "WR3", play: "Kendrick Bourne")
        let wr4 = Cell(pos: "WR4", play: "N'Keal Harry")
        let wr5 = Cell(pos: "WR5", play: "Gunner Olszewski")
        let te1 = Cell(pos: "TE1", play: "Jonnu Smith")
        let te2 = Cell(pos: "TE2", play: "Hunter Henry")
        let te3 = Cell(pos: "TE3", play: "Devin Asiasi")
        let k = Cell(pos: "K", play: "Nick Folk")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // AFC North
    func bengalsArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Joe Burrow")
        let qb2 = Cell(pos: "QB2", play: "Brandon Allen")
        let rb1 = Cell(pos: "RB1", play: "Joe Mixon")
        let rb2 = Cell(pos: "RB2", play: "Samaje Perine")
        let rb3 = Cell(pos: "RB3", play: "Chris Evans", rookie: "R")
        let rb4 = Cell(pos: "RB4", play: "Trayveon Williams")
        let wr1 = Cell(pos: "WR1", play: "Tyler Boyd")
        let wr2 = Cell(pos: "WR2", play: "Tee Higgins")
        let wr3 = Cell(pos: "WR3", play: "Ja'Marr Chase", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Auden Tate")
        let wr5 = Cell(pos: "WR5", play: "Michael Thomas")
        let te1 = Cell(pos: "TE1", play: "C.J. Uzomah")
        let te2 = Cell(pos: "TE2", play: "Drew Sample")
        let te3 = Cell(pos: "TE3", play: "Mason Schreck")
        let k = Cell(pos: "K", play: "Evan McPherson", rookie: "R")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func brownsArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Baker Mayfield")
        let qb2 = Cell(pos: "QB2", play: "Case Keenum")
        let rb1 = Cell(pos: "RB1", play: "Nick Chub")
        let rb2 = Cell(pos: "RB2", play: "Kareem Hunt")
        let rb3 = Cell(pos: "RB3", play: "D'Ernest Johnson")
        let rb4 = Cell(pos: "RB4", play: "Demetric Felton", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Odell Beckham Jr.")
        let wr2 = Cell(pos: "WR2", play: "Jarvis Landry")
        let wr3 = Cell(pos: "WR3", play: "Rashard Higgins")
        let wr4 = Cell(pos: "WR4", play: "Donovan Peoples-Jones")
        let wr5 = Cell(pos: "WR5", play: "Anthony Schwartz", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Austin Hooper")
        let te2 = Cell(pos: "TE2", play: "Harrison Bryant")
        let te3 = Cell(pos: "TE3", play: "David Njoku")
        let k = Cell(pos: "K", play: "Cody Parkey")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func ravensArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Lamar Jackson")
        let qb2 = Cell(pos: "QB2", play: "Trace McSorley")
        let rb1 = Cell(pos: "RB1", play: "J.K. Dobbins")
        let rb2 = Cell(pos: "RB2", play: "Gus Edwards")
        let rb3 = Cell(pos: "RB3", play: "Justice Hill")
        let rb4 = Cell(pos: "RB4", play: "Ty Williams")
        let wr1 = Cell(pos: "WR1", play: "Marquise Brown")
        let wr2 = Cell(pos: "WR2", play: "Rashod Bateman", rookie: "R")
        let wr3 = Cell(pos: "WR3", play: "Sammy Watkins")
        let wr4 = Cell(pos: "WR4", play: "Devin Duvernay")
        let wr5 = Cell(pos: "WR5", play: "Miles Boykin")
        let te1 = Cell(pos: "TE1", play: "Mark Andrews")
        let te2 = Cell(pos: "TE2", play: "Nick Boyle")
        let te3 = Cell(pos: "TE3", play: "Josh Oliver")
        let k = Cell(pos: "K", play: "Justin Tucker")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func steelersArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Ben Roethlisberger")
        let qb2 = Cell(pos: "QB2", play: "Mason Rudolph")
        let rb1 = Cell(pos: "RB1", play: "Najee Harris", rookie: "R")
        let rb2 = Cell(pos: "RB2", play: "Benny Snell Jr.")
        let rb3 = Cell(pos: "RB3", play: "Jaylen Samuels")
        let rb4 = Cell(pos: "RB4", play: "Anthony McFarland Jr.")
        let wr1 = Cell(pos: "WR1", play: "Diontae Johnson")
        let wr2 = Cell(pos: "WR2", play: "JuJu Smith-Schuster")
        let wr3 = Cell(pos: "WR3", play: "Chase Claypool")
        let wr4 = Cell(pos: "WR4", play: "James Washington")
        let wr5 = Cell(pos: "WR5", play: "Ray-Ray McCloud III")
        let te1 = Cell(pos: "TE1", play: "Eric Ebron")
        let te2 = Cell(pos: "TE2", play: "Pat Freiermuth", rookie: "R")
        let te3 = Cell(pos: "TE3", play: "Zach Gentry")
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // AFC South
    func coltsArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Carson Wentz")
        let qb2 = Cell(pos: "QB2", play: "Jacob Eason")
        let rb1 = Cell(pos: "RB1", play: "Jonathan Taylor")
        let rb2 = Cell(pos: "RB2", play: "Nyheim Hines")
        let rb3 = Cell(pos: "RB3", play: "Marlon Mack")
        let rb4 = Cell(pos: "RB4", play: "Jordan Wilkins")
        let wr1 = Cell(pos: "WR1", play: "T.Y. Hilton")
        let wr2 = Cell(pos: "WR2", play: "Michael Pittman Jr.")
        let wr3 = Cell(pos: "WR3", play: "Parris Campbell")
        let wr4 = Cell(pos: "WR4", play: "Zach Pascal")
        let wr5 = Cell(pos: "WR5", play: "Dezmon Patmon")
        let te1 = Cell(pos: "TE1", play: "Jack Doyle")
        let te2 = Cell(pos: "TE2", play: "Mo Alie-Cox")
        let te3 = Cell(pos: "TE3", play: "Kylen Granson", rookie: "R")
        let k = Cell(pos: "K", play: "Rodrigo Blankenship")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func jaguarsArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Trevor Lawrence", rookie: "R")
        let qb2 = Cell(pos: "QB2", play: "Gardner Minshew II")
        let rb1 = Cell(pos: "RB1", play: "James Robinson")
        let rb2 = Cell(pos: "RB2", play: "Travis Etienne", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "Carlos Hyde")
        let rb4 = Cell(pos: "RB4", play: "Devine Ozigbo")
        let wr1 = Cell(pos: "WR1", play: "DJ Chark Jr.")
        let wr2 = Cell(pos: "WR2", play: "Laviska Shenault Jr.")
        let wr3 = Cell(pos: "WR3", play: "Marvin Jones Jr.")
        let wr4 = Cell(pos: "WR4", play: "Collin Johnson")
        let wr5 = Cell(pos: "WR5", play: "Phillip Dorsett II")
        let te1 = Cell(pos: "TE1", play: "James O'Shaughnessy")
        let te2 = Cell(pos: "TE2", play: "Chris Manhertz")
        let te3 = Cell(pos: "TE3", play: "Luke Farrell", rookie: "R")
        let k = Cell(pos: "K", play: "Josh Lambo")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func texansArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Tyrod Taylor")
        let qb2 = Cell(pos: "QB2", play: "Davis Mills", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "David Johnson")
        let rb2 = Cell(pos: "RB2", play: "Phillip Lindsay")
        let rb3 = Cell(pos: "RB3", play: "Mark Ingram II")
        let rb4 = Cell(pos: "RB4", play: "Rex Burkhead")
        let wr1 = Cell(pos: "WR1", play: "Brandin Cooks")
        let wr2 = Cell(pos: "WR2", play: "Chris Conley")
        let wr3 = Cell(pos: "WR3", play: "Anthony Miller")
        let wr4 = Cell(pos: "WR4", play: "Nico Collins", rookie: "R")
        let wr5 = Cell(pos: "WR5", play: "Keke Coutee")
        let te1 = Cell(pos: "TE1", play: "Jordan Akins")
        let te2 = Cell(pos: "TE2", play: "Pharaoh Brown")
        let te3 = Cell(pos: "TE3", play: "Brevin Jordan", rookie: "R")
        let k = Cell(pos: "K", play: "Ka'imi Fairbairn")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func titansArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Ryan Tannehill")
        let qb2 = Cell(pos: "QB2", play: "Matt Barkley")
        let rb1 = Cell(pos: "RB1", play: "Derrick Henry")
        let rb2 = Cell(pos: "RB2", play: "Darrynton Evans", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "Brian Hill")
        let rb4 = Cell(pos: "RB4", play: "Jeremy McNichols")
        let wr1 = Cell(pos: "WR1", play: "A.J. Brown")
        let wr2 = Cell(pos: "WR2", play: "Julio Jones")
        let wr3 = Cell(pos: "WR3", play: "Josh Reynolds")
        let wr4 = Cell(pos: "WR4", play: "Dez Fitzpatrick", rookie: "R")
        let wr5 = Cell(pos: "WR5", play: "Cameron Batson")
        let te1 = Cell(pos: "TE1", play: "Anthony Firkser")
        let te2 = Cell(pos: "TE2", play: "Geoff Swaim")
        let te3 = Cell(pos: "TE3", play: "Luke Stocker")
        let k = Cell(pos: "K", play: "Greg Joseph")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // AFC West
    func broncosArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Drew Lock")
        let qb2 = Cell(pos: "QB2", play: "Teddy Bridgewater")
        let rb1 = Cell(pos: "RB1", play: "Melvin Gordon")
        let rb2 = Cell(pos: "RB2", play: "Javonte Williams")
        let rb3 = Cell(pos: "RB3", play: "Mike Boone")
        let rb4 = Cell(pos: "RB4", play: "Royce Freeman")
        let wr1 = Cell(pos: "WR1", play: "Courtland Sutton")
        let wr2 = Cell(pos: "WR2", play: "Jerry Jeudy")
        let wr3 = Cell(pos: "WR3", play: "KJ Hamler")
        let wr4 = Cell(pos: "WR4", play: "Tim Patrick")
        let wr5 = Cell(pos: "WR5", play: "Diontae Spencer")
        let te1 = Cell(pos: "TE1", play: "Noah Fant")
        let te2 = Cell(pos: "TE2", play: "Albert Okwuegbunam")
        let te3 = Cell(pos: "TE3", play: "Eric Saubert")
        let k = Cell(pos: "K", play: "Brandon McManus")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func chargersArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Justin Herbert")
        let qb2 = Cell(pos: "QB2", play: "Chase Daniel")
        let rb1 = Cell(pos: "RB1", play: "Austin Ekeler")
        let rb2 = Cell(pos: "RB2", play: "Justin Jackson")
        let rb3 = Cell(pos: "RB3", play: "Joshua Kelley")
        let rb4 = Cell(pos: "RB4", play: "Larry Rountree III", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Keenan Allen")
        let wr2 = Cell(pos: "WR2", play: "Mike Williams")
        let wr3 = Cell(pos: "WR3", play: "Josh Palmer", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Jalen Guyton")
        let wr5 = Cell(pos: "WR5", play: "Tyron Johnson")
        let te1 = Cell(pos: "TE1", play: "Jared Cook")
        let te2 = Cell(pos: "TE2", play: "Donald Parham")
        let te3 = Cell(pos: "TE3", play: "Tre' McKitty", rookie: "R")
        let k = Cell(pos: "K", play: "Michael Badgley")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func chiefsArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Patrick Mahomes")
        let qb2 = Cell(pos: "QB2", play: "Chad Henne")
        let rb1 = Cell(pos: "RB1", play: "Clyde Edwards-Helaire")
        let rb2 = Cell(pos: "RB2", play: "Darrel Williams")
        let rb3 = Cell(pos: "RB3", play: "Jerick McKinnon")
        let rb4 = Cell(pos: "RB4", play: "Darwin Thompson")
        let wr1 = Cell(pos: "WR1", play: "Tyreek Hill")
        let wr2 = Cell(pos: "WR2", play: "Mecole Hardman")
        let wr3 = Cell(pos: "WR3", play: "Demarcus Robinson")
        let wr4 = Cell(pos: "WR4", play: "Byron Pringle")
        let wr5 = Cell(pos: "WR5", play: "Cornell Powell", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Travis Kelce")
        let te2 = Cell(pos: "TE2", play: "Blake Bell")
        let te3 = Cell(pos: "TE3", play: "Noah Gray", rookie: "R")
        let k = Cell(pos: "K", play: "Harrison Butker")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func raidersArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Derek Carr")
        let qb2 = Cell(pos: "QB2", play: "Marcus Mariota")
        let rb1 = Cell(pos: "RB1", play: "Josh Jacobs")
        let rb2 = Cell(pos: "RB2", play: "Kenyan Drake")
        let rb3 = Cell(pos: "RB3", play: "Jalen Richard")
        let rb4 = Cell(pos: "RB4", play: "Trey Ragas", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Henry Ruggs III")
        let wr2 = Cell(pos: "WR2", play: "Bryan Edwards")
        let wr3 = Cell(pos: "WR3", play: "Hunter Renfrow")
        let wr4 = Cell(pos: "WR4", play: "John Brown")
        let wr5 = Cell(pos: "WR5", play: "Willie Snead IV")
        let te1 = Cell(pos: "TE1", play: "Darren Waller")
        let te2 = Cell(pos: "TE2", play: "Foster Moreau")
        let te3 = Cell(pos: "TE3", play: "Derek Carrier")
        let k = Cell(pos: "K", play: "Daniel Carlson")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // NFC East
    func cowboysArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Dak Prescott")
        let qb2 = Cell(pos: "QB2", play: "Garrett Gilbert")
        let rb1 = Cell(pos: "RB1", play: "Ezekiel Elliott")
        let rb2 = Cell(pos: "RB2", play: "Tony Pollard")
        let rb3 = Cell(pos: "RB3", play: "Rico Dowdle")
        let rb4 = Cell(pos: "RB4", play: "JaQuan Hardy", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Amari Cooper")
        let wr2 = Cell(pos: "WR2", play: "Michael Gallup")
        let wr3 = Cell(pos: "WR3", play: "CeeCee Lamb")
        let wr4 = Cell(pos: "WR4", play: "Noah Brown")
        let wr5 = Cell(pos: "WR5", play: "Cedrick Wilson")
        let te1 = Cell(pos: "TE1", play: "Blake Jarwin")
        let te2 = Cell(pos: "TE2", play: "Dalton Schultz")
        let te3 = Cell(pos: "TE3", play: "Sean McKeon")
        let k = Cell(pos: "K", play: "Greg Zuerlein")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func eaglesArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Jalen Hurts")
        let qb2 = Cell(pos: "QB2", play: "Joe Flacco")
        let rb1 = Cell(pos: "RB1", play: "Miles Sanders")
        let rb2 = Cell(pos: "RB2", play: "Boston Scott")
        let rb3 = Cell(pos: "RB3", play: "Kerryon Johnson")
        let rb4 = Cell(pos: "RB4", play: "Kenneth Gainwell", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "DeVonta Smith", rookie: "R")
        let wr2 = Cell(pos: "WR2", play: "Jalen Reagor")
        let wr3 = Cell(pos: "WR3", play: "Greg Ward Jr.")
        let wr4 = Cell(pos: "WR4", play: "Travis Fulgham")
        let wr5 = Cell(pos: "WR5", play: "Quez Watkins")
        let te1 = Cell(pos: "TE1", play: "Dallas Goedert")
        let te2 = Cell(pos: "TE2", play: "Zach Ertz")
        let te3 = Cell(pos: "TE3", play: "Richard Rodgers")
        let k = Cell(pos: "K", play: "Jake Elliott")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func giantsArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Daniel Jones")
        let qb2 = Cell(pos: "QB2", play: "Mike Glennon")
        let rb1 = Cell(pos: "RB1", play: "Saquon Barkley")
        let rb2 = Cell(pos: "RB2", play: "Devontae Booker")
        let rb3 = Cell(pos: "RB3", play: "Alfred Morris")
        let rb4 = Cell(pos: "RB4", play: "Corey Clement")
        let wr1 = Cell(pos: "WR1", play: "Kenny Golladay")
        let wr2 = Cell(pos: "WR2", play: "Sterling Shepard")
        let wr3 = Cell(pos: "WR3", play: "Kadarius Toney", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Darius Slayton")
        let wr5 = Cell(pos: "WR5", play: "John Ross III")
        let te1 = Cell(pos: "TE1", play: "Evan Engram")
        let te2 = Cell(pos: "TE2", play: "Kyle Rudolph")
        let te3 = Cell(pos: "TE3", play: "Kaden Smith")
        let k = Cell(pos: "K", play: "Aldrick Rosas")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func footballTeamArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Ryan Fitzpatrick")
        let qb2 = Cell(pos: "QB2", play: "Taylor Heinicke")
        let rb1 = Cell(pos: "RB1", play: "Antonio Gibson")
        let rb2 = Cell(pos: "RB2", play: "J.D. McKissic")
        let rb3 = Cell(pos: "RB3", play: "Peyton Barber")
        let rb4 = Cell(pos: "RB4", play: "Lamar Miller")
        let wr1 = Cell(pos: "WR1", play: "Terry McLaurin")
        let wr2 = Cell(pos: "WR2", play: "Curtis Samuel")
        let wr3 = Cell(pos: "WR3", play: "Adam Humphries")
        let wr4 = Cell(pos: "WR4", play: "Dyami Brown", rookie: "R")
        let wr5 = Cell(pos: "WR5", play: "Antonio Gandy-Golden")
        let te1 = Cell(pos: "TE1", play: "Logan Thomas")
        let te2 = Cell(pos: "TE2", play: "John Bates", rookie: "R")
        let te3 = Cell(pos: "TE3", play: "Temarrick Hemingway")
        let k = Cell(pos: "K", play: "Dustin Hopkins")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // NFC North
    func bearsArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Andy Dalton")
        let qb2 = Cell(pos: "QB2", play: "Justin Fields", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "David Montgomery")
        let rb2 = Cell(pos: "RB2", play: "Tarik Cohen")
        let rb3 = Cell(pos: "RB3", play: "Damien Williams")
        let rb4 = Cell(pos: "RB4", play: "Khalil Herbert", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Allen Robinson II")
        let wr2 = Cell(pos: "WR2", play: "Darnell Mooney")
        let wr3 = Cell(pos: "WR3", play: "Damiere Byrd")
        let wr4 = Cell(pos: "WR4", play: "Marquise Goodwin")
        let wr5 = Cell(pos: "WR5", play: "Javon Wims")
        let te1 = Cell(pos: "TE1", play: "Cole Kmet")
        let te2 = Cell(pos: "TE2", play: "Jimmy Graham")
        let te3 = Cell(pos: "TE3", play: "Jesse James")
        let k = Cell(pos: "K", play: "Cairo Santos")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func lionsArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Jared Goff")
        let qb2 = Cell(pos: "QB2", play: "David Blough")
        let rb1 = Cell(pos: "RB1", play: "D'Andre Swift")
        let rb2 = Cell(pos: "RB2", play: "Jamaal Williams")
        let rb3 = Cell(pos: "RB3", play: "Jermar Jefferson", rookie: "R")
        let rb4 = Cell(pos: "RB4", play: "Dedrick Mills", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Breshad Perriman")
        let wr2 = Cell(pos: "WR2", play: "Tyrell Williams")
        let wr3 = Cell(pos: "WR3", play: "Amon-Ra St. Brown", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Quintez Cephus")
        let wr5 = Cell(pos: "WR5", play: "Kalif Raymond")
        let te1 = Cell(pos: "TE1", play: "T.J. Hockenson")
        let te2 = Cell(pos: "TE2", play: "Darren Fells")
        let te3 = Cell(pos: "TE3", play: "Alize Mack")
        let k = Cell(pos: "K", play: "Randy Bullock")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func packersArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Aaron Rodgers")
        let qb2 = Cell(pos: "QB2", play: "Jordan Love")
        let rb1 = Cell(pos: "RB1", play: "Aaron Jones")
        let rb2 = Cell(pos: "RB2", play: "A.J. Dillon")
        let rb3 = Cell(pos: "RB3", play: "Kylin Hill", rookie: "R")
        let rb4 = Cell(pos: "RB4", play: "Dexter Williams")
        let wr1 = Cell(pos: "WR1", play: "Davante Adams")
        let wr2 = Cell(pos: "WR2", play: "Randall Cobb")
        let wr3 = Cell(pos: "WR3", play: "Alan Lazard")
        let wr4 = Cell(pos: "WR4", play: "Marquez Valdes-Scantling")
        let wr5 = Cell(pos: "WR5", play: "Amari Rodgers", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Robert Tonyan")
        let te2 = Cell(pos: "TE2", play: "Marcedes Lewis")
        let te3 = Cell(pos: "TE3", play: "Josiah Deguara")
        let k = Cell(pos: "K", play: "Mason Crosby")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func vikingsArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Kirk Cousins")
        let qb2 = Cell(pos: "QB2", play: "Kellen Mond", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Dalvin Cook")
        let rb2 = Cell(pos: "RB2", play: "Alexander Mattison")
        let rb3 = Cell(pos: "RB3", play: "Ameer Abdullah")
        let rb4 = Cell(pos: "RB4", play: "Kene Nwangwu", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Justin Jefferson")
        let wr2 = Cell(pos: "WR2", play: "Adam Thielen")
        let wr3 = Cell(pos: "WR3", play: "Chad Beebe")
        let wr4 = Cell(pos: "WR4", play: "Dede Westbrook")
        let wr5 = Cell(pos: "WR5", play: "Ihmir Smith-Marsette", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Irv Smith Jr.")
        let te2 = Cell(pos: "TE2", play: "Tyler Conklin")
        let te3 = Cell(pos: "TE3", play: "Brandon Dillon", rookie: "R")
        let k = Cell(pos: "K", play: "Greg Joseph")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // NFC South
    func buccaneersArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Tom Brady")
        let qb2 = Cell(pos: "QB2", play: "Kyle Trask", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Leonard Fournette")
        let rb2 = Cell(pos: "RB2", play: "Ronald Jones II")
        let rb3 = Cell(pos: "RB3", play: "Giovani Bernard")
        let rb4 = Cell(pos: "RB4", play: "Ke'Shawn Vaughn")
        let wr1 = Cell(pos: "WR1", play: "Mike Evans")
        let wr2 = Cell(pos: "WR2", play: "Chris Godwin")
        let wr3 = Cell(pos: "WR3", play: "Antonio Brown")
        let wr4 = Cell(pos: "WR4", play: "Scotty Miller")
        let wr5 = Cell(pos: "WR5", play: "Tyler Johnson")
        let te1 = Cell(pos: "TE1", play: "Rob Gronkowski")
        let te2 = Cell(pos: "TE2", play: "O.J. Howard")
        let te3 = Cell(pos: "TE3", play: "Cameron Brate")
        let k = Cell(pos: "K", play: "Ryan Succop")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func falconsArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Matt Ryan")
        let qb2 = Cell(pos: "QB2", play: "AJ McCarron")
        let rb1 = Cell(pos: "RB1", play: "Mike Davis")
        let rb2 = Cell(pos: "RB2", play: "Qadree Ollison")
        let rb3 = Cell(pos: "RB3", play: "Cordarrelle Patterson")
        let rb4 = Cell(pos: "RB4", play: "Javian Hawkins", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Calvin Ridley")
        let wr2 = Cell(pos: "WR2", play: "Russell Gage")
        let wr3 = Cell(pos: "WR3", play: "Olamide Zaccheaus")
        let wr4 = Cell(pos: "WR4", play: "Christian Blake")
        let wr5 = Cell(pos: "WR5", play: "Frank Darby", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Kyle Pitts", rookie: "R")
        let te2 = Cell(pos: "TE2", play: "Hayden Hurst")
        let te3 = Cell(pos: "TE3", play: "Lee Smith")
        let k = Cell(pos: "K", play: "Younghoe Koo")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func panthersArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Sam Darnold")
        let qb2 = Cell(pos: "QB2", play: "Phillip Walker")
        let rb1 = Cell(pos: "RB1", play: "Christian McCaffrey")
        let rb2 = Cell(pos: "RB2", play: "Chuba Hubbard", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "Rodney Smith")
        let rb4 = Cell(pos: "RB4", play: "Trenton Cannon")
        let wr1 = Cell(pos: "WR1", play: "DJ Moore")
        let wr2 = Cell(pos: "WR2", play: "Robby Anderson")
        let wr3 = Cell(pos: "WR3", play: "Terrace Marshall Jr.", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "David Moore")
        let wr5 = Cell(pos: "WR5", play: "Shi Smith", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Dan Arnold")
        let te2 = Cell(pos: "TE2", play: "Ian Thomas")
        let te3 = Cell(pos: "TE3", play: "Tommy Tremble", rookie: "R")
        let k = Cell(pos: "K", play: "Joey Slye")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func saintsArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Jameis Winston")
        let qb2 = Cell(pos: "QB2", play: "Taysom Hill")
        let rb1 = Cell(pos: "RB1", play: "Alvin Kamara")
        let rb2 = Cell(pos: "RB2", play: "Latavius Murray")
        let rb3 = Cell(pos: "RB3", play: "Devonta Freeman")
        let rb4 = Cell(pos: "RB4", play: "Dwayne Washington")
        let wr1 = Cell(pos: "WR1", play: "Michael Thomas")
        let wr2 = Cell(pos: "WR2", play: "Marquez Callaway")
        let wr3 = Cell(pos: "WR3", play: "Tre'Quan Smith")
        let wr4 = Cell(pos: "WR4", play: "Deonte Harris")
        let wr5 = Cell(pos: "WR5", play: "Ty Montgomery")
        let te1 = Cell(pos: "TE1", play: "Adam Trautman")
        let te2 = Cell(pos: "TE2", play: "Nick Vannett")
        let te3 = Cell(pos: "TE3", play: "Juwan Johnson")
        let k = Cell(pos: "K", play: "Wil Lutz")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // NFC West
    func _49ersArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Jimmy Garoppolo")
        let qb2 = Cell(pos: "QB2", play: "Trey Lance", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Raheem Mostert")
        let rb2 = Cell(pos: "RB2", play: "Trey Sermon", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "Wayne Gallman")
        let rb4 = Cell(pos: "RB4", play: "Elijah Mitchell", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Brandon Aiyuk")
        let wr2 = Cell(pos: "WR2", play: "Deebo Samuel")
        let wr3 = Cell(pos: "WR3", play: "Richie James Jr.")
        let wr4 = Cell(pos: "WR4", play: "Mohamed Sanu Sr.")
        let wr5 = Cell(pos: "WR5", play: "Trent Sherfield")
        let te1 = Cell(pos: "TE1", play: "George Kittle")
        let te2 = Cell(pos: "TE2", play: "Ross Dwelley")
        let te3 = Cell(pos: "TE3", play: "Charlie Woerner")
        let k = Cell(pos: "K", play: "Robbie Gould")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func cardinalsArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Kyler Murray")
        let qb2 = Cell(pos: "QB2", play: "Chris Streveler")
        let rb1 = Cell(pos: "RB1", play: "Chase Edmonds")
        let rb2 = Cell(pos: "RB2", play: "James Conner")
        let rb3 = Cell(pos: "RB3", play: "Ito Smith")
        let rb4 = Cell(pos: "RB4", play: "Eno Benjamin")
        let wr1 = Cell(pos: "WR1", play: "DeAndre Hopkins")
        let wr2 = Cell(pos: "WR2", play: "A.J. Green")
        let wr3 = Cell(pos: "WR3", play: "Rondale Moore", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Christian Kirk")
        let wr5 = Cell(pos: "WR5", play: "KeeSean Johnson")
        let te1 = Cell(pos: "TE1", play: "Maxx Williams")
        let te2 = Cell(pos: "TE2", play: "Darrell Daniels")
        let te3 = Cell(pos: "TE3", play: "Demetrius Harris")
        let k = Cell(pos: "K", play: "Matt Prater")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func ramsArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Matthew Stafford")
        let qb2 = Cell(pos: "QB2", play: "John Wolford")
        let rb1 = Cell(pos: "RB1", play: "Darrell Henderson Jr.")
        let rb2 = Cell(pos: "RB2", play: "Xavier Jones")
        let rb3 = Cell(pos: "RB3", play: "Jake Funk", rookie: "R")
        let rb4 = Cell(pos: "RB4", play: "Raymond Calais")
        let wr1 = Cell(pos: "WR1", play: "Robert Woods")
        let wr2 = Cell(pos: "WR2", play: "Cooper Kupp")
        let wr3 = Cell(pos: "WR3", play: "DeSean Jackson")
        let wr4 = Cell(pos: "WR4", play: "Van Jefferson")
        let wr5 = Cell(pos: "WR5", play: "Tutu Atwell", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Tyler Higbee")
        let te2 = Cell(pos: "TE2", play: "Brycen Hopkins")
        let te3 = Cell(pos: "TE3", play: "Jacob Harris", rookie: "R")
        let k = Cell(pos: "K", play: "Matt Gay")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func seahawksArray_2021() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Russell Wilson")
        let qb2 = Cell(pos: "QB2", play: "Geno Smith")
        let rb1 = Cell(pos: "RB1", play: "Chris Carson")
        let rb2 = Cell(pos: "RB2", play: "Rashaad Penny")
        let rb3 = Cell(pos: "RB3", play: "DeeJay Dallas")
        let rb4 = Cell(pos: "RB4", play: "Travis Homer")
        let wr1 = Cell(pos: "WR1", play: "DK Metcalf")
        let wr2 = Cell(pos: "WR2", play: "Tyler Lockett")
        let wr3 = Cell(pos: "WR3", play: "D'Wayne Eskridge", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Freddie Swain")
        let wr5 = Cell(pos: "WR5", play: "Penny Hart")
        let te1 = Cell(pos: "TE1", play: "Gerald Everett")
        let te2 = Cell(pos: "TE2", play: "Will Dissly")
        let te3 = Cell(pos: "TE3", play: "Colby Parkinson")
        let k = Cell(pos: "K", play: "Jason Myers")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
}
