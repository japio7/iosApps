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

struct InjuryResponse: Codable {
    var Week: Int?
    var Injuries: Dictionary<String,[Injuries]>
}

struct Injuries: Codable {
    var week: String?
    var playerId, playerName: String?
    var team, position: String?
    var injury, practiceStatus, gameStatus: String?
    var notes, lastUpdate, practiceStatusId: String?
}

struct DepthChartResponse: Codable {
    var DepthCharts: Dictionary<String, DepthCharts>
}

struct DepthCharts: Codable {
    var depth: String?
    var playerId: String?
    var playerName: String?
    var position: String?
    var team: String?
}

