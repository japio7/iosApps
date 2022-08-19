//
//  Database_2021.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 9/7/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import Foundation

class Database_2021 {
    
    static let shared = Database_2021()
    
    var leagueNames: [String]
    var teamNames: [String]
    var leagues: [[String]]    
    
    let myPlayerData = PlayerData(num: 1, numPosPick: 1, numRookie: 0, name: "Name", team: "Team", position: "Position", byeWeek: 0, isTopPlayer: true, isRookie: false)
    
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
    func playerList(position: String) -> [PlayerData] {
        return allPlayers.filter({ $0.position == position })
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
}
