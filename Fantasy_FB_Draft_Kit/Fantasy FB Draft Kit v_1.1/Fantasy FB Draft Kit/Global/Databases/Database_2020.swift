//
//  Database_2020.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 6/18/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import Foundation

class Database_2020 {
    
    static let shared = Database_2020()
    
    var leagueNames: [String]
    var leagues: [[String]]
    
    let myPlayerData = PlayerData(num: 1, numPosPick: 1, numRookie: 0, name: "Name", team: "Team", position: "Position", byeWeek: 0, isTopPlayer: true, isRookie: false)
    
    // Gets depth chart data
    private func getData_DC(from url: String) {
        let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, response, error in
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            var result: DepthChartResponse?
            do {
                result = try JSONDecoder().decode(DepthChartResponse.self, from: (data))
            }
            catch {
                print("failed to convert \(error)")
            }
            guard let json = result else {
                return
            }
            print(json)
        }
        task.resume()
    }
    
    // Prints depth charts data
    func printDepthCharts(url: String) {
        getData_DC(from: url)
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
            PlayerData(num: 0, numPosPick: 1, numRookie: 0, name: "San Francisco 49ers", team: "SF", position: "DEF", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 2, numRookie: 0, name: "Pittsburgh Steelers", team: "PIT", position: "DEF", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 3, numRookie: 0, name: "Baltimore Ravens", team: "BAL", position: "DEF", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 4, numRookie: 0, name: "Buffalo Bills", team: "BUF", position: "DEF", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 5, numRookie: 0, name: "New England Patriots", team: "NE", position: "DEF", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 6, numRookie: 0, name: "Chicago Bears", team: "CHI", position: "DEF", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 7, numRookie: 0, name: "New Orleans Saints", team: "NO", position: "DEF", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 8, numRookie: 0, name: "Kansas City Chiefs", team: "KC", position: "DEF", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 9, numRookie: 0, name: "Minnesota Vikings", team: "MIN", position: "DEF", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 10, numRookie: 0, name: "Los Angeles Rams", team: "LAR", position: "DEF", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 11, numRookie: 0, name: "Denver Broncos", team: "DEN", position: "DEF", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 12, numRookie: 0, name: "Philadelphia Eagles", team: "PHI", position: "DEF", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 13, numRookie: 0, name: "Los Angeles Chargers", team: "LAC", position: "DEF", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 14, numRookie: 0, name: "Tennessee Titans", team: "TEN", position: "DEF", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 15, numRookie: 0, name: "Seattle Seahawks", team: "SEA", position: "DEF", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 16, numRookie: 0, name: "Green Bay Packers", team: "GB", position: "DEF", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 17, numRookie: 0, name: "Indianapolis Colts", team: "IND", position: "DEF", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 18, numRookie: 0, name: "Tampa Bay Buccaneers", team: "TB", position: "DEF", byeWeek: 13, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 19, numRookie: 0, name: "Cleveland Browns", team: "CLE", position: "DEF", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 20, numRookie: 0, name: "Dallas Cowboys", team: "DAL", position: "DEF", byeWeek: 10, isTopPlayer: false, isRookie: false),
            
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
                PlayerData(num: 0, numPosPick: 1, numRookie: 0, name: "San Francisco 49ers", team: "SF", position: "DEF", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 2, numRookie: 0, name: "Pittsburgh Steelers", team: "PIT", position: "DEF", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 3, numRookie: 0, name: "Baltimore Ravens", team: "BAL", position: "DEF", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 4, numRookie: 0, name: "Buffalo Bills", team: "BUF", position: "DEF", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 5, numRookie: 0, name: "New England Patriots", team: "NE", position: "DEF", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 6, numRookie: 0, name: "Chicago Bears", team: "CHI", position: "DEF", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 7, numRookie: 0, name: "New Orleans Saints", team: "NO", position: "DEF", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 8, numRookie: 0, name: "Kansas City Chiefs", team: "KC", position: "DEF", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 9, numRookie: 0, name: "Minnesota Vikings", team: "MIN", position: "DEF", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 10, numRookie: 0, name: "Los Angeles Rams", team: "LAR", position: "DEF", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 11, numRookie: 0, name: "Denver Broncos", team: "DEN", position: "DEF", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 12, numRookie: 0, name: "Philadelphia Eagles", team: "PHI", position: "DEF", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 13, numRookie: 0, name: "Los Angeles Chargers", team: "LAC", position: "DEF", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 14, numRookie: 0, name: "Tennessee Titans", team: "TEN", position: "DEF", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 15, numRookie: 0, name: "Seattle Seahawks", team: "SEA", position: "DEF", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 16, numRookie: 0, name: "Green Bay Packers", team: "GB", position: "DEF", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 17, numRookie: 0, name: "Indianapolis Colts", team: "IND", position: "DEF", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 18, numRookie: 0, name: "Tampa Bay Buccaneers", team: "TB", position: "DEF", byeWeek: 13, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 19, numRookie: 0, name: "Cleveland Browns", team: "CLE", position: "DEF", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 20, numRookie: 0, name: "Dallas Cowboys", team: "DAL", position: "DEF", byeWeek: 10, isTopPlayer: false, isRookie: false),
                
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
}

