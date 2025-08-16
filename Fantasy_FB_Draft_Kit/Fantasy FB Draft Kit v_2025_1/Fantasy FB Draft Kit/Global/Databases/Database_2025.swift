//
//  Database_2023.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 12/15/21.
//  Copyright © 2021 Jared Pino. All rights reserved.
//

import Foundation
import UIKit

class Database_2025 {
    
    static let shared = Database_2025()
    
    var isDone = false
    var isLeagueDeleted = false
    var leagueNames: [String]
    var teamNames: [String]
    var leagues: [[String]]
    
    var playerData = [PlayerData]()
    
    var objectsArray: [[String]] = [["Overall Top 200", "Top 30 Rookies"], ["Top 30 Quarterbacks", "Top 80 Running Backs", "Top 80 Wide Receivers", "Top 30 Tight Ends", "Top 20 Defenses", "Top 15 Kickers"], ["Depth Charts"], ["My Leagues"], ["Reset Draft"]
    ]
    
    var teamAbbreviations = ["buffalo bills", "buffalo", "buf", "bills", "miami dolphins", "miami", "mia", "dolphins", "new york jets", "nyj", "jets", "new england patriots", "new england", "ne", "patriots", "cincinatti bengals", "cincinatti", "cin", "bengals", "cleveland browns", "cleveland", "cle", "browns", "baltimore ravens", "baltimore", "bal", "ravens", "pittsburgh steelers", "pittsburgh", "pit", "steelers", "indianapolis colts", "indianapolis", "ind", "colts", "jacksonville jaguars", "jacksonville", "jac", "jaguars", "houston texans", "houston", "hou", "texans", "tennessee titans", "tennessee", "ten", "titans", "denver broncos", "denver", "den", "broncos", "los angeles chargers", "lac", "chargers", "kansas city chiefs", "kansas city", "kc", "chiefs", "las vegas raiders", "las vegas", "lv", "raiders", "dallas cowboys", "dallas", "dal", "cowboys", "philadelphia eagles", "philadelphia", "phi", "eagles", "new york giants", "nyg", "giants", "washington commanders", "washington", "was", "commanders", "chicago bears", "chicago", "chi", "bears", "detroit lions", "detroit", "det", "lions", "green bay packers", "green bay", "gb", "packers", "minnesota vikings", "minnesota", "min", "vikings", "tampa bay buccaneers", "tampa bay", "tb", "buccaneers", "atlanta falcons", "atlanta", "atl", "falcons", "carolina panthers", "carolina", "car", "panthers", "new orleans saints", "new orleans", "no", "saints", "san francisco 49ers", "san francisco", "sf", "49ers", "arizona cardinals", "arizona", "ari", "cardinals", "los angeles Rams", "lar", "rams", "seattle seahawks", "seattle", "sea", "seahawks"]
    
    var positions = ["qb", "quarterback", "rb", "runningback", "running back", "wr", "wide receiver", "receiver", "te", "tight end", "k", "kicker"]
    
    func convertTeam(tn:String, label:UILabel) -> (String, Int) {
        var tup = ("", 0)
        label.text = ""
        
        if tn.lowercased() == "buffalo bills" || tn.lowercased() == "buffalo" || tn.lowercased() == "buf" || tn.lowercased() == "bills" {
            tup = ("BUF", 7)
        } else if tn.lowercased() == "miami dolphins" || tn.lowercased() == "miami" || tn.lowercased() == "mia" || tn.lowercased() == "dolphins" {
            tup = ("MIA", 11)
        } else if tn.lowercased() == "new york jets" || tn.lowercased() == "nyj" || tn.lowercased() == "jets" {
            tup = ("NYJ", 10)
        } else if tn.lowercased() == "new england patriots" || tn.lowercased() == "new england" || tn.lowercased() == "ne" || tn.lowercased() == "patriots" {
            tup = ("NE", 10)
        } else if tn.lowercased() == "cincinatti bengals" || tn.lowercased() == "cincinatti" || tn.lowercased() == "cin" || tn.lowercased() == "bengals" {
            tup = ("CIN", 10)
        } else if tn.lowercased() == "cleveland browns" || tn.lowercased() == "cleveland" || tn.lowercased() == "cle" || tn.lowercased() == "browns" {
            tup = ("CLE", 9)
        } else if tn.lowercased() == "baltimore ravens" || tn.lowercased() == "baltimore" || tn.lowercased() == "bal" || tn.lowercased() == "ravens" {
            tup = ("BAL", 10)
        } else if tn.lowercased() == "pittsburgh steelers" || tn.lowercased() == "pittsburgh" || tn.lowercased() == "pit" || tn.lowercased() == "steelers" {
            tup = ("PIT", 9)
        } else if tn.lowercased() == "indianapolis colts" || tn.lowercased() == "indianapolis" || tn.lowercased() == "ind" || tn.lowercased() == "colts" {
            tup = ("IND", 14)
        } else if tn.lowercased() == "jacksonville jaguars" || tn.lowercased() == "jacksonville" || tn.lowercased() == "jac" || tn.lowercased() == "jaguars" {
            tup = ("JAC", 11)
        } else if tn.lowercased() == "houston texans" || tn.lowercased() == "houston" || tn.lowercased() == "hou" || tn.lowercased() == "texans" {
            tup = ("HOU", 6)
        } else if tn.lowercased() == "tennessee titans" || tn.lowercased() == "tennessee" || tn.lowercased() == "ten" || tn.lowercased() == "titans" {
            tup = ("TEN", 6)
        } else if tn.lowercased() == "denver broncos" || tn.lowercased() == "denver" || tn.lowercased() == "den" || tn.lowercased() == "broncos" {
            tup = ("DEN", 9)
        } else if tn.lowercased() == "los angeles chargers" || tn.lowercased() == "lac" || tn.lowercased() == "chargers" {
            tup = ("LAC", 8)
        } else if tn.lowercased() == "kansas city chiefs" || tn.lowercased() == "kansas city" || tn.lowercased() == "kc" || tn.lowercased() == "chiefs" {
            tup = ("KC", 8)
        } else if tn.lowercased() == "las vegas raiders" || tn.lowercased() == "las vegas" || tn.lowercased() == "lv" || tn.lowercased() == "raiders" {
            tup = ("LV", 6)
        } else if tn.lowercased() == "dallas cowboys" || tn.lowercased() == "dallas" || tn.lowercased() == "dal" || tn.lowercased() == "cowboys" {
            tup = ("DAL", 9)
        } else if tn.lowercased() == "philadelphia eagles" || tn.lowercased() == "philadelphia" || tn.lowercased() == "phi" || tn.lowercased() == "eagles" {
            tup = ("PHI", 7)
        } else if tn.lowercased() == "new york giants" || tn.lowercased() == "nyg" || tn.lowercased() == "giants" {
            tup = ("NYG", 9)
        } else if tn.lowercased() == "washington commanders" || tn.lowercased() == "washington" || tn.lowercased() == "was" || tn.lowercased() == "commanders" {
            tup = ("WAS", 14)
        } else if tn.lowercased() == "chicago bears" || tn.lowercased() == "chicago" || tn.lowercased() == "chi" || tn.lowercased() == "bears" {
            tup = ("CHI", 14)
        } else if tn.lowercased() == "detroit lions" || tn.lowercased() == "detroit" || tn.lowercased() == "det" || tn.lowercased() == "lions" {
            tup = ("DET", 6)
        } else if tn.lowercased() == "green bay packers" || tn.lowercased() == "green bay" || tn.lowercased() == "gb" || tn.lowercased() == "packers" {
            tup = ("GB", 14)
        } else if tn.lowercased() == "minnesota vikings" || tn.lowercased() == "minnesota" || tn.lowercased() == "min" || tn.lowercased() == "vikings" {
            tup = ("MIN", 7)
        } else if tn.lowercased() == "tampa bay buccaneers" || tn.lowercased() == "tampa bay" || tn.lowercased() == "tb" || tn.lowercased() == "buccaneers" {
            tup = ("TB", 11)
        } else if tn.lowercased() == "atlanta falcons" || tn.lowercased() == "atlanta" || tn.lowercased() == "atl" || tn.lowercased() == "falcons" {
            tup = ("ATL", 14)
        } else if tn.lowercased() == "carolina panthers" || tn.lowercased() == "carolina" || tn.lowercased() == "car" || tn.lowercased() == "panthers" {
            tup = ("CAR", 13)
        } else if tn.lowercased() == "new orleans saints" || tn.lowercased() == "new orleans" || tn.lowercased() == "no" || tn.lowercased() == "saints" {
            tup = ("NO", 14)
        } else if tn.lowercased() == "san francisco 49ers" || tn.lowercased() == "san francisco" || tn.lowercased() == "sf" || tn.lowercased() == "49ers" {
            tup = ("SF", 9)
        } else if tn.lowercased() == "arizona cardinals" || tn.lowercased() == "arizona" || tn.lowercased() == "ari" || tn.lowercased() == "cardinals" {
            tup = ("ARI", 13)
        } else if tn.lowercased() == "los angeles Rams" || tn.lowercased() == "lar" || tn.lowercased() == "rams" {
            tup = ("LAR", 7)
        } else if tn.lowercased() == "seattle seahawks" || tn.lowercased() == "seattle" || tn.lowercased() == "sea" || tn.lowercased() == "seahawks" {
            tup = ("SEA", 11)
        } else {
            label.text = "Not Valid"
        }
        return tup
    }
    
    func allPlayersAppend(playerData: PlayerData) {
        allPlayers.append(playerData)
    }
    
    func getRankings() -> [String] {
        var rankings = [String]()
        for player in playerList(topPlayer: true) {
            rankings.append("\(player.num).  \(player.name),  \(player.team) - \(player.position) (\(player.byeWeek))")
        }
        return rankings
    }
    
    func isValidTeam(tn: String) -> Bool {
        if teamAbbreviations.contains(tn) {
            return true
        }
        return false
    }
    
    func isValidPos(pos: String) -> Bool {
        if positions.contains(pos) {
            return true
        }
        return false
    }
    
