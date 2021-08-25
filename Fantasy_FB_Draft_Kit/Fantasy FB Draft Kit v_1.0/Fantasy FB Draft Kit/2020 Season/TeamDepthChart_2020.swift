//
//  TeamDepthChart_2020.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 6/20/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import UIKit

class TeamDepthChart_2020: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var passedData = RowSelected()
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var label: UILabel!
    
    var data: [Cell] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        loadTeamData()
    }
    
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
            data = billsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.01938016217, green: 0.2123703163, blue: 0.5529411765, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.04705882353, blue: 0.1882352941, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.04705882353, blue: 0.1882352941, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.04705882353, blue: 0.1882352941, alpha: 1)
            label.textColor = .black
            label.text = "Buffalo Bills"
        }
        if passedData.sec == 0 && passedData.row == 1 {
            data = dolphinsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0.3411764706, blue: 0.4705882353, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.2980392157, blue: 0.007843137255, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.2980392157, blue: 0.007843137255, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.9882352941, green: 0.2980392157, blue: 0.007843137255, alpha: 1)
            label.textColor = .black
            label.text = "Miami Dolphins"
        }
        if passedData.sec == 0 && passedData.row == 2 {
            data = jetsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.3411764706, blue: 0.2509803922, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            label.textColor = .black
            label.text = "New York Jets"
        }
        if passedData.sec == 0 && passedData.row == 3 {
            data = patriotsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.04705882353, blue: 0.1882352941, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            label.textColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
            label.text = "New England Patriots"
        }
        
        if passedData.sec == 1 && passedData.row == 0 {
            data = bengalsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.textColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            label.text = "Cincinatti Bengals"
        }
        if passedData.sec == 1 && passedData.row == 1 {
            data = brownsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 1, green: 0.2352941176, blue: 0, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.1137254902, blue: 0, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.1137254902, blue: 0, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.1137254902, blue: 0, alpha: 1)
            label.textColor = .white
            label.text = "Cleveland Browns"
        }
        if passedData.sec == 1 && passedData.row == 2 {
            data = ravensArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.09803921569, blue: 0.3725490196, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.09803921569, blue: 0.3725490196, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.09803921569, blue: 0.3725490196, alpha: 1)
            label.textColor = #colorLiteral(red: 0.6196078431, green: 0.4862745098, blue: 0.04705882353, alpha: 1)
            label.text = "Baltimore Ravens"
        }
        if passedData.sec == 1 && passedData.row == 3 {
            data = steelersArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.textColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.text = "Pittsburgh Steelers"
        }
        
        if passedData.sec == 2 && passedData.row == 0 {
            data = coltsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0.1725490196, blue: 0.3725490196, alpha: 1)
            view2.backgroundColor = .white
            label.backgroundColor = .white
            table.backgroundColor = .white
            label.textColor = #colorLiteral(red: 0, green: 0.1725490196, blue: 0.3725490196, alpha: 1)
            label.text = "Indianapolis Colts"
        }
        if passedData.sec == 2 && passedData.row == 1 {
            data = jaguarsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.6235294118, green: 0.4745098039, blue: 0.1725490196, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
            label.textColor = .white
            label.text = "Jacksonville Jaguars"
        }
        if passedData.sec == 2 && passedData.row == 2 {
            data = texansArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.1254901961, blue: 0.1843137255, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            label.textColor = .white
            label.text = "Houston Texans"
        }
        if passedData.sec == 2 && passedData.row == 3 {
            data = titansArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.5411764706, green: 0.5529411765, blue: 0.5607843137, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.06274509804, blue: 0.1803921569, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.06274509804, blue: 0.1803921569, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.06274509804, blue: 0.1803921569, alpha: 1)
            label.textColor = #colorLiteral(red: 0.04705882353, green: 0.137254902, blue: 0.2509803922, alpha: 1)
            label.text = "Tennessee Titans"
        }
        
        if passedData.sec == 3 && passedData.row == 0 {
            data = broncosArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            label.textColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            label.text = "Denver Broncos"
        }
        if passedData.sec == 3 && passedData.row == 1 {
            data = chargersArray_2020()
            view1.backgroundColor = #colorLiteral(red: 1, green: 0.7607843137, blue: 0.05490196078, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0.7764705882, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0.7764705882, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0.7764705882, alpha: 1)
            label.textColor = #colorLiteral(red: 1, green: 0.7607843137, blue: 0.05490196078, alpha: 1)
            label.text = "Los Angeles Chargers"
        }
        if passedData.sec == 3 && passedData.row == 2 {
            data = chiefsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.09411764706, blue: 0.2156862745, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            label.textColor = .black
            label.text = "Kansas City Chiefs"
        }
        if passedData.sec == 3 && passedData.row == 3 {
            data = raidersArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            view2.backgroundColor = .black
            label.backgroundColor = .black
            table.backgroundColor = .black
            label.textColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            label.text = "Las Vegas Raiders"
        }
        
        if passedData.sec == 4 && passedData.row == 0 {
            data = cowboysArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.4980392157, green: 0.5882352941, blue: 0.5843137255, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0.2078431373, blue: 0.5803921569, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0.2078431373, blue: 0.5803921569, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0.2078431373, blue: 0.5803921569, alpha: 1)
            label.textColor = .white
            label.text = "Dallas Cowboys"
        }
        if passedData.sec == 4 && passedData.row == 1 {
            data = eaglesArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.3725490196, green: 0.3764705882, blue: 0.3843137255, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.textColor = #colorLiteral(red: 0.7294117647, green: 0.7921568627, blue: 0.8274509804, alpha: 1)
            label.text = "Philadelphia Eagles"
        }
        if passedData.sec == 4 && passedData.row == 2 {
            data = giantsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.137254902, blue: 0.3215686275, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6392156863, green: 0.05098039216, blue: 0.1764705882, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6392156863, green: 0.05098039216, blue: 0.1764705882, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6392156863, green: 0.05098039216, blue: 0.1764705882, alpha: 1)
            label.textColor = #colorLiteral(red: 0.003921568627, green: 0.137254902, blue: 0.3215686275, alpha: 1)
            label.text = "New York Giants"
        }
        if passedData.sec == 4 && passedData.row == 3 {
            data = redskinsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.2470588235, green: 0.06274509804, blue: 0.06274509804, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            label.textColor = #colorLiteral(red: 0.2470588235, green: 0.06274509804, blue: 0.06274509804, alpha: 1)
            label.text = "Washington Redskins"
        }
        
        if passedData.sec == 5 && passedData.row == 0 {
            data = bearsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.0431372549, green: 0.0862745098, blue: 0.1647058824, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.2196078431, blue: 0.01176470588, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.2196078431, blue: 0.01176470588, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.7843137255, green: 0.2196078431, blue: 0.01176470588, alpha: 1)
            label.textColor = #colorLiteral(red: 0.0431372549, green: 0.0862745098, blue: 0.1647058824, alpha: 1)
            label.text = "Chicago Bears"
        }
        if passedData.sec == 5 && passedData.row == 1 {
            data = lionsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
            label.textColor = .white
            label.text = "Detroit Lions"
        }
        if passedData.sec == 5 && passedData.row == 2 {
            data = packersArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.1882352941, blue: 0.1568627451, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            label.textColor = #colorLiteral(red: 0.09411764706, green: 0.1882352941, blue: 0.1568627451, alpha: 1)
            label.text = "Green Bay Packers"
        }
        if passedData.sec == 5 && passedData.row == 3 {
            data = vikingsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.3098039216, green: 0.1490196078, blue: 0.5137254902, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 1, green: 0.7764705882, blue: 0.1843137255, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 1, green: 0.7764705882, blue: 0.1843137255, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 1, green: 0.7764705882, blue: 0.1843137255, alpha: 1)
            label.textColor = #colorLiteral(red: 0.3098039216, green: 0.1490196078, blue: 0.5137254902, alpha: 1)
            label.text = "Minnesota Vikings"
        }
        
        if passedData.sec == 6 && passedData.row == 0 {
            data = buccaneersArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.1882352941, blue: 0.168627451, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.03921568627, blue: 0.03137254902, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.03921568627, blue: 0.03137254902, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.03921568627, green: 0.03921568627, blue: 0.03137254902, alpha: 1)
            label.textColor = #colorLiteral(red: 0.6941176471, green: 0.7294117647, blue: 0.7490196078, alpha: 1)
            label.text = "Tampa Bay Buccaneers"
        }
        if passedData.sec == 6 && passedData.row == 1 {
            data = falconsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.text = "Atlanta Falcons"
        }
        if passedData.sec == 6 && passedData.row == 2 {
            data = panthersArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.7490196078, green: 0.7529411765, blue: 0.7490196078, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0.5215686275, blue: 0.7921568627, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0.5215686275, blue: 0.7921568627, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0.5215686275, blue: 0.7921568627, alpha: 1)
            label.textColor = #colorLiteral(red: 0.7490196078, green: 0.7529411765, blue: 0.7490196078, alpha: 1)
            label.text = "Carolina Panthers"
        }
        if passedData.sec == 6 && passedData.row == 3 {
            data = saintsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.8274509804, green: 0.737254902, blue: 0.5529411765, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1215686275, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1215686275, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1215686275, alpha: 1)
            label.textColor = #colorLiteral(red: 0.8274509804, green: 0.737254902, blue: 0.5529411765, alpha: 1)
            label.text = "New Orleans Saints"
        }
        
        if passedData.sec == 7 && passedData.row == 0 {
            data = _49ersArray_2020()
            view1.backgroundColor = .black
            view2.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.6, blue: 0.3647058824, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.6, blue: 0.3647058824, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.6, blue: 0.3647058824, alpha: 1)
            label.textColor = .white
            label.text = "San Francisco 49ers"
        }
        if passedData.sec == 7 && passedData.row == 1 {
            data = cardinalsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            label.textColor = .white
            label.text = "Arizona Cardinals"
        }
        if passedData.sec == 7 && passedData.row == 2 {
            data = ramsArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.5254901961, green: 0.4274509804, blue: 0.2941176471, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.5254901961, green: 0.4274509804, blue: 0.2941176471, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.5254901961, green: 0.4274509804, blue: 0.2941176471, alpha: 1)
            label.textColor = .white
            label.text = "Los Angeles Rams"
        }
        if passedData.sec == 7 && passedData.row == 3 {
            data = seahawksArray_2020()
            view1.backgroundColor = #colorLiteral(red: 0.4117647059, green: 0.7450980392, blue: 0.1568627451, alpha: 1)
            view2.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            label.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            table.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            label.textColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            label.text = "Seattle Seahawks"
        }
    }
    
    // AFC East
    func billsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Josh Allen")
        let qb2 = Cell(pos: "QB2", play: "Matt Barkley")
        let qb3 = Cell(pos: "QB3", play: "Jake Fromm", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Devin Singletary")
        let rb2 = Cell(pos: "RB2", play: "Zack Moss", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "T.J. Yeldon")
        let wr1 = Cell(pos: "WR1", play: "Stefon Diggs")
        let wr2 = Cell(pos: "WR2", play: "John Brown")
        let wr3 = Cell(pos: "WR3", play: "Cole Beasley")
        let wr4 = Cell(pos: "WR4", play: "D'haquille Williams")
        let te1 = Cell(pos: "TE1", play: "Dawson Knox")
        let te2 = Cell(pos: "TE2", play: "Tyler Kroft")
        let k = Cell(pos: "K", play: "Stephen Hauschka")
        
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func dolphinsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Ryan Fitzpatrick")
        let qb2 = Cell(pos: "QB2", play: "Tua Tagovailoa", rookie: "R")
        let qb3 = Cell(pos: "QB3", play: "Josh Rosen")
        let rb1 = Cell(pos: "RB1", play: "Jordan Howard")
        let rb2 = Cell(pos: "RB2", play: "Matt Breida")
        let rb3 = Cell(pos: "RB3", play: "Kalen Ballage")
        let wr1 = Cell(pos: "WR1", play: "DeVante Parker")
        let wr2 = Cell(pos: "WR2", play: "Preston Williams")
        let wr3 = Cell(pos: "WR3", play: "Allen Hurns")
        let wr4 = Cell(pos: "WR4", play: "Albert Wilson")
        let te1 = Cell(pos: "TE1", play: "Mike Gesicki")
        let te2 = Cell(pos: "TE2", play: "Durham Smythe")
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func jetsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Sam Darnold")
        let qb2 = Cell(pos: "QB2", play: "Joe Flacco")
        let qb3 = Cell(pos: "QB3", play: "Trevor Siemian")
        let rb1 = Cell(pos: "RB1", play: "Le'Veon Bell")
        let rb2 = Cell(pos: "RB2", play: "Frank Gore")
        let rb3 = Cell(pos: "RB3", play: "Kenneth Dixon")
        let wr1 = Cell(pos: "WR1", play: "Jamison Crowder")
        let wr2 = Cell(pos: "WR2", play: "Breshad Perriman")
        let wr3 = Cell(pos: "WR3", play: "Denzel Mims", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Josh Doctson")
        let te1 = Cell(pos: "TE1", play: "Chris Herndon")
        let te2 = Cell(pos: "TE2", play: "Ryan Griffin")
        let k = Cell(pos: "K", play: "Sam Ficken")
        
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func patriotsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Jarrett Stidham")
        let qb2 = Cell(pos: "QB2", play: "Brian Hoyer")
        let rb1 = Cell(pos: "RB1", play: "Sony Michel")
        let rb2 = Cell(pos: "RB2", play: "James White")
        let rb3 = Cell(pos: "RB3", play: "Rex Burkhead")
        let wr1 = Cell(pos: "WR1", play: "Julian Edelman")
        let wr2 = Cell(pos: "WR2", play: "N'keal Harry")
        let wr3 = Cell(pos: "WR3", play: "Mohamed Sanu Sr.")
        let wr4 = Cell(pos: "WR4", play: "Jakobi Meyers")
        let te1 = Cell(pos: "TE1", play: "Matt LaCosse")
        let te2 = Cell(pos: "TE2", play: "Ryan Izzo")
        let k = Cell(pos: "K", play: "Justin Rohrwasser", rookie: "R")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // AFC North
    func bengalsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Joe Burrow", rookie: "R")
        let qb2 = Cell(pos: "QB2", play: "Ryan Finley")
        let rb1 = Cell(pos: "RB1", play: "Joe Mixon")
        let rb2 = Cell(pos: "RB2", play: "Giovani Bernard")
        let rb3 = Cell(pos: "RB3", play: "Trayveon Williams")
        let wr1 = Cell(pos: "WR1", play: "A.J. Green")
        let wr2 = Cell(pos: "WR2", play: "Tyler Boyd")
        let wr3 = Cell(pos: "WR3", play: "Tee Higgins", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "John Ross")
        let te1 = Cell(pos: "TE1", play: "C.J. Uzomah")
        let te2 = Cell(pos: "TE2", play: "Drew Sample")
        let k = Cell(pos: "K", play: "Randy Bullock")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func brownsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Baker Mayfield")
        let qb2 = Cell(pos: "QB2", play: "Garrett Gilbert")
        let rb1 = Cell(pos: "RB1", play: "Nick Chub")
        let rb2 = Cell(pos: "RB2", play: "Kareem Hunt")
        let rb3 = Cell(pos: "RB3", play: "D'Ernest Johnson")
        let rb4 = Cell(pos: "RB4", play: "Dontrell Hilliard")
        let wr1 = Cell(pos: "WR1", play: "Odell Beckham Jr.")
        let wr2 = Cell(pos: "WR2", play: "Jarvis Landry")
        let wr3 = Cell(pos: "WR3", play: "Rashard Higgins")
        let wr4 = Cell(pos: "WR4", play: "Taywan Taylor")
        let te1 = Cell(pos: "TE1", play: "Austin Hooper")
        let te2 = Cell(pos: "TE2", play: "David Njoku")
        let k = Cell(pos: "K", play: "Austin Seibert")
        
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func ravensArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Lamar Jackson")
        let qb2 = Cell(pos: "QB2", play: "Robert Griffin III")
        let rb1 = Cell(pos: "RB1", play: "Mark Ingram ll")
        let rb2 = Cell(pos: "RB2", play: "J.K. Dobbins", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "Gus Edwards")
        let wr1 = Cell(pos: "WR1", play: "Marquise Brown")
        let wr2 = Cell(pos: "WR2", play: "Willie Snead lV")
        let wr3 = Cell(pos: "WR3", play: "Miles Boykin")
        let wr4 = Cell(pos: "WR4", play: "Devin Duvernay", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Mark Andrews")
        let te2 = Cell(pos: "TE2", play: "Nick Boyle")
        let k = Cell(pos: "K", play: "Justin Tucker")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func steelersArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Ben Roethlisberger")
        let qb2 = Cell(pos: "QB2", play: "Mason Rudolph")
        let rb1 = Cell(pos: "RB1", play: "James Conner")
        let rb2 = Cell(pos: "RB2", play: "Jaylen Samuels")
        let rb3 = Cell(pos: "RB3", play: "Anthony McFarland Jr.", rookie: "R")
        let rb4 = Cell(pos: "RB4", play: "Benny Snell Jr.")
        let wr1 = Cell(pos: "WR1", play: "JuJu Smith-Schuster")
        let wr2 = Cell(pos: "WR2", play: "Diontae Johnson")
        let wr3 = Cell(pos: "WR3", play: "James Washington")
        let wr4 = Cell(pos: "WR4", play: "Chase Claypool", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Eric Ebron")
        let te2 = Cell(pos: "TE2", play: "Vance McDonald")
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // AFC South
    func coltsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Philip Rivers")
        let qb2 = Cell(pos: "QB2", play: "Jacoby Brissett")
        let qb3 = Cell(pos: "QB3", play: "Jacob Eason", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Marlon Mack")
        let rb2 = Cell(pos: "RB2", play: "Jonathan Taylor", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "Nyheim Hines")
        let rb4 = Cell(pos: "RB4", play: "Jordan Wilkins")
        let wr1 = Cell(pos: "WR1", play: "T.Y. Hilton")
        let wr2 = Cell(pos: "WR2", play: "Zach Pascal")
        let wr3 = Cell(pos: "WR3", play: "Parris Campbell")
        let wr4 = Cell(pos: "WR4", play: "Michael Pittman Jr.", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Jack Doyle")
        let te2 = Cell(pos: "TE2", play: "Trey Burton")
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func jaguarsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Gardner Minshew II")
        let qb2 = Cell(pos: "QB2", play: "Mike Glennon")
        let qb3 = Cell(pos: "QB3", play: "Jake Luton", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Leonard Fournette")
        let rb2 = Cell(pos: "RB2", play: "Ryquell Armstead")
        let rb3 = Cell(pos: "RB3", play: "Chris Thompson")
        let wr1 = Cell(pos: "WR1", play: "DJ Chark Jr.")
        let wr2 = Cell(pos: "WR2", play: "Dede Westbrook")
        let wr3 = Cell(pos: "WR3", play: "Laviska Shenault Jr.", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Chris Conley")
        let te1 = Cell(pos: "TE1", play: "Tyler Eifert")
        let te2 = Cell(pos: "TE2", play: "Josh Oliver")
        let k = Cell(pos: "K", play: "Josh Lambo")
        
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func texansArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Deshaun Watson")
        let qb2 = Cell(pos: "QB2", play: "AJ McCarron")
        let rb1 = Cell(pos: "RB1", play: "David Johnson")
        let rb2 = Cell(pos: "RB2", play: "Duke Johnson Jr.")
        let rb3 = Cell(pos: "RB3", play: "Gregory Howell Jr.")
        let wr1 = Cell(pos: "WR1", play: "Will Fuller V")
        let wr2 = Cell(pos: "WR2", play: "Brandin Cooks")
        let wr3 = Cell(pos: "WR3", play: "Kenny Stills")
        let wr4 = Cell(pos: "WR4", play: "Randall Cobb")
        let te1 = Cell(pos: "TE1", play: "Darren Fells")
        let te2 = Cell(pos: "TE2", play: "Jordan Akins")
        let k = Cell(pos: "K", play: "Ka'imi Fairbairn")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func titansArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Ryan Tannehill")
        let qb2 = Cell(pos: "QB2", play: "Logan Woodside")
        let qb3 = Cell(pos: "QB3", play: "Cole McDonald", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Derrick Henry")
        let rb2 = Cell(pos: "RB2", play: "Darrynton Evans", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "David Fluellen")
        let wr1 = Cell(pos: "WR1", play: "A.J. Brown")
        let wr2 = Cell(pos: "WR2", play: "Adam Humphries")
        let wr3 = Cell(pos: "WR3", play: "Corey Davis")
        let wr4 = Cell(pos: "WR4", play: "Kalif Raymond")
        let te1 = Cell(pos: "TE1", play: "Jonnu Smith")
        let te2 = Cell(pos: "TE2", play: "Anthony Firkser")
        let k = Cell(pos: "K", play: "Greg Joseph")
        
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // AFC West
    func broncosArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Drew Lock")
        let qb2 = Cell(pos: "QB2", play: "Brandon Allen")
        let rb1 = Cell(pos: "RB1", play: "Melvin Gordon III")
        let rb2 = Cell(pos: "RB2", play: "Phillip Lindsay")
        let rb3 = Cell(pos: "RB3", play: "Royce Freeman")
        let wr1 = Cell(pos: "WR1", play: "Courtland Sutton")
        let wr2 = Cell(pos: "WR2", play: "Jerry Jeudy", rookie: "R")
        let wr3 = Cell(pos: "WR3", play: "DaeSean Hamilton")
        let wr4 = Cell(pos: "WR4", play: "KJ Hamler", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Noah Fant")
        let te2 = Cell(pos: "TE2", play: "Jeff Hauerman")
        let k = Cell(pos: "K", play: "Brandon McManus")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func chargersArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Tyrod Taylor")
        let qb2 = Cell(pos: "QB2", play: "Easton Stick")
        let qb3 = Cell(pos: "QB3", play: "Justin Herbert", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Austin Ekeler")
        let rb2 = Cell(pos: "RB2", play: "Justin Jackson")
        let rb3 = Cell(pos: "RB3", play: "Joshua Kelley", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Keenan Allen")
        let wr2 = Cell(pos: "WR2", play: "Mike Williams")
        let wr3 = Cell(pos: "WR3", play: "Andre Patton")
        let wr4 = Cell(pos: "WR4", play: "Joe Reed", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Hunter Henry")
        let te2 = Cell(pos: "TE2", play: "Virgil Green")
        let k = Cell(pos: "K", play: "Michael Badgley")
        
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func chiefsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Patrick Mahomes")
        let qb2 = Cell(pos: "QB2", play: "Chad Henne")
        let rb1 = Cell(pos: "RB1", play: "Damien Williams")
        let rb2 = Cell(pos: "RB2", play: "Clyde Edwards-Helaire", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "Darwin Thompson")
        let wr1 = Cell(pos: "WR1", play: "Tyreek Hill")
        let wr2 = Cell(pos: "WR2", play: "Sammy Watkins")
        let wr3 = Cell(pos: "WR3", play: "Mecole Hardman")
        let wr4 = Cell(pos: "WR4", play: "Byron Pringle")
        let te1 = Cell(pos: "TE1", play: "Travis Kelce")
        let te2 = Cell(pos: "TE2", play: "Deon Yelder")
        let k = Cell(pos: "K", play: "Harrison Butker")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func raidersArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Derek Carr")
        let qb2 = Cell(pos: "QB2", play: "Marcus Mariota")
        let rb1 = Cell(pos: "RB1", play: "Josh Jacobs")
        let rb2 = Cell(pos: "RB2", play: "Jalen Richard")
        let rb3 = Cell(pos: "RB3", play: "Lynn Bowden Jr.", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Tyrell Williams")
        let wr2 = Cell(pos: "WR2", play: "Henry Ruggs III", rookie: "R")
        let wr3 = Cell(pos: "WR3", play: "Hunter Renfrow")
        let wr4 = Cell(pos: "WR4", play: "Nelson Agholor")
        let te1 = Cell(pos: "TE1", play: "Darren Waller")
        let te2 = Cell(pos: "TE2", play: "Foster Moreau")
        let k = Cell(pos: "K", play: "Daniel Carlson")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // NFC East
    func cowboysArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Dak Prescott")
        let qb2 = Cell(pos: "QB2", play: "Andy Dalton")
        let qb3 = Cell(pos: "QB3", play: "Ben Dinucci", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Ezekiel Elliott")
        let rb2 = Cell(pos: "RB2", play: "Tony Pollard")
        let rb3 = Cell(pos: "RB3", play: "Jamize Olawale")
        let wr1 = Cell(pos: "WR1", play: "Amari Cooper")
        let wr2 = Cell(pos: "WR2", play: "Michael Gallup")
        let wr3 = Cell(pos: "WR3", play: "CeeCee Lamb", rookie: "R")
        let wr4 = Cell(pos: "WR4", play: "Devin Smith")
        let te1 = Cell(pos: "TE1", play: "Blake Jarwin")
        let te2 = Cell(pos: "TE2", play: "Dalton Schultz")
        let k = Cell(pos: "K", play: "Greg Zuerlein")
        
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func eaglesArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Carson Wentz")
        let qb2 = Cell(pos: "QB2", play: "Jalen Hurts", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Miles Sanders")
        let rb2 = Cell(pos: "RB2", play: "Boston Scott")
        let rb3 = Cell(pos: "RB3", play: "Elijah Holyfield")
        let wr1 = Cell(pos: "WR1", play: "Alshon Jeffery")
        let wr2 = Cell(pos: "WR2", play: "DeSean Jackson")
        let wr3 = Cell(pos: "WR3", play: "Marquise Goodwin")
        let wr4 = Cell(pos: "WR4", play: "Jalen Reagor", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Zach Ertz")
        let te2 = Cell(pos: "TE2", play: "Dallas Goedert")
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func giantsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Daniel Jones")
        let qb2 = Cell(pos: "QB2", play: "Cooper Rush")
        let rb1 = Cell(pos: "RB1", play: "Saquon Barkley")
        let rb2 = Cell(pos: "RB2", play: "Elijhaa Penny")
        let rb3 = Cell(pos: "RB3", play: "Wayne Gallman Jr.")
        let wr1 = Cell(pos: "WR1", play: "Sterling Shepard")
        let wr2 = Cell(pos: "WR2", play: "Golden Tate")
        let wr3 = Cell(pos: "WR3", play: "Darius Slayton")
        let wr4 = Cell(pos: "WR4", play: "Cody Core")
        let te1 = Cell(pos: "TE1", play: "Evan Engram")
        let te2 = Cell(pos: "TE2", play: "Kaden Smith")
        let k = Cell(pos: "K", play: "Aldrick Rosas")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func redskinsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Dwayne Haskins")
        let qb2 = Cell(pos: "QB2", play: "Kyle Allen")
        let rb1 = Cell(pos: "RB1", play: "Derrius Guice")
        let rb2 = Cell(pos: "RB2", play: "Adrian Peterson")
        let rb3 = Cell(pos: "RB3", play: "Peyton Barber")
        let wr1 = Cell(pos: "WR1", play: "Terry McLaurin")
        let wr2 = Cell(pos: "WR2", play: "Kelvin Harmon")
        let wr3 = Cell(pos: "WR3", play: "Trey Quinn")
        let wr4 = Cell(pos: "WR4", play: "Steven Sims Jr.")
        let te1 = Cell(pos: "TE1", play: "Jeremy Sprinkle")
        let te2 = Cell(pos: "TE2", play: "Thaddeus Moss")
        let k = Cell(pos: "K", play: "Dustin Hopkins")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // NFC North
    func bearsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Mitchell Trubisky")
        let qb2 = Cell(pos: "QB2", play: "Nick Foles")
        let rb1 = Cell(pos: "RB1", play: "David Montgomery")
        let rb2 = Cell(pos: "RB2", play: "Tarik Cohen")
        let rb3 = Cell(pos: "RB3", play: "Ryan Nall")
        let wr1 = Cell(pos: "WR1", play: "Allen Robinson II")
        let wr2 = Cell(pos: "WR2", play: "Anthony Miller")
        let wr3 = Cell(pos: "WR3", play: "Javon Wims")
        let wr4 = Cell(pos: "WR4", play: "Cordarrelle Patterson")
        let te1 = Cell(pos: "TE1", play: "Jimmy Graham")
        let te2 = Cell(pos: "TE2", play: "Cole Kmet", rookie: "R")
        let k = Cell(pos: "K", play: "Eddy Pineiro")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func lionsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Matthew Stafford")
        let qb2 = Cell(pos: "QB2", play: "Chase Daniel")
        let rb1 = Cell(pos: "RB1", play: "Kerryon Johnson")
        let rb2 = Cell(pos: "RB2", play: "D'Andre Swift", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "Jason Huntley", rookie: "R")
        let wr1 = Cell(pos: "WR1", play: "Kenny Golladay")
        let wr2 = Cell(pos: "WR2", play: "Marvin Jones Jr.")
        let wr3 = Cell(pos: "WR3", play: "Danny Amendola")
        let wr4 = Cell(pos: "WR4", play: "Geronimo Allison")
        let te1 = Cell(pos: "TE1", play: "T.J. Hockenson")
        let te2 = Cell(pos: "TE2", play: "Jesse James")
        let k = Cell(pos: "K", play: "Matt Prater")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func packersArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Aaron Rodgers")
        let qb2 = Cell(pos: "QB2", play: "Jordan Love", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Aaron Jones")
        let rb2 = Cell(pos: "RB2", play: "A.J. Dillon", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "Jamaal Williams")
        let wr1 = Cell(pos: "WR1", play: "Davante Adams")
        let wr2 = Cell(pos: "WR2", play: "Devin Funchess")
        let wr3 = Cell(pos: "WR3", play: "Alan Lazard")
        let wr4 = Cell(pos: "WR4", play: "Marquez Valdes-Scantling")
        let te1 = Cell(pos: "TE1", play: "Jace Sternberger")
        let te2 = Cell(pos: "TE2", play: "Marcedes Lewis")
        let k = Cell(pos: "K", play: "Mason Crosby")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func vikingsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Kirk Cousins")
        let qb2 = Cell(pos: "QB2", play: "Sean Mannion")
        let qb3 = Cell(pos: "QB3", play: "Nate Stanley", rookie: "R")
        let rb1 = Cell(pos: "RB1", play: "Dalvin Cook")
        let rb2 = Cell(pos: "RB2", play: "Alexander Mattison")
        let rb3 = Cell(pos: "RB3", play: "Mike Boone")
        let wr1 = Cell(pos: "WR1", play: "Adam Thielen")
        let wr2 = Cell(pos: "WR2", play: "Justin Jefferson", rookie: "R")
        let wr3 = Cell(pos: "WR3", play: "Bisi Johnson")
        let wr4 = Cell(pos: "WR4", play: "Tajae Sharpe")
        let te1 = Cell(pos: "TE1", play: "Kyle Rudolph")
        let te2 = Cell(pos: "TE2", play: "Irv Smith Jr.")
        let k = Cell(pos: "K", play: "Dan Bailey")
        
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // NFC South
    func buccaneersArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Tom Brady")
        let qb2 = Cell(pos: "QB2", play: "Blaine Gabbert")
        let rb1 = Cell(pos: "RB1", play: "Ronald Jones II")
        let rb2 = Cell(pos: "RB2", play: "Ke'Shawn Vaughn", rookie: "R")
        let rb3 = Cell(pos: "RB3", play: "Dare Ogunbowale")
        let wr1 = Cell(pos: "WR1", play: "Mike Evans")
        let wr2 = Cell(pos: "WR2", play: "Chris Godwin")
        let wr3 = Cell(pos: "WR3", play: "Scotty Miller")
        let wr4 = Cell(pos: "WR4", play: "Justin Watson")
        let te1 = Cell(pos: "TE1", play: "Rob Gronkowski")
        let te2 = Cell(pos: "TE2", play: "O.J. Howard")
        let k = Cell(pos: "K", play: "Matt Gay")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func falconsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Matt Ryan")
        let qb2 = Cell(pos: "QB2", play: "Matt Schaub")
        let rb1 = Cell(pos: "RB1", play: "Todd Gurley II")
        let rb2 = Cell(pos: "RB2", play: "Ito Smith")
        let rb3 = Cell(pos: "RB3", play: "Brian Hill")
        let wr1 = Cell(pos: "WR1", play: "Julio Jones")
        let wr2 = Cell(pos: "WR2", play: "Calvin Ridley")
        let wr3 = Cell(pos: "WR3", play: "Russell Gage")
        let wr4 = Cell(pos: "WR4", play: "Laquon Treadwell")
        let te1 = Cell(pos: "TE1", play: "Hayden Hurst")
        let te2 = Cell(pos: "TE2", play: "Khari Lee")
        let k = Cell(pos: "K", play: "Younghoe Koo")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func panthersArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Teddy Bridgewater")
        let qb2 = Cell(pos: "QB2", play: "Will Grier")
        let rb1 = Cell(pos: "RB1", play: "Christian McCaffrey")
        let rb2 = Cell(pos: "RB2", play: "Jordan Scarlett")
        let rb3 = Cell(pos: "RB3", play: "Reggie Bonnafon")
        let wr1 = Cell(pos: "WR1", play: "DJ Moore")
        let wr2 = Cell(pos: "WR2", play: "Robby Anderson")
        let wr3 = Cell(pos: "WR3", play: "Curtis Samuel")
        let wr4 = Cell(pos: "WR4", play: "Pharoh Cooper")
        let te1 = Cell(pos: "TE1", play: "Ian Thomas")
        let te2 = Cell(pos: "TE2", play: "Chris Manhertz")
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
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func saintsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Drew Brees")
        let qb2 = Cell(pos: "QB2", play: "Taysom Hill")
        let rb1 = Cell(pos: "RB1", play: "Alvin Kamara")
        let rb2 = Cell(pos: "RB2", play: "Latavius Murray")
        let rb3 = Cell(pos: "RB3", play: "Dwayne Washington")
        let wr1 = Cell(pos: "WR1", play: "Michael Thomas")
        let wr2 = Cell(pos: "WR2", play: "Emmanuel Sanders")
        let wr3 = Cell(pos: "WR3", play: "Tre'Quan Smith")
        let wr4 = Cell(pos: "WR4", play: "Deonte Harris")
        let te1 = Cell(pos: "TE1", play: "Jared Cook")
        let te2 = Cell(pos: "TE2", play: "Josh Hill")
        let k = Cell(pos: "K", play: "Wil Lutz")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    // NFC West
    func _49ersArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Jimmy Garoppolo")
        let qb2 = Cell(pos: "QB2", play: "Nick Mullens")
        let rb1 = Cell(pos: "RB1", play: "Raheem Mostert")
        let rb2 = Cell(pos: "RB2", play: "Tevin Coleman")
        let rb3 = Cell(pos: "RB3", play: "Jerick McKinnon")
        let wr1 = Cell(pos: "WR1", play: "Deebo Samuel")
        let wr2 = Cell(pos: "WR2", play: "Brandon Aiyuk", rookie: "R")
        let wr3 = Cell(pos: "WR3", play: "Kendrick Bourne")
        let wr4 = Cell(pos: "WR4", play: "Jalen Hurd")
        let te1 = Cell(pos: "TE1", play: "George Kittle")
        let te2 = Cell(pos: "TE2", play: "Ross Dwelley")
        let k = Cell(pos: "K", play: "Robbie Gould")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func cardinalsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Kyler Murray")
        let qb2 = Cell(pos: "QB2", play: "Brett Hundley")
        let rb1 = Cell(pos: "RB1", play: "Kenyan Drake")
        let rb2 = Cell(pos: "RB2", play: "Chase Edmonds")
        let rb3 = Cell(pos: "RB3", play: "D.J. Foster")
        let wr1 = Cell(pos: "WR1", play: "DeAndre Hopkins")
        let wr2 = Cell(pos: "WR2", play: "Christian Kirk")
        let wr3 = Cell(pos: "WR3", play: "Larry Fitzgerald")
        let wr4 = Cell(pos: "WR4", play: "KeeSean Johnson")
        let te1 = Cell(pos: "TE1", play: "Dan Arnold")
        let te2 = Cell(pos: "TE2", play: "Maxx Williams")
        let k = Cell(pos: "K", play: "Zane Gonzalez")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func ramsArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Jared Goff")
        let qb2 = Cell(pos: "QB2", play: "John Wolford")
        let rb1 = Cell(pos: "RB1", play: "Cam Akers", rookie: "R")
        let rb2 = Cell(pos: "RB2", play: "Malcolm Brown")
        let rb3 = Cell(pos: "RB3", play: "Darrell Henderson")
        let wr1 = Cell(pos: "WR1", play: "Cooper Kupp")
        let wr2 = Cell(pos: "WR2", play: "Robert Woods")
        let wr3 = Cell(pos: "WR3", play: "Josh Reynolds")
        let wr4 = Cell(pos: "WR4", play: "Van Jefferson", rookie: "R")
        let te1 = Cell(pos: "TE1", play: "Tyler Higbee")
        let te2 = Cell(pos: "TE2", play: "Gerald Everett")
        let k = Cell(pos: "K", play: "Sam Sloman")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
    
    func seahawksArray_2020() -> [Cell] {
        
        var positionPlayer: [Cell] = []
        
        let qb1 = Cell(pos: "QB1", play: "Russell Wilson")
        let qb2 = Cell(pos: "QB2", play: "Geno Smith")
        let rb1 = Cell(pos: "RB1", play: "Chris Carson")
        let rb2 = Cell(pos: "RB2", play: "Carlos Hyde")
        let rb3 = Cell(pos: "RB3", play: "Rashaad Penny")
        let wr1 = Cell(pos: "WR1", play: "Tyler Lockett")
        let wr2 = Cell(pos: "WR2", play: "DK Metcalf")
        let wr3 = Cell(pos: "WR3", play: "David Moore")
        let wr4 = Cell(pos: "WR4", play: "Phillip Dorsett II")
        let te1 = Cell(pos: "TE1", play: "Greg Olsen")
        let te2 = Cell(pos: "TE2", play: "Jacob Hollister")
        let k = Cell(pos: "K", play: "Jason Myers")
        
        positionPlayer.append(qb1)
        positionPlayer.append(qb2)
        positionPlayer.append(rb1)
        positionPlayer.append(rb2)
        positionPlayer.append(rb3)
        positionPlayer.append(wr1)
        positionPlayer.append(wr2)
        positionPlayer.append(wr3)
        positionPlayer.append(wr4)
        positionPlayer.append(te1)
        positionPlayer.append(te2)
        positionPlayer.append(k)
        
        return positionPlayer
    }
}
