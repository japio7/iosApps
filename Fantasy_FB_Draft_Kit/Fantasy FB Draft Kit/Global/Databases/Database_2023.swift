//
//  Database_2023.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 12/15/21.
//  Copyright © 2021 Jared Pino. All rights reserved.
//

import Foundation
import UIKit

class Database_2023 {
    
    static let shared = Database_2023()
    
    var leagueNames: [String]
    var teamNames: [String]
    var leagues: [[String]]
    
    var playerData = [PlayerData]()
    
    var objectsArray: [[String]] = [["Overall Top 200", "Top 30 Rookies"], ["Top 30 Quarterbacks", "Top 80 Running Backs", "Top 80 Wide Receivers", "Top 30 Tight Ends", "Top 20 Defenses", "Top 15 Kickers"], ["Depth Charts"], ["My Leagues"], ["Reset Draft"]
    ]
    
    var teamAbbreviations = ["buffalo bills", "buffalo", "buf", "bills", "miami dolphins", "miami", "mia", "dolphins", "new york jets", "nyj", "jets", "new england patriots", "new england", "ne", "patriots", "cincinatti bengals", "cincinatti", "cin", "bengals", "cleveland browns", "cleveland", "cle", "browns", "baltimore ravens", "baltimore", "bal", "ravens", "pittsburgh steelers", "pittsburgh", "pit", "steelers", "indianapolis colts", "indianapolis", "ind", "colts", "jacksonville jaguars", "jacksonville", "jac", "jaguars", "houston texans", "houston", "hou", "texans", "tennessee titans", "tennessee", "ten", "titans", "denver broncos", "denver", "den", "broncos", "los angeles chargers", "lac", "chargers", "kansas city chiefs", "kansas city", "kc", "chiefs", "las vegas raiders", "las vegas", "lv", "raiders", "dallas cowboys", "dallas", "dal", "cowboys", "philadelphia eagles", "philadelphia", "phi", "eagles", "new york giants", "nyg", "giants", "washington commanders", "washington", "was", "commanders", "chicago bears", "chicago", "chi", "bears", "detroit lions", "detroit", "det", "lions", "green bay packers", "green bay", "gb", "packers", "minnesota vikings", "minnesota", "min", "vikings", "tampa bay buccaneers", "tampa bay", "tb", "buccaneers", "atlanta falcons", "atlanta", "atl", "falcons", "carolina panthers", "carolina", "car", "panthers", "new orleans saints", "new orleans", "no", "saints", "san francisco 49ers", "san francisco", "sf", "49ers", "arizona cardinals", "arizona", "ari", "cardinals", "los angeles Rams", "lar", "rams", "seattle seahawks", "seattle", "sea", "seahawks"]
    
