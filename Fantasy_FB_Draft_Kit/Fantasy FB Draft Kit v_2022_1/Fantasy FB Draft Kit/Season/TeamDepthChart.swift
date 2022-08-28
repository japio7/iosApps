//
//  TeamDepthChart.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 6/20/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import UIKit

class TeamDepthChart: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var passedData = RowSelected()
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if passedData.year == 0 {
            Database_2020.shared.loadTeamData(sec: passedData.sec!, row: passedData.row!, view1: view1, view2: view2, label: label, table: table)
        } else if passedData.year == 1 {
            Database_2021.shared.loadTeamData(sec: passedData.sec!, row: passedData.row!, view1: view1, view2: view2, label: label, table: table)
        } else if passedData.year == 2 {
            Database_2022.shared.loadTeamData(sec: passedData.sec!, row: passedData.row!, view1: view1, view2: view2, label: label, table: table)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if passedData.year == 0 {
            return Database_2020.shared.data.count
        } else if passedData.year == 1 {
            return Database_2021.shared.data.count
        } else if passedData.year == 2 {
            return Database_2022.shared.data.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "my cell") as! CustomCell
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
        var playerData : [Cell] = []
        if passedData.year == 0 {
            playerData = Database_2020.shared.data
        } else if passedData.year == 1 {
            playerData = Database_2021.shared.data
        } else if passedData.year == 2 {
            playerData = Database_2022.shared.data
        }
        if passedData.sec == 0 && passedData.row == 0 {
            cell.setPositionFontWhite(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.2, blue: 0.5529411765, alpha: 1)
        } else if passedData.sec == 0 && passedData.row == 1 {
            cell.setPosition(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.5568627451, blue: 0.5921568627, alpha: 1)
        } else if passedData.sec == 0 && passedData.row == 2 {
            cell.setPosition(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.3411764706, blue: 0.2509803922, alpha: 1)
        } else if passedData.sec == 0 && passedData.row == 3 {
            cell.setPositionFontBluePatriots(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
        } else if passedData.sec == 1 && passedData.row == 0 {
            cell.setPosition(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
        } else if passedData.sec == 1 && passedData.row == 1 {
            cell.setPositionFontWhite(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 1, green: 0.2352941176, blue: 0, alpha: 1)
        } else if passedData.sec == 1 && passedData.row == 2 {
            cell.setPositionFontGoldRavens(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        } else if passedData.sec == 1 && passedData.row == 3 {
            cell.setPositionFontYellowSteelers(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        } else if passedData.sec == 2 && passedData.row == 0 {
            cell.setPositionFontWhite(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.1725490196, blue: 0.3725490196, alpha: 1)
        } else if passedData.sec == 2 && passedData.row == 1 {
            cell.setPositionFontWhite(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.4039215686, blue: 0.4705882353, alpha: 1)
        } else if passedData.sec == 2 && passedData.row == 2 {
            cell.setPositionFontWhite(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0.01176470588, green: 0.1254901961, blue: 0.1843137255, alpha: 1)
        } else if passedData.sec == 2 && passedData.row == 3 {
            cell.setPositionFontBlueTitans(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.5607843137, blue: 0.8705882353, alpha: 1)
        } else if passedData.sec == 3 && passedData.row == 0 {
            cell.setPositionFontOrangeBroncos(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
        } else if passedData.sec == 3 && passedData.row == 1 {
            cell.setPositionFontGoldChargers(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.1647058824, blue: 0.368627451, alpha: 1)
        } else if passedData.sec == 3 && passedData.row == 2 {
            cell.setPosition(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.09411764706, blue: 0.2156862745, alpha: 1)
        } else if passedData.sec == 3 && passedData.row == 3 {
            cell.setPosition(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
        } else if passedData.sec == 4 && passedData.row == 0 {
            cell.setPositionFontWhite(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
        } else if passedData.sec == 4 && passedData.row == 1 {
            cell.setPositionFontSilverEagles(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.2980392157, blue: 0.3294117647, alpha: 1)
        } else if passedData.sec == 4 && passedData.row == 2 {
            cell.setPositionFontBlueGiants(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0.6078431373, green: 0.631372549, blue: 0.6352941176, alpha: 1)
        } else if passedData.sec == 4 && passedData.row == 3 {
            cell.setPositionFontGoldRedskins(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0.2470588235, green: 0.06274509804, blue: 0.06274509804, alpha: 1)
        } else if passedData.sec == 5 && passedData.row == 0 {
            cell.setPositionFontOrangeBears(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0.0431372549, green: 0.0862745098, blue: 0.1647058824, alpha: 1)
        } else if passedData.sec == 5 && passedData.row == 1 {
            cell.setPositionFontWhite(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.462745098, blue: 0.7137254902, alpha: 1)
        } else if passedData.sec == 5 && passedData.row == 2 {
            cell.setPositionFontGoldPackers(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0.09411764706, green: 0.1882352941, blue: 0.1568627451, alpha: 1)
        } else if passedData.sec == 5 && passedData.row == 3 {
            cell.setPositionFontGoldVikings(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0.3098039216, green: 0.1490196078, blue: 0.5137254902, alpha: 1)
        } else if passedData.sec == 6 && passedData.row == 0 {
            cell.setPositionFontGreyBuccaneers(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0.8352941176, green: 0.03921568627, blue: 0.03921568627, alpha: 1)
        } else if passedData.sec == 6 && passedData.row == 1 {
            cell.setPositionFontSilverFalcons(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        } else if passedData.sec == 6 && passedData.row == 2 {
            cell.setPositionFontSilverPanthers(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
        } else if passedData.sec == 6 && passedData.row == 3 {
            cell.setPositionFontBlackSaints(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0.8274509804, green: 0.737254902, blue: 0.5529411765, alpha: 1)
        } else if passedData.sec == 7 && passedData.row == 0 {
            cell.setPositionFontWhite(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0.6666666667, green: 0, blue: 0, alpha: 1)
        } else if passedData.sec == 7 && passedData.row == 1 {
            cell.setPositionFontWhite(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0.5921568627, green: 0.137254902, blue: 0.2470588235, alpha: 1)
        } else if passedData.sec == 7 && passedData.row == 2 {
            cell.setPositionFontWhite(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
        } else if passedData.sec == 7 && passedData.row == 3 {
            cell.setPositionFontGraySeahawks(playerPosition: playerData[indexPath.row])
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
        }
        return cell
    }
}
