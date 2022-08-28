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
    var isRostered: Bool {return rosterPosition >= 0}
    var isDrafted: Bool {return draftPosition >= 0}
}

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
