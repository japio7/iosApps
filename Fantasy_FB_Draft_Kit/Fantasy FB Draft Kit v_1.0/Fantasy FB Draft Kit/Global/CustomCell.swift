//
//  CustomCell.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 6/19/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import UIKit
import Foundation

class Custom_Cell: UITableViewCell {
    
    @IBOutlet weak var player: UILabel!
    @IBOutlet weak var team: UILabel!
    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var bye: UILabel!
}

class LeagueCell {
    var player: String
    var team: String
    var pos: String
    var bye: String
    
    init(player: String, team: String, pos: String, bye: String) {
        self.player = player
        self.team = team
        self.pos = pos
        self.bye = bye
    }
    
}


class CustomCell: UITableViewCell {

    @IBOutlet weak var position: UILabel!
    @IBOutlet weak var player: UILabel!
    @IBOutlet weak var rookie: UILabel!
    
    
    // Set font color to black.
    // Used by Bengals, Raider, Bills, Dolphins, Jets.
    func setPosition(playerPosition: Cell) {
        position.text = playerPosition.pos
        player.text = playerPosition.play
        rookie.text = playerPosition.rookie
        position.textColor = .black
        player.textColor = .black
        rookie.textColor = .black
        position.font.withSize(25)
        player.font.withSize(25)
        rookie.font.withSize(25)
        position.adjustsFontSizeToFitWidth = true
        player.adjustsFontSizeToFitWidth = true
        rookie.adjustsFontSizeToFitWidth = true
    }
    
    // Set font color to white.
    // Used by Browns, 49ers, Cardinals, Rams, Colts, Jaguars, Texans, Cowboys.
    func setPositionFontWhite(playerPosition: Cell) {
        position.text = playerPosition.pos
        player.text = playerPosition.play
        rookie.text = playerPosition.rookie
        position.textColor = .white
        player.textColor = .white
        rookie.textColor = .white
        position.font.withSize(22)
        player.font.withSize(22)
        rookie.font.withSize(22)
        position.adjustsFontSizeToFitWidth = true
        player.adjustsFontSizeToFitWidth = true
        rookie.adjustsFontSizeToFitWidth = true
    }
    
    // Set font color to Patriots blue.
    func setPositionFontBluePatriots(playerPosition: Cell) {
        position.text = playerPosition.pos
        player.text = playerPosition.play
        rookie.text = playerPosition.rookie
        position.textColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
        player.textColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
        rookie.textColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
        position.font.withSize(22)
        player.font.withSize(22)
        rookie.font.withSize(22)
        position.adjustsFontSizeToFitWidth = true
        player.adjustsFontSizeToFitWidth = true
        rookie.adjustsFontSizeToFitWidth = true
    }
    
    // Set font color to Ravens gold.
    func setPositionFontGoldRavens(playerPosition: Cell) {
        position.text = playerPosition.pos
        player.text = playerPosition.play
        rookie.text = playerPosition.rookie
        position.textColor = #colorLiteral(red: 0.6196078431, green: 0.4862745098, blue: 0.04705882353, alpha: 1)
        player.textColor = #colorLiteral(red: 0.6196078431, green: 0.4862745098, blue: 0.04705882353, alpha: 1)
        rookie.textColor = #colorLiteral(red: 0.6196078431, green: 0.4862745098, blue: 0.04705882353, alpha: 1)
        position.font.withSize(22)
        player.font.withSize(22)
        rookie.font.withSize(22)
        position.adjustsFontSizeToFitWidth = true
        player.adjustsFontSizeToFitWidth = true
        rookie.adjustsFontSizeToFitWidth = true
    }
    
    // Set font color to Steelers gold.
    func setPositionFontYellowSteelers(playerPosition: Cell) {
        position.text = playerPosition.pos
        player.text = playerPosition.play
        rookie.text = playerPosition.rookie
        position.textColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
        player.textColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
        rookie.textColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
        position.font.withSize(22)
        player.font.withSize(22)
        rookie.font.withSize(22)
        position.adjustsFontSizeToFitWidth = true
        player.adjustsFontSizeToFitWidth = true
        rookie.adjustsFontSizeToFitWidth = true
    }
    
    // Set font color to Titans blue.
    func setPositionFontBlueTitans(playerPosition: Cell) {
        position.text = playerPosition.pos
        player.text = playerPosition.play
        rookie.text = playerPosition.rookie
        position.textColor = #colorLiteral(red: 0.04705882353, green: 0.137254902, blue: 0.2509803922, alpha: 1)
        player.textColor = #colorLiteral(red: 0.04705882353, green: 0.137254902, blue: 0.2509803922, alpha: 1)
        rookie.textColor = #colorLiteral(red: 0.04705882353, green: 0.137254902, blue: 0.2509803922, alpha: 1)
        position.font.withSize(22)
        player.font.withSize(22)
        rookie.font.withSize(22)
        position.adjustsFontSizeToFitWidth = true
        player.adjustsFontSizeToFitWidth = true
        rookie.adjustsFontSizeToFitWidth = true
    }
    
