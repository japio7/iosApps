//
//  TeamDepthChart_2021.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 9/7/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import UIKit

class TeamDepthChart_2021: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var passedData = RowSelected()
    
    var data: [Cell] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let playerData = data[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "my cell") as! CustomCell
        
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
        
        if passedData.sec == 0 && passedData.row == 0 {
            cell.setPosition(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.2, blue: 0.5529411765, alpha: 1)
        }
        if passedData.sec == 0 && passedData.row == 1 {
            cell.setPosition(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.5568627451, blue: 0.5921568627, alpha: 1)
        }
        if passedData.sec == 0 && passedData.row == 2 {
            cell.setPosition(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.3411764706, blue: 0.2509803922, alpha: 1)
        }
        if passedData.sec == 0 && passedData.row == 3 {
            cell.setPositionFontBluePatriots(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
        }

        if passedData.sec == 1 && passedData.row == 0 {
            cell.setPosition(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
        }
        if passedData.sec == 1 && passedData.row == 1 {
            cell.setPositionFontWhite(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 1, green: 0.2352941176, blue: 0, alpha: 1)
        }
        if passedData.sec == 1 && passedData.row == 2 {
            cell.setPositionFontGoldRavens(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        if passedData.sec == 1 && passedData.row == 3 {
            cell.setPositionFontYellowSteelers(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }

        if passedData.sec == 2 && passedData.row == 0 {
            cell.setPositionFontWhite(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.1725490196, blue: 0.3725490196, alpha: 1)
        }
        if passedData.sec == 2 && passedData.row == 1 {
            cell.setPositionFontWhite(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.4039215686, blue: 0.4705882353, alpha: 1)
        }
        if passedData.sec == 2 && passedData.row == 2 {
            cell.setPositionFontWhite(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.1254901961, blue: 0.1843137255, alpha: 1)
        }
        if passedData.sec == 2 && passedData.row == 3 {
            cell.setPositionFontBlueTitans(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.5607843137, blue: 0.8705882353, alpha: 1)
        }

        if passedData.sec == 3 && passedData.row == 0 {
            cell.setPositionFontOrangeBroncos(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
        }
        if passedData.sec == 3 && passedData.row == 1 {
            cell.setPositionFontGoldChargers(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.1647058824, blue: 0.368627451, alpha: 1)
        }
        if passedData.sec == 3 && passedData.row == 2 {
            cell.setPosition(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.09411764706, blue: 0.2156862745, alpha: 1)
        }
        if passedData.sec == 3 && passedData.row == 3 {
            cell.setPosition(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
        }

        if passedData.sec == 4 && passedData.row == 0 {
            cell.setPositionFontWhite(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
        }
        if passedData.sec == 4 && passedData.row == 1 {
            cell.setPositionFontSilverEagles(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.2980392157, blue: 0.3294117647, alpha: 1)
        }
        if passedData.sec == 4 && passedData.row == 2 {
            cell.setPositionFontBlueGiants(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0.6078431373, green: 0.631372549, blue: 0.6352941176, alpha: 1)
        }
        if passedData.sec == 4 && passedData.row == 3 {
            cell.setPositionFontGoldRedskins(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0.2470588235, green: 0.06274509804, blue: 0.06274509804, alpha: 1)
        }

        if passedData.sec == 5 && passedData.row == 0 {
            cell.setPositionFontOrangeBears(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0.0431372549, green: 0.0862745098, blue: 0.1647058824, alpha: 1)
        }
        if passedData.sec == 5 && passedData.row == 1 {
            cell.setPositionFontWhite(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.462745098, blue: 0.7137254902, alpha: 1)
        }
        if passedData.sec == 5 && passedData.row == 2 {
            cell.setPositionFontGoldPackers(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.1882352941, blue: 0.1568627451, alpha: 1)
        }
        if passedData.sec == 5 && passedData.row == 3 {
            cell.setPositionFontGoldVikings(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0.3098039216, green: 0.1490196078, blue: 0.5137254902, alpha: 1)
        }

        if passedData.sec == 6 && passedData.row == 0 {
            cell.setPositionFontGreyBuccaneers(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0.8352941176, green: 0.03921568627, blue: 0.03921568627, alpha: 1)
        }
        if passedData.sec == 6 && passedData.row == 1 {
            cell.setPositionFontSilverFalcons(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        if passedData.sec == 6 && passedData.row == 2 {
            cell.setPositionFontSilverPanthers(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
        }
        if passedData.sec == 6 && passedData.row == 3 {
            cell.setPositionFontBlackSaints(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0.8274509804, green: 0.737254902, blue: 0.5529411765, alpha: 1)
        }

        if passedData.sec == 7 && passedData.row == 0 {
            cell.setPositionFontWhite(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0.6666666667, green: 0, blue: 0, alpha: 1)
        }
        if passedData.sec == 7 && passedData.row == 1 {
            cell.setPositionFontWhite(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0.5921568627, green: 0.137254902, blue: 0.2470588235, alpha: 1)
        }
        if passedData.sec == 7 && passedData.row == 2 {
            cell.setPositionFontWhite(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
        }
        if passedData.sec == 7 && passedData.row == 3 {
            cell.setPositionFontGraySeahawks(playerPosition: playerData)
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
        }
        return cell
    }
    
    func loadTeamData() {
        if passedData.sec == 0 && passedData.row == 0 {
            data = billsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.01938016217, green: 0.2123703163, blue: 0.5529411765, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.04705882353, blue: 0.1882352941, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.04705882353, blue: 0.1882352941, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.04705882353, blue: 0.1882352941, alpha: 1)
            label.textColor = .black
            label.text = "Buffalo Bills"
        }
        if passedData.sec == 0 && passedData.row == 1 {
            data = dolphinsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0.3411764706, blue: 0.4705882353, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.2980392157, blue: 0.007843137255, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.2980392157, blue: 0.007843137255, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.2980392157, blue: 0.007843137255, alpha: 1)
            label.textColor = .black
            label.text = "Miami Dolphins"
        }
        if passedData.sec == 0 && passedData.row == 2 {
            data = jetsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.3411764706, blue: 0.2509803922, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            label.textColor = .black
            label.text = "New York Jets"
        }
        if passedData.sec == 0 && passedData.row == 3 {
            data = patriotsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.04705882353, blue: 0.1882352941, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            label.textColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
            label.text = "New England Patriots"
        }
        
        if passedData.sec == 1 && passedData.row == 0 {
            data = bengalsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.textColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            label.text = "Cincinatti Bengals"
        }
        if passedData.sec == 1 && passedData.row == 1 {
            data = brownsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 1, green: 0.2352941176, blue: 0, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.1137254902, blue: 0, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.1137254902, blue: 0, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.1137254902, blue: 0, alpha: 1)
            label.textColor = .white
            label.text = "Cleveland Browns"
        }
        if passedData.sec == 1 && passedData.row == 2 {
            data = ravensArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.09803921569, blue: 0.3725490196, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.09803921569, blue: 0.3725490196, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.09803921569, blue: 0.3725490196, alpha: 1)
            label.textColor = #colorLiteral(red: 0.6196078431, green: 0.4862745098, blue: 0.04705882353, alpha: 1)
            label.text = "Baltimore Ravens"
        }
        if passedData.sec == 1 && passedData.row == 3 {
            data = steelersArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.textColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.text = "Pittsburgh Steelers"
        }
        
        if passedData.sec == 2 && passedData.row == 0 {
            data = coltsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0.1725490196, blue: 0.3725490196, alpha: 1)
            view2.backgroundColor = .white
            label.backgroundColor = .white
            table.backgroundColor = .white
            label.textColor = #colorLiteral(red: 0, green: 0.1725490196, blue: 0.3725490196, alpha: 1)
            label.text = "Indianapolis Colts"
        }
        if passedData.sec == 2 && passedData.row == 1 {
            data = jaguarsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.6235294118, green: 0.4745098039, blue: 0.1725490196, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            label.textColor = .white
            label.text = "Jacksonville Jaguars"
        }
        if passedData.sec == 2 && passedData.row == 2 {
            data = texansArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.1254901961, blue: 0.1843137255, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            label.textColor = .white
            label.text = "Houston Texans"
        }
        if passedData.sec == 2 && passedData.row == 3 {
            data = titansArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.5411764706, green: 0.5529411765, blue: 0.5607843137, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.06274509804, blue: 0.1803921569, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.06274509804, blue: 0.1803921569, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.06274509804, blue: 0.1803921569, alpha: 1)
            label.textColor = #colorLiteral(red: 0.04705882353, green: 0.137254902, blue: 0.2509803922, alpha: 1)
            label.text = "Tennessee Titans"
        }
        
        if passedData.sec == 3 && passedData.row == 0 {
            data = broncosArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            label.textColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            label.text = "Denver Broncos"
        }
        if passedData.sec == 3 && passedData.row == 1 {
            data = chargersArray_2021()
            view1.backgroundColor = #colorLiteral(red: 1, green: 0.7607843137, blue: 0.05490196078, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0.7764705882, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0.7764705882, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0.7764705882, alpha: 1)
            label.textColor = #colorLiteral(red: 1, green: 0.7607843137, blue: 0.05490196078, alpha: 1)
            label.text = "Los Angeles Chargers"
        }
        if passedData.sec == 3 && passedData.row == 2 {
            data = chiefsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.09411764706, blue: 0.2156862745, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            label.textColor = .black
            label.text = "Kansas City Chiefs"
        }
        if passedData.sec == 3 && passedData.row == 3 {
            data = raidersArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            view2.backgroundColor = .black
            label.backgroundColor = .black
            table.backgroundColor = .black
            label.textColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            label.text = "Las Vegas Raiders"
        }
        
        if passedData.sec == 4 && passedData.row == 0 {
            data = cowboysArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.4980392157, green: 0.5882352941, blue: 0.5843137255, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0.2078431373, blue: 0.5803921569, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0.2078431373, blue: 0.5803921569, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0.2078431373, blue: 0.5803921569, alpha: 1)
            label.textColor = .white
            label.text = "Dallas Cowboys"
        }
        if passedData.sec == 4 && passedData.row == 1 {
            data = eaglesArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.3725490196, green: 0.3764705882, blue: 0.3843137255, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.textColor = #colorLiteral(red: 0.7294117647, green: 0.7921568627, blue: 0.8274509804, alpha: 1)
            label.text = "Philadelphia Eagles"
        }
        if passedData.sec == 4 && passedData.row == 2 {
            data = giantsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.137254902, blue: 0.3215686275, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6392156863, green: 0.05098039216, blue: 0.1764705882, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6392156863, green: 0.05098039216, blue: 0.1764705882, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6392156863, green: 0.05098039216, blue: 0.1764705882, alpha: 1)
            label.textColor = #colorLiteral(red: 0.003921568627, green: 0.137254902, blue: 0.3215686275, alpha: 1)
            label.text = "New York Giants"
        }
        if passedData.sec == 4 && passedData.row == 3 {
            data = footballTeamArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.2470588235, green: 0.06274509804, blue: 0.06274509804, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.textColor = #colorLiteral(red: 0.2470588235, green: 0.06274509804, blue: 0.06274509804, alpha: 1)
            label.text = "Washington Football Team"
        }
        
        if passedData.sec == 5 && passedData.row == 0 {
            data = bearsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.0431372549, green: 0.0862745098, blue: 0.1647058824, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.2196078431, blue: 0.01176470588, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.2196078431, blue: 0.01176470588, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.2196078431, blue: 0.01176470588, alpha: 1)
            label.textColor = #colorLiteral(red: 0.0431372549, green: 0.0862745098, blue: 0.1647058824, alpha: 1)
            label.text = "Chicago Bears"
        }
        if passedData.sec == 5 && passedData.row == 1 {
            data = lionsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
            label.textColor = .white
            label.text = "Detroit Lions"
        }
        if passedData.sec == 5 && passedData.row == 2 {
            data = packersArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.1882352941, blue: 0.1568627451, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            label.textColor = #colorLiteral(red: 0.09411764706, green: 0.1882352941, blue: 0.1568627451, alpha: 1)
            label.text = "Green Bay Packers"
        }
        if passedData.sec == 5 && passedData.row == 3 {
            data = vikingsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.3098039216, green: 0.1490196078, blue: 0.5137254902, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7764705882, blue: 0.1843137255, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7764705882, blue: 0.1843137255, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7764705882, blue: 0.1843137255, alpha: 1)
            label.textColor = #colorLiteral(red: 0.3098039216, green: 0.1490196078, blue: 0.5137254902, alpha: 1)
            label.text = "Minnesota Vikings"
        }
        
        if passedData.sec == 6 && passedData.row == 0 {
            data = buccaneersArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.1882352941, blue: 0.168627451, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.03921568627, blue: 0.03137254902, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.03921568627, blue: 0.03137254902, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.03921568627, blue: 0.03137254902, alpha: 1)
            label.textColor = #colorLiteral(red: 0.6941176471, green: 0.7294117647, blue: 0.7490196078, alpha: 1)
            label.text = "Tampa Bay Buccaneers"
        }
        if passedData.sec == 6 && passedData.row == 1 {
            data = falconsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.text = "Atlanta Falcons"
        }
        if passedData.sec == 6 && passedData.row == 2 {
            data = panthersArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.7529411765, blue: 0.7490196078, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0.5215686275, blue: 0.7921568627, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0.5215686275, blue: 0.7921568627, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0.5215686275, blue: 0.7921568627, alpha: 1)
            label.textColor = #colorLiteral(red: 0.7490196078, green: 0.7529411765, blue: 0.7490196078, alpha: 1)
            label.text = "Carolina Panthers"
        }
        if passedData.sec == 6 && passedData.row == 3 {
            data = saintsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0.8274509804, green: 0.737254902, blue: 0.5529411765, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1215686275, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1215686275, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1215686275, alpha: 1)
            label.textColor = #colorLiteral(red: 0.8274509804, green: 0.737254902, blue: 0.5529411765, alpha: 1)
            label.text = "New Orleans Saints"
        }
        
        if passedData.sec == 7 && passedData.row == 0 {
            data = _49ersArray_2021()
            view1.backgroundColor = .black
            view2.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.6, blue: 0.3647058824, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.6, blue: 0.3647058824, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.6, blue: 0.3647058824, alpha: 1)
            label.textColor = .white
            label.text = "San Francisco 49ers"
        }
        if passedData.sec == 7 && passedData.row == 1 {
            data = cardinalsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.textColor = .white
            label.text = "Arizona Cardinals"
        }
        if passedData.sec == 7 && passedData.row == 2 {
            data = ramsArray_2021()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.5254901961, green: 0.4274509804, blue: 0.2941176471, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.5254901961, green: 0.4274509804, blue: 0.2941176471, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.5254901961, green: 0.4274509804, blue: 0.2941176471, alpha: 1)
            label.textColor = .white
            label.text = "Los Angeles Rams"
        }
        if passedData.sec == 7 && passedData.row == 3 {
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

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTeamData()
    }
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var table: UITableView!
    @IBOutlet var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    
}
