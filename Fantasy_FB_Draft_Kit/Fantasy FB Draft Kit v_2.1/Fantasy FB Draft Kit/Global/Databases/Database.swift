//
//  Database.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 6/18/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import Foundation

class PlayerData: Codable {
    var num: Int = 0
    var numPosPick: Int = 0
    var numRookie: Int = 0
    var name: String = ""
    var team: String = ""
    var position: String = ""
    var byeWeek: Int = 0
    
    var rosterPosition: Int = -1
    var draftPosition: Int = -1
    var isTopPlayer: Bool
    var isRookie: Bool
    
    var isRostered: Bool { return rosterPosition >= 0 }
    var isDrafted: Bool { return draftPosition >= 0 }
    
    init(num: Int, numPosPick: Int, numRookie: Int, name: String, team: String, position: String, byeWeek: Int, isTopPlayer: Bool, isRookie: Bool) {
        self.num = num
        self.numPosPick = numPosPick
        self.numRookie = numRookie
        self.name = name
        self.team = team
        self.position = position
        self.byeWeek = byeWeek
        
        self.isTopPlayer = isTopPlayer
        self.isRookie = isRookie
    }
}

// Draft Rankings
struct DraftRoster: Codable {
    var roster_draft: [RosterDraft]
}

struct RosterDraft: Codable {
    var rosterPosition: Int = -1
    var draftPosition: Int = -1
    var isRostered: Bool { return rosterPosition >= 0 }
    var isDrafted: Bool { return draftPosition >= 0 }
}

//struct DraftRankingsResponse: Codable {
//    var PPR: Int?
//    var DraftRankings: [DraftRankings]
//}

//struct DraftRankings: Codable {
//    var playerID: Int?
//    var position: String?
//    var displayName: String?
//    var fname: String?
//    var lname: String?
//    var team: String?
//    var byeWeek: String?
//    var standDev: String?
//    var nerdRank: String?
//    var positionRank: String?
//    var overallRank: Int?
//
//    init(playerID: Int, position: String, displayName: String, fname: String, lname: String, team: String, byeWeek: String, standDev: String, nerdRank: String, positionRank: String, overallRank: Int) {
//        self.playerID = playerID
//        self.position = position
//        self.displayName = displayName
//        self.fname = fname
//        self.lname = lname
//        self.team = team
//        self.byeWeek = byeWeek
//        self.standDev = standDev
//        self.nerdRank = nerdRank
//        self.positionRank = positionRank
//        self.overallRank = overallRank
//    }
//}

class Database {
    static let shared = Database()
    
    var appVersion: String {
       // return Bundle.main.infoDictionary![kCFBundleVersionKey as String] as! String
        return (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!
    }
    
    // Store app version in UserDefaults
    func store_app_version(a: String) {
        UserDefaults.standard.set(a, forKey: "stored_version")
    }
}