    // Set font color to Broncos orange.
    func setPositionFontOrangeBroncos(playerPosition: Cell) {
        position.text = playerPosition.pos
        player.text = playerPosition.play
        rookie.text = playerPosition.rookie
        position.textColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
        player.textColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
        rookie.textColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
        position.font.withSize(22)
        player.font.withSize(22)
        rookie.font.withSize(22)
        position.adjustsFontSizeToFitWidth = true
        player.adjustsFontSizeToFitWidth = true
        rookie.adjustsFontSizeToFitWidth = true
    }
    
    // Set font color to Chargers gold.
    func setPositionFontGoldChargers(playerPosition: Cell) {
        position.text = playerPosition.pos
        player.text = playerPosition.play
        rookie.text = playerPosition.rookie
        position.textColor = #colorLiteral(red: 1, green: 0.7607843137, blue: 0.05490196078, alpha: 1)
        player.textColor = #colorLiteral(red: 1, green: 0.7607843137, blue: 0.05490196078, alpha: 1)
        rookie.textColor = #colorLiteral(red: 1, green: 0.7607843137, blue: 0.05490196078, alpha: 1)
        position.font.withSize(22)
        player.font.withSize(22)
        rookie.font.withSize(22)
        position.adjustsFontSizeToFitWidth = true
        player.adjustsFontSizeToFitWidth = true
        rookie.adjustsFontSizeToFitWidth = true
    }
    
    // Set font color to Chiefs gold.
    func setPositionFontGoldChiefs(playerPosition: Cell) {
        position.text = playerPosition.pos
        player.text = playerPosition.play
        rookie.text = playerPosition.rookie
        position.textColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
        player.textColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
        rookie.textColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
        position.font.withSize(22)
        player.font.withSize(22)
        rookie.font.withSize(22)
        position.adjustsFontSizeToFitWidth = true
        player.adjustsFontSizeToFitWidth = true
        rookie.adjustsFontSizeToFitWidth = true
    }
    
    // Set font color to Eagles silver.
    func setPositionFontSilverEagles(playerPosition: Cell) {
        position.text = playerPosition.pos
        player.text = playerPosition.play
        rookie.text = playerPosition.rookie
        position.textColor = #colorLiteral(red: 0.7294117647, green: 0.7921568627, blue: 0.8274509804, alpha: 1)
        player.textColor = #colorLiteral(red: 0.7294117647, green: 0.7921568627, blue: 0.8274509804, alpha: 1)
        rookie.textColor = #colorLiteral(red: 0.7294117647, green: 0.7921568627, blue: 0.8274509804, alpha: 1)
        position.font.withSize(22)
        player.font.withSize(22)
        rookie.font.withSize(22)
        position.adjustsFontSizeToFitWidth = true
        player.adjustsFontSizeToFitWidth = true
        rookie.adjustsFontSizeToFitWidth = true
    }
    
    // Set font color to Giants blue.
    func setPositionFontBlueGiants(playerPosition: Cell) {
        position.text = playerPosition.pos
        player.text = playerPosition.play
        rookie.text = playerPosition.rookie
        position.textColor = #colorLiteral(red: 0.003921568627, green: 0.137254902, blue: 0.3215686275, alpha: 1)
        player.textColor = #colorLiteral(red: 0.003921568627, green: 0.137254902, blue: 0.3215686275, alpha: 1)
        rookie.textColor = #colorLiteral(red: 0.003921568627, green: 0.137254902, blue: 0.3215686275, alpha: 1)
        position.font.withSize(22)
        player.font.withSize(22)
        rookie.font.withSize(22)
        position.adjustsFontSizeToFitWidth = true
        player.adjustsFontSizeToFitWidth = true
        rookie.adjustsFontSizeToFitWidth = true
    }
    
    // Set font color to Redskins gold.
    func setPositionFontGoldRedskins(playerPosition: Cell) {
        position.text = playerPosition.pos
        player.text = playerPosition.play
        rookie.text = playerPosition.rookie
        position.textColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
        player.textColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
        rookie.textColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
        position.font.withSize(22)
        player.font.withSize(22)
        rookie.font.withSize(22)
        position.adjustsFontSizeToFitWidth = true
        player.adjustsFontSizeToFitWidth = true
        rookie.adjustsFontSizeToFitWidth = true
    }
    
    // Set font color to Bears orange.
    func setPositionFontOrangeBears(playerPosition: Cell) {
        position.text = playerPosition.pos
        player.text = playerPosition.play
        rookie.text = playerPosition.rookie
        position.textColor = #colorLiteral(red: 0.7843137255, green: 0.2196078431, blue: 0.01176470588, alpha: 1)
        player.textColor = #colorLiteral(red: 0.7843137255, green: 0.2196078431, blue: 0.01176470588, alpha: 1)
        rookie.textColor = #colorLiteral(red: 0.7843137255, green: 0.2196078431, blue: 0.01176470588, alpha: 1)
        position.font.withSize(22)
        player.font.withSize(22)
        rookie.font.withSize(22)
        position.adjustsFontSizeToFitWidth = true
        player.adjustsFontSizeToFitWidth = true
        rookie.adjustsFontSizeToFitWidth = true
    }
    