    var positions = ["qb", "quarterback", "quarter back", "rb", "runningback", "running back", "wr", "wide receiver", "receiver", "te", "tight end", "k", "kicker"]
    
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
        } else if tn.lowercased() == "los angeles Rams" || tn.lowercased() == " lar" || tn.lowercased() == "rams" {
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
                playerData = Database_2023.shared.playerList(topPlayer: true)
                label.text = "Overall Top 200"
            } else if passed.sec == 0 && passed.row == 1 {
                playerData = Database_2023.shared.playerList(rookie: true)
                label.text = "Top 30 Rookies"
            } else if passed.sec == 1 && passed.row == 0 {
                playerData = Database_2023.shared.playerList(position: "QB", num: 30)
                label.text = "Top 30 Quarterbacks"
            } else if passed.sec == 1 && passed.row == 1 {
                playerData = Database_2023.shared.playerList(position: "RB", num: 80)
                label.text = "Top 80 Running Backs"
            } else if passed.sec == 1 && passed.row == 2 {
                playerData = Database_2023.shared.playerList(position: "WR", num: 80)
                label.text = "Top 80 Wide Receivers"
            } else if passed.sec == 1 && passed.row == 3 {
                playerData = Database_2023.shared.playerList(position: "TE", num: 30)
                label.text = "Top 30 Tight Ends"
            } else if passed.sec == 1 && passed.row == 4 {
                playerData = Database_2023.shared.playerList(position: "DST", num: 20)
                label.text = "Top 20 Defenses"
            } else if passed.sec == 1 && passed.row == 5 {
                playerData = Database_2023.shared.playerList(position: "K", num: 15)
                label.text = "Top 15 Kickers"
            }
        }
    }
    
    // All players and leagues 2023
    fileprivate var allPlayers: [PlayerData]
    
    // All Players Save, Write and Read
    fileprivate func playerDataURL() -> URL {
        let documentDirectoryURL = FileManager.default.urls(for: .documentDirectory, in:.userDomainMask).last!
        return documentDirectoryURL.appendingPathComponent("playerData_2023.json")
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
        return documentDirectoryURL.appendingPathComponent("leagueNamesData_2023.json")
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
        return documentDirectoryURL.appendingPathComponent("teamNamesData_2023.json")
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
        return documentDirectoryURL.appendingPathComponent("leaguesData_2023.json")
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
            _table.reloadData()
        } else {
            return
        }
        changeMade()
    }
    
    // Reset the draft
    func resetDraft() {
        allPlayers = [
            PlayerData(num: 1, numPosPick: 1, numRookie: 0, name: "Justin Jefferson", team: "MIN", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 2, numPosPick: 2, numRookie: 0, name: "Ja'Marr Chase", team: "CIN", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 3, numPosPick: 1, numRookie: 0, name: "Christian McCaffrey", team: "SF", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 4, numPosPick: 2, numRookie: 0, name: "Austin Ekeler", team: "LAC", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 5, numPosPick: 3, numRookie: 0, name: "Cooper Kupp", team: "LAR", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 6, numPosPick: 4, numRookie: 0, name: "Tyreek Hill", team: "MIA", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 7, numPosPick: 1, numRookie: 0, name: "Travis Kelce", team: "KC", position: "TE", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 8, numPosPick: 5, numRookie: 0, name: "Stefon Diggs", team: "BUF", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 9, numPosPick: 3, numRookie: 0, name: "Saquon Barkley", team: "NYG", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 10, numPosPick: 4, numRookie: 1, name: "Bijan Robinson", team: "ATL", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: true),
            PlayerData(num: 11, numPosPick: 6, numRookie: 0, name: "CeeDee Lamb", team: "DAL", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 12, numPosPick: 5, numRookie: 0, name: "Nick Chubb", team: "CLE", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 13, numPosPick: 7, numRookie: 0, name: "A.J. Brown", team: "PHI", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 14, numPosPick: 8, numRookie: 0, name: "Amon-Ra St. Brown", team: "DET", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 15, numPosPick: 9, numRookie: 0, name: "Davante Adams", team: "LV", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 16, numPosPick: 6, numRookie: 0, name: "Tony Pollard", team: "DAL", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 17, numPosPick: 7, numRookie: 0, name: "Derrick Henry", team: "TEN", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 18, numPosPick: 10, numRookie: 0, name: "Garrett Wilson", team: "NYJ", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 19, numPosPick: 11, numRookie: 0, name: "Jaylen Waddle", team: "MIA", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 20, numPosPick: 8, numRookie: 0, name: "Jonathan Taylor", team: "IND", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 21, numPosPick: 9, numRookie: 0, name: "Josh Jacobs", team: "LV", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 22, numPosPick: 12, numRookie: 0, name: "Chris Olave", team: "NO", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 23, numPosPick: 13, numRookie: 0, name: "DeVonta Smith", team: "PHI", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 24, numPosPick: 1, numRookie: 0, name: "Patrick Mahomes", team: "KC", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 25, numPosPick: 2, numRookie: 0, name: "Jalen Hurts", team: "PHI", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 26, numPosPick: 2, numRookie: 0, name: "Mark Andrews", team: "BAL", position: "TE", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 27, numPosPick: 14, numRookie: 0, name: "Tee Higgins", team: "CIN", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 28, numPosPick: 10, numRookie: 0, name: "Rhamondre Stevenson", team: "NE", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 29, numPosPick: 3, numRookie: 0, name: "Josh Allen", team: "BUF", position: "QB", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 30, numPosPick: 11, numRookie: 0, name: "Najee Harris", team: "PIT", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 31, numPosPick: 15, numRookie: 0, name: "Keenan Allen", team: "LAC", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 32, numPosPick: 16, numRookie: 0, name: "Calvin Ridley", team: "JAC", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 33, numPosPick: 17, numRookie: 0, name: "DK Metcalf", team: "SEA", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 34, numPosPick: 12, numRookie: 0, name: "Travis Etienne Jr.", team: "JAC", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 35, numPosPick: 13, numRookie: 0, name: "Joe Mixon", team: "CIN", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 36, numPosPick: 14, numRookie: 2, name: "Jahmyr Gibbs", team: "DET", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: true),
            PlayerData(num: 37, numPosPick: 15, numRookie: 0, name: "Aaron Jones", team: "GB", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 38, numPosPick: 18, numRookie: 0, name: "Amari Cooper", team: "CLE", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 39, numPosPick: 19, numRookie: 0, name: "Deebo Samuel", team: "SF", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 40, numPosPick: 3, numRookie: 0, name: "T.J. Hockenson", team: "MIN", position: "TE", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 41, numPosPick: 20, numRookie: 0, name: "Jerry Jeudy", team: "DEN", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 42, numPosPick: 21, numRookie: 0, name: "DeAndre Hopkins", team: "TEN", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 43, numPosPick: 22, numRookie: 0, name: "Terry McLaurin", team: "WAS", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 44, numPosPick: 4, numRookie: 0, name: "Lamar Jackson", team: "BAL", position: "QB", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 45, numPosPick: 16, numRookie: 0, name: "Dameon Pierce", team: "HOU", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 46, numPosPick: 17, numRookie: 0, name: "Breece Hall", team: "NYJ", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 47, numPosPick: 23, numRookie: 0, name: "Chris Godwin", team: "TB", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 48, numPosPick: 24, numRookie: 0, name: "Drake London", team: "ATL", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 49, numPosPick: 25, numRookie: 0, name: "Christian Watson", team: "GB", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 50, numPosPick: 26, numRookie: 0, name: "DJ Moore", team: "CHI", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 51, numPosPick: 18, numRookie: 0, name: "Kenneth Walker", team: "SEA", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 52, numPosPick: 19, numRookie: 0, name: "Miles Sanders", team: "CAR", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 53, numPosPick: 5, numRookie: 0, name: "Joe Burrow", team: "CIN", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 54, numPosPick: 20, numRookie: 0, name: "Alexander Mattison", team: "MIN", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 55, numPosPick: 4, numRookie: 0, name: "George Kittle", team: "SF", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 56, numPosPick: 6, numRookie: 0, name: "Justin Fields", team: "CHI", position: "QB", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 57, numPosPick: 27, numRookie: 0, name: "Diontae Johnson", team: "PIT", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 58, numPosPick: 5, numRookie: 0, name: "Darren Waller", team: "NYG", position: "TE", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 59, numPosPick: 28, numRookie: 0, name: "Tyler Lockett", team: "SEA", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 60, numPosPick: 21, numRookie: 0, name: "James Conner", team: "ARI", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 61, numPosPick: 22, numRookie: 0, name: "Rachaad White", team: "TB", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 62, numPosPick: 23, numRookie: 0, name: "J.K. Dobbins", team: "BAL", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 63, numPosPick: 29, numRookie: 0, name: "Brandon Aiyuk", team: "SF", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 64, numPosPick: 30, numRookie: 0, name: "Mike Williams", team: "LAC", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 65, numPosPick: 24, numRookie: 0, name: "Cam Akers", team: "LAR", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 66, numPosPick: 31, numRookie: 0, name: "Mike Evans", team: "TB", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 67, numPosPick: 32, numRookie: 0, name: "Christian Kirk", team: "JAC", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 68, numPosPick: 7, numRookie: 0, name: "Justin Herbert", team: "LAC", position: "QB", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 69, numPosPick: 25, numRookie: 0, name: "Alvin Kamara", team: "NO", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 70, numPosPick: 6, numRookie: 0, name: "Dallas Goedert", team: "PHI", position: "TE", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 71, numPosPick: 7, numRookie: 0, name: "Kyle Pitts", team: "ATL", position: "TE", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 72, numPosPick: 33, numRookie: 0, name: "Marquise Brown", team: "ARI", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 73, numPosPick: 26, numRookie: 0, name: "James Cook", team: "BUF", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 74, numPosPick: 34, numRookie: 0, name: "Michael Pittman Jr.", team: "IND", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 75, numPosPick: 27, numRookie: 0, name: "Javonte Williams", team: "DEN", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 76, numPosPick: 8, numRookie: 0, name: "Trevor Lawrence", team: "JAC", position: "QB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 77, numPosPick: 35, numRookie: 0, name: "Jahan Dotson", team: "WAS", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 78, numPosPick: 36, numRookie: 0, name: "George Pickens", team: "PIT", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 79, numPosPick: 28, numRookie: 0, name: "David Montgomery", team: "DET", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 80, numPosPick: 29, numRookie: 0, name: "Isiah Pacheco", team: "KC", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 81, numPosPick: 37, numRookie: 3, name: "Jordan Addison", team: "MIN", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: true),
            PlayerData(num: 82, numPosPick: 38, numRookie: 4, name: "Jaxon Smith-Njigba", team: "SEA", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: true),
            PlayerData(num: 83, numPosPick: 39, numRookie: 0, name: "Treylon Burks", team: "TEN", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 84, numPosPick: 30, numRookie: 0, name: "D'Andre Swift", team: "PHI", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 85, numPosPick: 8, numRookie: 0, name: "Evan Engram", team: "JAC", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 86, numPosPick: 40, numRookie: 0, name: "Brandin Cooks", team: "DAL", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 87, numPosPick: 31, numRookie: 0, name: "AJ Dillon", team: "GB", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 88, numPosPick: 9, numRookie: 0, name: "Pat Freiermuth", team: "PIT", position: "TE", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 89, numPosPick: 32, numRookie: 0, name: "Dalvin Cook", team: "NYJ", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 90, numPosPick: 41, numRookie: 0, name: "Michael Thomas", team: "NO", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 91, numPosPick: 42, numRookie: 0, name: "JuJu Smith-Schuster", team: "NE", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 92, numPosPick: 43, numRookie: 0, name: "Gabriel Davis", team: "BUF", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 93, numPosPick: 10, numRookie: 0, name: "David Njoku", team: "CLE", position: "TE", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 94, numPosPick: 33, numRookie: 0, name: "Antonio Gibson", team: "WAS", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 95, numPosPick: 44, numRookie: 0, name: "Courtland Sutton", team: "DEN", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 96, numPosPick: 9, numRookie: 0, name: "Deshaun Watson", team: "CLE", position: "QB", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 97, numPosPick: 45, numRookie: 0, name: "Elijah Moore", team: "CLE", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 98, numPosPick: 46, numRookie: 5, name: "Zay Flowers", team: "BAL", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: true),
            PlayerData(num: 99, numPosPick: 47, numRookie: 6, name: "Quentin Johnston", team: "LAC", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: true),
            PlayerData(num: 100, numPosPick: 10, numRookie: 0, name: "Dak Prescott", team: "DAL", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 101, numPosPick: 34, numRookie: 0, name: "Brian Robinson Jr.", team: "WAS", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 102, numPosPick: 35, numRookie: 0, name: "Rashaad Penny", team: "PHI", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 103, numPosPick: 36, numRookie: 0, name: "Samaje Perine", team: "DEN", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 104, numPosPick: 11, numRookie: 0, name: "Daniel Jones", team: "NYG", position: "QB", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 105, numPosPick: 48, numRookie: 0, name: "Jakobi Meyers", team: "LV", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 106, numPosPick: 12, numRookie: 0, name: "Tua Tagovailoa", team: "MIA", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 107, numPosPick: 11, numRookie: 0, name: "Dalton Schultz", team: "HOU", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 108, numPosPick: 13, numRookie: 0, name: "Kirk Cousins", team: "MIN", position: "QB", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 109, numPosPick: 37, numRookie: 0, name: "Khalil Herbert", team: "CHI", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 110, numPosPick: 49, numRookie: 0, name: "Skyy Moore", team: "KC", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 111, numPosPick: 50, numRookie: 0, name: "Kadarius Toney", team: "KC", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 112, numPosPick: 51, numRookie: 0, name: "Rondale Moore", team: "ARI", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 113, numPosPick: 14, numRookie: 0, name: "Geno Smith", team: "SEA", position: "QB", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 114, numPosPick: 38, numRookie: 7, name: "Zach Charbonnet", team: "SEA", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: true),
            PlayerData(num: 115, numPosPick: 39, numRookie: 0, name: "Jamaal Williams", team: "NO", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 116, numPosPick: 52, numRookie: 0, name: "Odell Beckham Jr.", team: "BAL", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 117, numPosPick: 15, numRookie: 0, name: "Anthony Richardson", team: "IND", position: "QB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 118, numPosPick: 16, numRookie: 0, name: "Aaron Rodgers", team: "NYJ", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 119, numPosPick: 12, numRookie: 0, name: "Tyler Higbee", team: "LAR", position: "TE", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 120, numPosPick: 13, numRookie: 0, name: "Greg Dulcich", team: "DEN", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 121, numPosPick: 40, numRookie: 0, name: "Jerick McKinnon", team: "KC", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 122, numPosPick: 14, numRookie: 0, name: "Cole Kmet", team: "CHI", position: "TE", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 123, numPosPick: 53, numRookie: 0, name: "Allen Lazard", team: "NYJ", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 124, numPosPick: 54, numRookie: 0, name: "Adam Thielen", team: "CAR", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 125, numPosPick: 55, numRookie: 0, name: "Nico Collins", team: "HOU", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 126, numPosPick: 56, numRookie: 0, name: "Darnell Mooney", team: "CHI", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 127, numPosPick: 15, numRookie: 0, name: "Chigoziem Okonkwo", team: "TEN", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 128, numPosPick: 41, numRookie: 8, name: "Devon Achane", team: "MIA", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: true),
            PlayerData(num: 129, numPosPick: 57, numRookie: 0, name: "Rashod Bateman", team: "BAL", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 130, numPosPick: 17, numRookie: 0, name: "Russell Wilson", team: "DEN", position: "QB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 131, numPosPick: 58, numRookie: 0, name: "Tyler Boyd", team: "CIN", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 132, numPosPick: 59, numRookie: 0, name: "Romeo Doubs", team: "GB", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 133, numPosPick: 42, numRookie: 0, name: "Damien Harris", team: "BUF", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 134, numPosPick: 1, numRookie: 0, name: "Justin Tucker", team: "BAL", position: "K", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 135, numPosPick: 43, numRookie: 0, name: "Elijah Mitchell", team: "SF", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 136, numPosPick: 16, numRookie: 9, name: "Dalton Kincaid", team: "BUF", position: "TE", byeWeek: 13, isTopPlayer: true, isRookie: true),
            PlayerData(num: 137, numPosPick: 1, numRookie: 0, name: "San Francisco 49ers", team: "SF", position: "DST", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 138, numPosPick: 60, numRookie: 0, name: "Jameson Williams", team: "DET", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 139, numPosPick: 61, numRookie: 0, name: "Zay Jones", team: "JAC", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 140, numPosPick: 44, numRookie: 0, name: "Raheem Mostert", team: "MIA", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 141, numPosPick: 45, numRookie: 0, name: "Devin Singletary", team: "HOU", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 142, numPosPick: 62, numRookie: 0, name: "DJ Chark Jr.", team: "CAR", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 143, numPosPick: 17, numRookie: 0, name: "Gerald Everett", team: "LAC", position: "TE", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 144, numPosPick: 63, numRookie: 0, name: "Michael Gallup", team: "DAL", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 145, numPosPick: 64, numRookie: 0, name: "K.J. Osborn", team: "MIN", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 146, numPosPick: 46, numRookie: 0, name: "Jaylen Warren", team: "PIT", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 147, numPosPick: 2, numRookie: 0, name: "Dallas Cowboys", team: "DAL", position: "DST", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 148, numPosPick: 2, numRookie: 0, name: "Tyler Bass", team: "BUF", position: "K", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 149, numPosPick: 18, numRookie: 0, name: "Jared Goff", team: "DET", position: "QB", byeWeek: 9, isTopPlayer: true, isRookie: false),
            PlayerData(num: 150, numPosPick: 47, numRookie: 0, name: "Jeff Wilson", team: "MIA", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 151, numPosPick: 3, numRookie: 0, name: "Buffalo Bills", team: "BUF", position: "DST", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 152, numPosPick: 48, numRookie: 0, name: "Tyler Allgeier", team: "ATL", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 153, numPosPick: 49, numRookie: 0, name: "D'Onta Foreman", team: "CHI", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 154, numPosPick: 3, numRookie: 0, name: "Daniel Carlson", team: "LV", position: "K", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 155, numPosPick: 50, numRookie: 0, name: "Kenneth Gainwell", team: "PHI", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 156, numPosPick: 18, numRookie: 10, name: "Sam LaPorta", team: "DET", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: true),
            PlayerData(num: 157, numPosPick: 4, numRookie: 0, name: "Harrison Butker", team: "KC", position: "K", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 158, numPosPick: 65, numRookie: 11, name: "Jonathan Mingo", team: "CAR", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: true),
            PlayerData(num: 159, numPosPick: 4, numRookie: 0, name: "New England Patriots", team: "NE", position: "DST", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 160, numPosPick: 19, numRookie: 0, name: "Matthew Stafford", team: "LAR", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 161, numPosPick: 66, numRookie: 0, name: "Curtis Samuel", team: "WAS", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 162, numPosPick: 51, numRookie: 12, name: "Tank Bigsby", team: "JAC", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: true),
            PlayerData(num: 163, numPosPick: 5, numRookie: 0, name: "Evan McPherson", team: "CIN", position: "K", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 164, numPosPick: 20, numRookie: 0, name: "Kyler Murray", team: "ARI", position: "QB", byeWeek: 14, isTopPlayer: true, isRookie: false),
            PlayerData(num: 165, numPosPick: 67, numRookie: 0, name: "Isaiah Hodgins", team: "NYG", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 166, numPosPick: 68, numRookie: 0, name: "Donovan Peoples-Jones", team: "CLE", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 167, numPosPick: 69, numRookie: 0, name: "Marquez Valdes-Scantling", team: "KC", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 168, numPosPick: 70, numRookie: 0, name: "Parris Campbell", team: "NYG", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 169, numPosPick: 21, numRookie: 0, name: "Kenny Pickett", team: "PIT", position: "QB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 170, numPosPick: 72, numRookie: 0, name: "Alec Pierce", team: "IND", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 171, numPosPick: 73, numRookie: 0, name: "Van Jefferson", team: "LAR", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 172, numPosPick: 74, numRookie: 13, name: "Jayden Reed", team: "GB", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: true),
            PlayerData(num: 173, numPosPick: 19, numRookie: 0, name: "Irv Smith Jr.", team: "CIN", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 174, numPosPick: 52, numRookie: 0, name: "Kareem Hunt", team: "FA", position: "RB", byeWeek: 0, isTopPlayer: true, isRookie: false),
            PlayerData(num: 175, numPosPick: 75, numRookie: 0, name: "Hunter Renfrow", team: "LV", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 176, numPosPick: 53, numRookie: 14, name: "Roschon Johnson", team: "CHI", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: true),
            PlayerData(num: 177, numPosPick: 76,numRookie: 15, name: "Rashee Rice", team: "KC", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: true),
            PlayerData(num: 178, numPosPick: 6, numRookie: 0, name: "Younghoe Koo", team: "ATL", position: "K", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 179, numPosPick: 22, numRookie: 0, name: "Derek Carr", team: "NO", position: "QB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 180, numPosPick: 54, numRookie: 0, name: "Chuba Hubbard", team: "CAR", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 181, numPosPick: 5, numRookie: 0, name: "New York Jets", team: "NYJ", position: "DST", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 182, numPosPick: 55, numRookie: 0, name: "Ezekiel Elliott", team: "NE", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 183, numPosPick: 6, numRookie: 0, name: "New Orleans Saints", team: "NO", position: "DST", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 184, numPosPick: 20, numRookie: 0, name: "Dawson Knox", team: "BUF", position: "TE", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 185, numPosPick: 77, numRookie: 0, name: "Robert Woods", team: "HOU", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 186, numPosPick: 7, numRookie: 0, name: "Nick Folk", team: "NE", position: "K", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 187, numPosPick: 21, numRookie: 0, name: "Mike Gesicki", team: "NE", position: "TE", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 188, numPosPick: 8, numRookie: 0, name: "Jason Myers", team: "SEA", position: "K", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 189, numPosPick: 78, numRookie: 0, name: "Rashid Shaheed", team: "NO", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 190, numPosPick: 22, numRookie: 0, name: "Juwan Johnson", team: "NO", position: "TE", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 191, numPosPick: 79, numRookie: 0, name: "Chase Claypool", team: "PIT", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
            PlayerData(num: 192, numPosPick: 23, numRookie: 0, name: "Hayden Hurst", team: "CAR", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
            PlayerData(num: 193, numPosPick: 56, numRookie: 0, name: "Leonard Fournette", team: "FA", position: "RB", byeWeek: 0, isTopPlayer: true, isRookie: false),
            PlayerData(num: 194, numPosPick: 7, numRookie: 0, name: "Miami Dolphins", team: "MIA", position: "DST", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 195, numPosPick: 9, numRookie: 0, name: "Matt Gay", team: "IND", position: "K", byeWeek: 11, isTopPlayer: true, isRookie: false),
            PlayerData(num: 196, numPosPick: 57, numRookie: 0, name: "Jerome Ford", team: "CLE", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
            PlayerData(num: 197, numPosPick: 10, numRookie: 0, name: "Jake Elliott", team: "PHI", position: "K", byeWeek: 10, isTopPlayer: true, isRookie: false),
            PlayerData(num: 198, numPosPick: 8, numRookie: 0, name: "Pittsburgh Steelers", team: "PIT", position: "DST", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 199, numPosPick: 23, numRookie: 0, name: "Jordan Love", team: "GB", position: "QB", byeWeek: 6, isTopPlayer: true, isRookie: false),
            PlayerData(num: 200, numPosPick: 58, numRookie: 16, name: "Kendre Miller", team: "NO", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: true),
            
            // Not top 200 but still top in position.
            // Rest of Quarterbacks.
            PlayerData(num: 0, numPosPick: 24, numRookie: 18, name: "Bryce Young", team: "CAR", position: "QB", byeWeek: 7, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 25, numRookie: 0, name: "Brock Purdy", team: "SF", position: "QB", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 26, numRookie: 0, name: "Ryan Tannehill", team: "TEN", position: "QB", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 27, numRookie: 0, name: "Sam Howell", team: "WAS", position: "QB", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 28, numRookie: 23, name: "C.J. Stroud", team: "HOU", position: "QB", byeWeek: 7, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 29, numRookie: 0, name: "Jimmy Garoppolo", team: "LV", position: "QB", byeWeek: 13, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 30, numRookie: 0, name: "Mac Jones", team: "NE", position: "QB", byeWeek: 11, isTopPlayer: false, isRookie: false),
            
            // Rest of Running Backs.
            PlayerData(num: 0, numPosPick: 59, numRookie: 0, name: "Gus Edwards", team: "BAL", position: "RB", byeWeek: 13, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 60, numRookie: 0, name: "Cordarrelle Patterson", team: "ATL", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 61, numRookie: 0, name: "Michael Carter", team: "NYJ", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 62, numRookie: 0, name: "Clyde Edwards-Helaire", team: "KC", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 63, numRookie: 0, name: "Zamir White", team: "LV", position: "RB", byeWeek: 13, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 64, numRookie: 19, name: "Israel Abanikanda", team: "NYJ", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 65, numRookie: 20, name: "Tyjae Spears", team: "TEN", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 66, numRookie: 0, name: "Chase Edmonds", team: "TB", position: "RB", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 67, numRookie: 0, name: "Kyren Williams", team: "LAR", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 68, numRookie: 22, name: "Chase Brown", team: "CIN", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 69, numRookie: 0, name: "Joshua Kelley", team: "LAC", position: "RB", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 70, numRookie: 0, name: "Deon Jackson", team: "IND", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 71, numRookie: 0, name: "Keaontay Ingram", team: "ARI", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 72, numRookie: 0, name: "Ty Chandler", team: "MIN", position: "RB", byeWeek: 13, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 73, numRookie: 0, name: "Malik Davis", team: "DAL", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 74, numRookie: 27, name: "Evan Hull", team: "IND", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 75, numRookie: 28, name: "Eric Gray", team: "NYG", position: "RB", byeWeek: 13, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 76, numRookie: 0, name: "Trayveon Williams", team: "CIN", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 77, numRookie: 29, name: "Zach Evans", team: "LAR", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 78, numRookie: 0, name: "Pierre Strong", team: "NE", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 79, numRookie: 0, name: "Zonovan Knight", team: "NYJ", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 80, numRookie: 0, name: "Ty Montgomery", team: "NE", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: false),
            
            // Rest of Wide Receivers.
            PlayerData(num: 0, numPosPick: 80, numRookie: 0, name: "DeVante Parker", team: "NE", position: "WR", byeWeek: 11, isTopPlayer: false, isRookie: false),
            
            // Rest of Tight Ends.
            PlayerData(num: 0, numPosPick: 24, numRookie: 0, name: "Hunter Henry", team: "NE", position: "TE", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 25, numRookie: 0, name: "Zach Ertz", team: "ARI", position: "TE", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 26, numRookie: 0, name: "Jelani Woods", team: "IND", position: "TE", byeWeek: 11, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 27, numRookie: 0, name: "Tyler Conklin", team: "NYJ", position: "TE", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 28, numRookie: 0, name: "Trey McBride", team: "ARI", position: "TE", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 29, numRookie: 0, name: "Cade Otton", team: "TB", position: "TE", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 30, numRookie: 0, name: "Jake Ferguson", team: "DAL", position: "TE", byeWeek: 7, isTopPlayer: false, isRookie: false),
            
            // Rest of Defenses
            PlayerData(num: 0, numPosPick: 9, numRookie: 0, name: "Baltimore Ravens", team: "BAL", position: "DST", byeWeek: 13, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 10, numRookie: 0, name: "Philadelphia Eagles", team: "PHI", position: "DST", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 11, numRookie: 0, name: "Cleveland Browns", team: "CLE", position: "DST", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 12, numRookie: 0, name: "Green Bay Packers", team: "GB", position: "DST", byeWeek: 6, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 13, numRookie: 0, name: "Tampa Bay Buccaneers", team: "TB", position: "DST", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 14, numRookie: 0, name: "Denver Broncos", team: "DEN", position: "DST", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 15, numRookie: 0, name: "Cincinnati Bengals", team: "CIN", position: "DST", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 16, numRookie: 0, name: "Carolina Panthers", team: "CAR", position: "DST", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 17, numRookie: 0, name: "Washington Commanders", team: "WAS", position: "DST", byeWeek: 14, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 18, numRookie: 0, name: "Kansas City Chiefs", team: "KC", position: "DST", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 19, numRookie: 0, name: "Seattle Seahawks", team: "SEA", position: "DST", byeWeek: 5, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 20, numRookie: 0, name: "Jacksonville Jaguars", team: "JAC", position: "DST", byeWeek: 9, isTopPlayer: false, isRookie: false),
            
            // Rest of Kickers
            PlayerData(num: 0, numPosPick: 11, numRookie: 0, name: "Brandon McManus", team: "JAC", position: "K", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 12, numRookie: 0, name: "Jason Sanders", team: "MIA", position: "K", byeWeek: 10, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 13, numRookie: 0, name: "Greg Zuerlein", team: "NYJ", position: "K", byeWeek: 7, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 14, numRookie: 0, name: "Jake Moody", team: "SF", position: "K", byeWeek: 9, isTopPlayer: false, isRookie: false),
            PlayerData(num: 0, numPosPick: 15, numRookie: 0, name: "Graham Gano", team: "NYG", position: "K", byeWeek: 13, isTopPlayer: false, isRookie: false),
            
            // Rest of Rookies
            PlayerData(num: 0, numPosPick: 0, numRookie: 17, name: "Marvin Mims", team: "DEN", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 0, numRookie: 21, name: "Tank Dell", team: "HOU", position: "WR", byeWeek: 7, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 0, numRookie: 24, name: "Josh Downs", team: "IND", position: "WR", byeWeek: 11, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 0, numRookie: 25, name: "Rakim Jarrett", team: "TB", position: "WR", byeWeek: 5, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 0, numRookie: 26, name: "Michael Wilson", team: "ARI", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: true),
            PlayerData(num: 0, numPosPick: 0, numRookie: 30, name: "Deuce Vaughn", team: "DAL", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: true),
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
                PlayerData(num: 1, numPosPick: 1, numRookie: 0, name: "Justin Jefferson", team: "MIN", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 2, numPosPick: 2, numRookie: 0, name: "Ja'Marr Chase", team: "CIN", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 3, numPosPick: 1, numRookie: 0, name: "Christian McCaffrey", team: "SF", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 4, numPosPick: 2, numRookie: 0, name: "Austin Ekeler", team: "LAC", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 5, numPosPick: 3, numRookie: 0, name: "Cooper Kupp", team: "LAR", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 6, numPosPick: 4, numRookie: 0, name: "Tyreek Hill", team: "MIA", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 7, numPosPick: 1, numRookie: 0, name: "Travis Kelce", team: "KC", position: "TE", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 8, numPosPick: 5, numRookie: 0, name: "Stefon Diggs", team: "BUF", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 9, numPosPick: 3, numRookie: 0, name: "Saquon Barkley", team: "NYG", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 10, numPosPick: 4, numRookie: 1, name: "Bijan Robinson", team: "ATL", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: true),
                PlayerData(num: 11, numPosPick: 6, numRookie: 0, name: "CeeDee Lamb", team: "DAL", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 12, numPosPick: 5, numRookie: 0, name: "Nick Chubb", team: "CLE", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 13, numPosPick: 7, numRookie: 0, name: "A.J. Brown", team: "PHI", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 14, numPosPick: 8, numRookie: 0, name: "Amon-Ra St. Brown", team: "DET", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 15, numPosPick: 9, numRookie: 0, name: "Davante Adams", team: "LV", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 16, numPosPick: 6, numRookie: 0, name: "Tony Pollard", team: "DAL", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 17, numPosPick: 7, numRookie: 0, name: "Derrick Henry", team: "TEN", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 18, numPosPick: 10, numRookie: 0, name: "Garrett Wilson", team: "NYJ", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 19, numPosPick: 11, numRookie: 0, name: "Jaylen Waddle", team: "MIA", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 20, numPosPick: 8, numRookie: 0, name: "Jonathan Taylor", team: "IND", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 21, numPosPick: 9, numRookie: 0, name: "Josh Jacobs", team: "LV", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 22, numPosPick: 12, numRookie: 0, name: "Chris Olave", team: "NO", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 23, numPosPick: 13, numRookie: 0, name: "DeVonta Smith", team: "PHI", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 24, numPosPick: 1, numRookie: 0, name: "Patrick Mahomes", team: "KC", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 25, numPosPick: 2, numRookie: 0, name: "Jalen Hurts", team: "PHI", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 26, numPosPick: 2, numRookie: 0, name: "Mark Andrews", team: "BAL", position: "TE", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 27, numPosPick: 14, numRookie: 0, name: "Tee Higgins", team: "CIN", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 28, numPosPick: 10, numRookie: 0, name: "Rhamondre Stevenson", team: "NE", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 29, numPosPick: 3, numRookie: 0, name: "Josh Allen", team: "BUF", position: "QB", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 30, numPosPick: 11, numRookie: 0, name: "Najee Harris", team: "PIT", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 31, numPosPick: 15, numRookie: 0, name: "Keenan Allen", team: "LAC", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 32, numPosPick: 16, numRookie: 0, name: "Calvin Ridley", team: "JAC", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 33, numPosPick: 17, numRookie: 0, name: "DK Metcalf", team: "SEA", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 34, numPosPick: 12, numRookie: 0, name: "Travis Etienne Jr.", team: "JAC", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 35, numPosPick: 13, numRookie: 0, name: "Joe Mixon", team: "CIN", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 36, numPosPick: 14, numRookie: 2, name: "Jahmyr Gibbs", team: "DET", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: true),
                PlayerData(num: 37, numPosPick: 15, numRookie: 0, name: "Aaron Jones", team: "GB", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 38, numPosPick: 18, numRookie: 0, name: "Amari Cooper", team: "CLE", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 39, numPosPick: 19, numRookie: 0, name: "Deebo Samuel", team: "SF", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 40, numPosPick: 3, numRookie: 0, name: "T.J. Hockenson", team: "MIN", position: "TE", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 41, numPosPick: 20, numRookie: 0, name: "Jerry Jeudy", team: "DEN", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 42, numPosPick: 21, numRookie: 0, name: "DeAndre Hopkins", team: "TEN", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 43, numPosPick: 22, numRookie: 0, name: "Terry McLaurin", team: "WAS", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 44, numPosPick: 4, numRookie: 0, name: "Lamar Jackson", team: "BAL", position: "QB", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 45, numPosPick: 16, numRookie: 0, name: "Dameon Pierce", team: "HOU", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 46, numPosPick: 17, numRookie: 0, name: "Breece Hall", team: "NYJ", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 47, numPosPick: 23, numRookie: 0, name: "Chris Godwin", team: "TB", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 48, numPosPick: 24, numRookie: 0, name: "Drake London", team: "ATL", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 49, numPosPick: 25, numRookie: 0, name: "Christian Watson", team: "GB", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 50, numPosPick: 26, numRookie: 0, name: "DJ Moore", team: "CHI", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 51, numPosPick: 18, numRookie: 0, name: "Kenneth Walker", team: "SEA", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 52, numPosPick: 19, numRookie: 0, name: "Miles Sanders", team: "CAR", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 53, numPosPick: 5, numRookie: 0, name: "Joe Burrow", team: "CIN", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 54, numPosPick: 20, numRookie: 0, name: "Alexander Mattison", team: "MIN", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 55, numPosPick: 4, numRookie: 0, name: "George Kittle", team: "SF", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 56, numPosPick: 6, numRookie: 0, name: "Justin Fields", team: "CHI", position: "QB", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 57, numPosPick: 27, numRookie: 0, name: "Diontae Johnson", team: "PIT", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 58, numPosPick: 5, numRookie: 0, name: "Darren Waller", team: "NYG", position: "TE", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 59, numPosPick: 28, numRookie: 0, name: "Tyler Lockett", team: "SEA", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 60, numPosPick: 21, numRookie: 0, name: "James Conner", team: "ARI", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 61, numPosPick: 22, numRookie: 0, name: "Rachaad White", team: "TB", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 62, numPosPick: 23, numRookie: 0, name: "J.K. Dobbins", team: "BAL", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 63, numPosPick: 29, numRookie: 0, name: "Brandon Aiyuk", team: "SF", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 64, numPosPick: 30, numRookie: 0, name: "Mike Williams", team: "LAC", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 65, numPosPick: 24, numRookie: 0, name: "Cam Akers", team: "LAR", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 66, numPosPick: 31, numRookie: 0, name: "Mike Evans", team: "TB", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 67, numPosPick: 32, numRookie: 0, name: "Christian Kirk", team: "JAC", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 68, numPosPick: 7, numRookie: 0, name: "Justin Herbert", team: "LAC", position: "QB", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 69, numPosPick: 25, numRookie: 0, name: "Alvin Kamara", team: "NO", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 70, numPosPick: 6, numRookie: 0, name: "Dallas Goedert", team: "PHI", position: "TE", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 71, numPosPick: 7, numRookie: 0, name: "Kyle Pitts", team: "ATL", position: "TE", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 72, numPosPick: 33, numRookie: 0, name: "Marquise Brown", team: "ARI", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 73, numPosPick: 26, numRookie: 0, name: "James Cook", team: "BUF", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 74, numPosPick: 34, numRookie: 0, name: "Michael Pittman Jr.", team: "IND", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 75, numPosPick: 27, numRookie: 0, name: "Javonte Williams", team: "DEN", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 76, numPosPick: 8, numRookie: 0, name: "Trevor Lawrence", team: "JAC", position: "QB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 77, numPosPick: 35, numRookie: 0, name: "Jahan Dotson", team: "WAS", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 78, numPosPick: 36, numRookie: 0, name: "George Pickens", team: "PIT", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 79, numPosPick: 28, numRookie: 0, name: "David Montgomery", team: "DET", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 80, numPosPick: 29, numRookie: 0, name: "Isiah Pacheco", team: "KC", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 81, numPosPick: 37, numRookie: 3, name: "Jordan Addison", team: "MIN", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: true),
                PlayerData(num: 82, numPosPick: 38, numRookie: 4, name: "Jaxon Smith-Njigba", team: "SEA", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: true),
                PlayerData(num: 83, numPosPick: 39, numRookie: 0, name: "Treylon Burks", team: "TEN", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 84, numPosPick: 30, numRookie: 0, name: "D'Andre Swift", team: "PHI", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 85, numPosPick: 8, numRookie: 0, name: "Evan Engram", team: "JAC", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 86, numPosPick: 40, numRookie: 0, name: "Brandin Cooks", team: "DAL", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 87, numPosPick: 31, numRookie: 0, name: "AJ Dillon", team: "GB", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 88, numPosPick: 9, numRookie: 0, name: "Pat Freiermuth", team: "PIT", position: "TE", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 89, numPosPick: 32, numRookie: 0, name: "Dalvin Cook", team: "NYJ", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 90, numPosPick: 41, numRookie: 0, name: "Michael Thomas", team: "NO", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 91, numPosPick: 42, numRookie: 0, name: "JuJu Smith-Schuster", team: "NE", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 92, numPosPick: 43, numRookie: 0, name: "Gabriel Davis", team: "BUF", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 93, numPosPick: 10, numRookie: 0, name: "David Njoku", team: "CLE", position: "TE", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 94, numPosPick: 33, numRookie: 0, name: "Antonio Gibson", team: "WAS", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 95, numPosPick: 44, numRookie: 0, name: "Courtland Sutton", team: "DEN", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 96, numPosPick: 9, numRookie: 0, name: "Deshaun Watson", team: "CLE", position: "QB", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 97, numPosPick: 45, numRookie: 0, name: "Elijah Moore", team: "CLE", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 98, numPosPick: 46, numRookie: 5, name: "Zay Flowers", team: "BAL", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: true),
                PlayerData(num: 99, numPosPick: 47, numRookie: 6, name: "Quentin Johnston", team: "LAC", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: true),
                PlayerData(num: 100, numPosPick: 10, numRookie: 0, name: "Dak Prescott", team: "DAL", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 101, numPosPick: 34, numRookie: 0, name: "Brian Robinson Jr.", team: "WAS", position: "RB", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 102, numPosPick: 35, numRookie: 0, name: "Rashaad Penny", team: "PHI", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 103, numPosPick: 36, numRookie: 0, name: "Samaje Perine", team: "DEN", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 104, numPosPick: 11, numRookie: 0, name: "Daniel Jones", team: "NYG", position: "QB", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 105, numPosPick: 48, numRookie: 0, name: "Jakobi Meyers", team: "LV", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 106, numPosPick: 12, numRookie: 0, name: "Tua Tagovailoa", team: "MIA", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 107, numPosPick: 11, numRookie: 0, name: "Dalton Schultz", team: "HOU", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 108, numPosPick: 13, numRookie: 0, name: "Kirk Cousins", team: "MIN", position: "QB", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 109, numPosPick: 37, numRookie: 0, name: "Khalil Herbert", team: "CHI", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 110, numPosPick: 49, numRookie: 0, name: "Skyy Moore", team: "KC", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 111, numPosPick: 50, numRookie: 0, name: "Kadarius Toney", team: "KC", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 112, numPosPick: 51, numRookie: 0, name: "Rondale Moore", team: "ARI", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 113, numPosPick: 14, numRookie: 0, name: "Geno Smith", team: "SEA", position: "QB", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 114, numPosPick: 38, numRookie: 7, name: "Zach Charbonnet", team: "SEA", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: true),
                PlayerData(num: 115, numPosPick: 39, numRookie: 0, name: "Jamaal Williams", team: "NO", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 116, numPosPick: 52, numRookie: 0, name: "Odell Beckham Jr.", team: "BAL", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 117, numPosPick: 15, numRookie: 0, name: "Anthony Richardson", team: "IND", position: "QB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 118, numPosPick: 16, numRookie: 0, name: "Aaron Rodgers", team: "NYJ", position: "QB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 119, numPosPick: 12, numRookie: 0, name: "Tyler Higbee", team: "LAR", position: "TE", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 120, numPosPick: 13, numRookie: 0, name: "Greg Dulcich", team: "DEN", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 121, numPosPick: 40, numRookie: 0, name: "Jerick McKinnon", team: "KC", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 122, numPosPick: 14, numRookie: 0, name: "Cole Kmet", team: "CHI", position: "TE", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 123, numPosPick: 53, numRookie: 0, name: "Allen Lazard", team: "NYJ", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 124, numPosPick: 54, numRookie: 0, name: "Adam Thielen", team: "CAR", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 125, numPosPick: 55, numRookie: 0, name: "Nico Collins", team: "HOU", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 126, numPosPick: 56, numRookie: 0, name: "Darnell Mooney", team: "CHI", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 127, numPosPick: 15, numRookie: 0, name: "Chigoziem Okonkwo", team: "TEN", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 128, numPosPick: 41, numRookie: 8, name: "Devon Achane", team: "MIA", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: true),
                PlayerData(num: 129, numPosPick: 57, numRookie: 0, name: "Rashod Bateman", team: "BAL", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 130, numPosPick: 17, numRookie: 0, name: "Russell Wilson", team: "DEN", position: "QB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 131, numPosPick: 58, numRookie: 0, name: "Tyler Boyd", team: "CIN", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 132, numPosPick: 59, numRookie: 0, name: "Romeo Doubs", team: "GB", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 133, numPosPick: 42, numRookie: 0, name: "Damien Harris", team: "BUF", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 134, numPosPick: 1, numRookie: 0, name: "Justin Tucker", team: "BAL", position: "K", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 135, numPosPick: 43, numRookie: 0, name: "Elijah Mitchell", team: "SF", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 136, numPosPick: 16, numRookie: 9, name: "Dalton Kincaid", team: "BUF", position: "TE", byeWeek: 13, isTopPlayer: true, isRookie: true),
                PlayerData(num: 137, numPosPick: 1, numRookie: 0, name: "San Francisco 49ers", team: "SF", position: "DST", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 138, numPosPick: 60, numRookie: 0, name: "Jameson Williams", team: "DET", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 139, numPosPick: 61, numRookie: 0, name: "Zay Jones", team: "JAC", position: "WR", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 140, numPosPick: 44, numRookie: 0, name: "Raheem Mostert", team: "MIA", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 141, numPosPick: 45, numRookie: 0, name: "Devin Singletary", team: "HOU", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 142, numPosPick: 62, numRookie: 0, name: "DJ Chark Jr.", team: "CAR", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 143, numPosPick: 17, numRookie: 0, name: "Gerald Everett", team: "LAC", position: "TE", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 144, numPosPick: 63, numRookie: 0, name: "Michael Gallup", team: "DAL", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 145, numPosPick: 64, numRookie: 0, name: "K.J. Osborn", team: "MIN", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 146, numPosPick: 46, numRookie: 0, name: "Jaylen Warren", team: "PIT", position: "RB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 147, numPosPick: 2, numRookie: 0, name: "Dallas Cowboys", team: "DAL", position: "DST", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 148, numPosPick: 2, numRookie: 0, name: "Tyler Bass", team: "BUF", position: "K", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 149, numPosPick: 18, numRookie: 0, name: "Jared Goff", team: "DET", position: "QB", byeWeek: 9, isTopPlayer: true, isRookie: false),
                PlayerData(num: 150, numPosPick: 47, numRookie: 0, name: "Jeff Wilson", team: "MIA", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 151, numPosPick: 3, numRookie: 0, name: "Buffalo Bills", team: "BUF", position: "DST", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 152, numPosPick: 48, numRookie: 0, name: "Tyler Allgeier", team: "ATL", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 153, numPosPick: 49, numRookie: 0, name: "D'Onta Foreman", team: "CHI", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 154, numPosPick: 3, numRookie: 0, name: "Daniel Carlson", team: "LV", position: "K", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 155, numPosPick: 50, numRookie: 0, name: "Kenneth Gainwell", team: "PHI", position: "RB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 156, numPosPick: 18, numRookie: 10, name: "Sam LaPorta", team: "DET", position: "TE", byeWeek: 9, isTopPlayer: true, isRookie: true),
                PlayerData(num: 157, numPosPick: 4, numRookie: 0, name: "Harrison Butker", team: "KC", position: "K", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 158, numPosPick: 65, numRookie: 11, name: "Jonathan Mingo", team: "CAR", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: true),
                PlayerData(num: 159, numPosPick: 4, numRookie: 0, name: "New England Patriots", team: "NE", position: "DST", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 160, numPosPick: 19, numRookie: 0, name: "Matthew Stafford", team: "LAR", position: "QB", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 161, numPosPick: 66, numRookie: 0, name: "Curtis Samuel", team: "WAS", position: "WR", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 162, numPosPick: 51, numRookie: 12, name: "Tank Bigsby", team: "JAC", position: "RB", byeWeek: 9, isTopPlayer: true, isRookie: true),
                PlayerData(num: 163, numPosPick: 5, numRookie: 0, name: "Evan McPherson", team: "CIN", position: "K", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 164, numPosPick: 20, numRookie: 0, name: "Kyler Murray", team: "ARI", position: "QB", byeWeek: 14, isTopPlayer: true, isRookie: false),
                PlayerData(num: 165, numPosPick: 67, numRookie: 0, name: "Isaiah Hodgins", team: "NYG", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 166, numPosPick: 68, numRookie: 0, name: "Donovan Peoples-Jones", team: "CLE", position: "WR", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 167, numPosPick: 69, numRookie: 0, name: "Marquez Valdes-Scantling", team: "KC", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 168, numPosPick: 70, numRookie: 0, name: "Parris Campbell", team: "NYG", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 169, numPosPick: 21, numRookie: 0, name: "Kenny Pickett", team: "PIT", position: "QB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 170, numPosPick: 72, numRookie: 0, name: "Alec Pierce", team: "IND", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 171, numPosPick: 73, numRookie: 0, name: "Van Jefferson", team: "LAR", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 172, numPosPick: 74, numRookie: 13, name: "Jayden Reed", team: "GB", position: "WR", byeWeek: 6, isTopPlayer: true, isRookie: true),
                PlayerData(num: 173, numPosPick: 19, numRookie: 0, name: "Irv Smith Jr.", team: "CIN", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 174, numPosPick: 52, numRookie: 0, name: "Kareem Hunt", team: "FA", position: "RB", byeWeek: 0, isTopPlayer: true, isRookie: false),
                PlayerData(num: 175, numPosPick: 75, numRookie: 0, name: "Hunter Renfrow", team: "LV", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 176, numPosPick: 53, numRookie: 14, name: "Roschon Johnson", team: "CHI", position: "RB", byeWeek: 13, isTopPlayer: true, isRookie: true),
                PlayerData(num: 177, numPosPick: 76,numRookie: 15, name: "Rashee Rice", team: "KC", position: "WR", byeWeek: 10, isTopPlayer: true, isRookie: true),
                PlayerData(num: 178, numPosPick: 6, numRookie: 0, name: "Younghoe Koo", team: "ATL", position: "K", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 179, numPosPick: 22, numRookie: 0, name: "Derek Carr", team: "NO", position: "QB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 180, numPosPick: 54, numRookie: 0, name: "Chuba Hubbard", team: "CAR", position: "RB", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 181, numPosPick: 5, numRookie: 0, name: "New York Jets", team: "NYJ", position: "DST", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 182, numPosPick: 55, numRookie: 0, name: "Ezekiel Elliott", team: "NE", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 183, numPosPick: 6, numRookie: 0, name: "New Orleans Saints", team: "NO", position: "DST", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 184, numPosPick: 20, numRookie: 0, name: "Dawson Knox", team: "BUF", position: "TE", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 185, numPosPick: 77, numRookie: 0, name: "Robert Woods", team: "HOU", position: "WR", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 186, numPosPick: 7, numRookie: 0, name: "Nick Folk", team: "NE", position: "K", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 187, numPosPick: 21, numRookie: 0, name: "Mike Gesicki", team: "NE", position: "TE", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 188, numPosPick: 8, numRookie: 0, name: "Jason Myers", team: "SEA", position: "K", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 189, numPosPick: 78, numRookie: 0, name: "Rashid Shaheed", team: "NO", position: "WR", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 190, numPosPick: 22, numRookie: 0, name: "Juwan Johnson", team: "NO", position: "TE", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 191, numPosPick: 79, numRookie: 0, name: "Chase Claypool", team: "PIT", position: "WR", byeWeek: 13, isTopPlayer: true, isRookie: false),
                PlayerData(num: 192, numPosPick: 23, numRookie: 0, name: "Hayden Hurst", team: "CAR", position: "TE", byeWeek: 7, isTopPlayer: true, isRookie: false),
                PlayerData(num: 193, numPosPick: 56, numRookie: 0, name: "Leonard Fournette", team: "FA", position: "RB", byeWeek: 0, isTopPlayer: true, isRookie: false),
                PlayerData(num: 194, numPosPick: 7, numRookie: 0, name: "Miami Dolphins", team: "MIA", position: "DST", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 195, numPosPick: 9, numRookie: 0, name: "Matt Gay", team: "IND", position: "K", byeWeek: 11, isTopPlayer: true, isRookie: false),
                PlayerData(num: 196, numPosPick: 57, numRookie: 0, name: "Jerome Ford", team: "CLE", position: "RB", byeWeek: 5, isTopPlayer: true, isRookie: false),
                PlayerData(num: 197, numPosPick: 10, numRookie: 0, name: "Jake Elliott", team: "PHI", position: "K", byeWeek: 10, isTopPlayer: true, isRookie: false),
                PlayerData(num: 198, numPosPick: 8, numRookie: 0, name: "Pittsburgh Steelers", team: "PIT", position: "DST", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 199, numPosPick: 23, numRookie: 0, name: "Jordan Love", team: "GB", position: "QB", byeWeek: 6, isTopPlayer: true, isRookie: false),
                PlayerData(num: 200, numPosPick: 58, numRookie: 16, name: "Kendre Miller", team: "NO", position: "RB", byeWeek: 11, isTopPlayer: true, isRookie: true),
                
                // Not top 200 but still top in position.
                // Rest of Quarterbacks.
                PlayerData(num: 0, numPosPick: 24, numRookie: 18, name: "Bryce Young", team: "CAR", position: "QB", byeWeek: 7, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 25, numRookie: 0, name: "Brock Purdy", team: "SF", position: "QB", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 26, numRookie: 0, name: "Ryan Tannehill", team: "TEN", position: "QB", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 27, numRookie: 0, name: "Sam Howell", team: "WAS", position: "QB", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 28, numRookie: 23, name: "C.J. Stroud", team: "HOU", position: "QB", byeWeek: 7, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 29, numRookie: 0, name: "Jimmy Garoppolo", team: "LV", position: "QB", byeWeek: 13, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 30, numRookie: 0, name: "Mac Jones", team: "NE", position: "QB", byeWeek: 11, isTopPlayer: false, isRookie: false),
                
                // Rest of Running Backs.
                PlayerData(num: 0, numPosPick: 59, numRookie: 0, name: "Gus Edwards", team: "BAL", position: "RB", byeWeek: 13, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 60, numRookie: 0, name: "Cordarrelle Patterson", team: "ATL", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 61, numRookie: 0, name: "Michael Carter", team: "NYJ", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 62, numRookie: 0, name: "Clyde Edwards-Helaire", team: "KC", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 63, numRookie: 0, name: "Zamir White", team: "LV", position: "RB", byeWeek: 13, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 64, numRookie: 19, name: "Israel Abanikanda", team: "NYJ", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 65, numRookie: 20, name: "Tyjae Spears", team: "TEN", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 66, numRookie: 0, name: "Chase Edmonds", team: "TB", position: "RB", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 67, numRookie: 0, name: "Kyren Williams", team: "LAR", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 68, numRookie: 22, name: "Chase Brown", team: "CIN", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 69, numRookie: 0, name: "Joshua Kelley", team: "LAC", position: "RB", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 70, numRookie: 0, name: "Deon Jackson", team: "IND", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 71, numRookie: 0, name: "Keaontay Ingram", team: "ARI", position: "RB", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 72, numRookie: 0, name: "Ty Chandler", team: "MIN", position: "RB", byeWeek: 13, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 73, numRookie: 0, name: "Malik Davis", team: "DAL", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 74, numRookie: 27, name: "Evan Hull", team: "IND", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 75, numRookie: 28, name: "Eric Gray", team: "NYG", position: "RB", byeWeek: 13, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 76, numRookie: 0, name: "Trayveon Williams", team: "CIN", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 77, numRookie: 29, name: "Zach Evans", team: "LAR", position: "RB", byeWeek: 10, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 78, numRookie: 0, name: "Pierre Strong", team: "NE", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 79, numRookie: 0, name: "Zonovan Knight", team: "NYJ", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 80, numRookie: 0, name: "Ty Montgomery", team: "NE", position: "RB", byeWeek: 11, isTopPlayer: false, isRookie: false),
                
                // Rest of Wide Receivers.
                PlayerData(num: 0, numPosPick: 80, numRookie: 0, name: "DeVante Parker", team: "NE", position: "WR", byeWeek: 11, isTopPlayer: false, isRookie: false),
                
                // Rest of Tight Ends.
                PlayerData(num: 0, numPosPick: 24, numRookie: 0, name: "Hunter Henry", team: "NE", position: "TE", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 25, numRookie: 0, name: "Zach Ertz", team: "ARI", position: "TE", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 26, numRookie: 0, name: "Jelani Woods", team: "IND", position: "TE", byeWeek: 11, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 27, numRookie: 0, name: "Tyler Conklin", team: "NYJ", position: "TE", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 28, numRookie: 0, name: "Trey McBride", team: "ARI", position: "TE", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 29, numRookie: 0, name: "Cade Otton", team: "TB", position: "TE", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 30, numRookie: 0, name: "Jake Ferguson", team: "DAL", position: "TE", byeWeek: 7, isTopPlayer: false, isRookie: false),
                
                // Rest of Defenses
                PlayerData(num: 0, numPosPick: 9, numRookie: 0, name: "Baltimore Ravens", team: "BAL", position: "DST", byeWeek: 13, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 10, numRookie: 0, name: "Philadelphia Eagles", team: "PHI", position: "DST", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 11, numRookie: 0, name: "Cleveland Browns", team: "CLE", position: "DST", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 12, numRookie: 0, name: "Green Bay Packers", team: "GB", position: "DST", byeWeek: 6, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 13, numRookie: 0, name: "Tampa Bay Buccaneers", team: "TB", position: "DST", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 14, numRookie: 0, name: "Denver Broncos", team: "DEN", position: "DST", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 15, numRookie: 0, name: "Cincinnati Bengals", team: "CIN", position: "DST", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 16, numRookie: 0, name: "Carolina Panthers", team: "CAR", position: "DST", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 17, numRookie: 0, name: "Washington Commanders", team: "WAS", position: "DST", byeWeek: 14, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 18, numRookie: 0, name: "Kansas City Chiefs", team: "KC", position: "DST", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 19, numRookie: 0, name: "Seattle Seahawks", team: "SEA", position: "DST", byeWeek: 5, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 20, numRookie: 0, name: "Jacksonville Jaguars", team: "JAC", position: "DST", byeWeek: 9, isTopPlayer: false, isRookie: false),
                
                // Rest of Kickers
                PlayerData(num: 0, numPosPick: 11, numRookie: 0, name: "Brandon McManus", team: "JAC", position: "K", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 12, numRookie: 0, name: "Jason Sanders", team: "MIA", position: "K", byeWeek: 10, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 13, numRookie: 0, name: "Greg Zuerlein", team: "NYJ", position: "K", byeWeek: 7, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 14, numRookie: 0, name: "Jake Moody", team: "SF", position: "K", byeWeek: 9, isTopPlayer: false, isRookie: false),
                PlayerData(num: 0, numPosPick: 15, numRookie: 0, name: "Graham Gano", team: "NYG", position: "K", byeWeek: 13, isTopPlayer: false, isRookie: false),
                
                // Rest of Rookies
                PlayerData(num: 0, numPosPick: 0, numRookie: 17, name: "Marvin Mims", team: "DEN", position: "WR", byeWeek: 9, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 0, numRookie: 21, name: "Tank Dell", team: "HOU", position: "WR", byeWeek: 7, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 0, numRookie: 24, name: "Josh Downs", team: "IND", position: "WR", byeWeek: 11, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 0, numRookie: 25, name: "Rakim Jarrett", team: "TB", position: "WR", byeWeek: 5, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 0, numRookie: 26, name: "Michael Wilson", team: "ARI", position: "WR", byeWeek: 14, isTopPlayer: false, isRookie: true),
                PlayerData(num: 0, numPosPick: 0, numRookie: 30, name: "Deuce Vaughn", team: "DAL", position: "RB", byeWeek: 7, isTopPlayer: false, isRookie: true),
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
            data = billsArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0.01938016217, green: 0.2123703163, blue: 0.5529411765, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.04705882353, blue: 0.1882352941, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.04705882353, blue: 0.1882352941, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.04705882353, blue: 0.1882352941, alpha: 1)
            label.textColor = .white
            label.text = "Buffalo Bills"
        }
        if sec == 0 && row == 1 {
            data = dolphinsArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0.3411764706, blue: 0.4705882353, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.2980392157, blue: 0.007843137255, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.2980392157, blue: 0.007843137255, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.2980392157, blue: 0.007843137255, alpha: 1)
            label.textColor = .black
            label.text = "Miami Dolphins"
        }
        if sec == 0 && row == 2 {
            data = jetsArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.3411764706, blue: 0.2509803922, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            label.textColor = .black
            label.text = "New York Jets"
        }
        if sec == 0 && row == 3 {
            data = patriotsArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.04705882353, blue: 0.1882352941, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            label.textColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
            label.text = "New England Patriots"
        }
        
        if sec == 1 && row == 0 {
            data = bengalsArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.textColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            label.text = "Cincinatti Bengals"
        }
        if sec == 1 && row == 1 {
            data = brownsArray_2023()
            view1.backgroundColor = #colorLiteral(red: 1, green: 0.2352941176, blue: 0, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.1137254902, blue: 0, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.1137254902, blue: 0, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.1137254902, blue: 0, alpha: 1)
            label.textColor = .white
            label.text = "Cleveland Browns"
        }
        if sec == 1 && row == 2 {
            data = ravensArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.09803921569, blue: 0.3725490196, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.09803921569, blue: 0.3725490196, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.09803921569, blue: 0.3725490196, alpha: 1)
            label.textColor = #colorLiteral(red: 0.6196078431, green: 0.4862745098, blue: 0.04705882353, alpha: 1)
            label.text = "Baltimore Ravens"
        }
        if sec == 1 && row == 3 {
            data = steelersArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.textColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.text = "Pittsburgh Steelers"
        }
        
        if sec == 2 && row == 0 {
            data = coltsArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0.1725490196, blue: 0.3725490196, alpha: 1)
            view2.backgroundColor = .white
            label.backgroundColor = .white
            table.backgroundColor = .white
            label.textColor = #colorLiteral(red: 0, green: 0.1725490196, blue: 0.3725490196, alpha: 1)
            label.text = "Indianapolis Colts"
        }
        if sec == 2 && row == 1 {
            data = jaguarsArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0.6235294118, green: 0.4745098039, blue: 0.1725490196, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            label.textColor = .white
            label.text = "Jacksonville Jaguars"
        }
        if sec == 2 && row == 2 {
            data = texansArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.1254901961, blue: 0.1843137255, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            label.textColor = .white
            label.text = "Houston Texans"
        }
        if sec == 2 && row == 3 {
            data = titansArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0.5411764706, green: 0.5529411765, blue: 0.5607843137, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.06274509804, blue: 0.1803921569, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.06274509804, blue: 0.1803921569, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.06274509804, blue: 0.1803921569, alpha: 1)
            label.textColor = #colorLiteral(red: 0.04705882353, green: 0.137254902, blue: 0.2509803922, alpha: 1)
            label.text = "Tennessee Titans"
        }
        
        if sec == 3 && row == 0 {
            data = broncosArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            label.textColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            label.text = "Denver Broncos"
        }
        if sec == 3 && row == 1 {
            data = chargersArray_2023()
            view1.backgroundColor = #colorLiteral(red: 1, green: 0.7607843137, blue: 0.05490196078, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0.7764705882, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0.7764705882, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0.7764705882, alpha: 1)
            label.textColor = #colorLiteral(red: 1, green: 0.7607843137, blue: 0.05490196078, alpha: 1)
            label.text = "Los Angeles Chargers"
        }
        if sec == 3 && row == 2 {
            data = chiefsArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.09411764706, blue: 0.2156862745, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            label.textColor = .black
            label.text = "Kansas City Chiefs"
        }
        if sec == 3 && row == 3 {
            data = raidersArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            view2.backgroundColor = .black
            label.backgroundColor = .black
            table.backgroundColor = .black
            label.textColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            label.text = "Las Vegas Raiders"
        }
        
        if sec == 4 && row == 0 {
            data = cowboysArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0.4980392157, green: 0.5882352941, blue: 0.5843137255, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0.2078431373, blue: 0.5803921569, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0.2078431373, blue: 0.5803921569, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0.2078431373, blue: 0.5803921569, alpha: 1)
            label.textColor = .white
            label.text = "Dallas Cowboys"
        }
        if sec == 4 && row == 1 {
            data = eaglesArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0.3725490196, green: 0.3764705882, blue: 0.3843137255, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.textColor = #colorLiteral(red: 0.7294117647, green: 0.7921568627, blue: 0.8274509804, alpha: 1)
            label.text = "Philadelphia Eagles"
        }
        if sec == 4 && row == 2 {
            data = giantsArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.137254902, blue: 0.3215686275, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6392156863, green: 0.05098039216, blue: 0.1764705882, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6392156863, green: 0.05098039216, blue: 0.1764705882, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6392156863, green: 0.05098039216, blue: 0.1764705882, alpha: 1)
            label.textColor = #colorLiteral(red: 0.003921568627, green: 0.137254902, blue: 0.3215686275, alpha: 1)
            label.text = "New York Giants"
        }
        if sec == 4 && row == 3 {
            data = commandersArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0.2470588235, green: 0.06274509804, blue: 0.06274509804, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.textColor = #colorLiteral(red: 0.2470588235, green: 0.06274509804, blue: 0.06274509804, alpha: 1)
            label.text = "Washington Commanders"
        }
        
        if sec == 5 && row == 0 {
            data = bearsArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0.0431372549, green: 0.0862745098, blue: 0.1647058824, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.2196078431, blue: 0.01176470588, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.2196078431, blue: 0.01176470588, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.2196078431, blue: 0.01176470588, alpha: 1)
            label.textColor = #colorLiteral(red: 0.0431372549, green: 0.0862745098, blue: 0.1647058824, alpha: 1)
            label.text = "Chicago Bears"
        }
        if sec == 5 && row == 1 {
            data = lionsArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
            label.textColor = .white
            label.text = "Detroit Lions"
        }
        if sec == 5 && row == 2 {
            data = packersArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.1882352941, blue: 0.1568627451, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            label.textColor = #colorLiteral(red: 0.09411764706, green: 0.1882352941, blue: 0.1568627451, alpha: 1)
            label.text = "Green Bay Packers"
        }
        if sec == 5 && row == 3 {
            data = vikingsArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0.3098039216, green: 0.1490196078, blue: 0.5137254902, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7764705882, blue: 0.1843137255, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7764705882, blue: 0.1843137255, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7764705882, blue: 0.1843137255, alpha: 1)
            label.textColor = #colorLiteral(red: 0.3098039216, green: 0.1490196078, blue: 0.5137254902, alpha: 1)
            label.text = "Minnesota Vikings"
        }
        
        if sec == 6 && row == 0 {
            data = buccaneersArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.1882352941, blue: 0.168627451, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.03921568627, blue: 0.03137254902, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.03921568627, blue: 0.03137254902, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.03921568627, blue: 0.03137254902, alpha: 1)
            label.textColor = #colorLiteral(red: 0.6941176471, green: 0.7294117647, blue: 0.7490196078, alpha: 1)
            label.text = "Tampa Bay Buccaneers"
        }
        if sec == 6 && row == 1 {
            data = falconsArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.text = "Atlanta Falcons"
        }
        if sec == 6 && row == 2 {
            data = panthersArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.7529411765, blue: 0.7490196078, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0.5215686275, blue: 0.7921568627, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0.5215686275, blue: 0.7921568627, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0.5215686275, blue: 0.7921568627, alpha: 1)
            label.textColor = #colorLiteral(red: 0.7490196078, green: 0.7529411765, blue: 0.7490196078, alpha: 1)
            label.text = "Carolina Panthers"
        }
        if sec == 6 && row == 3 {
            data = saintsArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0.8274509804, green: 0.737254902, blue: 0.5529411765, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1215686275, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1215686275, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1215686275, alpha: 1)
            label.textColor = #colorLiteral(red: 0.8274509804, green: 0.737254902, blue: 0.5529411765, alpha: 1)
            label.text = "New Orleans Saints"
        }
        
        if sec == 7 && row == 0 {
            data = _49ersArray_2023()
            view1.backgroundColor = .black
            view2.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.6, blue: 0.3647058824, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.6, blue: 0.3647058824, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.6, blue: 0.3647058824, alpha: 1)
            label.textColor = .white
            label.text = "San Francisco 49ers"
        }
        if sec == 7 && row == 1 {
            data = cardinalsArray_2023()
            view1.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.textColor = .white
            label.text = "Arizona Cardinals"
        }
        if sec == 7 && row == 2 {
            data = ramsArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.5254901961, green: 0.4274509804, blue: 0.2941176471, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.5254901961, green: 0.4274509804, blue: 0.2941176471, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.5254901961, green: 0.4274509804, blue: 0.2941176471, alpha: 1)
            label.textColor = .white
            label.text = "Los Angeles Rams"
        }
        if sec == 7 && row == 3 {
            data = seahawksArray_2023()
            view1.backgroundColor = #colorLiteral(red: 0.4117647059, green: 0.7450980392, blue: 0.1568627451, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            label.textColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            label.text = "Seattle Seahawks"
        }
    }
    
    // AFC East
    func billsArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Josh Allen")
        let qb2 = Cell(pos: "QB2", play: "Kyle Allen")
        let qb3 = Cell(pos: "QB3", play: "Matt Barkley")
        let rb1 = Cell(pos: "RB1", play: "James Cook")
        let rb2 = Cell(pos: "RB2", play: "Damien Harris")
        let rb3 = Cell(pos: "RB3", play: "Latavius Murray")
        let wr1 = Cell(pos: "WR1", play: "Stefon Diggs")
        let wr2 = Cell(pos: "WR2", play: "Gabriel Davis")
        let wr3 = Cell(pos: "WR3", play: "Deonte Harty")
        let wr4 = Cell(pos: "WR4", play: "Khalil Shakir")
        let wr5 = Cell(pos: "WR5", play: "Trent Sherfield")
        let wr6 = Cell(pos: "WR6", play: "Justin Shorter", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Dawson Knox")
        let te2 = Cell(pos: "TE2", play: "Dalton Kincaid", rookie: "R")
        let te3 = Cell(pos: "TE3", play: "Quintin Morris")
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
    
    func dolphinsArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Tua Tagovailoa")
        let qb2 = Cell(pos: "QB2", play: "Mike White")
        let qb3 = Cell(pos: "QB3", play: "Skylar Thompson", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Raheem Mostert")
        let rb2 = Cell(pos: "RB2", play: "Jeff Wilson Jr.")
        let rb3 = Cell(pos: "RB3", play: "Devon Achane", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Tyreek Hill")
        let wr2 = Cell(pos: "WR2", play: "Jaylen Waddle")
        let wr3 = Cell(pos: "WR3", play: "Braxton Berrios")
        let wr4 = Cell(pos: "WR4", play: "Cedrick Wilson Jr.")
        let wr5 = Cell(pos: "WR5", play: "Robbie Chosen")
        let wr6 = Cell(pos: "WR6", play: "River Cracraft")
        let te1 = Cell(pos: "TE1", play: "Durham Smythe")
        let te2 = Cell(pos: "TE2", play: "Eric Saubert")
        let te3 = Cell(pos: "TE3", play: "Tyler Kroft")
        let te4 = Cell(pos: "TE4", play: "Elijah Higgins", rookie: "R")
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
        positionPlayer.append(te4)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func jetsArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Aaron Rodgers")
        let qb2 = Cell(pos: "QB2", play: "Zach Wilson")
        let qb3 = Cell(pos: "QB3", play: "Tim Boyle")
        let rb1 = Cell(pos: "RB1", play: "Breece Hall")
        let rb2 = Cell(pos: "RB2", play: "Dalvin Cook")
        let rb3 = Cell(pos: "RB3", play: "Michael Carter")
        let rb4 = Cell(pos: "RB4", play: "Zonovan Knight")
        let wr1 = Cell(pos: "WR1", play: "Garrett Wilson")
        let wr2 = Cell(pos: "WR2", play: "Allen Lazard")
        let wr3 = Cell(pos: "WR3", play: "Corey Davis")
        let wr4 = Cell(pos: "WR4", play: "Mecole Hardman Jr.")
        let wr5 = Cell(pos: "WR5", play: "Randall Cobb")
        let wr6 = Cell(pos: "WR6", play: "Jason Brownlee", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Tyler Conklin")
        let te2 = Cell(pos: "TE2", play: "C.J. Uzomah")
        let te3 = Cell(pos: "TE3", play: "Jeremy Ruckert")
        let k = Cell(pos: "K", play: "Greg Zuerlein")
        
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
    
    func patriotsArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Mac Jones")
        let qb2 = Cell(pos: "QB2", play: "Bailey Zappe")
        let qb3 = Cell(pos: "QB3", play: "Trace McSorley")
        let rb1 = Cell(pos: "RB1", play: "Rhamondre Stevenson")
        let rb2 = Cell(pos: "RB2", play: "Ezekiel Elliott")
        let rb3 = Cell(pos: "RB3", play: "Ty Montgomery")
        let rb4 = Cell(pos: "RB4", play: "Pierre Strong Jr.")
        let wr1 = Cell(pos: "WR1", play: "JuJu Smith-Schuster")
        let wr2 = Cell(pos: "WR2", play: "DeVante Parker")
        let wr3 = Cell(pos: "WR3", play: "Kendrick Bourne")
        let wr4 = Cell(pos: "WR4", play: "Tyquan Thornton")
        let wr5 = Cell(pos: "WR5", play: "Kayshon Boutte", rookie: "R")
        let wr6 = Cell(pos: "WR6", play: "Demario Douglas", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Hunter Henry")
        let te2 = Cell(pos: "TE2", play: "Mike Gesicki")
        let te3 = Cell(pos: "TE3", play: "Anthony Firkser")
        let k = Cell(pos: "K", play: "Chad Ryland", rookie: "R")
        
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
    
    // AFC North
    func bengalsArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Joe Burrow")
        let qb2 = Cell(pos: "QB2", play: "Trevor Siemian")
        let qb3 = Cell(pos: "QB3", play: "Jake Browning")
        let rb1 = Cell(pos: "RB1", play: "Joe Mixon")
        let rb2 = Cell(pos: "RB2", play: "Trayveon Williams")
        let rb3 = Cell(pos: "RB3", play: "Chase Brown")
        let rb4 = Cell(pos: "RB4", play: "Chris Evans")
        let wr1 = Cell(pos: "WR1", play: "Ja'Marr Chase")
        let wr2 = Cell(pos: "WR2", play: "Tee Higgins")
        let wr3 = Cell(pos: "WR3", play: "Tyler Boyd")
        let wr4 = Cell(pos: "WR4", play: "Trenton Irwin")
        let wr5 = Cell(pos: "WR5", play: "Charlie Jones", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Irv Smith Jr.")
        let te2 = Cell(pos: "TE2", play: "Drew Sample")
        let te3 = Cell(pos: "TE3", play: "Mitchell Wilcox")
        let k = Cell(pos: "K", play: "Evan McPherson")
        
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func brownsArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Deshaun Watson")
        let qb2 = Cell(pos: "QB2", play: "Joshua Dobbs")
        let qb3 = Cell(pos: "QB3", play: "Dorian Thompson-Robinson", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Nick Chub")
        let rb2 = Cell(pos: "RB2", play: "Jerome Ford")
        let rb3 = Cell(pos: "RB3", play: "Demetric Felton Jr.")
        let rb4 = Cell(pos: "RB4", play: "John Kelly Jr.")
        let wr1 = Cell(pos: "WR1", play: "Amari Cooper")
        let wr2 = Cell(pos: "WR2", play: "Donovan Peoples-Jones")
        let wr3 = Cell(pos: "WR3", play: "Elijah Moore ")
        let wr4 = Cell(pos: "WR3", play: "David Bell")
        let wr5 = Cell(pos: "WR5", play: "Cedric Tillman", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "David Njoku")
        let te2 = Cell(pos: "TE2", play: "Jordan Akins")
        let te3 = Cell(pos: "TE3", play: "Harrison Bryant ")
        let k = Cell(pos: "K", play: "Cade York")
        
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func ravensArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Lamar Jackson")
        let qb2 = Cell(pos: "QB2", play: "Tyler Huntley")
        let qb3 = Cell(pos: "QB3", play: "Josh Johnson")
        let rb1 = Cell(pos: "RB1", play: "J.K. Dobbins")
        let rb2 = Cell(pos: "RB2", play: "Gus Edwards")
        let rb3 = Cell(pos: "RB3", play: "Justice Hill")
        let rb4 = Cell(pos: "RB4", play: "Melvin Gordan")
        let wr1 = Cell(pos: "WR1", play: "Rashod Bateman")
        let wr2 = Cell(pos: "WR2", play: "Odell Beckham Jr.")
        let wr3 = Cell(pos: "WR3", play: "Zay Flowers", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Nelson Agholor")
        let wr5 = Cell(pos: "WR5", play: "Devin Duvernay")
        let te1 = Cell(pos: "TE1", play: "Mark Andrews")
        let te2 = Cell(pos: "TE2", play: "Isaiah Likely")
        let te3 = Cell(pos: "TE3", play: "Charlie Kolar")
        let k = Cell(pos: "K", play: "Justin Tucker")
        
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func steelersArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Kenny Pickett")
        let qb2 = Cell(pos: "QB2", play: "Mitch Trubisky")
        let qb3 = Cell(pos: "QB3", play: "Mason Rudolph")
        let rb1 = Cell(pos: "RB1", play: "Najee Harris")
        let rb2 = Cell(pos: "RB2", play: "Jaylen Warren")
        let rb3 = Cell(pos: "RB3", play: "Anthony McFarland")
        let rb4 = Cell(pos: "RB4", play: "Darius Hagans", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Diontae Johnson")
        let wr2 = Cell(pos: "WR2", play: "George Pickens")
        let wr3 = Cell(pos: "WR3", play: "Allen Robinson")
        let wr4 = Cell(pos: "WR4", play: "Calvin Austin")
        let wr5 = Cell(pos: "WR5", play: "Miles Boykin")
        let te1 = Cell(pos: "TE1", play: "Pat Freiermuth")
        let te2 = Cell(pos: "TE2", play: "Zach Gentry")
        let te3 = Cell(pos: "TE3", play: "Darnell Washington", rookie: "R")
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // AFC South
    func coltsArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Anthony Richardson", rookie: "R")
        let qb2 = Cell(pos: "QB2", play: "Gardner Minshew II")
        let qb3 = Cell(pos: "QB3", play: "Sam Ehlinger")
        let rb1 = Cell(pos: "RB1", play: "Jonathan Taylor")
        let rb2 = Cell(pos: "RB2", play: "Zack Moss")
        let rb3 = Cell(pos: "RB3", play: "Evan Hull", rookie: "R")
        let rb4 = Cell(pos: "RB4", play: "Kenyan Drake")
        let wr1 = Cell(pos: "WR1", play: "Michael Pittman")
        let wr2 = Cell(pos: "WR2", play: "Alec Pierce")
        let wr3 = Cell(pos: "WR3", play: "Josh Downs", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Isaiah McKenzie")
        let wr5 = Cell(pos: "WR5", play: "Breshad Perriman")
        let te1 = Cell(pos: "TE1", play: "Jelani Woods")
        let te2 = Cell(pos: "TE2", play: "Mo Alie-Cox")
        let te3 = Cell(pos: "TE3", play: "Will Mallory", rookie: "R")
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func jaguarsArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Trevor Lawrence")
        let qb2 = Cell(pos: "QB2", play: "C.J. Beathard")
        let qb3 = Cell(pos: "QB3", play: "Nathan Rourke", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Travis Etienne")
        let rb2 = Cell(pos: "RB2", play: "Tank Bigsby", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "JaMycal Hasty")
        let rb4 = Cell(pos: "RB4", play: "Snoop Conner")
        let wr1 = Cell(pos: "WR1", play: "Calvin Ridley")
        let wr2 = Cell(pos: "WR2", play: "Christian Kirk")
        let wr3 = Cell(pos: "WR3", play: "Zay Jones")
        let wr4 = Cell(pos: "WR4", play: "Jamal Agnew")
        let wr5 = Cell(pos: "WR5", play: "Parker Washington", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Evan Engram")
        let te2 = Cell(pos: "TE2", play: "Brenton Strange", rookie: "R")
        let te3 = Cell(pos: "TE3", play: "Luke Farrell")
        let k = Cell(pos: "K", play: "Brandon McManus")
        
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func texansArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "C.J. Stroud", rookie: "R")
        let qb2 = Cell(pos: "QB2", play: "Davis Mills")
        let rb1 = Cell(pos: "RB1", play: "Dameon Pierce")
        let rb2 = Cell(pos: "RB2", play: "Devin Singletary")
        let rb3 = Cell(pos: "RB3", play: "Dare Ogunbowale")
        let rb4 = Cell(pos: "RB4", play: "Mike Boone")
        let wr1 = Cell(pos: "WR1", play: "Nico Collins")
        let wr2 = Cell(pos: "WR2", play: "Robert Woods")
        let wr3 = Cell(pos: "WR3", play: "John Metchie")
        let wr4 = Cell(pos: "WR4", play: "Tank Dell", rookie: "R")
        let wr5 = Cell(pos: "WR5", play: "Noah Brown")
        let te1 = Cell(pos: "TE1", play: "Dalton Schultz")
        let te2 = Cell(pos: "TE2", play: "Teagan Quitoriano")
        let te3 = Cell(pos: "TE3", play: "Brevin Jordan")
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
    
    func titansArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Ryan Tannehill")
        let qb2 = Cell(pos: "QB2", play: "Will Levis", rookie: "R")
        let qb3 = Cell(pos: "QB3", play: "Malik Willis")
        let rb1 = Cell(pos: "RB1", play: "Derrick Henry")
        let rb2 = Cell(pos: "RB2", play: "Tyjae Spears", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "Hassan Haskins")
        let rb4 = Cell(pos: "RB4", play: "Julius Chestnut")
        let wr1 = Cell(pos: "WR1", play: "DeAndre Hopkins")
        let wr2 = Cell(pos: "WR2", play: "Treylon Burks")
        let wr3 = Cell(pos: "WR3", play: "Nick Westbrook-Ikhine")
        let wr4 = Cell(pos: "WR4", play: "Kyle Philips")
        let wr5 = Cell(pos: "WR5", play: "Chris Moore")
        let te1 = Cell(pos: "TE1", play: "Chigoziem Okonkwo")
        let te2 = Cell(pos: "TE2", play: "Trevon Wesco")
        let te3 = Cell(pos: "TE3", play: "Kevin Rader")
        let k = Cell(pos: "K", play: "Michael Badgley")
        
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // AFC West
    func broncosArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Russell Wilson")
        let qb2 = Cell(pos: "QB2", play: "Jarrett Stidham")
        let rb1 = Cell(pos: "RB1", play: "Javonte Williams")
        let rb2 = Cell(pos: "RB2", play: "Samaje Perine")
        let rb3 = Cell(pos: "RB3", play: "Tony Jones Jr.")
        let rb4 = Cell(pos: "RB4", play: "Jaleel McLaughlin", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Jerry Jeudy")
        let wr2 = Cell(pos: "WR2", play: "Courtland Sutton")
        let wr3 = Cell(pos: "WR3", play: "Marvin Mims Jr.", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Marquez Callaway")
        let wr5 = Cell(pos: "WR5", play: "Kendall Hinton")
        let te1 = Cell(pos: "TE1", play: "Greg Dulcich")
        let te2 = Cell(pos: "TE2", play: "Adam Trautman")
        let te3 = Cell(pos: "TE3", play: "Chris Manhertz")
        let k = Cell(pos: "K", play: "Brett Maher")
        
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
    
    func chargersArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Justin Herbert")
        let qb2 = Cell(pos: "QB2", play: "Easton Stick")
        let qb3 = Cell(pos: "QB3", play: "Max Duggan", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Austin Ekeler")
        let rb2 = Cell(pos: "RB2", play: "Joshua Kelley")
        let rb3 = Cell(pos: "RB3", play: "Isaiah Spiller")
        let rb4 = Cell(pos: "RB4", play: "Elijah Dotson", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Keenan Allen")
        let wr2 = Cell(pos: "WR2", play: "Mike Williams")
        let wr3 = Cell(pos: "WR3", play: "Quentin Johnston", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Josh Palmer")
        let wr5 = Cell(pos: "WR5", play: "Jalen Guyton")
        let te1 = Cell(pos: "TE1", play: "Gerald Everett")
        let te2 = Cell(pos: "TE2", play: "Donald Parham")
        let te3 = Cell(pos: "TE3", play: "Tre' McKitty")
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func chiefsArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Patrick Mahomes")
        let qb2 = Cell(pos: "QB2", play: "Blaine Gabbert")
        let rb1 = Cell(pos: "RB1", play: "Isiah Pacheco")
        let rb2 = Cell(pos: "RB2", play: "Jerick McKinnon")
        let rb3 = Cell(pos: "RB3", play: "Clyde Edwards-Helaire")
        let rb4 = Cell(pos: "RB4", play: "Deneric Prince", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Marquez Valdes-Scantling")
        let wr2 = Cell(pos: "WR2", play: "Skyy Moore")
        let wr3 = Cell(pos: "WR3", play: "Kadarius Toney")
        let wr4 = Cell(pos: "WR4", play: "Rashee Rice", rookie: "R")
        let wr5 = Cell(pos: "WR5", play: "Justin Watson")
        let te1 = Cell(pos: "TE1", play: "Travis Kelce")
        let te2 = Cell(pos: "TE2", play: "Noah Gray")
        let te3 = Cell(pos: "TE3", play: "Blake Bell")
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
    
    func raidersArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Jimmy Garoppolo")
        let qb2 = Cell(pos: "QB2", play: "Brian Hoyer")
        let qb3 = Cell(pos: "QB3", play: "Aidan O'Connell", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Josh Jacobs")
        let rb2 = Cell(pos: "RB2", play: "Ameer Abdullah")
        let rb3 = Cell(pos: "RB3", play: "Zamir White")
        let rb4 = Cell(pos: "RB4", play: "Brandon Bolden")
        let wr1 = Cell(pos: "WR1", play: "Davante Adams")
        let wr2 = Cell(pos: "WR2", play: "Jakobi Meyers")
        let wr3 = Cell(pos: "WR3", play: "Hunter Renfrow")
        let wr4 = Cell(pos: "WR4", play: "Phillip Dorsett")
        let wr5 = Cell(pos: "WR5", play: "Tre Tucker", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Austin Hooper")
        let te2 = Cell(pos: "TE2", play: "Michael Mayer", rookie: "R")
        let te3 = Cell(pos: "TE3", play: "Jesper Horsted")
        let k = Cell(pos: "K", play: "Daniel Carlson")
        
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // NFC East
    func cowboysArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Dak Prescott")
        let qb2 = Cell(pos: "QB2", play: "Cooper Rush")
        let qb3 = Cell(pos: "QB3", play: "Will Grier")
        let rb1 = Cell(pos: "RB1", play: "Tony Pollard")
        let rb2 = Cell(pos: "RB2", play: "Rico Dowdle ")
        let rb3 = Cell(pos: "RB3", play: "Malik Davis")
        let rb4 = Cell(pos: "RB4", play: "Deuce Vaughn", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "CeeCee Lamb")
        let wr2 = Cell(pos: "WR2", play: "Brandin Cooks")
        let wr3 = Cell(pos: "WR3", play: "Michael Gallup")
        let wr4 = Cell(pos: "WR4", play: "Jalen Tolbert")
        let wr5 = Cell(pos: "WR5", play: "KaVontae Turpin")
        let te1 = Cell(pos: "TE1", play: "Jake Ferguson")
        let te2 = Cell(pos: "TE2", play: "Luke Schoonmaker", rookie: "R")
        let te3 = Cell(pos: "TE3", play: "Peyton Hendershot")
        let k = Cell(pos: "K", play: "Brandon Aubrey", rookie: "R")
        
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func eaglesArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Jalen Hurts")
        let qb2 = Cell(pos: "QB2", play: "Marcus Mariota")
        let qb3 = Cell(pos: "QB3", play: "Tanner McKee", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "D'Andre Swift")
        let rb2 = Cell(pos: "RB2", play: "Rashaad Penny")
        let rb3 = Cell(pos: "RB3", play: "Kenneth Gainwell")
        let rb4 = Cell(pos: "RB4", play: "Boston Scott")
        let wr1 = Cell(pos: "WR1", play: "A.J. Brown")
        let wr2 = Cell(pos: "WR2", play: "DeVonta Smith")
        let wr3 = Cell(pos: "WR3", play: "Quez Watkins")
        let wr4 = Cell(pos: "WR4", play: "Olamide Zaccheaus")
        let wr5 = Cell(pos: "WR5", play: "Joseph Ngata", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Dallas Goedert")
        let te2 = Cell(pos: "TE2", play: "Dan Arnold")
        let te3 = Cell(pos: "TE3", play: "Jack Stoll")
        let k = Cell(pos: "K", play: "Jake Elliott")
        
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func giantsArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Daniel Jones")
        let qb2 = Cell(pos: "QB2", play: "Tyrod Taylor")
        let qb3 = Cell(pos: "QB3", play: "Tommy DeVito", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Saquon Barkley")
        let rb2 = Cell(pos: "RB2", play: "Matt Breida")
        let rb3 = Cell(pos: "RB3", play: "Gary Brightwell")
        let rb4 = Cell(pos: "RB4", play: "Eric Gray", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Parris Campbell")
        let wr2 = Cell(pos: "WR2", play: "Isaiah Hodgins")
        let wr3 = Cell(pos: "WR3", play: "Darius Slayton")
        let wr4 = Cell(pos: "WR4", play: "Wan'Dale Robinson")
        let wr5 = Cell(pos: "WR5", play: "Sterling Shepard")
        let te1 = Cell(pos: "TE1", play: "Darren Waller")
        let te2 = Cell(pos: "TE2", play: "Daniel Bellinger")
        let te3 = Cell(pos: "TE3", play: "Lawrence Cager")
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func commandersArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Sam Howell")
        let qb2 = Cell(pos: "QB2", play: "Jacoby Brissett")
        let qb3 = Cell(pos: "QB3", play: "Jake Fromm")
        let rb1 = Cell(pos: "RB1", play: "Brian Robinson")
        let rb2 = Cell(pos: "RB2", play: "Antonio Gibson")
        let rb3 = Cell(pos: "RB3", play: "Chris Rodriguez Jr.", rookie: "R")
        let rb4 = Cell(pos: "RB4", play: "Jonathan Williams")
        let wr1 = Cell(pos: "WR1", play: "Terry McLaurin")
        let wr2 = Cell(pos: "WR2", play: "Jahan Dotson")
        let wr3 = Cell(pos: "WR3", play: "Curtis Samuel")
        let wr4 = Cell(pos: "WR4", play: "Dyami Brown")
        let wr5 = Cell(pos: "WR5", play: "Byron Pringle")
        let te1 = Cell(pos: "TE1", play: "Logan Thomas")
        let te2 = Cell(pos: "TE2", play: "John Bates")
        let te3 = Cell(pos: "TE3", play: "Cole Turner")
        let k = Cell(pos: "K", play: "Joey Slye")
        
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // NFC North
    func bearsArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Justin Fields")
        let qb2 = Cell(pos: "QB2", play: "Phillip Walker")
        let qb3 = Cell(pos: "QB3", play: "Tyson Bagent", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Khalil Herbert")
        let rb2 = Cell(pos: "RB2", play: "D'Onta Foreman")
        let rb3 = Cell(pos: "RB3", play: "Roschon Johnson", rookie: "R")
        let rb4 = Cell(pos: "RB4", play: "Travis Homer")
        let wr1 = Cell(pos: "WR1", play: "DJ Moore")
        let wr2 = Cell(pos: "WR2", play: "Darnell Mooney")
        let wr3 = Cell(pos: "WR3", play: "Chase Claypool")
        let wr4 = Cell(pos: "WR4", play: "Equanimeous St. Brown")
        let wr5 = Cell(pos: "WR5", play: "Velus Jones Jr.")
        let te1 = Cell(pos: "TE1", play: "Cole Kmet")
        let te2 = Cell(pos: "TE2", play: "Robert Tonyan")
        let te3 = Cell(pos: "TE3", play: "Marcedes Lewis")
        let k = Cell(pos: "K", play: "Cairo Santos")
        
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func lionsArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Jared Goff")
        let qb2 = Cell(pos: "QB2", play: "Teddy Bridgewater")
        let qb3 = Cell(pos: "QB3", play: "Hendon Hooker", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Jahmyr Gibbs", rookie: "R")
        let rb2 = Cell(pos: "RB2", play: "David Montgomery")
        let rb3 = Cell(pos: "RB3", play: "Craig Reynolds")
        let wr1 = Cell(pos: "WR1", play: "Amon-Ra St. Brown")
        let wr2 = Cell(pos: "WR2", play: "Josh Reynolds")
        let wr3 = Cell(pos: "WR3", play: "Marvin Jones Jr.")
        let wr4 = Cell(pos: "WR4", play: "Kalif Raymond")
        let wr5 = Cell(pos: "WR5", play: "Antoine Green", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Sam LaPorta", rookie: "R")
        let te2 = Cell(pos: "TE2", play: "Brock Wright")
        let te3 = Cell(pos: "TE3", play: "James Mitchell")
        let k = Cell(pos: "K", play: "Riley Patterson")
        
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func packersArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Jordan Love")
        let qb2 = Cell(pos: "QB2", play: "Sean Clifford", rookie: "R")
        let qb3 = Cell(pos: "QB3", play: "Alex McGough")
        let rb1 = Cell(pos: "RB1", play: "Aaron Jones")
        let rb2 = Cell(pos: "RB2", play: "A.J. Dillon")
        let rb3 = Cell(pos: "RB3", play: "Patrick Taylor")
        let rb4 = Cell(pos: "RB4", play: "Lew Nichols", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Christian Watson")
        let wr2 = Cell(pos: "WR2", play: "Romeo Doubs")
        let wr3 = Cell(pos: "WR3", play: "Jayden Reed", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Dontayvion Wicks", rookie: "R")
        let wr5 = Cell(pos: "WR5", play: "Samori Toure")
        let te1 = Cell(pos: "TE1", play: "Luke Musgrave", rookie: "R")
        let te2 = Cell(pos: "TE2", play: "Tucker Kraft", rookie: "R")
        let te3 = Cell(pos: "TE3", play: "Josiah Deguara")
        let k = Cell(pos: "K", play: "Anders Carlson", rookie: "R")
        
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func vikingsArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Kirk Cousins")
        let qb2 = Cell(pos: "QB2", play: "Nick Mullens")
        let qb3 = Cell(pos: "QB3", play: "Jaren Hall", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Alexander Mattison")
        let rb2 = Cell(pos: "RB2", play: "Ty Chandler")
        let rb3 = Cell(pos: "RB3", play: "Kene Nwangwu")
        let rb4 = Cell(pos: "RB4", play: "DeWayne McBride", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Justin Jefferson")
        let wr2 = Cell(pos: "WR2", play: "Jordan Addison", rookie: "R")
        let wr3 = Cell(pos: "WR3", play: "K.J. Osborn")
        let wr4 = Cell(pos: "WR4", play: "Brandon Powell")
        let wr5 = Cell(pos: "WR5", play: "Jalen Reagor")
        let te1 = Cell(pos: "TE1", play: "T.J. Hockenson")
        let te2 = Cell(pos: "TE2", play: "Josh Oliver")
        let te3 = Cell(pos: "TE3", play: "Johnny Mundt")
        let k = Cell(pos: "K", play: "Greg Joseph")
        
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // NFC South
    func buccaneersArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Baker Mayfield")
        let qb2 = Cell(pos: "QB2", play: "Kyle Trask")
        let qb3 = Cell(pos: "QB3", play: "John Wolford")
        let rb1 = Cell(pos: "RB1", play: "Rachaad White")
        let rb2 = Cell(pos: "RB2", play: "Chase Edmonds")
        let rb3 = Cell(pos: "RB3", play: "Ke'Shawn Vaughn")
        let rb4 = Cell(pos: "RB4", play: "Sean Tucker", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Mike Evans")
        let wr2 = Cell(pos: "WR2", play: "Chris Godwin")
        let wr3 = Cell(pos: "WR3", play: "Trey Palmer", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "David Moore")
        let wr5 = Cell(pos: "WR5", play: "Deven Thompkins")
        let te1 = Cell(pos: "TE1", play: "Cade Otton")
        let te2 = Cell(pos: "TE2", play: "Ko Kieft")
        let te3 = Cell(pos: "TE3", play: "Payne Durham", rookie: "R")
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func falconsArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Desmond Ridder")
        let qb2 = Cell(pos: "QB2", play: "Taylor Heinicke")
        let qb3 = Cell(pos: "QB3", play: "Logan Woodside")
        let rb1 = Cell(pos: "RB1", play: "Bijan Robinson", rookie: "R")
        let rb2 = Cell(pos: "RB2", play: "Cordarrelle Patterson")
        let rb3 = Cell(pos: "RB3", play: "Tyler Allgeier")
        let rb4 = Cell(pos: "RB4", play: "Godwin Igwebuike")
        let wr1 = Cell(pos: "WR1", play: "Drake London")
        let wr2 = Cell(pos: "WR2", play: "Mack Hollins")
        let wr3 = Cell(pos: "WR3", play: "KhaDarel Hodge")
        let wr4 = Cell(pos: "WR4", play: "Penny Hart")
        let wr5 = Cell(pos: "WR5", play: "Scotty Miller")
        let te1 = Cell(pos: "TE1", play: "Kyle Pitts")
        let te2 = Cell(pos: "TE2", play: "Jonnu Smith")
        let te3 = Cell(pos: "TE3", play: "Parker Hesse")
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
        positionPlayer.append(wr5)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func panthersArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Bryce Young", rookie: "R")
        let qb2 = Cell(pos: "QB2", play: "Andy Dalton")
        let qb3 = Cell(pos: "QB3", play: "Matt Corral")
        let rb1 = Cell(pos: "RB1", play: "Miles Sanders")
        let rb2 = Cell(pos: "RB2", play: "Chuba Hubbard")
        let rb3 = Cell(pos: "RB3", play: "Raheem Blackshear")
        let rb4 = Cell(pos: "RB4", play: "Spencer Brown")
        let wr1 = Cell(pos: "WR1", play: "DJ Chark Jr.")
        let wr2 = Cell(pos: "WR2", play: "Adam Thielen")
        let wr3 = Cell(pos: "WR3", play: "Jonathan Mingo", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Terrace Marshall Jr.")
        let wr5 = Cell(pos: "WR5", play: "Laviska Shenault Jr.")
        let te1 = Cell(pos: "TE1", play: "Hayden Hurst")
        let te2 = Cell(pos: "TE2", play: "Ian Thomas")
        let te3 = Cell(pos: "TE3", play: "Tommy Tremble")
        let k = Cell(pos: "K", play: "Eddy Pineiro")
        
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func saintsArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Derek Carr")
        let qb2 = Cell(pos: "QB2", play: "Jameis Winston")
        let qb3 = Cell(pos: "QB3", play: "Jake Haener", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Jamaal Williams")
        let rb2 = Cell(pos: "RB2", play: "Kendre Miller", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "Kirk Merritt")
        let rb4 = Cell(pos: "RB4", play: "Ellis Merriweather", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Chris Olave")
        let wr2 = Cell(pos: "WR2", play: "Michael Thomas")
        let wr3 = Cell(pos: "WR3", play: "Rashid Shaheed")
        let wr4 = Cell(pos: "WR4", play: "Tre'Quan Smith")
        let wr5 = Cell(pos: "WR5", play: "A.T Perry", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Juwan Johnson")
        let te2 = Cell(pos: "TE2", play: "Foster Moreau")
        let te3 = Cell(pos: "TE3", play: "Taysom Hill")
        let k = Cell(pos: "K", play: "Wil Lutz")
        
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // NFC West
    func _49ersArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Brock Purdy")
        let qb2 = Cell(pos: "QB2", play: "Trey Lance")
        let qb3 = Cell(pos: "QB3", play: "Darnold, Sam")
        let rb1 = Cell(pos: "RB1", play: "Christian McCaffrey")
        let rb2 = Cell(pos: "RB2", play: "Elijah Mitchell")
        let rb3 = Cell(pos: "RB3", play: "Tyrion Davis-Price")
        let rb4 = Cell(pos: "RB4", play: "Jordan Mason")
        let wr1 = Cell(pos: "WR1", play: "Deebo Samuel")
        let wr2 = Cell(pos: "WR2", play: "Brandon Aiyuk")
        let wr3 = Cell(pos: "WR3", play: "Jauan Jennings")
        let wr4 = Cell(pos: "WR4", play: "Danny Gray")
        let wr5 = Cell(pos: "WR5", play: "Ray-Ray McCloud")
        let te1 = Cell(pos: "TE1", play: "George Kittle")
        let te2 = Cell(pos: "TE2", play: "Cameron Latu", rookie: "R")
        let te3 = Cell(pos: "TE3", play: "Ross Dwelley")
        let k = Cell(pos: "K", play: "Jake Moody", rookie: "R")
        
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func cardinalsArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Kyler Murray")
        let qb2 = Cell(pos: "QB2", play: "Colt McCoy")
        let qb3 = Cell(pos: "QB3", play: "Clayton Tune", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "James Conner")
        let rb2 = Cell(pos: "RB2", play: "Keaontay Ingram")
        let rb3 = Cell(pos: "RB3", play: "Corey Clement")
        let rb4 = Cell(pos: "RB4", play: "Emari Demercado", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Marquise Brown")
        let wr2 = Cell(pos: "WR2", play: "Rondale Moore")
        let wr3 = Cell(pos: "WR3", play: "Michael Wilson", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Greg Dortch")
        let wr5 = Cell(pos: "WR5", play: "Zach Pascal")
        let te1 = Cell(pos: "TE1", play: "Zach Ertz")
        let te2 = Cell(pos: "TE2", play: "Trey McBride")
        let te3 = Cell(pos: "TE3", play: "Geoff Swaim")
        let k = Cell(pos: "K", play: "Matt Prater")
        
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func ramsArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Matthew Stafford")
        let qb2 = Cell(pos: "QB2", play: "Stetson Bennett", rookie: "R")
        let qb3 = Cell(pos: "QB3", play: "Brett Rypien")
        let rb1 = Cell(pos: "RB1", play: "Cam Akers")
        let rb2 = Cell(pos: "RB2", play: "Kyren Williams")
        let rb3 = Cell(pos: "RB3", play: "Zach Evans", rookie: "R")
        let rb4 = Cell(pos: "RB4", play: "Royce Freeman")
        let wr1 = Cell(pos: "WR1", play: "Cooper Kupp")
        let wr2 = Cell(pos: "WR2", play: "Van Jefferson")
        let wr3 = Cell(pos: "WR3", play: "Tutu Atwell")
        let wr4 = Cell(pos: "WR4", play: "Ben Skowronek")
        let wr5 = Cell(pos: "WR5", play: "Demarcus Robinson")
        let te1 = Cell(pos: "TE1", play: "Tyler Higbee")
        let te2 = Cell(pos: "TE2", play: "Hunter Long")
        let te3 = Cell(pos: "TE3", play: "Brycen Hopkins")
        let k = Cell(pos: "K", play: "Tanner Brown", rookie: "R")
        
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func seahawksArray_2023() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Geno Smith")
        let qb2 = Cell(pos: "QB2", play: "Drew Lock")
        let qb3 = Cell(pos: "QB3", play: "Holton Ahlers", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Ken Walker")
        let rb2 = Cell(pos: "RB2", play: "Zach Charbonnet", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "DeeJay Dallas")
        let rb4 = Cell(pos: "RB4", play: "Kenny McIntosh", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "DK Metcalf")
        let wr2 = Cell(pos: "WR2", play: "Tyler Lockett")
        let wr3 = Cell(pos: "WR3", play: "Jaxon Smith-Njigba", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Dareke Young")
        let wr5 = Cell(pos: "WR5", play: "Cody Thompson")
        let te1 = Cell(pos: "TE1", play: "Noah Fant")
        let te2 = Cell(pos: "TE2", play: "Will Dissly")
        let te3 = Cell(pos: "TE3", play: "Colby Parkinson")
        let k = Cell(pos: "K", play: "Jason Myers")
        
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(te3)
        positionPlayer.append(k)
        
        return positionPlayer
    }
}