    func getTop(yyyy: Int, passed: RowSelected, label: UILabel) {
        if passed.year == yyyy {
            if passed.sec == 0 && passed.row == 0 {
                playerData = playerList(topPlayer: true)
                label.text = "Overall Top 200"
            } else if passed.sec == 0 && passed.row == 1 {
                playerData = playerList(rookie: true, num: 30)
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
    
    // All players and leagues 2025
    fileprivate var allPlayers: [PlayerData]
    
    // All Players Save, Write and Read
    fileprivate func playerDataURL() -> URL {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in:.userDomainMask).last!
        return documentDirectoryURL.appendingPathComponent("playerData_2025.json")
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
        return documentDirectoryURL.appendingPathComponent("leagueNamesData_2025.json")
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
        return documentDirectoryURL.appendingPathComponent("teamNamesData_2025.json")
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
        return documentDirectoryURL.appendingPathComponent("leaguesData_2025.json")
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
    
    func playerList(rookie: Bool, num: Int) -> [PlayerData] {
        return allPlayers.filter({ $0.isRookie == rookie }).filter({$0.numRookie <= num}).filter({$0.numRookie != 0})
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

    func addToLeagues(league_name: String, team_name: String) {
        leagueNames.insert(league_name, at: 0)
        teamNames.insert(team_name, at: 0)
        leagues.insert(roster_array(), at: 0)
        changeMade()
    }

    func deleteLeague(index: IndexPath, _table: UITableView) {
        if leagues != [] {
            leagueNames.remove(at: index.row)
            teamNames.remove(at: index.row)
            leagues.remove(at: index.row)
            isLeagueDeleted = true
            _table.reloadData()
        } else {
            return
        }
        changeMade()
    }
    
    // Reset the draft
    func resetDraft() {
        
        allPlayers=[
            PlayerData(num: 1, numPosPick: 1, numRookie: 0, name: "Ja'Marr Chase", team: "CIN", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 2, numPosPick: 1, numRookie: 0, name: "Saquon Barkley", team: "PHI", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 3, numPosPick: 2, numRookie: 0, name: "Bijan Robinson", team: "ATL", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 4, numPosPick: 2, numRookie: 0, name: "Justin Jefferson", team: "MIN", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 5, numPosPick: 3, numRookie: 0, name: "CeeDee Lamb", team: "DAL", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 6, numPosPick: 3, numRookie: 0, name: "Jahmyr Gibbs", team: "DET", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 7, numPosPick: 4, numRookie: 0, name: "Derrick Henry", team: "BAL", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 8, numPosPick: 4, numRookie: 0, name: "Puka Nacua", team: "LAR", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 9, numPosPick: 5, numRookie: 0, name: "Nico Collins", team: "HOU", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 10, numPosPick: 6, numRookie: 0, name: "Brian Thomas Jr.", team: "JAC", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 11, numPosPick: 7, numRookie: 0, name: "Malik Nabers", team: "NYG", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 12, numPosPick: 5, numRookie: 1, name: "Ashton Jeanty", team: "LV", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: true),
            PlayerData(num: 13, numPosPick: 8, numRookie: 0, name: "Amon-Ra St. Brown", team: "DET", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 14, numPosPick: 6, numRookie: 0, name: "Christian McCaffrey", team: "SF", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 15, numPosPick: 7, numRookie: 0, name: "Jonathan Taylor", team: "IND", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 16, numPosPick: 9, numRookie: 0, name: "A.J. Brown", team: "PHI", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 17, numPosPick: 8, numRookie: 0, name: "De'Von Achane", team: "MIA", position: "RB", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 18, numPosPick: 9, numRookie: 0, name: "Josh Jacobs", team: "GB", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 19, numPosPick: 10, numRookie: 0, name: "Drake London", team: "ATL", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 20, numPosPick: 1, numRookie: 0, name: "George Kittle", team: "SF", position: "TE", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 21, numPosPick: 2, numRookie: 0, name: "Brock Bowers", team: "LV", position: "TE", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 22, numPosPick: 11, numRookie: 0, name: "Ladd McConkey", team: "LAC", position: "WR", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 23, numPosPick: 10, numRookie: 0, name: "Bucky Irving", team: "TB", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 24, numPosPick: 11, numRookie: 0, name: "Kyren Williams", team: "LAR", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 25, numPosPick: 1, numRookie: 0, name: "Josh Allen", team: "BUF", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 26, numPosPick: 2, numRookie: 0, name: "Lamar Jackson", team: "BAL", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 27, numPosPick: 12, numRookie: 0, name: "Tee Higgins", team: "CIN", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 28, numPosPick: 13, numRookie: 0, name: "Mike Evans", team: "TB", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 29, numPosPick: 14, numRookie: 0, name: "Tyreek Hill", team: "MIA", position: "WR", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 30, numPosPick: 12, numRookie: 0, name: "Chase Brown", team: "CIN", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 31, numPosPick: 3, numRookie: 0, name: "Jayden Daniels", team: "WAS", position: "QB", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 32, numPosPick: 3, numRookie: 0, name: "Trey McBride", team: "ARI", position: "TE", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 33, numPosPick: 13, numRookie: 0, name: "James Cook", team: "BUF", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 34, numPosPick: 15, numRookie: 0, name: "Davante Adams", team: "LAR", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 35, numPosPick: 16, numRookie: 0, name: "Jaxon Smith-Njigba", team: "SEA", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 36, numPosPick: 17, numRookie: 0, name: "Terry McLaurin", team: "WAS", position: "WR", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 37, numPosPick: 4, numRookie: 0, name: "Jalen Hurts", team: "PHI", position: "QB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 38, numPosPick: 14, numRookie: 0, name: "Breece Hall", team: "NYJ", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 39, numPosPick: 18, numRookie: 0, name: "Garrett Wilson", team: "NYJ", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 40, numPosPick: 19, numRookie: 0, name: "Marvin Harrison Jr.", team: "ARI", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 41, numPosPick: 15, numRookie: 0, name: "Kenneth Walker III", team: "SEA", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 42, numPosPick: 16, numRookie: 0, name: "Chuba Hubbard", team: "CAR", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 43, numPosPick: 20, numRookie: 0, name: "DK Metcalf", team: "PIT", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 44, numPosPick: 17, numRookie: 0, name: "James Conner", team: "ARI", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 45, numPosPick: 18, numRookie: 2, name: "Omarion Hampton", team: "LAC", position: "RB", byeWeek: 12, isTopPlayer: true, isRookie: true),
            PlayerData(num: 46, numPosPick: 19, numRookie: 0, name: "Alvin Kamara", team: "NO", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 47, numPosPick: 21, numRookie: 0, name: "Jameson Williams", team: "DET", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 48, numPosPick: 5, numRookie: 0, name: "Joe Burrow", team: "CIN", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 49, numPosPick: 22, numRookie: 0, name: "Courtland Sutton", team: "DEN", position: "WR", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 50, numPosPick: 23, numRookie: 0, name: "DJ Moore", team: "CHI", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 51, numPosPick: 24, numRookie: 0, name: "Zay Flowers", team: "BAL", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 52, numPosPick: 20, numRookie: 0, name: "David Montgomery", team: "DET", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 53, numPosPick: 25, numRookie: 0, name: "Xavier Worthy", team: "KC", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 54, numPosPick: 26, numRookie: 0, name: "DeVonta Smith", team: "PHI", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 55, numPosPick: 4, numRookie: 0, name: "Sam LaPorta", team: "DET", position: "TE", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 56, numPosPick: 21, numRookie: 0, name: "Joe Mixon", team: "HOU", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 57, numPosPick: 22, numRookie: 0, name: "D'Andre Swift", team: "CHI", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 58, numPosPick: 27, numRookie: 0, name: "Rashee Rice", team: "KC", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 59, numPosPick: 23, numRookie: 3, name: "TreVeyon Henderson", team: "NE", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: true),
            PlayerData(num: 60, numPosPick: 28, numRookie: 0, name: "Calvin Ridley", team: "TEN", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 61, numPosPick: 6, numRookie: 0, name: "Patrick Mahomes II", team: "KC", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 62, numPosPick: 29, numRookie: 0, name: "George Pickens", team: "DAL", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 63, numPosPick: 24, numRookie: 4, name: "RJ Harvey", team: "DEN", position: "RB", byeWeek: 12, isTopPlayer: true, isRookie: true),
            PlayerData(num: 64, numPosPick: 25, numRookie: 0, name: "Aaron Jones Sr.", team: "MIN", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 65, numPosPick: 26, numRookie: 5, name: "Kaleb Johnson", team: "PIT", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: true),
            PlayerData(num: 66, numPosPick: 30, numRookie: 6, name: "Tetairoa McMillan", team: "CAR", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: true),
            PlayerData(num: 67, numPosPick: 7, numRookie: 0, name: "Baker Mayfield", team: "TB", position: "QB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 68, numPosPick: 27, numRookie: 0, name: "Tony Pollard", team: "TEN", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 69, numPosPick: 31, numRookie: 0, name: "Jaylen Waddle", team: "MIA", position: "WR", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 70, numPosPick: 28, numRookie: 0, name: "Isiah Pacheco", team: "KC", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 71, numPosPick: 5, numRookie: 0, name: "Mark Andrews", team: "BAL", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 72, numPosPick: 29, numRookie: 0, name: "Brian Robinson Jr.", team: "WAS", position: "RB", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 73, numPosPick: 8, numRookie: 0, name: "Bo Nix", team: "DEN", position: "QB", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 74, numPosPick: 32, numRookie: 7, name: "Travis Hunter", team: "JAC", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: true),
            PlayerData(num: 75, numPosPick: 6, numRookie: 0, name: "T.J. Hockenson", team: "MIN", position: "TE", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 76, numPosPick: 33, numRookie: 0, name: "Chris Olave", team: "NO", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 77, numPosPick: 34, numRookie: 0, name: "Jordan Addison", team: "MIN", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 78, numPosPick: 9, numRookie: 0, name: "Kyler Murray", team: "ARI", position: "QB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 79, numPosPick: 35, numRookie: 0, name: "Rome Odunze", team: "CHI", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 80, numPosPick: 36, numRookie: 0, name: "Jerry Jeudy", team: "CLE", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 81, numPosPick: 37, numRookie: 0, name: "Jayden Reed", team: "GB", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 82, numPosPick: 7, numRookie: 0, name: "Travis Kelce", team: "KC", position: "TE", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 83, numPosPick: 38, numRookie: 0, name: "Jauan Jennings", team: "SF", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 84, numPosPick: 30, numRookie: 0, name: "Tyrone Tracy Jr.", team: "NYG", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 85, numPosPick: 39, numRookie: 0, name: "Chris Godwin", team: "TB", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 86, numPosPick: 10, numRookie: 0, name: "Justin Fields", team: "NYJ", position: "QB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 87, numPosPick: 31, numRookie: 0, name: "Travis Etienne Jr.", team: "JAC", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 88, numPosPick: 40, numRookie: 0, name: "Deebo Samuel Sr.", team: "WAS", position: "WR", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 89, numPosPick: 8, numRookie: 0, name: "Tucker Kraft", team: "GB", position: "TE", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 90, numPosPick: 9, numRookie: 0, name: "David Njoku", team: "CLE", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 91, numPosPick: 32, numRookie: 8, name: "Quinshon Judkins", team: "CLE", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: true),
            PlayerData(num: 92, numPosPick: 11, numRookie: 0, name: "Brock Purdy", team: "SF", position: "QB", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 93, numPosPick: 33, numRookie: 0, name: "Najee Harris", team: "LAC", position: "RB", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 94, numPosPick: 12, numRookie: 0, name: "Dak Prescott", team: "DAL", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 95, numPosPick: 13, numRookie: 0, name: "Justin Herbert", team: "LAC", position: "QB", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 96, numPosPick: 14, numRookie: 0, name: "Caleb Williams", team: "CHI", position: "QB", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 97, numPosPick: 34, numRookie: 0, name: "Jaylen Warren", team: "PIT", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 98, numPosPick: 35, numRookie: 0, name: "Jordan Mason", team: "MIN", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 99, numPosPick: 10, numRookie: 0, name: "Evan Engram", team: "DEN", position: "TE", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 100, numPosPick: 41, numRookie: 0, name: "Jakobi Meyers", team: "LV", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 101, numPosPick: 36, numRookie: 0, name: "Javonte Williams", team: "DAL", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 102, numPosPick: 42, numRookie: 0, name: "Ricky Pearsall", team: "SF", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 103, numPosPick: 15, numRookie: 0, name: "Jared Goff", team: "DET", position: "QB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 104, numPosPick: 43, numRookie: 0, name: "Khalil Shakir", team: "BUF", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 105, numPosPick: 37, numRookie: 0, name: "Rhamondre Stevenson", team: "NE", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 106, numPosPick: 16, numRookie: 0, name: "Drake Maye", team: "NE", position: "QB", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 107, numPosPick: 38, numRookie: 9, name: "Cam Skattebo", team: "NYG", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: true),
            PlayerData(num: 108, numPosPick: 17, numRookie: 0, name: "Jordan Love", team: "GB", position: "QB", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 109, numPosPick: 39, numRookie: 0, name: "Zach Charbonnet", team: "SEA", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 110, numPosPick: 44, numRookie: 0, name: "Stefon Diggs", team: "NE", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 111, numPosPick: 40, numRookie: 0, name: "Tank Bigsby", team: "JAC", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 112, numPosPick: 45, numRookie: 0, name: "Josh Downs", team: "IND", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 113, numPosPick: 11, numRookie: 10, name: "Tyler Warren", team: "IND", position: "TE", byeWeek: 11, isTopPlayer: true, isRookie: true),
            PlayerData(num: 114, numPosPick: 18, numRookie: 0, name: "Trevor Lawrence", team: "JAC", position: "QB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 115, numPosPick: 12, numRookie: 0, name: "Dalton Kincaid", team: "BUF", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 116, numPosPick: 19, numRookie: 0, name: "C.J. Stroud", team: "HOU", position: "QB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 117, numPosPick: 46, numRookie: 0, name: "Brandon Aiyuk", team: "SF", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 118, numPosPick: 47, numRookie: 0, name: "Darnell Mooney", team: "ATL", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 119, numPosPick: 13, numRookie: 0, name: "Dallas Goedert", team: "PHI", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 120, numPosPick: 41, numRookie: 0, name: "Tyjae Spears", team: "TEN", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 121, numPosPick: 48, numRookie: 0, name: "Cooper Kupp", team: "SEA", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 122, numPosPick: 49, numRookie: 0, name: "Michael Pittman Jr.", team: "IND", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 123, numPosPick: 42, numRookie: 0, name: "J.K. Dobbins", team: "DEN", position: "RB", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 124, numPosPick: 50, numRookie: 0, name: "Keon Coleman", team: "BUF", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 125, numPosPick: 43, numRookie: 0, name: "Rachaad White", team: "TB", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 126, numPosPick: 51, numRookie: 11, name: "Emeka Egbuka", team: "TB", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: true),
            PlayerData(num: 127, numPosPick: 44, numRookie: 0, name: "Ray Davis", team: "BUF", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 128, numPosPick: 20, numRookie: 0, name: "J.J. McCarthy", team: "MIN", position: "QB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 129, numPosPick: 14, numRookie: 0, name: "Kyle Pitts Sr.", team: "ATL", position: "TE", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 130, numPosPick: 45, numRookie: 0, name: "Trey Benson", team: "ARI", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 131, numPosPick: 52, numRookie: 0, name: "Rashid Shaheed", team: "NO", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 132, numPosPick: 53, numRookie: 12, name: "Matthew Golden", team: "GB", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: true),
            PlayerData(num: 133, numPosPick: 15, numRookie: 0, name: "Jonnu Smith", team: "PIT", position: "TE", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 134, numPosPick: 46, numRookie: 0, name: "Isaac Guerendo", team: "SF", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 135, numPosPick: 21, numRookie: 0, name: "Tua Tagovailoa", team: "MIA", position: "QB", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 136, numPosPick: 22, numRookie: 0, name: "Matthew Stafford", team: "LAR", position: "QB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 137, numPosPick: 16, numRookie: 13, name: "Colston Loveland", team: "CHI", position: "TE", byeWeek: 5, isTopPlayer: true, isRookie: true),
            PlayerData(num: 138, numPosPick: 47, numRookie: 0, name: "Tyler Allgeier", team: "ATL", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 139, numPosPick: 17, numRookie: 0, name: "Jake Ferguson", team: "DAL", position: "TE", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 140, numPosPick: 54, numRookie: 0, name: "Rashod Bateman", team: "BAL", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 141, numPosPick: 48, numRookie: 0, name: "Austin Ekeler", team: "WAS", position: "RB", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 142, numPosPick: 55, numRookie: 0, name: "Christian Kirk", team: "HOU", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 143, numPosPick: 49, numRookie: 0, name: "Jaylen Wright", team: "MIA", position: "RB", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 144, numPosPick: 50, numRookie: 0, name: "Rico Dowdle", team: "CAR", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 145, numPosPick: 51, numRookie: 0, name: "Nick Chubb", team: "HOU", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 146, numPosPick: 18, numRookie: 0, name: "Isaiah Likely", team: "BAL", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 147, numPosPick: 23, numRookie: 0, name: "Bryce Young", team: "CAR", position: "QB", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 148, numPosPick: 56, numRookie: 0, name: "Marvin Mims Jr.", team: "DEN", position: "WR", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 149, numPosPick: 52, numRookie: 14, name: "Bhayshul Tuten", team: "JAC", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: true),
            PlayerData(num: 150, numPosPick: 19, numRookie: 0, name: "Hunter Henry", team: "NE", position: "TE", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 151, numPosPick: 53, numRookie: 0, name: "Braelon Allen", team: "NYJ", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 152, numPosPick: 24, numRookie: 0, name: "Michael Penix Jr.", team: "ATL", position: "QB", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 153, numPosPick: 54, numRookie: 0, name: "Jerome Ford", team: "CLE", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 154, numPosPick: 57, numRookie: 15, name: "Luther Burden III", team: "CHI", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: true),
            PlayerData(num: 155, numPosPick: 58, numRookie: 0, name: "Cedric Tillman", team: "CLE", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 156, numPosPick: 59, numRookie: 16, name: "Tre' Harris", team: "LAC", position: "WR", byeWeek: 12, isTopPlayer: true, isRookie: true),
            PlayerData(num: 157, numPosPick: 60, numRookie: 0, name: "Romeo Doubs", team: "GB", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 158, numPosPick: 61, numRookie: 0, name: "Marquise Brown", team: "KC", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 159, numPosPick: 1, numRookie: 0, name: "Denver Broncos", team: "DEN", position: "DST", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 160, numPosPick: 55, numRookie: 17, name: "Jaydon Blue", team: "DAL", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: true),
            PlayerData(num: 161, numPosPick: 56, numRookie: 0, name: "Roschon Johnson", team: "CHI", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 162, numPosPick: 62, numRookie: 0, name: "Quentin Johnston", team: "LAC", position: "WR", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 163, numPosPick: 25, numRookie: 0, name: "Geno Smith", team: "LV", position: "QB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 164, numPosPick: 63, numRookie: 0, name: "Jalen McMillan", team: "TB", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 165, numPosPick: 20, numRookie: 0, name: "Zach Ertz", team: "WAS", position: "TE", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 166, numPosPick: 57, numRookie: 18, name: "Dylan Sampson", team: "CLE", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: true),
            PlayerData(num: 167, numPosPick: 58, numRookie: 0, name: "MarShawn Lloyd", team: "GB", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 168, numPosPick: 59, numRookie: 0, name: "Blake Corum", team: "LAR", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 169, numPosPick: 64, numRookie: 19, name: "Kyle Williams", team: "NE", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: true),
            PlayerData(num: 170, numPosPick: 65, numRookie: 20, name: "Jayden Higgins", team: "HOU", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: true),
            PlayerData(num: 171, numPosPick: 66, numRookie: 0, name: "Adam Thielen", team: "CAR", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 172, numPosPick: 2, numRookie: 0, name: "Philadelphia Eagles", team: "PHI", position: "DST", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 173, numPosPick: 3, numRookie: 0, name: "Pittsburgh Steelers", team: "PIT", position: "DST", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 174, numPosPick: 4, numRookie: 0, name: "Baltimore Ravens", team: "BAL", position: "DST", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 175, numPosPick: 67, numRookie: 0, name: "DeAndre Hopkins", team: "BAL", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 176, numPosPick: 5, numRookie: 0, name: "Minnesota Vikings", team: "MIN", position: "DST", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 177, numPosPick: 68, numRookie: 0, name: "Xavier Legette", team: "CAR", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 178, numPosPick: 69, numRookie: 0, name: "Joshua Palmer", team: "BUF", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 179, numPosPick: 26, numRookie: 0, name: "Sam Darnold", team: "SEA", position: "QB", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 180, numPosPick: 70, numRookie: 0, name: "Alec Pierce", team: "IND", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 181, numPosPick: 6, numRookie: 0, name: "Houston Texans", team: "HOU", position: "DST", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 182, numPosPick: 7, numRookie: 0, name: "Buffalo Bills", team: "BUF", position: "DST", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 183, numPosPick: 8, numRookie: 0, name: "Kansas City Chiefs", team: "KC", position: "DST", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 184, numPosPick: 9, numRookie: 0, name: "Detroit Lions", team: "DET", position: "DST", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 185, numPosPick: 71, numRookie: 0, name: "Wan'Dale Robinson", team: "NYG", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 186, numPosPick: 60, numRookie: 0, name: "Kareem Hunt", team: "KC", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 187, numPosPick: 21, numRookie: 0, name: "Pat Freiermuth", team: "PIT", position: "TE", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 188, numPosPick: 72, numRookie: 0, name: "DeMario Douglas", team: "NE", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 189, numPosPick: 22, numRookie: 0, name: "Mike Gesicki", team: "CIN", position: "TE", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 190, numPosPick: 1, numRookie: 0, name: "Brandon Aubrey", team: "DAL", position: "K", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 191, numPosPick: 23, numRookie: 0, name: "Cade Otton", team: "TB", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 192, numPosPick: 10, numRookie: 0, name: "Los Angeles Chargers", team: "LAC", position: "DST", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 193, numPosPick: 2, numRookie: 0, name: "Jake Bates", team: "DET", position: "K", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 194, numPosPick: 3, numRookie: 0, name: "Cameron Dicker", team: "LAC", position: "K", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 195, numPosPick: 27, numRookie: 21, name: "Cameron Ward", team: "TEN", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: true),
            PlayerData(num: 196, numPosPick: 61, numRookie: 0, name: "Kendre Miller", team: "NO", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 197, numPosPick: 24, numRookie: 0, name: "Brenton Strange", team: "JAC", position: "TE", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 198, numPosPick: 11, numRookie: 0, name: "Los Angeles Rams", team: "LAR", position: "DST", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 199, numPosPick: 12, numRookie: 0, name: "Seattle Seahawks", team: "SEA", position: "DST", byeWeek: 8, isTopPlayer: true, isRookie: false),
            PlayerData(num: 200, numPosPick: 4, numRookie: 0, name: "Wil Lutz", team: "DEN", position: "K", byeWeek: 12, isTopPlayer: true, isRookie: false),
            PlayerData(num: 201, numPosPick: 73, numRookie: 0, name: "Michael Wilson", team: "ARI", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 202, numPosPick: 74, numRookie: 0, name: "Jalen Coker", team: "CAR", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 203, numPosPick: 75, numRookie: 22, name: "Jack Bech", team: "LV", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: true),
            PlayerData(num: 204, numPosPick: 13, numRookie: 0, name: "Green Bay Packers", team: "GB", position: "DST", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 205, numPosPick: 5, numRookie: 0, name: "Ka'imi Fairbairn", team: "HOU", position: "K", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 206, numPosPick: 62, numRookie: 23, name: "DJ Giddens", team: "IND", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: true),
            PlayerData(num: 207, numPosPick: 6, numRookie: 0, name: "Chase McLaughlin", team: "TB", position: "K", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 208, numPosPick: 14, numRookie: 0, name: "New York Jets", team: "NYJ", position: "DST", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 209, numPosPick: 7, numRookie: 0, name: "Chris Boswell", team: "PIT", position: "K", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 210, numPosPick: 63, numRookie: 24, name: "Devin Neal", team: "NO", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: true),
            PlayerData(num: 211, numPosPick: 28, numRookie: 0, name: "Aaron Rodgers", team: "PIT", position: "QB", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 212, numPosPick: 76, numRookie: 0, name: "Adonai Mitchell", team: "IND", position: "WR", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 213, numPosPick: 77, numRookie: 0, name: "Dontayvion Wicks", team: "GB", position: "WR", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 214, numPosPick: 25, numRookie: 0, name: "Chig Okonkwo", team: "TEN", position: "TE", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 215, numPosPick: 78, numRookie: 0, name: "Darius Slayton", team: "NYG", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 216, numPosPick: 8, numRookie: 0, name: "Evan McPherson", team: "CIN", position: "K", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 217, numPosPick: 9, numRookie: 0, name: "Harrison Butker", team: "KC", position: "K", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 218, numPosPick: 79, numRookie: 0, name: "Andrei Iosivas", team: "CIN", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 219, numPosPick: 10, numRookie: 0, name: "Tyler Bass", team: "BUF", position: "K", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 220, numPosPick: 64, numRookie: 0, name: "Miles Sanders", team: "DAL", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 221, numPosPick: 65, numRookie: 25, name: "Kyle Monangai", team: "CHI", position: "RB", byeWeek: 5, isTopPlayer: false, isRookie: true),
            PlayerData(num: 222, numPosPick: 26, numRookie: 26, name: "Mason Taylor", team: "NYJ", position: "TE", byeWeek: 9, isTopPlayer: false, isRookie: true),
            PlayerData(num: 223, numPosPick: 27, numRookie: 0, name: "Dalton Schultz", team: "HOU", position: "TE", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 224, numPosPick: 66, numRookie: 0, name: "Justice Hill", team: "BAL", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 225, numPosPick: 67, numRookie: 0, name: "Will Shipley", team: "PHI", position: "RB", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 226, numPosPick: 15, numRookie: 0, name: "San Francisco 49ers", team: "SF", position: "DST", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 227, numPosPick: 28, numRookie: 27, name: "Elijah Arroyo", team: "SEA", position: "TE", byeWeek: 8, isTopPlayer: false, isRookie: true),
            PlayerData(num: 228, numPosPick: 11, numRookie: 0, name: "Jake Elliott", team: "PHI", position: "K", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 229, numPosPick: 80, numRookie: 0, name: "Calvin Austin III", team: "PIT", position: "WR", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 230, numPosPick: 81, numRookie: 28, name: "Jaylin Noel", team: "HOU", position: "WR", byeWeek: 6, isTopPlayer: false, isRookie: true),
            PlayerData(num: 231, numPosPick: 12, numRookie: 0, name: "Jason Sanders", team: "MIA", position: "K", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 232, numPosPick: 68, numRookie: 0, name: "Keaton Mitchell", team: "BAL", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 233, numPosPick: 69, numRookie: 0, name: "Elijah Mitchell", team: "KC", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 234, numPosPick: 29, numRookie: 0, name: "Anthony Richardson Sr.", team: "IND", position: "QB", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 235, numPosPick: 70, numRookie: 0, name: "Audric Estime", team: "DEN", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 236, numPosPick: 71, numRookie: 0, name: "Jaleel McLaughlin", team: "DEN", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 237, numPosPick: 82, numRookie: 29, name: "Elic Ayomanor", team: "TEN", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: true),
            PlayerData(num: 238, numPosPick: 29, numRookie: 0, name: "Juwan Johnson", team: "NO", position: "TE", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 239, numPosPick: 13, numRookie: 0, name: "Younghoe Koo", team: "ATL", position: "K", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 240, numPosPick: 83, numRookie: 0, name: "Tyler Lockett", team: "TEN", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 241, numPosPick: 72, numRookie: 0, name: "Raheem Mostert", team: "LV", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 242, numPosPick: 84, numRookie: 30, name: "Pat Bryant", team: "DEN", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: true),
            PlayerData(num: 243, numPosPick: 30, numRookie: 0, name: "Ja'Tavion Sanders", team: "CAR", position: "TE", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 244, numPosPick: 16, numRookie: 0, name: "Dallas Cowboys", team: "DAL", position: "DST", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 245, numPosPick: 73, numRookie: 31, name: "Jarquez Hunter", team: "LAR", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: true),
            PlayerData(num: 246, numPosPick: 85, numRookie: 0, name: "Keenan Allen", team: "FA", position: "WR", byeWeek: 0, isTopPlayer: false, isRookie: false),
            PlayerData(num: 247, numPosPick: 86, numRookie: 0, name: "Devaughn Vele", team: "DEN", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 248, numPosPick: 31, numRookie: 0, name: "Cole Kmet", team: "CHI", position: "TE", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 249, numPosPick: 74, numRookie: 32, name: "Ollie Gordon II", team: "MIA", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: true),
            PlayerData(num: 250, numPosPick: 87, numRookie: 0, name: "Jalen Tolbert", team: "DAL", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 251, numPosPick: 75, numRookie: 0, name: "Devin Singletary", team: "NYG", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 252, numPosPick: 88, numRookie: 0, name: "Diontae Johnson", team: "CLE", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 253, numPosPick: 89, numRookie: 0, name: "Nick Westbrook-Ikhine", team: "MIA", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 254, numPosPick: 30, numRookie: 0, name: "Russell Wilson", team: "NYG", position: "QB", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 255, numPosPick: 17, numRookie: 0, name: "Tampa Bay Buccaneers", team: "TB", position: "DST", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 256, numPosPick: 14, numRookie: 0, name: "Matt Gay", team: "WAS", position: "K", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 257, numPosPick: 76, numRookie: 33, name: "Trevor Etienne", team: "CAR", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: true),
            PlayerData(num: 258, numPosPick: 90, numRookie: 34, name: "Jalen Royals", team: "KC", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: true),
            PlayerData(num: 259, numPosPick: 91, numRookie: 0, name: "Kayshon Boutte", team: "NE", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 260, numPosPick: 77, numRookie: 35, name: "Brashard Smith", team: "KC", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: true),
            PlayerData(num: 261, numPosPick: 92, numRookie: 0, name: "Brandin Cooks", team: "NO", position: "WR", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 262, numPosPick: 78, numRookie: 0, name: "Antonio Gibson", team: "NE", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 263, numPosPick: 93, numRookie: 0, name: "Roman Wilson", team: "PIT", position: "WR", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 264, numPosPick: 79, numRookie: 36, name: "Tahj Brooks", team: "CIN", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: true),
            PlayerData(num: 265, numPosPick: 80, numRookie: 0, name: "Kenneth Gainwell", team: "PIT", position: "RB", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 266, numPosPick: 94, numRookie: 0, name: "Elijah Moore", team: "BUF", position: "WR", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 267, numPosPick: 15, numRookie: 0, name: "Joshua Karty", team: "LAR", position: "K", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 268, numPosPick: 95, numRookie: 0, name: "Amari Cooper", team: "FA", position: "WR", byeWeek: 0, isTopPlayer: false, isRookie: false),
            PlayerData(num: 269, numPosPick: 81, numRookie: 0, name: "Sean Tucker", team: "TB", position: "RB", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 270, numPosPick: 96, numRookie: 0, name: "Dyami Brown", team: "JAC", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 271, numPosPick: 32, numRookie: 0, name: "Noah Gray", team: "KC", position: "TE", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 272, numPosPick: 31, numRookie: 0, name: "Daniel Jones", team: "IND", position: "QB", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 273, numPosPick: 33, numRookie: 0, name: "Taysom Hill", team: "NO", position: "TE", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 274, numPosPick: 18, numRookie: 0, name: "Cleveland Browns", team: "CLE", position: "DST", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 275, numPosPick: 82, numRookie: 37, name: "Jordan James", team: "SF", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: true),
            PlayerData(num: 276, numPosPick: 83, numRookie: 0, name: "Khalil Herbert", team: "IND", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 277, numPosPick: 84, numRookie: 38, name: "Woody Marks", team: "HOU", position: "RB", byeWeek: 6, isTopPlayer: false, isRookie: true),
            PlayerData(num: 278, numPosPick: 97, numRookie: 0, name: "Malik Washington", team: "MIA", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 279, numPosPick: 85, numRookie: 0, name: "Ty Johnson", team: "BUF", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 280, numPosPick: 86, numRookie: 0, name: "Isaiah Davis", team: "NYJ", position: "RB", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 281, numPosPick: 34, numRookie: 39, name: "Harold Fannin Jr.", team: "CLE", position: "TE", byeWeek: 9, isTopPlayer: false, isRookie: true),
            PlayerData(num: 282, numPosPick: 98, numRookie: 0, name: "Tim Patrick", team: "DET", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 283, numPosPick: 87, numRookie: 0, name: "Alexander Mattison", team: "MIA", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 284, numPosPick: 99, numRookie: 0, name: "Tre Tucker", team: "LV", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 285, numPosPick: 100, numRookie: 0, name: "Jalen Nailor", team: "MIN", position: "WR", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 286, numPosPick: 88, numRookie: 0, name: "Zack Moss", team: "FA", position: "RB", byeWeek: 0, isTopPlayer: false, isRookie: false),
            PlayerData(num: 287, numPosPick: 32, numRookie: 40, name: "Tyler Shough", team: "NO", position: "QB", byeWeek: 11, isTopPlayer: false, isRookie: true),
            PlayerData(num: 288, numPosPick: 19, numRookie: 0, name: "Chicago Bears", team: "CHI", position: "DST", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 289, numPosPick: 35, numRookie: 0, name: "Theo Johnson", team: "NYG", position: "TE", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 290, numPosPick: 36, numRookie: 0, name: "Darren Waller", team: "MIA", position: "TE", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 291, numPosPick: 33, numRookie: 0, name: "Joe Flacco", team: "CLE", position: "QB", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 292, numPosPick: 89, numRookie: 0, name: "Sincere McCormick", team: "LV", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 293, numPosPick: 16, numRookie: 0, name: "Daniel Carlson", team: "LV", position: "K", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 294, numPosPick: 101, numRookie: 0, name: "Parker Washington", team: "JAC", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 295, numPosPick: 90, numRookie: 0, name: "Kimani Vidal", team: "LAC", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 296, numPosPick: 102, numRookie: 41, name: "Xavier Restrepo", team: "TEN", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: true),
            PlayerData(num: 297, numPosPick: 103, numRookie: 0, name: "Christian Watson", team: "GB", position: "WR", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 298, numPosPick: 91, numRookie: 42, name: "Damien Martinez", team: "SEA", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: true),
            PlayerData(num: 299, numPosPick: 37, numRookie: 0, name: "Noah Fant", team: "FA", position: "TE", byeWeek: 0, isTopPlayer: false, isRookie: false),
            PlayerData(num: 300, numPosPick: 34, numRookie: 43, name: "Jaxson Dart", team: "NYG", position: "QB", byeWeek: 14, isTopPlayer: false, isRookie: true),
            PlayerData(num: 301, numPosPick: 38, numRookie: 44, name: "Terrance Ferguson", team: "LAR", position: "TE", byeWeek: 8, isTopPlayer: false, isRookie: true),
            PlayerData(num: 302, numPosPick: 92, numRookie: 0, name: "Dameon Pierce", team: "HOU", position: "RB", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 303, numPosPick: 104, numRookie: 0, name: "Luke McCaffrey", team: "WAS", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 304, numPosPick: 39, numRookie: 45, name: "Oronde Gadsden II", team: "LAC", position: "TE", byeWeek: 12, isTopPlayer: false, isRookie: true),
            PlayerData(num: 305, numPosPick: 105, numRookie: 46, name: "Tory Horton", team: "SEA", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: true),
            PlayerData(num: 306, numPosPick: 93, numRookie: 0, name: "Emanuel Wilson", team: "GB", position: "RB", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 307, numPosPick: 106, numRookie: 0, name: "Gabe Davis", team: "FA", position: "WR", byeWeek: 0, isTopPlayer: false, isRookie: false),
            PlayerData(num: 308, numPosPick: 107, numRookie: 0, name: "Jermaine Burton", team: "CIN", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 309, numPosPick: 94, numRookie: 47, name: "Jacory Croskey-Merritt", team: "WAS", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: true),
            PlayerData(num: 310, numPosPick: 95, numRookie: 0, name: "Ty Chandler", team: "MIN", position: "RB", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 311, numPosPick: 96, numRookie: 0, name: "Chris Brooks", team: "GB", position: "RB", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 312, numPosPick: 97, numRookie: 48, name: "Phil Mafah", team: "DAL", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: true),
            PlayerData(num: 313, numPosPick: 108, numRookie: 49, name: "Isaac TeSlaa", team: "DET", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: true),
            PlayerData(num: 314, numPosPick: 17, numRookie: 0, name: "Will Reichard", team: "MIN", position: "K", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 315, numPosPick: 109, numRookie: 50, name: "Tez Johnson", team: "TB", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: true),
            PlayerData(num: 316, numPosPick: 110, numRookie: 51, name: "Dont'e Thornton Jr.", team: "LV", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: true),
            PlayerData(num: 317, numPosPick: 18, numRookie: 0, name: "Tyler Loop", team: "BAL", position: "K", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 318, numPosPick: 19, numRookie: 0, name: "Jason Myers", team: "SEA", position: "K", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 319, numPosPick: 20, numRookie: 0, name: "New England Patriots", team: "NE", position: "DST", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 320, numPosPick: 40, numRookie: 0, name: "Ben Sinnott", team: "WAS", position: "TE", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 321, numPosPick: 41, numRookie: 0, name: "Tyler Higbee", team: "LAR", position: "TE", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 322, numPosPick: 42, numRookie: 0, name: "Will Dissly", team: "LAC", position: "TE", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 323, numPosPick: 98, numRookie: 52, name: "Raheim Sanders", team: "LAC", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: true),
            PlayerData(num: 324, numPosPick: 21, numRookie: 0, name: "Miami Dolphins", team: "MIA", position: "DST", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 325, numPosPick: 35, numRookie: 53, name: "Shedeur Sanders", team: "CLE", position: "QB", byeWeek: 9, isTopPlayer: false, isRookie: true),
            PlayerData(num: 326, numPosPick: 111, numRookie: 0, name: "Tutu Atwell", team: "LAR", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 327, numPosPick: 22, numRookie: 0, name: "Arizona Cardinals", team: "ARI", position: "DST", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 328, numPosPick: 99, numRookie: 0, name: "Chris Rodriguez Jr.", team: "WAS", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 329, numPosPick: 36, numRookie: 0, name: "Tyrod Taylor", team: "NYJ", position: "QB", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 330, numPosPick: 100, numRookie: 0, name: "Gus Edwards", team: "FA", position: "RB", byeWeek: 0, isTopPlayer: false, isRookie: false),
            PlayerData(num: 331, numPosPick: 101, numRookie: 0, name: "Cam Akers", team: "NO", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 332, numPosPick: 43, numRookie: 0, name: "Tyler Conklin", team: "LAC", position: "TE", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 333, numPosPick: 102, numRookie: 0, name: "A.J. Dillon", team: "PHI", position: "RB", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 334, numPosPick: 103, numRookie: 0, name: "Zamir White", team: "LV", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 335, numPosPick: 112, numRookie: 54, name: "Tai Felton", team: "MIN", position: "WR", byeWeek: 6, isTopPlayer: false, isRookie: true),
            PlayerData(num: 336, numPosPick: 113, numRookie: 0, name: "Jordan Whittington", team: "LAR", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 337, numPosPick: 114, numRookie: 0, name: "Marquez Valdes-Scantling", team: "SEA", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 338, numPosPick: 115, numRookie: 0, name: "Ray-Ray McCloud III", team: "ATL", position: "WR", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 339, numPosPick: 116, numRookie: 0, name: "Demarcus Robinson", team: "SF", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 340, numPosPick: 117, numRookie: 0, name: "John Metchie III", team: "HOU", position: "WR", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 341, numPosPick: 37, numRookie: 55, name: "Jalen Milroe", team: "SEA", position: "QB", byeWeek: 8, isTopPlayer: false, isRookie: true),
            PlayerData(num: 342, numPosPick: 20, numRookie: 0, name: "Justin Tucker", team: "FA", position: "K", byeWeek: 0, isTopPlayer: false, isRookie: false),
            PlayerData(num: 343, numPosPick: 118, numRookie: 0, name: "Troy Franklin", team: "DEN", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 344, numPosPick: 21, numRookie: 0, name: "Jake Moody", team: "SF", position: "K", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 345, numPosPick: 119, numRookie: 56, name: "Savion Williams", team: "GB", position: "WR", byeWeek: 5, isTopPlayer: false, isRookie: true),
            PlayerData(num: 346, numPosPick: 44, numRookie: 0, name: "Dawson Knox", team: "BUF", position: "TE", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 347, numPosPick: 120, numRookie: 0, name: "Josh Reynolds", team: "NYJ", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 348, numPosPick: 121, numRookie: 57, name: "Isaiah Bond", team: "FA", position: "WR", byeWeek: 0, isTopPlayer: false, isRookie: true),
            PlayerData(num: 349, numPosPick: 104, numRookie: 0, name: "Samaje Perine", team: "CIN", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 350, numPosPick: 122, numRookie: 0, name: "Noah Brown", team: "WAS", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 351, numPosPick: 105, numRookie: 58, name: "Donovan Edwards", team: "NYJ", position: "RB", byeWeek: 9, isTopPlayer: false, isRookie: true),
            PlayerData(num: 352, numPosPick: 23, numRookie: 0, name: "New York Giants", team: "NYG", position: "DST", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 353, numPosPick: 38, numRookie: 0, name: "Kirk Cousins", team: "ATL", position: "QB", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 354, numPosPick: 123, numRookie: 0, name: "KaVontae Turpin", team: "DAL", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 355, numPosPick: 124, numRookie: 59, name: "Chimere Dike", team: "TEN", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: true),
            PlayerData(num: 356, numPosPick: 125, numRookie: 0, name: "Mack Hollins", team: "NE", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 357, numPosPick: 45, numRookie: 0, name: "Michael Mayer", team: "LV", position: "TE", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 358, numPosPick: 126, numRookie: 0, name: "Tank Dell", team: "HOU", position: "WR", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 359, numPosPick: 22, numRookie: 0, name: "Cam Little", team: "JAC", position: "K", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 360, numPosPick: 23, numRookie: 0, name: "Brandon McManus", team: "GB", position: "K", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 361, numPosPick: 46, numRookie: 0, name: "Luke Musgrave", team: "GB", position: "TE", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 362, numPosPick: 127, numRookie: 0, name: "Allen Lazard", team: "NYJ", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 363, numPosPick: 39, numRookie: 0, name: "Spencer Rattler", team: "NO", position: "QB", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 364, numPosPick: 24, numRookie: 0, name: "Washington Commanders", team: "WAS", position: "DST", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 365, numPosPick: 47, numRookie: 0, name: "AJ Barner", team: "SEA", position: "TE", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 366, numPosPick: 128, numRookie: 0, name: "Curtis Samuel", team: "BUF", position: "WR", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 367, numPosPick: 40, numRookie: 0, name: "Jameis Winston", team: "NYG", position: "QB", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 368, numPosPick: 106, numRookie: 0, name: "Trey Sermon", team: "PIT", position: "RB", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 369, numPosPick: 48, numRookie: 0, name: "Austin Hooper", team: "NE", position: "TE", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 370, numPosPick: 41, numRookie: 0, name: "Kenny Pickett", team: "CLE", position: "QB", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 371, numPosPick: 24, numRookie: 0, name: "Eddy Pineiro", team: "FA", position: "K", byeWeek: 0, isTopPlayer: false, isRookie: false),
            PlayerData(num: 372, numPosPick: 25, numRookie: 0, name: "Atlanta Falcons", team: "ATL", position: "DST", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 373, numPosPick: 107, numRookie: 60, name: "LeQuint Allen Jr.", team: "JAC", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: true),
            PlayerData(num: 374, numPosPick: 49, numRookie: 61, name: "Gunnar Helm", team: "TEN", position: "TE", byeWeek: 10, isTopPlayer: false, isRookie: true),
            PlayerData(num: 375, numPosPick: 129, numRookie: 0, name: "Greg Dortch", team: "ARI", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 376, numPosPick: 108, numRookie: 62, name: "Kalel Mullings", team: "TEN", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: true),
            PlayerData(num: 377, numPosPick: 130, numRookie: 63, name: "Jaylin Lane", team: "WAS", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: true),
            PlayerData(num: 378, numPosPick: 25, numRookie: 0, name: "Matt Prater", team: "FA", position: "K", byeWeek: 0, isTopPlayer: false, isRookie: false),
            PlayerData(num: 379, numPosPick: 131, numRookie: 0, name: "Jahan Dotson", team: "PHI", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 380, numPosPick: 26, numRookie: 0, name: "Cairo Santos", team: "CHI", position: "K", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 381, numPosPick: 132, numRookie: 64, name: "Antwane Wells Jr.", team: "NYG", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: true),
            PlayerData(num: 382, numPosPick: 109, numRookie: 0, name: "Ameer Abdullah", team: "FA", position: "RB", byeWeek: 0, isTopPlayer: false, isRookie: false),
            PlayerData(num: 383, numPosPick: 133, numRookie: 0, name: "Van Jefferson", team: "TEN", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 384, numPosPick: 42, numRookie: 65, name: "Dillon Gabriel", team: "CLE", position: "QB", byeWeek: 9, isTopPlayer: false, isRookie: true),
            PlayerData(num: 385, numPosPick: 134, numRookie: 0, name: "Robert Woods", team: "PIT", position: "WR", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 386, numPosPick: 27, numRookie: 0, name: "Blake Grupe", team: "NO", position: "K", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 387, numPosPick: 50, numRookie: 0, name: "Foster Moreau", team: "NO", position: "TE", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 388, numPosPick: 110, numRookie: 0, name: "Ja'Quinden Jackson", team: "JAC", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 389, numPosPick: 26, numRookie: 0, name: "Indianapolis Colts", team: "IND", position: "DST", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 390, numPosPick: 51, numRookie: 0, name: "Luke Schoonmaker", team: "DAL", position: "TE", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 391, numPosPick: 52, numRookie: 0, name: "Tommy Tremble", team: "CAR", position: "TE", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 392, numPosPick: 28, numRookie: 0, name: "Graham Gano", team: "NYG", position: "K", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 393, numPosPick: 135, numRookie: 66, name: "Theo Wease Jr.", team: "MIA", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: true),
            PlayerData(num: 394, numPosPick: 136, numRookie: 0, name: "Jalin Hyatt", team: "NYG", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 395, numPosPick: 43, numRookie: 0, name: "Mason Rudolph", team: "PIT", position: "QB", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 396, numPosPick: 111, numRookie: 0, name: "Emari Demercado", team: "ARI", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 397, numPosPick: 112, numRookie: 0, name: "Jonathon Brooks", team: "CAR", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 398, numPosPick: 29, numRookie: 0, name: "Chad Ryland", team: "ARI", position: "K", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 399, numPosPick: 113, numRookie: 0, name: "Jeremy McNichols", team: "WAS", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 400, numPosPick: 137, numRookie: 0, name: "Olamide Zaccheaus", team: "CHI", position: "WR", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 401, numPosPick: 138, numRookie: 67, name: "Arian Smith", team: "NYJ", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: true),
            PlayerData(num: 402, numPosPick: 139, numRookie: 0, name: "Kendrick Bourne", team: "NE", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 403, numPosPick: 140, numRookie: 0, name: "Ja'Lynn Polk", team: "NE", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 404, numPosPick: 30, numRookie: 0, name: "Nick Folk", team: "NYJ", position: "K", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 405, numPosPick: 114, numRookie: 0, name: "Kyle Juszczyk", team: "SF", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 406, numPosPick: 27, numRookie: 0, name: "Cincinnati Bengals", team: "CIN", position: "DST", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 407, numPosPick: 115, numRookie: 0, name: "D'Ernest Johnson", team: "FA", position: "RB", byeWeek: 0, isTopPlayer: false, isRookie: false),
            PlayerData(num: 408, numPosPick: 141, numRookie: 0, name: "Jacob Cowing", team: "SF", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 409, numPosPick: 28, numRookie: 0, name: "New Orleans Saints", team: "NO", position: "DST", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 410, numPosPick: 29, numRookie: 0, name: "Las Vegas Raiders", team: "LV", position: "DST", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 411, numPosPick: 53, numRookie: 0, name: "Josh Oliver", team: "MIN", position: "TE", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 412, numPosPick: 116, numRookie: 0, name: "Craig Reynolds", team: "DET", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 413, numPosPick: 54, numRookie: 0, name: "Grant Calcaterra", team: "PHI", position: "TE", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 414, numPosPick: 55, numRookie: 0, name: "Cade Stover", team: "HOU", position: "TE", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 415, numPosPick: 56, numRookie: 68, name: "Luke Lachey", team: "HOU", position: "TE", byeWeek: 6, isTopPlayer: false, isRookie: true),
            PlayerData(num: 416, numPosPick: 44, numRookie: 0, name: "Deshaun Watson", team: "CLE", position: "QB", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 417, numPosPick: 117, numRookie: 0, name: "Chris Tyree", team: "NO", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 418, numPosPick: 45, numRookie: 0, name: "Joe Milton III", team: "DAL", position: "QB", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 419, numPosPick: 46, numRookie: 69, name: "Will Howard", team: "PIT", position: "QB", byeWeek: 5, isTopPlayer: false, isRookie: true),
            PlayerData(num: 420, numPosPick: 142, numRookie: 0, name: "Malachi Corley", team: "NYJ", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 421, numPosPick: 47, numRookie: 0, name: "Aidan O'Connell", team: "LV", position: "QB", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 422, numPosPick: 143, numRookie: 0, name: "Devontez Walker", team: "BAL", position: "WR", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 423, numPosPick: 57, numRookie: 70, name: "Mitchell Evans", team: "CAR", position: "TE", byeWeek: 14, isTopPlayer: false, isRookie: true),
            PlayerData(num: 424, numPosPick: 58, numRookie: 0, name: "Stone Smartt", team: "NYJ", position: "TE", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 425, numPosPick: 144, numRookie: 0, name: "Jonathan Mingo", team: "DAL", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 426, numPosPick: 118, numRookie: 0, name: "Clyde Edwards-Helaire", team: "NO", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 427, numPosPick: 145, numRookie: 0, name: "Kalif Raymond", team: "DET", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 428, numPosPick: 30, numRookie: 0, name: "Jacksonville Jaguars", team: "JAC", position: "DST", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 429, numPosPick: 146, numRookie: 0, name: "Javon Baker", team: "NE", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 430, numPosPick: 119, numRookie: 0, name: "Cordarrelle Patterson", team: "FA", position: "RB", byeWeek: 0, isTopPlayer: false, isRookie: false),
            PlayerData(num: 431, numPosPick: 147, numRookie: 0, name: "Zay Jones", team: "ARI", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 432, numPosPick: 148, numRookie: 0, name: "Hunter Renfrow", team: "CAR", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 433, numPosPick: 149, numRookie: 0, name: "JuJu Smith-Schuster", team: "KC", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 434, numPosPick: 150, numRookie: 0, name: "Michael Gallup", team: "WAS", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 435, numPosPick: 59, numRookie: 0, name: "Elijah Higgins", team: "ARI", position: "TE", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 436, numPosPick: 120, numRookie: 0, name: "Tyler Goodson", team: "IND", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 437, numPosPick: 121, numRookie: 0, name: "Pierre Strong Jr.", team: "CLE", position: "RB", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 438, numPosPick: 151, numRookie: 0, name: "Derius Davis", team: "LAC", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 439, numPosPick: 60, numRookie: 0, name: "Darnell Washington", team: "PIT", position: "TE", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 440, numPosPick: 48, numRookie: 0, name: "Zach Wilson", team: "MIA", position: "QB", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 441, numPosPick: 152, numRookie: 0, name: "Tyler Johnson", team: "NYJ", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 442, numPosPick: 153, numRookie: 0, name: "Treylon Burks", team: "TEN", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 443, numPosPick: 61, numRookie: 0, name: "Jeremy Ruckert", team: "NYJ", position: "TE", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 444, numPosPick: 122, numRookie: 0, name: "Alec Ingold", team: "MIA", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 445, numPosPick: 123, numRookie: 0, name: "Hunter Luepke", team: "DAL", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 446, numPosPick: 154, numRookie: 71, name: "Kaden Prather", team: "BUF", position: "WR", byeWeek: 7, isTopPlayer: false, isRookie: true),
            PlayerData(num: 447, numPosPick: 62, numRookie: 0, name: "Greg Dulcich", team: "NYG", position: "TE", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 448, numPosPick: 124, numRookie: 0, name: "C.J. Ham", team: "MIN", position: "RB", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 449, numPosPick: 49, numRookie: 0, name: "Marcus Mariota", team: "WAS", position: "QB", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 450, numPosPick: 125, numRookie: 0, name: "Deuce Vaughn", team: "DAL", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 451, numPosPick: 155, numRookie: 0, name: "Julian Fleming", team: "FA", position: "WR", byeWeek: 0, isTopPlayer: false, isRookie: false),
            PlayerData(num: 452, numPosPick: 126, numRookie: 0, name: "Jaydn Ott", team: "FA", position: "RB", byeWeek: 0, isTopPlayer: false, isRookie: false),
            PlayerData(num: 453, numPosPick: 156, numRookie: 72, name: "Jordan Watkins", team: "SF", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: true),
            PlayerData(num: 454, numPosPick: 127, numRookie: 0, name: "Julius Chestnut", team: "TEN", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 455, numPosPick: 157, numRookie: 73, name: "KeAndre Lambert-Smith", team: "LAC", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: true),
            PlayerData(num: 456, numPosPick: 158, numRookie: 0, name: "KhaDarel Hodge", team: "ATL", position: "WR", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 457, numPosPick: 159, numRookie: 0, name: "DJ Chark Jr.", team: "ATL", position: "WR", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 458, numPosPick: 50, numRookie: 0, name: "Malik Willis", team: "GB", position: "QB", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 459, numPosPick: 63, numRookie: 0, name: "Brevin Jordan", team: "HOU", position: "TE", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 460, numPosPick: 64, numRookie: 0, name: "Josh Whyle", team: "TEN", position: "TE", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 461, numPosPick: 160, numRookie: 0, name: "Bub Means", team: "NO", position: "WR", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 462, numPosPick: 128, numRookie: 0, name: "Michael Carter", team: "ARI", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 463, numPosPick: 129, numRookie: 0, name: "Tyler Badie", team: "DEN", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 464, numPosPick: 65, numRookie: 0, name: "Julian Hill", team: "MIA", position: "TE", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 465, numPosPick: 161, numRookie: 74, name: "Efton Chism III", team: "NE", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: true),
            PlayerData(num: 466, numPosPick: 130, numRookie: 75, name: "Marcus Yarns", team: "NO", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: true),
            PlayerData(num: 467, numPosPick: 162, numRookie: 0, name: "Jake Bobo", team: "SEA", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 468, numPosPick: 51, numRookie: 0, name: "Gardner Minshew II", team: "KC", position: "QB", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 469, numPosPick: 163, numRookie: 0, name: "David Bell", team: "CLE", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 470, numPosPick: 66, numRookie: 0, name: "Colby Parkinson", team: "LAR", position: "TE", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 471, numPosPick: 52, numRookie: 0, name: "Sam Howell", team: "MIN", position: "QB", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 472, numPosPick: 131, numRookie: 0, name: "Hassan Haskins", team: "LAC", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 473, numPosPick: 164, numRookie: 0, name: "K.J. Osborn", team: "WAS", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 474, numPosPick: 132, numRookie: 0, name: "Rasheen Ali", team: "BAL", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 475, numPosPick: 67, numRookie: 0, name: "Kylen Granson", team: "PHI", position: "TE", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 476, numPosPick: 165, numRookie: 0, name: "Rondale Moore", team: "MIN", position: "WR", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 477, numPosPick: 68, numRookie: 0, name: "Daniel Bellinger", team: "NYG", position: "TE", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 478, numPosPick: 133, numRookie: 0, name: "Carson Steele", team: "KC", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 479, numPosPick: 134, numRookie: 0, name: "Michael Burton", team: "DEN", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 480, numPosPick: 135, numRookie: 0, name: "Patrick Taylor Jr.", team: "SF", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 481, numPosPick: 166, numRookie: 76, name: "Jimmy Horn Jr.", team: "CAR", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: true),
            PlayerData(num: 482, numPosPick: 136, numRookie: 0, name: "Dare Ogunbowale", team: "HOU", position: "RB", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 483, numPosPick: 69, numRookie: 0, name: "John Bates", team: "WAS", position: "TE", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 484, numPosPick: 70, numRookie: 0, name: "Tanner Hudson", team: "CIN", position: "TE", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 485, numPosPick: 137, numRookie: 0, name: "Ronnie Rivers", team: "LAR", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 486, numPosPick: 71, numRookie: 0, name: "Adam Trautman", team: "DEN", position: "TE", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 487, numPosPick: 167, numRookie: 0, name: "David Moore", team: "CAR", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 488, numPosPick: 53, numRookie: 0, name: "Mac Jones", team: "SF", position: "QB", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 489, numPosPick: 72, numRookie: 0, name: "Jelani Woods", team: "IND", position: "TE", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 490, numPosPick: 168, numRookie: 0, name: "Mecole Hardman Jr.", team: "GB", position: "WR", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 491, numPosPick: 138, numRookie: 77, name: "Lan Larison", team: "NE", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: true),
            PlayerData(num: 492, numPosPick: 54, numRookie: 0, name: "Taylor Heinicke", team: "LAC", position: "QB", byeWeek: 12, isTopPlayer: false, isRookie: false),
            PlayerData(num: 493, numPosPick: 55, numRookie: 0, name: "Cooper Rush", team: "BAL", position: "QB", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 494, numPosPick: 73, numRookie: 0, name: "Harrison Bryant", team: "PHI", position: "TE", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 495, numPosPick: 74, numRookie: 0, name: "Brock Wright", team: "DET", position: "TE", byeWeek: 8, isTopPlayer: false, isRookie: false),
            PlayerData(num: 496, numPosPick: 169, numRookie: 0, name: "Cedrick Wilson Jr.", team: "NO", position: "WR", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 497, numPosPick: 56, numRookie: 0, name: "Kyle Trask", team: "TB", position: "QB", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 498, numPosPick: 75, numRookie: 0, name: "Drew Sample", team: "CIN", position: "TE", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 499, numPosPick: 57, numRookie: 0, name: "Jake Browning", team: "CIN", position: "QB", byeWeek: 10, isTopPlayer: false, isRookie: false)
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
            allPlayers=[
                PlayerData(num: 1, numPosPick: 1, numRookie: 0, name: "Ja'Marr Chase", team: "CIN", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 2, numPosPick: 1, numRookie: 0, name: "Saquon Barkley", team: "PHI", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 3, numPosPick: 2, numRookie: 0, name: "Bijan Robinson", team: "ATL", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 4, numPosPick: 2, numRookie: 0, name: "Justin Jefferson", team: "MIN", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 5, numPosPick: 3, numRookie: 0, name: "CeeDee Lamb", team: "DAL", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 6, numPosPick: 3, numRookie: 0, name: "Jahmyr Gibbs", team: "DET", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 7, numPosPick: 4, numRookie: 0, name: "Derrick Henry", team: "BAL", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 8, numPosPick: 4, numRookie: 0, name: "Puka Nacua", team: "LAR", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 9, numPosPick: 5, numRookie: 0, name: "Nico Collins", team: "HOU", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 10, numPosPick: 6, numRookie: 0, name: "Brian Thomas Jr.", team: "JAC", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 11, numPosPick: 7, numRookie: 0, name: "Malik Nabers", team: "NYG", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 12, numPosPick: 5, numRookie: 1, name: "Ashton Jeanty", team: "LV", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: true),
                PlayerData(num: 13, numPosPick: 8, numRookie: 0, name: "Amon-Ra St. Brown", team: "DET", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 14, numPosPick: 6, numRookie: 0, name: "Christian McCaffrey", team: "SF", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 15, numPosPick: 7, numRookie: 0, name: "Jonathan Taylor", team: "IND", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 16, numPosPick: 9, numRookie: 0, name: "A.J. Brown", team: "PHI", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 17, numPosPick: 8, numRookie: 0, name: "De'Von Achane", team: "MIA", position: "RB", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 18, numPosPick: 9, numRookie: 0, name: "Josh Jacobs", team: "GB", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 19, numPosPick: 10, numRookie: 0, name: "Drake London", team: "ATL", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 20, numPosPick: 1, numRookie: 0, name: "George Kittle", team: "SF", position: "TE", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 21, numPosPick: 2, numRookie: 0, name: "Brock Bowers", team: "LV", position: "TE", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 22, numPosPick: 11, numRookie: 0, name: "Ladd McConkey", team: "LAC", position: "WR", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 23, numPosPick: 10, numRookie: 0, name: "Bucky Irving", team: "TB", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 24, numPosPick: 11, numRookie: 0, name: "Kyren Williams", team: "LAR", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 25, numPosPick: 1, numRookie: 0, name: "Josh Allen", team: "BUF", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 26, numPosPick: 2, numRookie: 0, name: "Lamar Jackson", team: "BAL", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 27, numPosPick: 12, numRookie: 0, name: "Tee Higgins", team: "CIN", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 28, numPosPick: 13, numRookie: 0, name: "Mike Evans", team: "TB", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 29, numPosPick: 14, numRookie: 0, name: "Tyreek Hill", team: "MIA", position: "WR", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 30, numPosPick: 12, numRookie: 0, name: "Chase Brown", team: "CIN", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 31, numPosPick: 3, numRookie: 0, name: "Jayden Daniels", team: "WAS", position: "QB", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 32, numPosPick: 3, numRookie: 0, name: "Trey McBride", team: "ARI", position: "TE", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 33, numPosPick: 13, numRookie: 0, name: "James Cook", team: "BUF", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 34, numPosPick: 15, numRookie: 0, name: "Davante Adams", team: "LAR", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 35, numPosPick: 16, numRookie: 0, name: "Jaxon Smith-Njigba", team: "SEA", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 36, numPosPick: 17, numRookie: 0, name: "Terry McLaurin", team: "WAS", position: "WR", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 37, numPosPick: 4, numRookie: 0, name: "Jalen Hurts", team: "PHI", position: "QB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 38, numPosPick: 14, numRookie: 0, name: "Breece Hall", team: "NYJ", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 39, numPosPick: 18, numRookie: 0, name: "Garrett Wilson", team: "NYJ", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 40, numPosPick: 19, numRookie: 0, name: "Marvin Harrison Jr.", team: "ARI", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 41, numPosPick: 15, numRookie: 0, name: "Kenneth Walker III", team: "SEA", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 42, numPosPick: 16, numRookie: 0, name: "Chuba Hubbard", team: "CAR", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 43, numPosPick: 20, numRookie: 0, name: "DK Metcalf", team: "PIT", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 44, numPosPick: 17, numRookie: 0, name: "James Conner", team: "ARI", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 45, numPosPick: 18, numRookie: 2, name: "Omarion Hampton", team: "LAC", position: "RB", byeWeek: 12, isTopPlayer: true, isRookie: true),
                PlayerData(num: 46, numPosPick: 19, numRookie: 0, name: "Alvin Kamara", team: "NO", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 47, numPosPick: 21, numRookie: 0, name: "Jameson Williams", team: "DET", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 48, numPosPick: 5, numRookie: 0, name: "Joe Burrow", team: "CIN", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 49, numPosPick: 22, numRookie: 0, name: "Courtland Sutton", team: "DEN", position: "WR", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 50, numPosPick: 23, numRookie: 0, name: "DJ Moore", team: "CHI", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 51, numPosPick: 24, numRookie: 0, name: "Zay Flowers", team: "BAL", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 52, numPosPick: 20, numRookie: 0, name: "David Montgomery", team: "DET", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 53, numPosPick: 25, numRookie: 0, name: "Xavier Worthy", team: "KC", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 54, numPosPick: 26, numRookie: 0, name: "DeVonta Smith", team: "PHI", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 55, numPosPick: 4, numRookie: 0, name: "Sam LaPorta", team: "DET", position: "TE", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 56, numPosPick: 21, numRookie: 0, name: "Joe Mixon", team: "HOU", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 57, numPosPick: 22, numRookie: 0, name: "D'Andre Swift", team: "CHI", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 58, numPosPick: 27, numRookie: 0, name: "Rashee Rice", team: "KC", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 59, numPosPick: 23, numRookie: 3, name: "TreVeyon Henderson", team: "NE", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: true),
                PlayerData(num: 60, numPosPick: 28, numRookie: 0, name: "Calvin Ridley", team: "TEN", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 61, numPosPick: 6, numRookie: 0, name: "Patrick Mahomes II", team: "KC", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 62, numPosPick: 29, numRookie: 0, name: "George Pickens", team: "DAL", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 63, numPosPick: 24, numRookie: 4, name: "RJ Harvey", team: "DEN", position: "RB", byeWeek: 12, isTopPlayer: true, isRookie: true),
                PlayerData(num: 64, numPosPick: 25, numRookie: 0, name: "Aaron Jones Sr.", team: "MIN", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 65, numPosPick: 26, numRookie: 5, name: "Kaleb Johnson", team: "PIT", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: true),
                PlayerData(num: 66, numPosPick: 30, numRookie: 6, name: "Tetairoa McMillan", team: "CAR", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: true),
                PlayerData(num: 67, numPosPick: 7, numRookie: 0, name: "Baker Mayfield", team: "TB", position: "QB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 68, numPosPick: 27, numRookie: 0, name: "Tony Pollard", team: "TEN", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 69, numPosPick: 31, numRookie: 0, name: "Jaylen Waddle", team: "MIA", position: "WR", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 70, numPosPick: 28, numRookie: 0, name: "Isiah Pacheco", team: "KC", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 71, numPosPick: 5, numRookie: 0, name: "Mark Andrews", team: "BAL", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 72, numPosPick: 29, numRookie: 0, name: "Brian Robinson Jr.", team: "WAS", position: "RB", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 73, numPosPick: 8, numRookie: 0, name: "Bo Nix", team: "DEN", position: "QB", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 74, numPosPick: 32, numRookie: 7, name: "Travis Hunter", team: "JAC", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: true),
                PlayerData(num: 75, numPosPick: 6, numRookie: 0, name: "T.J. Hockenson", team: "MIN", position: "TE", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 76, numPosPick: 33, numRookie: 0, name: "Chris Olave", team: "NO", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 77, numPosPick: 34, numRookie: 0, name: "Jordan Addison", team: "MIN", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 78, numPosPick: 9, numRookie: 0, name: "Kyler Murray", team: "ARI", position: "QB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 79, numPosPick: 35, numRookie: 0, name: "Rome Odunze", team: "CHI", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 80, numPosPick: 36, numRookie: 0, name: "Jerry Jeudy", team: "CLE", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 81, numPosPick: 37, numRookie: 0, name: "Jayden Reed", team: "GB", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 82, numPosPick: 7, numRookie: 0, name: "Travis Kelce", team: "KC", position: "TE", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 83, numPosPick: 38, numRookie: 0, name: "Jauan Jennings", team: "SF", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 84, numPosPick: 30, numRookie: 0, name: "Tyrone Tracy Jr.", team: "NYG", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 85, numPosPick: 39, numRookie: 0, name: "Chris Godwin", team: "TB", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 86, numPosPick: 10, numRookie: 0, name: "Justin Fields", team: "NYJ", position: "QB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 87, numPosPick: 31, numRookie: 0, name: "Travis Etienne Jr.", team: "JAC", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 88, numPosPick: 40, numRookie: 0, name: "Deebo Samuel Sr.", team: "WAS", position: "WR", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 89, numPosPick: 8, numRookie: 0, name: "Tucker Kraft", team: "GB", position: "TE", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 90, numPosPick: 9, numRookie: 0, name: "David Njoku", team: "CLE", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 91, numPosPick: 32, numRookie: 8, name: "Quinshon Judkins", team: "CLE", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: true),
                PlayerData(num: 92, numPosPick: 11, numRookie: 0, name: "Brock Purdy", team: "SF", position: "QB", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 93, numPosPick: 33, numRookie: 0, name: "Najee Harris", team: "LAC", position: "RB", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 94, numPosPick: 12, numRookie: 0, name: "Dak Prescott", team: "DAL", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 95, numPosPick: 13, numRookie: 0, name: "Justin Herbert", team: "LAC", position: "QB", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 96, numPosPick: 14, numRookie: 0, name: "Caleb Williams", team: "CHI", position: "QB", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 97, numPosPick: 34, numRookie: 0, name: "Jaylen Warren", team: "PIT", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 98, numPosPick: 35, numRookie: 0, name: "Jordan Mason", team: "MIN", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 99, numPosPick: 10, numRookie: 0, name: "Evan Engram", team: "DEN", position: "TE", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 100, numPosPick: 41, numRookie: 0, name: "Jakobi Meyers", team: "LV", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 101, numPosPick: 36, numRookie: 0, name: "Javonte Williams", team: "DAL", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 102, numPosPick: 42, numRookie: 0, name: "Ricky Pearsall", team: "SF", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 103, numPosPick: 15, numRookie: 0, name: "Jared Goff", team: "DET", position: "QB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 104, numPosPick: 43, numRookie: 0, name: "Khalil Shakir", team: "BUF", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 105, numPosPick: 37, numRookie: 0, name: "Rhamondre Stevenson", team: "NE", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 106, numPosPick: 16, numRookie: 0, name: "Drake Maye", team: "NE", position: "QB", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 107, numPosPick: 38, numRookie: 9, name: "Cam Skattebo", team: "NYG", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: true),
                PlayerData(num: 108, numPosPick: 17, numRookie: 0, name: "Jordan Love", team: "GB", position: "QB", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 109, numPosPick: 39, numRookie: 0, name: "Zach Charbonnet", team: "SEA", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 110, numPosPick: 44, numRookie: 0, name: "Stefon Diggs", team: "NE", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 111, numPosPick: 40, numRookie: 0, name: "Tank Bigsby", team: "JAC", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 112, numPosPick: 45, numRookie: 0, name: "Josh Downs", team: "IND", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 113, numPosPick: 11, numRookie: 10, name: "Tyler Warren", team: "IND", position: "TE", byeWeek: 11, isTopPlayer: true, isRookie: true),
                PlayerData(num: 114, numPosPick: 18, numRookie: 0, name: "Trevor Lawrence", team: "JAC", position: "QB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 115, numPosPick: 12, numRookie: 0, name: "Dalton Kincaid", team: "BUF", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 116, numPosPick: 19, numRookie: 0, name: "C.J. Stroud", team: "HOU", position: "QB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 117, numPosPick: 46, numRookie: 0, name: "Brandon Aiyuk", team: "SF", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 118, numPosPick: 47, numRookie: 0, name: "Darnell Mooney", team: "ATL", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 119, numPosPick: 13, numRookie: 0, name: "Dallas Goedert", team: "PHI", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 120, numPosPick: 41, numRookie: 0, name: "Tyjae Spears", team: "TEN", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 121, numPosPick: 48, numRookie: 0, name: "Cooper Kupp", team: "SEA", position: "WR", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 122, numPosPick: 49, numRookie: 0, name: "Michael Pittman Jr.", team: "IND", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 123, numPosPick: 42, numRookie: 0, name: "J.K. Dobbins", team: "DEN", position: "RB", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 124, numPosPick: 50, numRookie: 0, name: "Keon Coleman", team: "BUF", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 125, numPosPick: 43, numRookie: 0, name: "Rachaad White", team: "TB", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 126, numPosPick: 51, numRookie: 11, name: "Emeka Egbuka", team: "TB", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: true),
                PlayerData(num: 127, numPosPick: 44, numRookie: 0, name: "Ray Davis", team: "BUF", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 128, numPosPick: 20, numRookie: 0, name: "J.J. McCarthy", team: "MIN", position: "QB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 129, numPosPick: 14, numRookie: 0, name: "Kyle Pitts Sr.", team: "ATL", position: "TE", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 130, numPosPick: 45, numRookie: 0, name: "Trey Benson", team: "ARI", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 131, numPosPick: 52, numRookie: 0, name: "Rashid Shaheed", team: "NO", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 132, numPosPick: 53, numRookie: 12, name: "Matthew Golden", team: "GB", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: true),
                PlayerData(num: 133, numPosPick: 15, numRookie: 0, name: "Jonnu Smith", team: "PIT", position: "TE", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 134, numPosPick: 46, numRookie: 0, name: "Isaac Guerendo", team: "SF", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 135, numPosPick: 21, numRookie: 0, name: "Tua Tagovailoa", team: "MIA", position: "QB", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 136, numPosPick: 22, numRookie: 0, name: "Matthew Stafford", team: "LAR", position: "QB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 137, numPosPick: 16, numRookie: 13, name: "Colston Loveland", team: "CHI", position: "TE", byeWeek: 5, isTopPlayer: true, isRookie: true),
                PlayerData(num: 138, numPosPick: 47, numRookie: 0, name: "Tyler Allgeier", team: "ATL", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 139, numPosPick: 17, numRookie: 0, name: "Jake Ferguson", team: "DAL", position: "TE", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 140, numPosPick: 54, numRookie: 0, name: "Rashod Bateman", team: "BAL", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 141, numPosPick: 48, numRookie: 0, name: "Austin Ekeler", team: "WAS", position: "RB", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 142, numPosPick: 55, numRookie: 0, name: "Christian Kirk", team: "HOU", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 143, numPosPick: 49, numRookie: 0, name: "Jaylen Wright", team: "MIA", position: "RB", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 144, numPosPick: 50, numRookie: 0, name: "Rico Dowdle", team: "CAR", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 145, numPosPick: 51, numRookie: 0, name: "Nick Chubb", team: "HOU", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 146, numPosPick: 18, numRookie: 0, name: "Isaiah Likely", team: "BAL", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 147, numPosPick: 23, numRookie: 0, name: "Bryce Young", team: "CAR", position: "QB", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 148, numPosPick: 56, numRookie: 0, name: "Marvin Mims Jr.", team: "DEN", position: "WR", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 149, numPosPick: 52, numRookie: 14, name: "Bhayshul Tuten", team: "JAC", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: true),
                PlayerData(num: 150, numPosPick: 19, numRookie: 0, name: "Hunter Henry", team: "NE", position: "TE", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 151, numPosPick: 53, numRookie: 0, name: "Braelon Allen", team: "NYJ", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 152, numPosPick: 24, numRookie: 0, name: "Michael Penix Jr.", team: "ATL", position: "QB", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 153, numPosPick: 54, numRookie: 0, name: "Jerome Ford", team: "CLE", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 154, numPosPick: 57, numRookie: 15, name: "Luther Burden III", team: "CHI", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: true),
                PlayerData(num: 155, numPosPick: 58, numRookie: 0, name: "Cedric Tillman", team: "CLE", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 156, numPosPick: 59, numRookie: 16, name: "Tre' Harris", team: "LAC", position: "WR", byeWeek: 12, isTopPlayer: true, isRookie: true),
                PlayerData(num: 157, numPosPick: 60, numRookie: 0, name: "Romeo Doubs", team: "GB", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 158, numPosPick: 61, numRookie: 0, name: "Marquise Brown", team: "KC", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 159, numPosPick: 1, numRookie: 0, name: "Denver Broncos", team: "DEN", position: "DST", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 160, numPosPick: 55, numRookie: 17, name: "Jaydon Blue", team: "DAL", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: true),
                PlayerData(num: 161, numPosPick: 56, numRookie: 0, name: "Roschon Johnson", team: "CHI", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 162, numPosPick: 62, numRookie: 0, name: "Quentin Johnston", team: "LAC", position: "WR", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 163, numPosPick: 25, numRookie: 0, name: "Geno Smith", team: "LV", position: "QB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 164, numPosPick: 63, numRookie: 0, name: "Jalen McMillan", team: "TB", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 165, numPosPick: 20, numRookie: 0, name: "Zach Ertz", team: "WAS", position: "TE", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 166, numPosPick: 57, numRookie: 18, name: "Dylan Sampson", team: "CLE", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: true),
                PlayerData(num: 167, numPosPick: 58, numRookie: 0, name: "MarShawn Lloyd", team: "GB", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 168, numPosPick: 59, numRookie: 0, name: "Blake Corum", team: "LAR", position: "RB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 169, numPosPick: 64, numRookie: 19, name: "Kyle Williams", team: "NE", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: true),
                PlayerData(num: 170, numPosPick: 65, numRookie: 20, name: "Jayden Higgins", team: "HOU", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: true),
                PlayerData(num: 171, numPosPick: 66, numRookie: 0, name: "Adam Thielen", team: "CAR", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 172, numPosPick: 2, numRookie: 0, name: "Philadelphia Eagles", team: "PHI", position: "DST", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 173, numPosPick: 3, numRookie: 0, name: "Pittsburgh Steelers", team: "PIT", position: "DST", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 174, numPosPick: 4, numRookie: 0, name: "Baltimore Ravens", team: "BAL", position: "DST", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 175, numPosPick: 67, numRookie: 0, name: "DeAndre Hopkins", team: "BAL", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 176, numPosPick: 5, numRookie: 0, name: "Minnesota Vikings", team: "MIN", position: "DST", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 177, numPosPick: 68, numRookie: 0, name: "Xavier Legette", team: "CAR", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 178, numPosPick: 69, numRookie: 0, name: "Joshua Palmer", team: "BUF", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 179, numPosPick: 26, numRookie: 0, name: "Sam Darnold", team: "SEA", position: "QB", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 180, numPosPick: 70, numRookie: 0, name: "Alec Pierce", team: "IND", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 181, numPosPick: 6, numRookie: 0, name: "Houston Texans", team: "HOU", position: "DST", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 182, numPosPick: 7, numRookie: 0, name: "Buffalo Bills", team: "BUF", position: "DST", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 183, numPosPick: 8, numRookie: 0, name: "Kansas City Chiefs", team: "KC", position: "DST", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 184, numPosPick: 9, numRookie: 0, name: "Detroit Lions", team: "DET", position: "DST", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 185, numPosPick: 71, numRookie: 0, name: "Wan'Dale Robinson", team: "NYG", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 186, numPosPick: 60, numRookie: 0, name: "Kareem Hunt", team: "KC", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 187, numPosPick: 21, numRookie: 0, name: "Pat Freiermuth", team: "PIT", position: "TE", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 188, numPosPick: 72, numRookie: 0, name: "DeMario Douglas", team: "NE", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 189, numPosPick: 22, numRookie: 0, name: "Mike Gesicki", team: "CIN", position: "TE", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 190, numPosPick: 1, numRookie: 0, name: "Brandon Aubrey", team: "DAL", position: "K", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 191, numPosPick: 23, numRookie: 0, name: "Cade Otton", team: "TB", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 192, numPosPick: 10, numRookie: 0, name: "Los Angeles Chargers", team: "LAC", position: "DST", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 193, numPosPick: 2, numRookie: 0, name: "Jake Bates", team: "DET", position: "K", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 194, numPosPick: 3, numRookie: 0, name: "Cameron Dicker", team: "LAC", position: "K", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 195, numPosPick: 27, numRookie: 21, name: "Cameron Ward", team: "TEN", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: true),
                PlayerData(num: 196, numPosPick: 61, numRookie: 0, name: "Kendre Miller", team: "NO", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 197, numPosPick: 24, numRookie: 0, name: "Brenton Strange", team: "JAC", position: "TE", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 198, numPosPick: 11, numRookie: 0, name: "Los Angeles Rams", team: "LAR", position: "DST", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 199, numPosPick: 12, numRookie: 0, name: "Seattle Seahawks", team: "SEA", position: "DST", byeWeek: 8, isTopPlayer: true, isRookie: false),
                PlayerData(num: 200, numPosPick: 4, numRookie: 0, name: "Wil Lutz", team: "DEN", position: "K", byeWeek: 12, isTopPlayer: true, isRookie: false),
                PlayerData(num: 201, numPosPick: 73, numRookie: 0, name: "Michael Wilson", team: "ARI", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 202, numPosPick: 74, numRookie: 0, name: "Jalen Coker", team: "CAR", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 203, numPosPick: 75, numRookie: 22, name: "Jack Bech", team: "LV", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: true),
                PlayerData(num: 204, numPosPick: 13, numRookie: 0, name: "Green Bay Packers", team: "GB", position: "DST", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 205, numPosPick: 5, numRookie: 0, name: "Ka'imi Fairbairn", team: "HOU", position: "K", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 206, numPosPick: 62, numRookie: 23, name: "DJ Giddens", team: "IND", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: true),
                PlayerData(num: 207, numPosPick: 6, numRookie: 0, name: "Chase McLaughlin", team: "TB", position: "K", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 208, numPosPick: 14, numRookie: 0, name: "New York Jets", team: "NYJ", position: "DST", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 209, numPosPick: 7, numRookie: 0, name: "Chris Boswell", team: "PIT", position: "K", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 210, numPosPick: 63, numRookie: 24, name: "Devin Neal", team: "NO", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: true),
                PlayerData(num: 211, numPosPick: 28, numRookie: 0, name: "Aaron Rodgers", team: "PIT", position: "QB", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 212, numPosPick: 76, numRookie: 0, name: "Adonai Mitchell", team: "IND", position: "WR", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 213, numPosPick: 77, numRookie: 0, name: "Dontayvion Wicks", team: "GB", position: "WR", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 214, numPosPick: 25, numRookie: 0, name: "Chig Okonkwo", team: "TEN", position: "TE", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 215, numPosPick: 78, numRookie: 0, name: "Darius Slayton", team: "NYG", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 216, numPosPick: 8, numRookie: 0, name: "Evan McPherson", team: "CIN", position: "K", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 217, numPosPick: 9, numRookie: 0, name: "Harrison Butker", team: "KC", position: "K", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 218, numPosPick: 79, numRookie: 0, name: "Andrei Iosivas", team: "CIN", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 219, numPosPick: 10, numRookie: 0, name: "Tyler Bass", team: "BUF", position: "K", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 220, numPosPick: 64, numRookie: 0, name: "Miles Sanders", team: "DAL", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 221, numPosPick: 65, numRookie: 25, name: "Kyle Monangai", team: "CHI", position: "RB", byeWeek: 5, isTopPlayer: false, isRookie: true),
                PlayerData(num: 222, numPosPick: 26, numRookie: 26, name: "Mason Taylor", team: "NYJ", position: "TE", byeWeek: 9, isTopPlayer: false, isRookie: true),
                PlayerData(num: 223, numPosPick: 27, numRookie: 0, name: "Dalton Schultz", team: "HOU", position: "TE", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 224, numPosPick: 66, numRookie: 0, name: "Justice Hill", team: "BAL", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 225, numPosPick: 67, numRookie: 0, name: "Will Shipley", team: "PHI", position: "RB", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 226, numPosPick: 15, numRookie: 0, name: "San Francisco 49ers", team: "SF", position: "DST", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 227, numPosPick: 28, numRookie: 27, name: "Elijah Arroyo", team: "SEA", position: "TE", byeWeek: 8, isTopPlayer: false, isRookie: true),
                PlayerData(num: 228, numPosPick: 11, numRookie: 0, name: "Jake Elliott", team: "PHI", position: "K", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 229, numPosPick: 80, numRookie: 0, name: "Calvin Austin III", team: "PIT", position: "WR", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 230, numPosPick: 81, numRookie: 28, name: "Jaylin Noel", team: "HOU", position: "WR", byeWeek: 6, isTopPlayer: false, isRookie: true),
                PlayerData(num: 231, numPosPick: 12, numRookie: 0, name: "Jason Sanders", team: "MIA", position: "K", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 232, numPosPick: 68, numRookie: 0, name: "Keaton Mitchell", team: "BAL", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 233, numPosPick: 69, numRookie: 0, name: "Elijah Mitchell", team: "KC", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 234, numPosPick: 29, numRookie: 0, name: "Anthony Richardson Sr.", team: "IND", position: "QB", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 235, numPosPick: 70, numRookie: 0, name: "Audric Estime", team: "DEN", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 236, numPosPick: 71, numRookie: 0, name: "Jaleel McLaughlin", team: "DEN", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 237, numPosPick: 82, numRookie: 29, name: "Elic Ayomanor", team: "TEN", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: true),
                PlayerData(num: 238, numPosPick: 29, numRookie: 0, name: "Juwan Johnson", team: "NO", position: "TE", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 239, numPosPick: 13, numRookie: 0, name: "Younghoe Koo", team: "ATL", position: "K", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 240, numPosPick: 83, numRookie: 0, name: "Tyler Lockett", team: "TEN", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 241, numPosPick: 72, numRookie: 0, name: "Raheem Mostert", team: "LV", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 242, numPosPick: 84, numRookie: 30, name: "Pat Bryant", team: "DEN", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: true),
                PlayerData(num: 243, numPosPick: 30, numRookie: 0, name: "Ja'Tavion Sanders", team: "CAR", position: "TE", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 244, numPosPick: 16, numRookie: 0, name: "Dallas Cowboys", team: "DAL", position: "DST", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 245, numPosPick: 73, numRookie: 31, name: "Jarquez Hunter", team: "LAR", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: true),
                PlayerData(num: 246, numPosPick: 85, numRookie: 0, name: "Keenan Allen", team: "FA", position: "WR", byeWeek: 0, isTopPlayer: false, isRookie: false),
                PlayerData(num: 247, numPosPick: 86, numRookie: 0, name: "Devaughn Vele", team: "DEN", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 248, numPosPick: 31, numRookie: 0, name: "Cole Kmet", team: "CHI", position: "TE", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 249, numPosPick: 74, numRookie: 32, name: "Ollie Gordon II", team: "MIA", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: true),
                PlayerData(num: 250, numPosPick: 87, numRookie: 0, name: "Jalen Tolbert", team: "DAL", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 251, numPosPick: 75, numRookie: 0, name: "Devin Singletary", team: "NYG", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 252, numPosPick: 88, numRookie: 0, name: "Diontae Johnson", team: "CLE", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 253, numPosPick: 89, numRookie: 0, name: "Nick Westbrook-Ikhine", team: "MIA", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 254, numPosPick: 30, numRookie: 0, name: "Russell Wilson", team: "NYG", position: "QB", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 255, numPosPick: 17, numRookie: 0, name: "Tampa Bay Buccaneers", team: "TB", position: "DST", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 256, numPosPick: 14, numRookie: 0, name: "Matt Gay", team: "WAS", position: "K", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 257, numPosPick: 76, numRookie: 33, name: "Trevor Etienne", team: "CAR", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: true),
                PlayerData(num: 258, numPosPick: 90, numRookie: 34, name: "Jalen Royals", team: "KC", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: true),
                PlayerData(num: 259, numPosPick: 91, numRookie: 0, name: "Kayshon Boutte", team: "NE", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 260, numPosPick: 77, numRookie: 35, name: "Brashard Smith", team: "KC", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: true),
                PlayerData(num: 261, numPosPick: 92, numRookie: 0, name: "Brandin Cooks", team: "NO", position: "WR", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 262, numPosPick: 78, numRookie: 0, name: "Antonio Gibson", team: "NE", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 263, numPosPick: 93, numRookie: 0, name: "Roman Wilson", team: "PIT", position: "WR", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 264, numPosPick: 79, numRookie: 36, name: "Tahj Brooks", team: "CIN", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: true),
                PlayerData(num: 265, numPosPick: 80, numRookie: 0, name: "Kenneth Gainwell", team: "PIT", position: "RB", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 266, numPosPick: 94, numRookie: 0, name: "Elijah Moore", team: "BUF", position: "WR", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 267, numPosPick: 15, numRookie: 0, name: "Joshua Karty", team: "LAR", position: "K", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 268, numPosPick: 95, numRookie: 0, name: "Amari Cooper", team: "FA", position: "WR", byeWeek: 0, isTopPlayer: false, isRookie: false),
                PlayerData(num: 269, numPosPick: 81, numRookie: 0, name: "Sean Tucker", team: "TB", position: "RB", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 270, numPosPick: 96, numRookie: 0, name: "Dyami Brown", team: "JAC", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 271, numPosPick: 32, numRookie: 0, name: "Noah Gray", team: "KC", position: "TE", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 272, numPosPick: 31, numRookie: 0, name: "Daniel Jones", team: "IND", position: "QB", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 273, numPosPick: 33, numRookie: 0, name: "Taysom Hill", team: "NO", position: "TE", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 274, numPosPick: 18, numRookie: 0, name: "Cleveland Browns", team: "CLE", position: "DST", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 275, numPosPick: 82, numRookie: 37, name: "Jordan James", team: "SF", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: true),
                PlayerData(num: 276, numPosPick: 83, numRookie: 0, name: "Khalil Herbert", team: "IND", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 277, numPosPick: 84, numRookie: 38, name: "Woody Marks", team: "HOU", position: "RB", byeWeek: 6, isTopPlayer: false, isRookie: true),
                PlayerData(num: 278, numPosPick: 97, numRookie: 0, name: "Malik Washington", team: "MIA", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 279, numPosPick: 85, numRookie: 0, name: "Ty Johnson", team: "BUF", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 280, numPosPick: 86, numRookie: 0, name: "Isaiah Davis", team: "NYJ", position: "RB", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 281, numPosPick: 34, numRookie: 39, name: "Harold Fannin Jr.", team: "CLE", position: "TE", byeWeek: 9, isTopPlayer: false, isRookie: true),
                PlayerData(num: 282, numPosPick: 98, numRookie: 0, name: "Tim Patrick", team: "DET", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 283, numPosPick: 87, numRookie: 0, name: "Alexander Mattison", team: "MIA", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 284, numPosPick: 99, numRookie: 0, name: "Tre Tucker", team: "LV", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 285, numPosPick: 100, numRookie: 0, name: "Jalen Nailor", team: "MIN", position: "WR", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 286, numPosPick: 88, numRookie: 0, name: "Zack Moss", team: "FA", position: "RB", byeWeek: 0, isTopPlayer: false, isRookie: false),
                PlayerData(num: 287, numPosPick: 32, numRookie: 40, name: "Tyler Shough", team: "NO", position: "QB", byeWeek: 11, isTopPlayer: false, isRookie: true),
                PlayerData(num: 288, numPosPick: 19, numRookie: 0, name: "Chicago Bears", team: "CHI", position: "DST", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 289, numPosPick: 35, numRookie: 0, name: "Theo Johnson", team: "NYG", position: "TE", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 290, numPosPick: 36, numRookie: 0, name: "Darren Waller", team: "MIA", position: "TE", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 291, numPosPick: 33, numRookie: 0, name: "Joe Flacco", team: "CLE", position: "QB", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 292, numPosPick: 89, numRookie: 0, name: "Sincere McCormick", team: "LV", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 293, numPosPick: 16, numRookie: 0, name: "Daniel Carlson", team: "LV", position: "K", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 294, numPosPick: 101, numRookie: 0, name: "Parker Washington", team: "JAC", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 295, numPosPick: 90, numRookie: 0, name: "Kimani Vidal", team: "LAC", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 296, numPosPick: 102, numRookie: 41, name: "Xavier Restrepo", team: "TEN", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: true),
                PlayerData(num: 297, numPosPick: 103, numRookie: 0, name: "Christian Watson", team: "GB", position: "WR", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 298, numPosPick: 91, numRookie: 42, name: "Damien Martinez", team: "SEA", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: true),
                PlayerData(num: 299, numPosPick: 37, numRookie: 0, name: "Noah Fant", team: "FA", position: "TE", byeWeek: 0, isTopPlayer: false, isRookie: false),
                PlayerData(num: 300, numPosPick: 34, numRookie: 43, name: "Jaxson Dart", team: "NYG", position: "QB", byeWeek: 14, isTopPlayer: false, isRookie: true),
                PlayerData(num: 301, numPosPick: 38, numRookie: 44, name: "Terrance Ferguson", team: "LAR", position: "TE", byeWeek: 8, isTopPlayer: false, isRookie: true),
                PlayerData(num: 302, numPosPick: 92, numRookie: 0, name: "Dameon Pierce", team: "HOU", position: "RB", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 303, numPosPick: 104, numRookie: 0, name: "Luke McCaffrey", team: "WAS", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 304, numPosPick: 39, numRookie: 45, name: "Oronde Gadsden II", team: "LAC", position: "TE", byeWeek: 12, isTopPlayer: false, isRookie: true),
                PlayerData(num: 305, numPosPick: 105, numRookie: 46, name: "Tory Horton", team: "SEA", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: true),
                PlayerData(num: 306, numPosPick: 93, numRookie: 0, name: "Emanuel Wilson", team: "GB", position: "RB", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 307, numPosPick: 106, numRookie: 0, name: "Gabe Davis", team: "FA", position: "WR", byeWeek: 0, isTopPlayer: false, isRookie: false),
                PlayerData(num: 308, numPosPick: 107, numRookie: 0, name: "Jermaine Burton", team: "CIN", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 309, numPosPick: 94, numRookie: 47, name: "Jacory Croskey-Merritt", team: "WAS", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: true),
                PlayerData(num: 310, numPosPick: 95, numRookie: 0, name: "Ty Chandler", team: "MIN", position: "RB", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 311, numPosPick: 96, numRookie: 0, name: "Chris Brooks", team: "GB", position: "RB", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 312, numPosPick: 97, numRookie: 48, name: "Phil Mafah", team: "DAL", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: true),
                PlayerData(num: 313, numPosPick: 108, numRookie: 49, name: "Isaac TeSlaa", team: "DET", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: true),
                PlayerData(num: 314, numPosPick: 17, numRookie: 0, name: "Will Reichard", team: "MIN", position: "K", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 315, numPosPick: 109, numRookie: 50, name: "Tez Johnson", team: "TB", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: true),
                PlayerData(num: 316, numPosPick: 110, numRookie: 51, name: "Dont'e Thornton Jr.", team: "LV", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: true),
                PlayerData(num: 317, numPosPick: 18, numRookie: 0, name: "Tyler Loop", team: "BAL", position: "K", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 318, numPosPick: 19, numRookie: 0, name: "Jason Myers", team: "SEA", position: "K", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 319, numPosPick: 20, numRookie: 0, name: "New England Patriots", team: "NE", position: "DST", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 320, numPosPick: 40, numRookie: 0, name: "Ben Sinnott", team: "WAS", position: "TE", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 321, numPosPick: 41, numRookie: 0, name: "Tyler Higbee", team: "LAR", position: "TE", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 322, numPosPick: 42, numRookie: 0, name: "Will Dissly", team: "LAC", position: "TE", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 323, numPosPick: 98, numRookie: 52, name: "Raheim Sanders", team: "LAC", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: true),
                PlayerData(num: 324, numPosPick: 21, numRookie: 0, name: "Miami Dolphins", team: "MIA", position: "DST", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 325, numPosPick: 35, numRookie: 53, name: "Shedeur Sanders", team: "CLE", position: "QB", byeWeek: 9, isTopPlayer: false, isRookie: true),
                PlayerData(num: 326, numPosPick: 111, numRookie: 0, name: "Tutu Atwell", team: "LAR", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 327, numPosPick: 22, numRookie: 0, name: "Arizona Cardinals", team: "ARI", position: "DST", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 328, numPosPick: 99, numRookie: 0, name: "Chris Rodriguez Jr.", team: "WAS", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 329, numPosPick: 36, numRookie: 0, name: "Tyrod Taylor", team: "NYJ", position: "QB", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 330, numPosPick: 100, numRookie: 0, name: "Gus Edwards", team: "FA", position: "RB", byeWeek: 0, isTopPlayer: false, isRookie: false),
                PlayerData(num: 331, numPosPick: 101, numRookie: 0, name: "Cam Akers", team: "NO", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 332, numPosPick: 43, numRookie: 0, name: "Tyler Conklin", team: "LAC", position: "TE", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 333, numPosPick: 102, numRookie: 0, name: "A.J. Dillon", team: "PHI", position: "RB", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 334, numPosPick: 103, numRookie: 0, name: "Zamir White", team: "LV", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 335, numPosPick: 112, numRookie: 54, name: "Tai Felton", team: "MIN", position: "WR", byeWeek: 6, isTopPlayer: false, isRookie: true),
                PlayerData(num: 336, numPosPick: 113, numRookie: 0, name: "Jordan Whittington", team: "LAR", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 337, numPosPick: 114, numRookie: 0, name: "Marquez Valdes-Scantling", team: "SEA", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 338, numPosPick: 115, numRookie: 0, name: "Ray-Ray McCloud III", team: "ATL", position: "WR", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 339, numPosPick: 116, numRookie: 0, name: "Demarcus Robinson", team: "SF", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 340, numPosPick: 117, numRookie: 0, name: "John Metchie III", team: "HOU", position: "WR", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 341, numPosPick: 37, numRookie: 55, name: "Jalen Milroe", team: "SEA", position: "QB", byeWeek: 8, isTopPlayer: false, isRookie: true),
                PlayerData(num: 342, numPosPick: 20, numRookie: 0, name: "Justin Tucker", team: "FA", position: "K", byeWeek: 0, isTopPlayer: false, isRookie: false),
                PlayerData(num: 343, numPosPick: 118, numRookie: 0, name: "Troy Franklin", team: "DEN", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 344, numPosPick: 21, numRookie: 0, name: "Jake Moody", team: "SF", position: "K", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 345, numPosPick: 119, numRookie: 56, name: "Savion Williams", team: "GB", position: "WR", byeWeek: 5, isTopPlayer: false, isRookie: true),
                PlayerData(num: 346, numPosPick: 44, numRookie: 0, name: "Dawson Knox", team: "BUF", position: "TE", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 347, numPosPick: 120, numRookie: 0, name: "Josh Reynolds", team: "NYJ", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 348, numPosPick: 121, numRookie: 57, name: "Isaiah Bond", team: "FA", position: "WR", byeWeek: 0, isTopPlayer: false, isRookie: true),
                PlayerData(num: 349, numPosPick: 104, numRookie: 0, name: "Samaje Perine", team: "CIN", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 350, numPosPick: 122, numRookie: 0, name: "Noah Brown", team: "WAS", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 351, numPosPick: 105, numRookie: 58, name: "Donovan Edwards", team: "NYJ", position: "RB", byeWeek: 9, isTopPlayer: false, isRookie: true),
                PlayerData(num: 352, numPosPick: 23, numRookie: 0, name: "New York Giants", team: "NYG", position: "DST", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 353, numPosPick: 38, numRookie: 0, name: "Kirk Cousins", team: "ATL", position: "QB", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 354, numPosPick: 123, numRookie: 0, name: "KaVontae Turpin", team: "DAL", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 355, numPosPick: 124, numRookie: 59, name: "Chimere Dike", team: "TEN", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: true),
                PlayerData(num: 356, numPosPick: 125, numRookie: 0, name: "Mack Hollins", team: "NE", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 357, numPosPick: 45, numRookie: 0, name: "Michael Mayer", team: "LV", position: "TE", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 358, numPosPick: 126, numRookie: 0, name: "Tank Dell", team: "HOU", position: "WR", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 359, numPosPick: 22, numRookie: 0, name: "Cam Little", team: "JAC", position: "K", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 360, numPosPick: 23, numRookie: 0, name: "Brandon McManus", team: "GB", position: "K", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 361, numPosPick: 46, numRookie: 0, name: "Luke Musgrave", team: "GB", position: "TE", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 362, numPosPick: 127, numRookie: 0, name: "Allen Lazard", team: "NYJ", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 363, numPosPick: 39, numRookie: 0, name: "Spencer Rattler", team: "NO", position: "QB", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 364, numPosPick: 24, numRookie: 0, name: "Washington Commanders", team: "WAS", position: "DST", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 365, numPosPick: 47, numRookie: 0, name: "AJ Barner", team: "SEA", position: "TE", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 366, numPosPick: 128, numRookie: 0, name: "Curtis Samuel", team: "BUF", position: "WR", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 367, numPosPick: 40, numRookie: 0, name: "Jameis Winston", team: "NYG", position: "QB", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 368, numPosPick: 106, numRookie: 0, name: "Trey Sermon", team: "PIT", position: "RB", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 369, numPosPick: 48, numRookie: 0, name: "Austin Hooper", team: "NE", position: "TE", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 370, numPosPick: 41, numRookie: 0, name: "Kenny Pickett", team: "CLE", position: "QB", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 371, numPosPick: 24, numRookie: 0, name: "Eddy Pineiro", team: "FA", position: "K", byeWeek: 0, isTopPlayer: false, isRookie: false),
                PlayerData(num: 372, numPosPick: 25, numRookie: 0, name: "Atlanta Falcons", team: "ATL", position: "DST", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 373, numPosPick: 107, numRookie: 60, name: "LeQuint Allen Jr.", team: "JAC", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: true),
                PlayerData(num: 374, numPosPick: 49, numRookie: 61, name: "Gunnar Helm", team: "TEN", position: "TE", byeWeek: 10, isTopPlayer: false, isRookie: true),
                PlayerData(num: 375, numPosPick: 129, numRookie: 0, name: "Greg Dortch", team: "ARI", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 376, numPosPick: 108, numRookie: 62, name: "Kalel Mullings", team: "TEN", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: true),
                PlayerData(num: 377, numPosPick: 130, numRookie: 63, name: "Jaylin Lane", team: "WAS", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: true),
                PlayerData(num: 378, numPosPick: 25, numRookie: 0, name: "Matt Prater", team: "FA", position: "K", byeWeek: 0, isTopPlayer: false, isRookie: false),
                PlayerData(num: 379, numPosPick: 131, numRookie: 0, name: "Jahan Dotson", team: "PHI", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 380, numPosPick: 26, numRookie: 0, name: "Cairo Santos", team: "CHI", position: "K", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 381, numPosPick: 132, numRookie: 64, name: "Antwane Wells Jr.", team: "NYG", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: true),
                PlayerData(num: 382, numPosPick: 109, numRookie: 0, name: "Ameer Abdullah", team: "FA", position: "RB", byeWeek: 0, isTopPlayer: false, isRookie: false),
                PlayerData(num: 383, numPosPick: 133, numRookie: 0, name: "Van Jefferson", team: "TEN", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 384, numPosPick: 42, numRookie: 65, name: "Dillon Gabriel", team: "CLE", position: "QB", byeWeek: 9, isTopPlayer: false, isRookie: true),
                PlayerData(num: 385, numPosPick: 134, numRookie: 0, name: "Robert Woods", team: "PIT", position: "WR", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 386, numPosPick: 27, numRookie: 0, name: "Blake Grupe", team: "NO", position: "K", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 387, numPosPick: 50, numRookie: 0, name: "Foster Moreau", team: "NO", position: "TE", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 388, numPosPick: 110, numRookie: 0, name: "Ja'Quinden Jackson", team: "JAC", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 389, numPosPick: 26, numRookie: 0, name: "Indianapolis Colts", team: "IND", position: "DST", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 390, numPosPick: 51, numRookie: 0, name: "Luke Schoonmaker", team: "DAL", position: "TE", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 391, numPosPick: 52, numRookie: 0, name: "Tommy Tremble", team: "CAR", position: "TE", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 392, numPosPick: 28, numRookie: 0, name: "Graham Gano", team: "NYG", position: "K", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 393, numPosPick: 135, numRookie: 66, name: "Theo Wease Jr.", team: "MIA", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: true),
                PlayerData(num: 394, numPosPick: 136, numRookie: 0, name: "Jalin Hyatt", team: "NYG", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 395, numPosPick: 43, numRookie: 0, name: "Mason Rudolph", team: "PIT", position: "QB", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 396, numPosPick: 111, numRookie: 0, name: "Emari Demercado", team: "ARI", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 397, numPosPick: 112, numRookie: 0, name: "Jonathon Brooks", team: "CAR", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 398, numPosPick: 29, numRookie: 0, name: "Chad Ryland", team: "ARI", position: "K", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 399, numPosPick: 113, numRookie: 0, name: "Jeremy McNichols", team: "WAS", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 400, numPosPick: 137, numRookie: 0, name: "Olamide Zaccheaus", team: "CHI", position: "WR", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 401, numPosPick: 138, numRookie: 67, name: "Arian Smith", team: "NYJ", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: true),
                PlayerData(num: 402, numPosPick: 139, numRookie: 0, name: "Kendrick Bourne", team: "NE", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 403, numPosPick: 140, numRookie: 0, name: "Ja'Lynn Polk", team: "NE", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 404, numPosPick: 30, numRookie: 0, name: "Nick Folk", team: "NYJ", position: "K", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 405, numPosPick: 114, numRookie: 0, name: "Kyle Juszczyk", team: "SF", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 406, numPosPick: 27, numRookie: 0, name: "Cincinnati Bengals", team: "CIN", position: "DST", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 407, numPosPick: 115, numRookie: 0, name: "D'Ernest Johnson", team: "FA", position: "RB", byeWeek: 0, isTopPlayer: false, isRookie: false),
                PlayerData(num: 408, numPosPick: 141, numRookie: 0, name: "Jacob Cowing", team: "SF", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 409, numPosPick: 28, numRookie: 0, name: "New Orleans Saints", team: "NO", position: "DST", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 410, numPosPick: 29, numRookie: 0, name: "Las Vegas Raiders", team: "LV", position: "DST", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 411, numPosPick: 53, numRookie: 0, name: "Josh Oliver", team: "MIN", position: "TE", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 412, numPosPick: 116, numRookie: 0, name: "Craig Reynolds", team: "DET", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 413, numPosPick: 54, numRookie: 0, name: "Grant Calcaterra", team: "PHI", position: "TE", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 414, numPosPick: 55, numRookie: 0, name: "Cade Stover", team: "HOU", position: "TE", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 415, numPosPick: 56, numRookie: 68, name: "Luke Lachey", team: "HOU", position: "TE", byeWeek: 6, isTopPlayer: false, isRookie: true),
                PlayerData(num: 416, numPosPick: 44, numRookie: 0, name: "Deshaun Watson", team: "CLE", position: "QB", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 417, numPosPick: 117, numRookie: 0, name: "Chris Tyree", team: "NO", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 418, numPosPick: 45, numRookie: 0, name: "Joe Milton III", team: "DAL", position: "QB", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 419, numPosPick: 46, numRookie: 69, name: "Will Howard", team: "PIT", position: "QB", byeWeek: 5, isTopPlayer: false, isRookie: true),
                PlayerData(num: 420, numPosPick: 142, numRookie: 0, name: "Malachi Corley", team: "NYJ", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 421, numPosPick: 47, numRookie: 0, name: "Aidan O'Connell", team: "LV", position: "QB", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 422, numPosPick: 143, numRookie: 0, name: "Devontez Walker", team: "BAL", position: "WR", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 423, numPosPick: 57, numRookie: 70, name: "Mitchell Evans", team: "CAR", position: "TE", byeWeek: 14, isTopPlayer: false, isRookie: true),
                PlayerData(num: 424, numPosPick: 58, numRookie: 0, name: "Stone Smartt", team: "NYJ", position: "TE", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 425, numPosPick: 144, numRookie: 0, name: "Jonathan Mingo", team: "DAL", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 426, numPosPick: 118, numRookie: 0, name: "Clyde Edwards-Helaire", team: "NO", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 427, numPosPick: 145, numRookie: 0, name: "Kalif Raymond", team: "DET", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 428, numPosPick: 30, numRookie: 0, name: "Jacksonville Jaguars", team: "JAC", position: "DST", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 429, numPosPick: 146, numRookie: 0, name: "Javon Baker", team: "NE", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 430, numPosPick: 119, numRookie: 0, name: "Cordarrelle Patterson", team: "FA", position: "RB", byeWeek: 0, isTopPlayer: false, isRookie: false),
                PlayerData(num: 431, numPosPick: 147, numRookie: 0, name: "Zay Jones", team: "ARI", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 432, numPosPick: 148, numRookie: 0, name: "Hunter Renfrow", team: "CAR", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 433, numPosPick: 149, numRookie: 0, name: "JuJu Smith-Schuster", team: "KC", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 434, numPosPick: 150, numRookie: 0, name: "Michael Gallup", team: "WAS", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 435, numPosPick: 59, numRookie: 0, name: "Elijah Higgins", team: "ARI", position: "TE", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 436, numPosPick: 120, numRookie: 0, name: "Tyler Goodson", team: "IND", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 437, numPosPick: 121, numRookie: 0, name: "Pierre Strong Jr.", team: "CLE", position: "RB", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 438, numPosPick: 151, numRookie: 0, name: "Derius Davis", team: "LAC", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 439, numPosPick: 60, numRookie: 0, name: "Darnell Washington", team: "PIT", position: "TE", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 440, numPosPick: 48, numRookie: 0, name: "Zach Wilson", team: "MIA", position: "QB", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 441, numPosPick: 152, numRookie: 0, name: "Tyler Johnson", team: "NYJ", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 442, numPosPick: 153, numRookie: 0, name: "Treylon Burks", team: "TEN", position: "WR", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 443, numPosPick: 61, numRookie: 0, name: "Jeremy Ruckert", team: "NYJ", position: "TE", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 444, numPosPick: 122, numRookie: 0, name: "Alec Ingold", team: "MIA", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 445, numPosPick: 123, numRookie: 0, name: "Hunter Luepke", team: "DAL", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 446, numPosPick: 154, numRookie: 71, name: "Kaden Prather", team: "BUF", position: "WR", byeWeek: 7, isTopPlayer: false, isRookie: true),
                PlayerData(num: 447, numPosPick: 62, numRookie: 0, name: "Greg Dulcich", team: "NYG", position: "TE", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 448, numPosPick: 124, numRookie: 0, name: "C.J. Ham", team: "MIN", position: "RB", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 449, numPosPick: 49, numRookie: 0, name: "Marcus Mariota", team: "WAS", position: "QB", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 450, numPosPick: 125, numRookie: 0, name: "Deuce Vaughn", team: "DAL", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 451, numPosPick: 155, numRookie: 0, name: "Julian Fleming", team: "FA", position: "WR", byeWeek: 0, isTopPlayer: false, isRookie: false),
                PlayerData(num: 452, numPosPick: 126, numRookie: 0, name: "Jaydn Ott", team: "FA", position: "RB", byeWeek: 0, isTopPlayer: false, isRookie: false),
                PlayerData(num: 453, numPosPick: 156, numRookie: 72, name: "Jordan Watkins", team: "SF", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: true),
                PlayerData(num: 454, numPosPick: 127, numRookie: 0, name: "Julius Chestnut", team: "TEN", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 455, numPosPick: 157, numRookie: 73, name: "KeAndre Lambert-Smith", team: "LAC", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: true),
                PlayerData(num: 456, numPosPick: 158, numRookie: 0, name: "KhaDarel Hodge", team: "ATL", position: "WR", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 457, numPosPick: 159, numRookie: 0, name: "DJ Chark Jr.", team: "ATL", position: "WR", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 458, numPosPick: 50, numRookie: 0, name: "Malik Willis", team: "GB", position: "QB", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 459, numPosPick: 63, numRookie: 0, name: "Brevin Jordan", team: "HOU", position: "TE", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 460, numPosPick: 64, numRookie: 0, name: "Josh Whyle", team: "TEN", position: "TE", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 461, numPosPick: 160, numRookie: 0, name: "Bub Means", team: "NO", position: "WR", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 462, numPosPick: 128, numRookie: 0, name: "Michael Carter", team: "ARI", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 463, numPosPick: 129, numRookie: 0, name: "Tyler Badie", team: "DEN", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 464, numPosPick: 65, numRookie: 0, name: "Julian Hill", team: "MIA", position: "TE", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 465, numPosPick: 161, numRookie: 74, name: "Efton Chism III", team: "NE", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: true),
                PlayerData(num: 466, numPosPick: 130, numRookie: 75, name: "Marcus Yarns", team: "NO", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: true),
                PlayerData(num: 467, numPosPick: 162, numRookie: 0, name: "Jake Bobo", team: "SEA", position: "WR", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 468, numPosPick: 51, numRookie: 0, name: "Gardner Minshew II", team: "KC", position: "QB", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 469, numPosPick: 163, numRookie: 0, name: "David Bell", team: "CLE", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 470, numPosPick: 66, numRookie: 0, name: "Colby Parkinson", team: "LAR", position: "TE", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 471, numPosPick: 52, numRookie: 0, name: "Sam Howell", team: "MIN", position: "QB", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 472, numPosPick: 131, numRookie: 0, name: "Hassan Haskins", team: "LAC", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 473, numPosPick: 164, numRookie: 0, name: "K.J. Osborn", team: "WAS", position: "WR", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 474, numPosPick: 132, numRookie: 0, name: "Rasheen Ali", team: "BAL", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 475, numPosPick: 67, numRookie: 0, name: "Kylen Granson", team: "PHI", position: "TE", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 476, numPosPick: 165, numRookie: 0, name: "Rondale Moore", team: "MIN", position: "WR", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 477, numPosPick: 68, numRookie: 0, name: "Daniel Bellinger", team: "NYG", position: "TE", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 478, numPosPick: 133, numRookie: 0, name: "Carson Steele", team: "KC", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 479, numPosPick: 134, numRookie: 0, name: "Michael Burton", team: "DEN", position: "RB", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 480, numPosPick: 135, numRookie: 0, name: "Patrick Taylor Jr.", team: "SF", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 481, numPosPick: 166, numRookie: 76, name: "Jimmy Horn Jr.", team: "CAR", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: true),
                PlayerData(num: 482, numPosPick: 136, numRookie: 0, name: "Dare Ogunbowale", team: "HOU", position: "RB", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 483, numPosPick: 69, numRookie: 0, name: "John Bates", team: "WAS", position: "TE", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 484, numPosPick: 70, numRookie: 0, name: "Tanner Hudson", team: "CIN", position: "TE", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 485, numPosPick: 137, numRookie: 0, name: "Ronnie Rivers", team: "LAR", position: "RB", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 486, numPosPick: 71, numRookie: 0, name: "Adam Trautman", team: "DEN", position: "TE", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 487, numPosPick: 167, numRookie: 0, name: "David Moore", team: "CAR", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 488, numPosPick: 53, numRookie: 0, name: "Mac Jones", team: "SF", position: "QB", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 489, numPosPick: 72, numRookie: 0, name: "Jelani Woods", team: "IND", position: "TE", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 490, numPosPick: 168, numRookie: 0, name: "Mecole Hardman Jr.", team: "GB", position: "WR", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 491, numPosPick: 138, numRookie: 77, name: "Lan Larison", team: "NE", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: true),
                PlayerData(num: 492, numPosPick: 54, numRookie: 0, name: "Taylor Heinicke", team: "LAC", position: "QB", byeWeek: 12, isTopPlayer: false, isRookie: false),
                PlayerData(num: 493, numPosPick: 55, numRookie: 0, name: "Cooper Rush", team: "BAL", position: "QB", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 494, numPosPick: 73, numRookie: 0, name: "Harrison Bryant", team: "PHI", position: "TE", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 495, numPosPick: 74, numRookie: 0, name: "Brock Wright", team: "DET", position: "TE", byeWeek: 8, isTopPlayer: false, isRookie: false),
                PlayerData(num: 496, numPosPick: 169, numRookie: 0, name: "Cedrick Wilson Jr.", team: "NO", position: "WR", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 497, numPosPick: 56, numRookie: 0, name: "Kyle Trask", team: "TB", position: "QB", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 498, numPosPick: 75, numRookie: 0, name: "Drew Sample", team: "CIN", position: "TE", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 499, numPosPick: 57, numRookie: 0, name: "Jake Browning", team: "CIN", position: "QB", byeWeek: 10, isTopPlayer: false, isRookie: false)
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
        ["Dallas Cowboys", "Philadelphia Eagles", "New York Giants", "Washington Commanders"],
        //NFC North
        ["Chicago Bears", "Detroit Lions", "Green Bay Packers", "Minnesota Vikings"],
        //NFC South
        ["Tampa Bay Buccaneers", "Atlanta Falcons", "Carolina Panthers", "New Orleans Saints"],
        //NFC West
        ["San Francisco 49ers", "Arizona Cardinals", "Los Angeles Rams", "Seattle Seahawks"]
    ]
    
    func loadTeamData(sec:Int, row:Int, view1:UIView, view2:UIView, label:UILabel, table:UITableView) {
        if sec == 0 && row == 0 {
            data = billsArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0.01938016217, green: 0.2123703163, blue: 0.5529411765, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.04705882353, blue: 0.1882352941, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.04705882353, blue: 0.1882352941, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.04705882353, blue: 0.1882352941, alpha: 1)
            label.textColor = .white
            label.text = "Buffalo Bills"
        }
        if sec == 0 && row == 1 {
            data = dolphinsArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0.3411764706, blue: 0.4705882353, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.2980392157, blue: 0.007843137255, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.2980392157, blue: 0.007843137255, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.2980392157, blue: 0.007843137255, alpha: 1)
            label.textColor = .black
            label.text = "Miami Dolphins"
        }
        if sec == 0 && row == 2 {
            data = jetsArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.3411764706, blue: 0.2509803922, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            label.textColor = .black
            label.text = "New York Jets"
        }
        if sec == 0 && row == 3 {
            data = patriotsArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.04705882353, blue: 0.1882352941, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            label.textColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
            label.text = "New England Patriots"
        }
        
        if sec == 1 && row == 0 {
            data = bengalsArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.textColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            label.text = "Cincinatti Bengals"
        }
        if sec == 1 && row == 1 {
            data = brownsArray_2025()
            view1.backgroundColor = #colorLiteral(red: 1, green: 0.2352941176, blue: 0, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.1137254902, blue: 0, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.1137254902, blue: 0, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.1137254902, blue: 0, alpha: 1)
            label.textColor = .white
            label.text = "Cleveland Browns"
        }
        if sec == 1 && row == 2 {
            data = ravensArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.09803921569, blue: 0.3725490196, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.09803921569, blue: 0.3725490196, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.09803921569, blue: 0.3725490196, alpha: 1)
            label.textColor = #colorLiteral(red: 0.6196078431, green: 0.4862745098, blue: 0.04705882353, alpha: 1)
            label.text = "Baltimore Ravens"
        }
        if sec == 1 && row == 3 {
            data = steelersArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.textColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.text = "Pittsburgh Steelers"
        }
        
        if sec == 2 && row == 0 {
            data = coltsArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0.1725490196, blue: 0.3725490196, alpha: 1)
            view2.backgroundColor = .white
            label.backgroundColor = .white
            table.backgroundColor = .white
            label.textColor = #colorLiteral(red: 0, green: 0.1725490196, blue: 0.3725490196, alpha: 1)
            label.text = "Indianapolis Colts"
        }
        if sec == 2 && row == 1 {
            data = jaguarsArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0.6235294118, green: 0.4745098039, blue: 0.1725490196, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            label.textColor = .white
            label.text = "Jacksonville Jaguars"
        }
        if sec == 2 && row == 2 {
            data = texansArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.1254901961, blue: 0.1843137255, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            label.textColor = .white
            label.text = "Houston Texans"
        }
        if sec == 2 && row == 3 {
            data = titansArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0.5411764706, green: 0.5529411765, blue: 0.5607843137, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.06274509804, blue: 0.1803921569, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.06274509804, blue: 0.1803921569, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.06274509804, blue: 0.1803921569, alpha: 1)
            label.textColor = #colorLiteral(red: 0.04705882353, green: 0.137254902, blue: 0.2509803922, alpha: 1)
            label.text = "Tennessee Titans"
        }
        
        if sec == 3 && row == 0 {
            data = broncosArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            label.textColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            label.text = "Denver Broncos"
        }
        if sec == 3 && row == 1 {
            data = chargersArray_2025()
            view1.backgroundColor = #colorLiteral(red: 1, green: 0.7607843137, blue: 0.05490196078, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0.7764705882, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0.7764705882, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0.7764705882, alpha: 1)
            label.textColor = #colorLiteral(red: 1, green: 0.7607843137, blue: 0.05490196078, alpha: 1)
            label.text = "Los Angeles Chargers"
        }
        if sec == 3 && row == 2 {
            data = chiefsArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.09411764706, blue: 0.2156862745, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            label.textColor = .black
            label.text = "Kansas City Chiefs"
        }
        if sec == 3 && row == 3 {
            data = raidersArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            view2.backgroundColor = .black
            label.backgroundColor = .black
            table.backgroundColor = .black
            label.textColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            label.text = "Las Vegas Raiders"
        }
        
        if sec == 4 && row == 0 {
            data = cowboysArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0.4980392157, green: 0.5882352941, blue: 0.5843137255, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0.2078431373, blue: 0.5803921569, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0.2078431373, blue: 0.5803921569, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0.2078431373, blue: 0.5803921569, alpha: 1)
            label.textColor = .white
            label.text = "Dallas Cowboys"
        }
        if sec == 4 && row == 1 {
            data = eaglesArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0.3725490196, green: 0.3764705882, blue: 0.3843137255, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.textColor = #colorLiteral(red: 0.7294117647, green: 0.7921568627, blue: 0.8274509804, alpha: 1)
            label.text = "Philadelphia Eagles"
        }
        if sec == 4 && row == 2 {
            data = giantsArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.137254902, blue: 0.3215686275, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6392156863, green: 0.05098039216, blue: 0.1764705882, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6392156863, green: 0.05098039216, blue: 0.1764705882, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6392156863, green: 0.05098039216, blue: 0.1764705882, alpha: 1)
            label.textColor = #colorLiteral(red: 0.003921568627, green: 0.137254902, blue: 0.3215686275, alpha: 1)
            label.text = "New York Giants"
        }
        if sec == 4 && row == 3 {
            data = commandersArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0.2470588235, green: 0.06274509804, blue: 0.06274509804, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.textColor = #colorLiteral(red: 0.2470588235, green: 0.06274509804, blue: 0.06274509804, alpha: 1)
            label.text = "Washington Commanders"
        }
        
        if sec == 5 && row == 0 {
            data = bearsArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0.0431372549, green: 0.0862745098, blue: 0.1647058824, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.2196078431, blue: 0.01176470588, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.2196078431, blue: 0.01176470588, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.2196078431, blue: 0.01176470588, alpha: 1)
            label.textColor = #colorLiteral(red: 0.0431372549, green: 0.0862745098, blue: 0.1647058824, alpha: 1)
            label.text = "Chicago Bears"
        }
        if sec == 5 && row == 1 {
            data = lionsArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
            label.textColor = .white
            label.text = "Detroit Lions"
        }
        if sec == 5 && row == 2 {
            data = packersArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.1882352941, blue: 0.1568627451, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            label.textColor = #colorLiteral(red: 0.09411764706, green: 0.1882352941, blue: 0.1568627451, alpha: 1)
            label.text = "Green Bay Packers"
        }
        if sec == 5 && row == 3 {
            data = vikingsArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0.3098039216, green: 0.1490196078, blue: 0.5137254902, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7764705882, blue: 0.1843137255, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7764705882, blue: 0.1843137255, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7764705882, blue: 0.1843137255, alpha: 1)
            label.textColor = #colorLiteral(red: 0.3098039216, green: 0.1490196078, blue: 0.5137254902, alpha: 1)
            label.text = "Minnesota Vikings"
        }
        
        if sec == 6 && row == 0 {
            data = buccaneersArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.1882352941, blue: 0.168627451, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.03921568627, blue: 0.03137254902, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.03921568627, blue: 0.03137254902, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.03921568627, blue: 0.03137254902, alpha: 1)
            label.textColor = #colorLiteral(red: 0.6941176471, green: 0.7294117647, blue: 0.7490196078, alpha: 1)
            label.text = "Tampa Bay Buccaneers"
        }
        if sec == 6 && row == 1 {
            data = falconsArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.text = "Atlanta Falcons"
        }
        if sec == 6 && row == 2 {
            data = panthersArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.7529411765, blue: 0.7490196078, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0.5215686275, blue: 0.7921568627, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0.5215686275, blue: 0.7921568627, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0.5215686275, blue: 0.7921568627, alpha: 1)
            label.textColor = #colorLiteral(red: 0.7490196078, green: 0.7529411765, blue: 0.7490196078, alpha: 1)
            label.text = "Carolina Panthers"
        }
        if sec == 6 && row == 3 {
            data = saintsArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0.8274509804, green: 0.737254902, blue: 0.5529411765, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1215686275, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1215686275, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1215686275, alpha: 1)
            label.textColor = #colorLiteral(red: 0.8274509804, green: 0.737254902, blue: 0.5529411765, alpha: 1)
            label.text = "New Orleans Saints"
        }
        
        if sec == 7 && row == 0 {
            data = _49ersArray_2025()
            view1.backgroundColor = .black
            view2.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.6, blue: 0.3647058824, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.6, blue: 0.3647058824, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.6, blue: 0.3647058824, alpha: 1)
            label.textColor = .white
            label.text = "San Francisco 49ers"
        }
        if sec == 7 && row == 1 {
            data = cardinalsArray_2025()
            view1.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.textColor = .white
            label.text = "Arizona Cardinals"
        }
        if sec == 7 && row == 2 {
            data = ramsArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.5254901961, green: 0.4274509804, blue: 0.2941176471, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.5254901961, green: 0.4274509804, blue: 0.2941176471, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.5254901961, green: 0.4274509804, blue: 0.2941176471, alpha: 1)
            label.textColor = .white
            label.text = "Los Angeles Rams"
        }
        if sec == 7 && row == 3 {
            data = seahawksArray_2025()
            view1.backgroundColor = #colorLiteral(red: 0.4117647059, green: 0.7450980392, blue: 0.1568627451, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            label.textColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            label.text = "Seattle Seahawks"
        }
    }
    
    // AFC East
    func billsArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Josh Allen")
        let qb2 = Cell(pos: "QB2", play: "Mitchell Trubisky")
        let qb3 = Cell(pos: "QB3", play: "Mike White")
        let rb1 = Cell(pos: "RB1", play: "James Cook")
        let rb2 = Cell(pos: "RB2", play: "Ray Davis")
        let rb3 = Cell(pos: "RB3", play: "Ty Johnson")
        let wr1 = Cell(pos: "WR1", play: "Khalil Shakir")
        let wr2 = Cell(pos: "WR2", play: "Keon Coleman")
        let wr3 = Cell(pos: "WR3", play: "Joshua Palmer")
        let wr4 = Cell(pos: "WR4", play: "Elijah Moore")
        let wr5 = Cell(pos: "WR5", play: "Curtis Samuel")
        let wr6 = Cell(pos: "WR6", play: "Laviska Shenault")
        let te1 = Cell(pos: "TE1", play: "Dalton Kincaid")
        let te2 = Cell(pos: "TE2", play: "Dawson Knox")
        let te3 = Cell(pos: "TE3", play: "Jackson Hawes")
        let k = Cell(pos: "K", play: "Tyler Bass")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func dolphinsArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Tua Tagovailoa")
        let qb2 = Cell(pos: "QB2", play: "Zach Wilson")
        let qb3 = Cell(pos: "QB3", play: "Quinn Ewers", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "De'Von Achane")
        let rb2 = Cell(pos: "RB2", play: "Alexander Mattison")
        let rb3 = Cell(pos: "RB3", play: "Jaylen Wright")
        let wr1 = Cell(pos: "WR1", play: "Tyreek Hill")
        let wr2 = Cell(pos: "WR2", play: "Jaylen Waddle")
        let wr3 = Cell(pos: "WR3", play: "Nick Westbrook-Ikhine")
        let wr4 = Cell(pos: "WR4", play: "Malik Washington")
        let wr5 = Cell(pos: "WR5", play: "Dee Eskridge")
        let wr6 = Cell(pos: "WR6", play: "Tahj Washington")
        let te1 = Cell(pos: "TE1", play: "Darren Waller")
        let te2 = Cell(pos: "TE2", play: "Julian Hill")
        let te3 = Cell(pos: "TE3", play: "Pharaoh Brown")
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
        positionPlayer.append(wr5)
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func jetsArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Justin Fields")
        let qb2 = Cell(pos: "QB2", play: "Tyrod Taylor")
        let rb1 = Cell(pos: "RB1", play: "Breece Hall")
        let rb2 = Cell(pos: "RB2", play: "Braelon Allen")
        let rb3 = Cell(pos: "RB3", play: "Isaiah Davis")
        let rb4 = Cell(pos: "RB4", play: "Kene Nwangwu")
        let wr1 = Cell(pos: "WR1", play: "Garrett Wilson")
        let wr2 = Cell(pos: "WR2", play: "Allen Lazard")
        let wr3 = Cell(pos: "WR3", play: "Josh Reynolds")
        let wr4 = Cell(pos: "WR4", play: "Malachi Corley")
        let wr5 = Cell(pos: "WR5", play: "Tyler Johnson")
        let wr6 = Cell(pos: "WR6", play: "Xavier Gipson")
        let te1 = Cell(pos: "TE1", play: "Jason Taylor")
        let te2 = Cell(pos: "TE2", play: "Jeremy Ruckert")
        let te3 = Cell(pos: "TE3", play: "Stone Smartt")
        let k = Cell(pos: "K", play: "Harrison Mevis")
        
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
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        return positionPlayer
    }
    
    func patriotsArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Drake Maye")
        let qb2 = Cell(pos: "QB2", play: "Joshua Dobbs")
        let rb1 = Cell(pos: "RB1", play: "TreVeyon Henderson", rookie: "R")
        let rb2 = Cell(pos: "RB2", play: "Rhamondre Stevenson")
        let rb3 = Cell(pos: "RB3", play: "Antonio Gibson")
        let rb4 = Cell(pos: "RB4", play: "Trayveon Williams")
        let wr1 = Cell(pos: "WR1", play: "Stefon Diggs")
        let wr2 = Cell(pos: "WR2", play: "DeMario Douglas")
        let wr3 = Cell(pos: "WR3", play: "Kyle Williams", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Kayshon Boutte")
        let wr5 = Cell(pos: "WR5", play: "Kendrick Bourne")
        let wr6 = Cell(pos: "WR6", play: "Mack Hollins")
        let te1 = Cell(pos: "TE1", play: "Hunter Henry")
        let te2 = Cell(pos: "TE2", play: "Austin Hooper")
        let te3 = Cell(pos: "TE3", play: "Jaheim Bell")
        let k = Cell(pos: "K", play: "Andres Borregales")
        
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
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // AFC North
    func bengalsArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Joe Burrow")
        let qb2 = Cell(pos: "QB2", play: "Jake Browning")
        let rb1 = Cell(pos: "RB1", play: "Chase Brown")
        let rb2 = Cell(pos: "RB2", play: "Zach Moss")
        let rb3 = Cell(pos: "RB3", play: "Samaje Perine")
        let rb4 = Cell(pos: "RB4", play: "Tahj Brooks", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Ja'Marr Chase")
        let wr2 = Cell(pos: "WR2", play: "Tee Higgins")
        let wr3 = Cell(pos: "WR3", play: "Andrei Iosivas")
        let wr4 = Cell(pos: "WR4", play: "Jermaine Burton")
        let wr5 = Cell(pos: "WR5", play: "Charlie Jones")
        let wr6 = Cell(pos: "WR6", play: "Kendric Pryor")
        let te1 = Cell(pos: "TE1", play: "Mike Gesicki")
        let te2 = Cell(pos: "TE2", play: "Drew Sample", rookie: "R")
        let te3 = Cell(pos: "TE3", play: "Erick All")
        let k = Cell(pos: "K", play: "Evan McPherson")
        
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
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func brownsArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Joe Flacco")
        let qb2 = Cell(pos: "QB2", play: "Kenny Pickett")
        let qb3 = Cell(pos: "QB3", play: "Shedeur Sanders", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Jerome Ford")
        let rb2 = Cell(pos: "RB2", play: "Quinshon Judkins", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "Dylan Sampson", rookie: "R")
        let rb4 = Cell(pos: "RB4", play: "Pierre Strong Jr.")
        let wr1 = Cell(pos: "WR1", play: "Jerry Jeudy")
        let wr2 = Cell(pos: "WR2", play: "Cedric Tillman")
        let wr3 = Cell(pos: "WR3", play: "Diontae Johnson")
        let wr4 = Cell(pos: "WR4", play: "DeAndre Carter")
        let wr5 = Cell(pos: "WR5", play: "Michael Woods")
        let wr6 = Cell(pos: "WR6", play: "David Bell")
        let te1 = Cell(pos: "TE1", play: "David Njoku")
        let te2 = Cell(pos: "TE2", play: "Harold Fanning", rookie: "R")
        let te3 = Cell(pos: "TE3", play: "Blake Whiteheart")
        let k = Cell(pos: "K", play: "Dustin Hopkins")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func ravensArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Lamar Jackson")
        let qb2 = Cell(pos: "QB2", play: "Cooper Rush")
        let rb1 = Cell(pos: "RB1", play: "Derrick Henry")
        let rb2 = Cell(pos: "RB2", play: "Justice Hill")
        let rb3 = Cell(pos: "RB3", play: "Keaton Mitchell")
        let rb4 = Cell(pos: "RB4", play: "Rasheen Ali")
        let wr1 = Cell(pos: "WR1", play: "Zay Flowers")
        let wr2 = Cell(pos: "WR2", play: "Rashod Bateman")
        let wr3 = Cell(pos: "WR3", play: "DeAndre Hopkins")
        let wr4 = Cell(pos: "WR4", play: "Tylan Wallace")
        let wr5 = Cell(pos: "WR5", play: "Anthony Miller")
        let wr6 = Cell(pos: "WR6", play: "Devontez Walker")
        let te1 = Cell(pos: "TE1", play: "Mark Andrews")
        let te2 = Cell(pos: "TE2", play: "Isaiah Likely")
        let te3 = Cell(pos: "TE3", play: "Charlie Kolar")
        let k = Cell(pos: "K", play: "Tyler Loop", rookie: "R")
        
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
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func steelersArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Aaron Rodgers")
        let qb2 = Cell(pos: "QB2", play: "Mason Rudolph")
        let qb3 = Cell(pos: "QB3", play: "Will Howard", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Kaleb Johnson", rookie: "R")
        let rb2 = Cell(pos: "RB2", play: "Jaylen Warren")
        let rb3 = Cell(pos: "RB3", play: "Cordarrelle Patterson")
        let rb4 = Cell(pos: "RB4", play: "Kenneth Gainwell")
        let wr1 = Cell(pos: "WR1", play: "DK Metcalf")
        let wr2 = Cell(pos: "WR2", play: "Calvin Austin III")
        let wr3 = Cell(pos: "WR3", play: "Robert Woods")
        let wr4 = Cell(pos: "WR4", play: "Roman Wilson")
        let wr5 = Cell(pos: "WR5", play: "Scotty Miller")
        let wr6 = Cell(pos: "WR6", play: "Ben Skowronek")
        let te1 = Cell(pos: "TE1", play: "Pat Freiermuth")
        let te2 = Cell(pos: "TE2", play: "Jonnu Smith")
        let te3 = Cell(pos: "TE3", play: "Darnell Washington")
        let k = Cell(pos: "K", play: "Chris Boswell")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // AFC South
    func coltsArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Anthony Richardson")
        let qb2 = Cell(pos: "QB2", play: "Daniel Jones")
        let rb1 = Cell(pos: "RB1", play: "Jonathan Taylor")
        let rb2 = Cell(pos: "RB2", play: "DJ Giddens", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "Khalil Herbert")
        let rb4 = Cell(pos: "RB4", play: "Tyler Goodson")
        let wr1 = Cell(pos: "WR1", play: "Josh Downs")
        let wr2 = Cell(pos: "WR2", play: "Michael Pittman")
        let wr3 = Cell(pos: "WR3", play: "Alec Pierce")
        let wr4 = Cell(pos: "WR4", play: "Adonai Mitchell")
        let wr5 = Cell(pos: "WR5", play: "Ashton Dulin")
        let wr6 = Cell(pos: "WR6", play: "Anthony Gould")
        let te1 = Cell(pos: "TE1", play: "Tyler Warren", rookie: "R")
        let te2 = Cell(pos: "TE2", play: "Andrew Ogletree")
        let te3 = Cell(pos: "TE3", play: "Will Mallory")
        let k = Cell(pos: "K", play: "Spencer Shrader")
        
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
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func jaguarsArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Trevor Lawrence")
        let qb2 = Cell(pos: "QB2", play: "Nick Mullens")
        let rb1 = Cell(pos: "RB1", play: "Travis Etienne")
        let rb2 = Cell(pos: "RB2", play: "Tank Bigsby")
        let rb3 = Cell(pos: "RB3", play: "Bhayshul Tuten", rookie: "R")
        let rb4 = Cell(pos: "RB4", play: "LeQuint Allen", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Brian Thomas Jr.")
        let wr2 = Cell(pos: "WR2", play: "Travis Hunter", rookie: "R")
        let wr3 = Cell(pos: "WR3", play: "Dyami Brown")
        let wr4 = Cell(pos: "WR4", play: "Parker Washington")
        let wr5 = Cell(pos: "WR5", play: "Joshua Cephus", rookie: "R")
        let wr6 = Cell(pos: "WR6", play: "Austin Trammell")
        let te1 = Cell(pos: "TE1", play: "Brenton Strange")
        let te2 = Cell(pos: "TE2", play: "Johnny Mundt")
        let te3 = Cell(pos: "TE3", play: "Hunter Long")
        let k = Cell(pos: "K", play: "Cam Little")
        
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
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func texansArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "C.J. Stroud")
        let qb2 = Cell(pos: "QB2", play: "Davis Mills")
        let rb1 = Cell(pos: "RB1", play: "Joe Mixon")
        let rb2 = Cell(pos: "RB2", play: "Nick Chubb")
        let rb3 = Cell(pos: "RB3", play: "Dameon Pierce")
        let rb4 = Cell(pos: "RB4", play: "Woody Marks")
        let wr1 = Cell(pos: "WR1", play: "Nico Collins")
        let wr2 = Cell(pos: "WR2", play: "Christian Kirk")
        let wr3 = Cell(pos: "WR3", play: "Jayden Higgins", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Jaylin Noel", rookie: "R")
        let wr5 = Cell(pos: "WR5", play: "Tank Dell")
        let wr6 = Cell(pos: "WR6", play: "John Metchie")
        let te1 = Cell(pos: "TE1", play: "Dalton Schultz")
        let te2 = Cell(pos: "TE2", play: "Brevin Jordan")
        let te3 = Cell(pos: "TE3", play: "Cade Stover")
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
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func titansArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Cam Ward", rookie: "R")
        let qb2 = Cell(pos: "QB2", play: "Brandon Allen")
        let rb1 = Cell(pos: "RB1", play: "Tony Pollard")
        let rb2 = Cell(pos: "RB2", play: "Tyjae Spears")
        let rb3 = Cell(pos: "RB3", play: "Julius Chestnut")
        let wr1 = Cell(pos: "WR1", play: "Calvin Ridley")
        let wr2 = Cell(pos: "WR2", play: "Tyler Lockett")
        let wr3 = Cell(pos: "WR3", play: "Elic Ayomanor", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Van Jefferson")
        let wr5 = Cell(pos: "WR5", play: "Chimere Dike", rookie: "R")
        let wr6 = Cell(pos: "WR6", play: "Treylon Burks")
        let te1 = Cell(pos: "TE1", play: "Chigoziem Okonkwo")
        let te2 = Cell(pos: "TE2", play: "Gunnar Helm", rookie: "R")
        let te3 = Cell(pos: "TE3", play: "Josh Whyle")
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
        positionPlayer.append(wr5)
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // AFC West
    func broncosArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Bo Nix")
        let qb2 = Cell(pos: "QB2", play: "Jarrett Stidham")
        let rb1 = Cell(pos: "RB1", play: "RJ Harvey", rookie: "R")
        let rb2 = Cell(pos: "RB2", play: "J.K. Dobbins")
        let rb3 = Cell(pos: "RB3", play: "Jaleel McLaughlin")
        let rb4 = Cell(pos: "RB4", play: "Audric Estime")
        let wr1 = Cell(pos: "WR1", play: "Courtland Sutton")
        let wr2 = Cell(pos: "WR2", play: "Marvin Mims")
        let wr3 = Cell(pos: "WR3", play: "Devaughn Vele")
        let wr4 = Cell(pos: "WR4", play: "Pat Bryant", rookie: "R")
        let wr5 = Cell(pos: "WR5", play: "Troy Franklin")
        let wr6 = Cell(pos: "WR6", play: "Trent Sherfield")
        let te1 = Cell(pos: "TE1", play: "Evan Engram")
        let te2 = Cell(pos: "TE2", play: "Adam Trautman")
        let te3 = Cell(pos: "TE3", play: "Lucas Krull")
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
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func chargersArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Justin Herbert")
        let qb2 = Cell(pos: "QB2", play: "Taylor Heinicke")
        let qb3 = Cell(pos: "QB3", play: "Trey Lance")
        let rb1 = Cell(pos: "RB1", play: "Omarion Hampton", rookie: "R")
        let rb2 = Cell(pos: "RB2", play: "Najee Harris")
        let rb3 = Cell(pos: "RB3", play: "Kimani Vidal")
        let rb4 = Cell(pos: "RB4", play: "Hassan Haskins")
        let wr1 = Cell(pos: "WR1", play: "Ladd McConkey")
        let wr2 = Cell(pos: "WR2", play: "Tre Harris", rookie: "R")
        let wr3 = Cell(pos: "WR3", play: "Quentin Johnston")
        let wr4 = Cell(pos: "WR4", play: "Jalen Reagor")
        let wr5 = Cell(pos: "WR5", play: "Derius Davis")
        let wr6 = Cell(pos: "WR6", play: "Brenden Rice")
        let te1 = Cell(pos: "TE1", play: "Will Dissly")
        let te2 = Cell(pos: "TE2", play: "Tyler Conklin")
        let te3 = Cell(pos: "TE3", play: "Oronde Gadsden", rookie: "R")
        let k = Cell(pos: "K", play: "Cameron Dicker")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func chiefsArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Patrick Mahomes")
        let qb2 = Cell(pos: "QB2", play: "Gardner Minshew")
        let rb1 = Cell(pos: "RB1", play: "Isiah Pacheco")
        let rb2 = Cell(pos: "RB2", play: "Kareem Hunt")
        let rb3 = Cell(pos: "RB3", play: "Brashard Smith", rookie: "R")
        let rb4 = Cell(pos: "RB4", play: "Elijah Mitchell")
        let wr1 = Cell(pos: "WR1", play: "Rashee Rice")
        let wr2 = Cell(pos: "WR2", play: "Xavier Worthy")
        let wr3 = Cell(pos: "WR3", play: "Hollywood Brown")
        let wr4 = Cell(pos: "WR4", play: "Jalen Royals", rookie: "R")
        let wr5 = Cell(pos: "WR5", play: "JuJu Smith-Schuster")
        let wr6 = Cell(pos: "WR6", play: "Skyy Moore")
        let te1 = Cell(pos: "TE1", play: "Travis Kelce")
        let te2 = Cell(pos: "TE2", play: "Noah Gray")
        let te3 = Cell(pos: "TE3", play: "Jared Wiley")
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
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func raidersArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Geno Smith")
        let qb2 = Cell(pos: "QB2", play: "Aidan O'Connell")
        let rb1 = Cell(pos: "RB1", play: "Ashton Jeanty", rookie: "R")
        let rb2 = Cell(pos: "RB2", play: "Raheem Mostert")
        let rb3 = Cell(pos: "RB3", play: "Sincere McCormick")
        let rb4 = Cell(pos: "RB4", play: "Dylan Laube")
        let wr1 = Cell(pos: "WR1", play: "Jakobi Meyers")
        let wr2 = Cell(pos: "WR2", play: "Jack Bech", rookie: "R")
        let wr3 = Cell(pos: "WR3", play: "Tre Tucker")
        let wr4 = Cell(pos: "WR4", play: "Dont'e Thornton", rookie: "R")
        let wr5 = Cell(pos: "WR5", play: "Tommy Mellott", rookie: "R")
        let wr6 = Cell(pos: "WR6", play: "Alex Bachman")
        let te1 = Cell(pos: "TE1", play: "Brock Bowers")
        let te2 = Cell(pos: "TE2", play: "Michael Mayer")
        let te3 = Cell(pos: "TE3", play: "Ian Thomas")
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
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // NFC East
    func cowboysArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Dak Prescott")
        let qb2 = Cell(pos: "QB2", play: "Joe Milton")
        let rb1 = Cell(pos: "RB1", play: "Javonte Williams")
        let rb2 = Cell(pos: "RB2", play: "Jaydon Blue", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "Miles Sanders")
        let rb4 = Cell(pos: "RB4", play: "Hunter Luepke")
        let wr1 = Cell(pos: "WR1", play: "CeeCee Lamb")
        let wr2 = Cell(pos: "WR2", play: "George Pickens")
        let wr3 = Cell(pos: "WR3", play: "Jalen Tolbert")
        let wr4 = Cell(pos: "WR4", play: "KaVontae Turpin")
        let wr5 = Cell(pos: "WR5", play: "Parris Campbell")
        let wr6 = Cell(pos: "WR6", play: "Jalen Brooks")
        let te1 = Cell(pos: "TE1", play: "Jake Ferguson")
        let te2 = Cell(pos: "TE2", play: "Luke Schoonmaker")
        let te3 = Cell(pos: "TE3", play: "Brevyn Spann-Ford")
        let k = Cell(pos: "K", play: "Brandon Aubrey")
        
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
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func eaglesArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Jalen Hurts")
        let qb2 = Cell(pos: "QB2", play: "Tanner McKee")
        let rb1 = Cell(pos: "RB1", play: "Saquon Barkley")
        let rb2 = Cell(pos: "RB2", play: "Will Shipley")
        let rb3 = Cell(pos: "RB3", play: "AJ Dillon")
        let wr1 = Cell(pos: "WR1", play: "A.J. Brown")
        let wr2 = Cell(pos: "WR2", play: "DeVonta Smith")
        let wr3 = Cell(pos: "WR3", play: "Jahan Dotson")
        let wr4 = Cell(pos: "WR4", play: "Johnny Wilson")
        let wr5 = Cell(pos: "WR5", play: "Ainias Smith")
        let wr6 = Cell(pos: "WR6", play: "Elijah Cooks")
        let te1 = Cell(pos: "TE1", play: "Dallas Goedert")
        let te2 = Cell(pos: "TE2", play: "Grant Calcaterra")
        let te3 = Cell(pos: "TE3", play: "Kylen Granson")
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
        positionPlayer.append(wr5)
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func giantsArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Russell Wilson")
        let qb2 = Cell(pos: "QB2", play: "Jameis Winston")
        let qb3 = Cell(pos: "QB3", play: "Jaxson Dart", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Tyrone Tracy")
        let rb2 = Cell(pos: "RB2", play: "Cam Skattebo", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "Devin Singletary")
        let rb4 = Cell(pos: "RB4", play: "Eric Gray")
        let wr1 = Cell(pos: "WR1", play: "Malik Nabers")
        let wr2 = Cell(pos: "WR2", play: "Wan'Dale Robinson")
        let wr3 = Cell(pos: "WR3", play: "Darius Slayton")
        let wr4 = Cell(pos: "WR4", play: "Jalin Hyatt")
        let wr5 = Cell(pos: "WR5", play: "Zach Pascal")
        let wr6 = Cell(pos: "WR6", play: "Ihmir Smith-Marsette")
        let te1 = Cell(pos: "TE1", play: "Theo Johnson")
        let te2 = Cell(pos: "TE2", play: "Daniel Bellinger")
        let te3 = Cell(pos: "TE3", play: "Chris Manhertz")
        let k = Cell(pos: "K", play: "Graham Gano")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func commandersArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Jayden Daniels")
        let qb2 = Cell(pos: "QB2", play: "Marcus Mariota")
        let qb3 = Cell(pos: "QB3", play: "Josh Johnson")
        let rb1 = Cell(pos: "RB1", play: "Brian Robinson")
        let rb2 = Cell(pos: "RB2", play: "Austin Ekeler")
        let rb3 = Cell(pos: "RB3", play: "Jacory Croskey-Merritt", rookie: "R")
        let rb4 = Cell(pos: "RB4", play: "Jeremy McNichols")
        let wr1 = Cell(pos: "WR1", play: "Terry McLaurin")
        let wr2 = Cell(pos: "WR2", play: "Deebo Samuel")
        let wr3 = Cell(pos: "WR3", play: "Noah Brown")
        let wr4 = Cell(pos: "WR4", play: "Jaylin Lane", rookie: "R")
        let wr5 = Cell(pos: "WR5", play: "Luke McCaffrey")
        let wr6 = Cell(pos: "WR6", play: "Michael Gallup")
        let te1 = Cell(pos: "TE1", play: "Zach Ertz")
        let te2 = Cell(pos: "TE2", play: "Ben Sinnott")
        let te3 = Cell(pos: "TE3", play: "John Bates")
        let k = Cell(pos: "K", play: "Matt Gay")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // NFC North
    func bearsArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Caleb Williams")
        let qb2 = Cell(pos: "QB2", play: "Tyson Bagent")
        let rb1 = Cell(pos: "RB1", play: "D'Andre Swift")
        let rb2 = Cell(pos: "RB2", play: "Roschon Johnson")
        let rb3 = Cell(pos: "RB3", play: "Kyle Monangai", rookie: "R")
        let rb4 = Cell(pos: "RB4", play: "Travis Homer")
        let wr1 = Cell(pos: "WR1", play: "DJ Moore")
        let wr2 = Cell(pos: "WR2", play: "Rome Odunze")
        let wr3 = Cell(pos: "WR3", play: "Luther Burden", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Olamide Zaccheaus")
        let wr5 = Cell(pos: "WR5", play: "Devin Duvernay")
        let wr6 = Cell(pos: "WR6", play: "Tyler Scott")
        let te1 = Cell(pos: "TE1", play: "Colston Loveland", rookie: "R")
        let te2 = Cell(pos: "TE2", play: "Cole Kmet")
        let te3 = Cell(pos: "TE3", play: "Durham Smythe")
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
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func lionsArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Jared Goff")
        let qb2 = Cell(pos: "QB2", play: "Hendon Hooker")
        let rb1 = Cell(pos: "RB1", play: "Jahmyr Gibbs")
        let rb2 = Cell(pos: "RB2", play: "David Montgomery")
        let rb3 = Cell(pos: "RB3", play: "Craig Reynolds")
        let rb4 = Cell(pos: "RB4", play: "Slone Vaki")
        let wr1 = Cell(pos: "WR1", play: "Amon-Ra St. Brown")
        let wr2 = Cell(pos: "WR2", play: "Jameson Williams")
        let wr3 = Cell(pos: "WR3", play: "Isaac TeSlaa", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Tim Patrick")
        let wr5 = Cell(pos: "WR5", play: "Kalif Raymond")
        let wr6 = Cell(pos: "WR6", play: "Tom Kennedy")
        let te1 = Cell(pos: "TE1", play: "Sam LaPorta")
        let te2 = Cell(pos: "TE2", play: "Brock Wright")
        let te3 = Cell(pos: "TE3", play: "Shane Zylstra")
        let k = Cell(pos: "K", play: "Jake Bates")
        
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
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func packersArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Jordan Love")
        let qb2 = Cell(pos: "QB2", play: "Malik Willis")
        let rb1 = Cell(pos: "RB1", play: "Josh Jacobs")
        let rb2 = Cell(pos: "RB2", play: "MarShawn Lloyd")
        let rb3 = Cell(pos: "RB3", play: "Emanuel Wilson")
        let rb4 = Cell(pos: "RB4", play: "Chris Brooks")
        let wr1 = Cell(pos: "WR1", play: "Jayden Reed")
        let wr2 = Cell(pos: "WR2", play: "Matthew Golden", rookie: "R")
        let wr3 = Cell(pos: "WR3", play: "Romeo Doubs")
        let wr4 = Cell(pos: "WR4", play: "Dontayvion Wicks")
        let wr5 = Cell(pos: "WR5", play: "Christian Watson")
        let wr6 = Cell(pos: "WR6", play: "Savion Williams", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Tucker Kraft")
        let te2 = Cell(pos: "TE2", play: "Luke Musgrave")
        let te3 = Cell(pos: "TE3", play: "Ben Sims")
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
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func vikingsArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "J.J. McCarthy")
        let qb2 = Cell(pos: "QB2", play: "Sam Howell", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Aaron Jones")
        let rb2 = Cell(pos: "RB2", play: "Jordan Mason")
        let rb3 = Cell(pos: "RB3", play: "Ty Chandler")
        let rb4 = Cell(pos: "RB4", play: "C.J. Ham")
        let wr1 = Cell(pos: "WR1", play: "Justin Jefferson")
        let wr2 = Cell(pos: "WR2", play: "Jordan Addison")
        let wr3 = Cell(pos: "WR3", play: "Tai Felton", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Jalen Nailor")
        let wr5 = Cell(pos: "WR5", play: "Rondale Moore")
        let wr6 = Cell(pos: "WR6", play: "Tim Jones")
        let te1 = Cell(pos: "TE1", play: "T.J. Hockenson")
        let te2 = Cell(pos: "TE2", play: "Josh Oliver")
        let k = Cell(pos: "K", play: "Will Reichard")
        
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
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // NFC South
    func buccaneersArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Baker Mayfield")
        let qb2 = Cell(pos: "QB2", play: "Kyle Trask")
        let rb1 = Cell(pos: "RB1", play: "Bucky Irving")
        let rb2 = Cell(pos: "RB2", play: "Rachaad White")
        let rb3 = Cell(pos: "RB3", play: "Sean Tucker")
        let wr1 = Cell(pos: "WR1", play: "Mike Evans")
        let wr2 = Cell(pos: "WR2", play: "Chris Godwin")
        let wr3 = Cell(pos: "WR3", play: "Emeka Egbuka", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Jalen McMillan")
        let wr5 = Cell(pos: "WR5", play: "Sterling Shepard")
        let wr6 = Cell(pos: "WR6", play: "Trey Palmer")
        let te1 = Cell(pos: "TE1", play: "Cade Otton")
        let te2 = Cell(pos: "TE2", play: "Payne Durham")
        let te3 = Cell(pos: "TE3", play: "Devin Culp")
        let k = Cell(pos: "K", play: "Chase McLaughlin")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(wr5)
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func falconsArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Michael Penix Jr.")
        let qb2 = Cell(pos: "QB2", play: "Kirk Cousins")
        let rb1 = Cell(pos: "RB1", play: "Bijan Robinson")
        let rb2 = Cell(pos: "RB2", play: "Tyler Allgeier")
        let rb3 = Cell(pos: "RB3", play: "Carlos Washington Jr.", rookie: "R")
        let rb4 = Cell(pos: "RB4", play: "Elijah Dotson")
        let wr1 = Cell(pos: "WR1", play: "Drake London")
        let wr2 = Cell(pos: "WR2", play: "Darnell Mooney")
        let wr3 = Cell(pos: "WR3", play: "Ray-Ray McCloud")
        let wr4 = Cell(pos: "WR4", play: "KhaDarel Hodge")
        let wr5 = Cell(pos: "WR5", play: "Jamal Agnew")
        let wr6 = Cell(pos: "WR6", play: "Casey Washington")
        let te1 = Cell(pos: "TE1", play: "Kyle Pitts")
        let te2 = Cell(pos: "TE2", play: "Charlie Woerner")
        let te3 = Cell(pos: "TE3", play: "Feleipe Franks")
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
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func panthersArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Bryce Young")
        let qb2 = Cell(pos: "QB2", play: "Andy Dalton")
        let rb1 = Cell(pos: "RB1", play: "Chuba Hubbard")
        let rb2 = Cell(pos: "RB2", play: "Rico Dowdle")
        let rb3 = Cell(pos: "RB3", play: "Trevor Etienne", rookie: "R")
        let rb4 = Cell(pos: "RB4", play: "Raheem Blackshear")
        let wr1 = Cell(pos: "WR1", play: "Tetairoa McMillan", rookie: "R")
        let wr2 = Cell(pos: "WR2", play: "Xavier Legette")
        let wr3 = Cell(pos: "WR3", play: "Adam Thielen")
        let wr4 = Cell(pos: "WR4", play: "Jalen Coker")
        let wr5 = Cell(pos: "WR5", play: "David Moore")
        let wr6 = Cell(pos: "WR6", play: "Hunter Renfrow")
        let te1 = Cell(pos: "TE1", play: "Tommy Tremble")
        let te2 = Cell(pos: "TE2", play: "Ja'Tavion Sanders")
        let k = Cell(pos: "K", play: "Matthew Wright")
        
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
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func saintsArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Tyler Shough", rookie: "R")
        let qb2 = Cell(pos: "QB2", play: "Spencer Rattler")
        let qb3 = Cell(pos: "QB3", play: "Jake Haener")
        let rb1 = Cell(pos: "RB1", play: "Alvin Kamara")
        let rb2 = Cell(pos: "RB2", play: "Kendre Miller")
        let rb3 = Cell(pos: "RB3", play: "Devin Neal", rookie: "R")
        let rb4 = Cell(pos: "RB4", play: "Cam Akers")
        let wr1 = Cell(pos: "WR1", play: "Chris Olave")
        let wr2 = Cell(pos: "WR2", play: "Rashid Shaheed")
        let wr3 = Cell(pos: "WR3", play: "Brandin Cooks")
        let wr4 = Cell(pos: "WR4", play: "Cedrick Wilson")
        let wr5 = Cell(pos: "WR5", play: "Bub Means")
        let wr6 = Cell(pos: "WR6", play: "Kevin Austin")
        let te1 = Cell(pos: "TE1", play: "Juwan Johnson")
        let te2 = Cell(pos: "TE2", play: "Taysom Hill")
        let te3 = Cell(pos: "TE3", play: "Foster Moreau")
        let k = Cell(pos: "K", play: "Blake Grupe")
        
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
        positionPlayer.append(wr5)
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // NFC West
    func _49ersArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Brock Purdy")
        let qb2 = Cell(pos: "QB2", play: "Mac Jones")
        let rb1 = Cell(pos: "RB1", play: "Christian McCaffrey")
        let rb2 = Cell(pos: "RB2", play: "Isaac Guerendo")
        let rb3 = Cell(pos: "RB3", play: "Jordan James", rookie: "R")
        let rb4 = Cell(pos: "RB4", play: "Patrick Taylor")
        let wr1 = Cell(pos: "WR1", play: "Jauan Jennings")
        let wr2 = Cell(pos: "WR2", play: "Brandon Aiyuk")
        let wr3 = Cell(pos: "WR3", play: "Ricky Pearsall")
        let wr4 = Cell(pos: "WR4", play: "Demarcus Robinson")
        let wr5 = Cell(pos: "WR5", play: "Jacob Cowing")
        let wr6 = Cell(pos: "WR6", play: "Jordan Watkins", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "George Kittle")
        let te2 = Cell(pos: "TE2", play: "Luke Farrell")
        let te3 = Cell(pos: "TE3", play: "Brayden Willis")
        let k = Cell(pos: "K", play: "Jake Moody")
        
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
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func cardinalsArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Kyler Murray")
        let qb2 = Cell(pos: "QB2", play: "Jacoby Brissett")
        let rb1 = Cell(pos: "RB1", play: "James Conner")
        let rb2 = Cell(pos: "RB2", play: "Trey Benson")
        let rb3 = Cell(pos: "RB3", play: "Emari Demercado")
        let rb4 = Cell(pos: "RB4", play: "DeeJay Dallas")
        let wr1 = Cell(pos: "WR1", play: "Marvin Harrison Jr.")
        let wr2 = Cell(pos: "WR2", play: "Michael Wilson")
        let wr3 = Cell(pos: "WR3", play: "Greg Dortch")
        let wr4 = Cell(pos: "WR4", play: "Zay Jones")
        let wr5 = Cell(pos: "WR5", play: "Simi Fehoko")
        let wr6 = Cell(pos: "WR6", play: "Xavier Weaver")
        let te1 = Cell(pos: "TE1", play: "Trey McBride")
        let te2 = Cell(pos: "TE2", play: "Tip Reiman")
        let te3 = Cell(pos: "TE3", play: "Elijah Higgins")
        let k = Cell(pos: "K", play: "Chad Ryland")
        
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
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func ramsArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Matthew Stafford")
        let qb2 = Cell(pos: "QB2", play: "Jimmy Garoppolo")
        let rb1 = Cell(pos: "RB1", play: "Kyren Williams")
        let rb2 = Cell(pos: "RB2", play: "Jarquez Hunter", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "Blake Corum")
        let rb4 = Cell(pos: "RB4", play: "Ronnie Rivers")
        let wr1 = Cell(pos: "WR1", play: "Puka Nacua")
        let wr2 = Cell(pos: "WR2", play: "Davante Adams")
        let wr3 = Cell(pos: "WR3", play: "Tutu Atwell")
        let wr4 = Cell(pos: "WR4", play: "Jordan Whittington")
        let wr5 = Cell(pos: "WR5", play: "Xavier Smith")
        let wr6 = Cell(pos: "WR6", play: "Britain Covey")
        let te1 = Cell(pos: "TE1", play: "Tyler Higbee")
        let te2 = Cell(pos: "TE2", play: "Terrance Ferguson", rookie: "R")
        let te3 = Cell(pos: "TE3", play: "Colby Parkinson")
        let k = Cell(pos: "K", play: "Joshua Karty")
        
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
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func seahawksArray_2025() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Sam Darnold")
        let qb2 = Cell(pos: "QB2", play: "Drew Lock")
        let rb1 = Cell(pos: "RB1", play: "Kenneth Walker")
        let rb2 = Cell(pos: "RB2", play: "Zach Charbonnet")
        let rb3 = Cell(pos: "RB3", play: "Kenny McIntosh")
        let rb4 = Cell(pos: "RB4", play: "George Holani")
        let rb5 = Cell(pos: "RB5", play: "Damien Martinez", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Jaxon Smith-Njigba")
        let wr2 = Cell(pos: "WR2", play: "Cooper Kupp")
        let wr3 = Cell(pos: "WR3", play: "Marquez Valdes-Scantling")
        let wr4 = Cell(pos: "WR4", play: "Tory Horton", rookie: "R")
        let wr5 = Cell(pos: "WR5", play: "Jake Bobo")
        let wr6 = Cell(pos: "WR6", play: "Ricky White", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Elijah Arroyo", rookie: "R")
        let te2 = Cell(pos: "TE2", play: "AJ Barner")
        let te3 = Cell(pos: "TE3", play: "Eric Saubert")
        let k = Cell(pos: "K", play: "Jason Myers")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(rb4)
        positionPlayer.append(rb5)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(wr5)
        positionPlayer.append(wr6)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
}