    // Set font color to Packers gold.
    func setPositionFontGoldPackers(playerPosition: Cell) {
        position.text = playerPosition.pos
        player.text = playerPosition.play
        rookie.text = playerPosition.rookie
        position.textColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
        player.textColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
        rookie.textColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
        position.font.withSize(22)
        player.font.withSize(22)
        rookie.font.withSize(22)
        position.adjustsFontSizeToFitWidth = true
        player.adjustsFontSizeToFitWidth = true
        rookie.adjustsFontSizeToFitWidth = true
    }
    
    // Set font color to Vikings gold.
    func setPositionFontGoldVikings(playerPosition: Cell) {
        position.text = playerPosition.pos
        player.text = playerPosition.play
        rookie.text = playerPosition.rookie
        position.textColor = #colorLiteral(red: 1, green: 0.7764705882, blue: 0.1843137255, alpha: 1)
        player.textColor = #colorLiteral(red: 1, green: 0.7764705882, blue: 0.1843137255, alpha: 1)
        rookie.textColor = #colorLiteral(red: 1, green: 0.7764705882, blue: 0.1843137255, alpha: 1)
        position.font.withSize(22)
        player.font.withSize(22)
        rookie.font.withSize(22)
        position.adjustsFontSizeToFitWidth = true
        player.adjustsFontSizeToFitWidth = true
        rookie.adjustsFontSizeToFitWidth = true
    }
    
    // Set font color to Buccaneers grey.
    func setPositionFontGreyBuccaneers(playerPosition: Cell) {
        position.text = playerPosition.pos
        player.text = playerPosition.play
        rookie.text = playerPosition.rookie
        position.textColor = #colorLiteral(red: 0.6941176471, green: 0.7294117647, blue: 0.7490196078, alpha: 1)
        player.textColor = #colorLiteral(red: 0.6941176471, green: 0.7294117647, blue: 0.7490196078, alpha: 1)
        rookie.textColor = #colorLiteral(red: 0.6941176471, green: 0.7294117647, blue: 0.7490196078, alpha: 1)
        position.font.withSize(22)
        player.font.withSize(22)
        rookie.font.withSize(22)
        position.adjustsFontSizeToFitWidth = true
        player.adjustsFontSizeToFitWidth = true
        rookie.adjustsFontSizeToFitWidth = true
    }
    
    // Set font color to Falcons silver.
    func setPositionFontSilverFalcons(playerPosition: Cell) {
        position.text = playerPosition.pos
        player.text = playerPosition.play
        rookie.text = playerPosition.rookie
        position.textColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
        player.textColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
        rookie.textColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
        position.font.withSize(22)
        player.font.withSize(22)
        rookie.font.withSize(22)
        position.adjustsFontSizeToFitWidth = true
        player.adjustsFontSizeToFitWidth = true
        rookie.adjustsFontSizeToFitWidth = true
    }
    
    // Set font color to Panthers silver.
    func setPositionFontSilverPanthers(playerPosition: Cell) {
        position.text = playerPosition.pos
        player.text = playerPosition.play
        rookie.text = playerPosition.rookie
        position.textColor = #colorLiteral(red: 0.7490196078, green: 0.7529411765, blue: 0.7490196078, alpha: 1)
        player.textColor = #colorLiteral(red: 0.7490196078, green: 0.7529411765, blue: 0.7490196078, alpha: 1)
        rookie.textColor = #colorLiteral(red: 0.7490196078, green: 0.7529411765, blue: 0.7490196078, alpha: 1)
        position.font.withSize(22)
        player.font.withSize(22)
        rookie.font.withSize(22)
        position.adjustsFontSizeToFitWidth = true
        player.adjustsFontSizeToFitWidth = true
        rookie.adjustsFontSizeToFitWidth = true
    }
    
    // Set font color to Saints gold.
    func setPositionFontBlackSaints(playerPosition: Cell) {
        position.text = playerPosition.pos
        player.text = playerPosition.play
        rookie.text = playerPosition.rookie
        position.textColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1215686275, alpha: 1)
        player.textColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1215686275, alpha: 1)
        rookie.textColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1215686275, alpha: 1)
        position.font.withSize(22)
        player.font.withSize(22)
        rookie.font.withSize(22)
        position.adjustsFontSizeToFitWidth = true
        player.adjustsFontSizeToFitWidth = true
        rookie.adjustsFontSizeToFitWidth = true
    }
    
    // Set font color to Seahawks gray.
    func setPositionFontGraySeahawks(playerPosition: Cell) {
        position.text = playerPosition.pos
        player.text = playerPosition.play
        rookie.text = playerPosition.rookie
        position.textColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
        player.textColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
        rookie.textColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
        position.font.withSize(22)
        player.font.withSize(22)
        rookie.font.withSize(22)
        position.adjustsFontSizeToFitWidth = true
        player.adjustsFontSizeToFitWidth = true
        rookie.adjustsFontSizeToFitWidth = true
    }
}

class Cell {
    var pos: String
    var play: String
    var rookie: String
    
    
    init(pos: String, play: String, rookie: String = "") {
        self.pos = pos
        self.play = play
        self.rookie = rookie
    }
}
