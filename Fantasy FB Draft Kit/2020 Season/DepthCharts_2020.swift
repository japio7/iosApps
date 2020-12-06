//
//  DepthCharts_2020.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 6/19/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import UIKit

class DepthCharts_2020: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedSection: Int = 0
    var selectedRow: Int = 0
    
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
        ["Dallas Cowboys", "Philadelphia Eagles", "New York Giants", "Washington Redskins"],
        //NFC North
        ["Chicago Bears", "Detroit Lions", "Green Bay Packers", "Minnesota Vikings"],
        //NFC South
        ["Tampa Bay Buccaneers", "Atlanta Falcons", "Carolina Panthers", "New Orleans Saints"],
        //NFC West
        ["San Francisco 49ers", "Arizona Cardinals", "Los Angeles Rams", "Seattle Seahawks"]
    ]
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel!.font = UIFont.boldSystemFont(ofSize: 28)
            header.textLabel?.backgroundColor = .systemGroupedBackground
            header.backgroundView?.backgroundColor = .systemGroupedBackground
            header.textLabel?.adjustsFontSizeToFitWidth = true
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return depthChartTeamDivision[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return depthChartTeams[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return depthChartTeams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        cell.textLabel?.text = depthChartTeams[indexPath.section][indexPath.row]
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        
        if indexPath.section == 0 && indexPath.row == 0 {
            cell.backgroundColor = #colorLiteral(red: 0.7764705882, green: 0.04705882353, blue: 0.1882352941, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0.01938016217, green: 0.2123703163, blue: 0.5529411765, alpha: 1)
        }
        if indexPath.section == 0 && indexPath.row == 1 {
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.5568627451, blue: 0.5921568627, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0.9882352941, green: 0.2980392157, blue: 0.007843137255, alpha: 1)
        }
        if indexPath.section == 0 && indexPath.row == 2 {
            cell.backgroundColor = #colorLiteral(red: 0.07058823529, green: 0.3411764706, blue: 0.2509803922, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
        if indexPath.section == 0 && indexPath.row == 3 {
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
        }
        if indexPath.section == 1 && indexPath.row == 0 {
            cell.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        if indexPath.section == 1 && indexPath.row == 1 {
            cell.backgroundColor = #colorLiteral(red: 0.1921568627, green: 0.1137254902, blue: 0, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 1, green: 0.2352941176, blue: 0, alpha: 1)
        }
        if indexPath.section == 1 && indexPath.row == 2 {
            cell.backgroundColor = #colorLiteral(red: 0.1019607843, green: 0.09803921569, blue: 0.3725490196, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0.6196078431, green: 0.4862745098, blue: 0.04705882353, alpha: 1)
        }
        if indexPath.section == 1 && indexPath.row == 3 {
            cell.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
        }
        if indexPath.section == 2 && indexPath.row == 0 {
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.1725490196, blue: 0.3725490196, alpha: 1)
            cell.textLabel?.textColor = .white
        }
        if indexPath.section == 2 && indexPath.row == 1 {
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.4039215686, blue: 0.4705882353, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0.6235294118, green: 0.4745098039, blue: 0.1725490196, alpha: 1)
        }
        if indexPath.section == 2 && indexPath.row == 2 {
            cell.backgroundColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0.01176470588, green: 0.1254901961, blue: 0.1843137255, alpha: 1)
        }
        if indexPath.section == 2 && indexPath.row == 3 {
            cell.backgroundColor = #colorLiteral(red: 0.2549019608, green: 0.5607843137, blue: 0.8705882353, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0.7843137255, green: 0.06274509804, blue: 0.1803921569, alpha: 1)
        }
        if indexPath.section == 3 && indexPath.row == 0 {
            cell.backgroundColor = #colorLiteral(red: 0.9843137255, green: 0.3098039216, blue: 0.07843137255, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
        }
        if indexPath.section == 3 && indexPath.row == 1 {
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.5019607843, blue: 0.7764705882, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 1, green: 0.7607843137, blue: 0.05490196078, alpha: 1)
        }
        if indexPath.section == 3 && indexPath.row == 2 {
            cell.backgroundColor = #colorLiteral(red: 0.8901960784, green: 0.09411764706, blue: 0.2156862745, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
        }
        if indexPath.section == 3 && indexPath.row == 3 {
            cell.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            cell.textLabel?.textColor = .black
        }
        if indexPath.section == 4 && indexPath.row == 0 {
            cell.backgroundColor = #colorLiteral(red: 0.4980392157, green: 0.5882352941, blue: 0.5843137255, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
        }
        if indexPath.section == 4 && indexPath.row == 1 {
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.2980392157, blue: 0.3294117647, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        if indexPath.section == 4 && indexPath.row == 2 {
            cell.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0.137254902, blue: 0.3215686275, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0.6392156863, green: 0.05098039216, blue: 0.1764705882, alpha: 1)
        }
        if indexPath.section == 4 && indexPath.row == 3 {
            cell.backgroundColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.07058823529, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0.2470588235, green: 0.06274509804, blue: 0.06274509804, alpha: 1)
        }
        if indexPath.section == 5 && indexPath.row == 0 {
            cell.backgroundColor = #colorLiteral(red: 0.0431372549, green: 0.0862745098, blue: 0.1647058824, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0.7843137255, green: 0.2196078431, blue: 0.01176470588, alpha: 1)
        }
        if indexPath.section == 5 && indexPath.row == 1 {
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.462745098, blue: 0.7137254902, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0.6901960784, green: 0.7176470588, blue: 0.737254902, alpha: 1)
        }
        if indexPath.section == 5 && indexPath.row == 2 {
            cell.backgroundColor = #colorLiteral(red: 1, green: 0.7215686275, blue: 0.1098039216, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0.09411764706, green: 0.1882352941, blue: 0.1568627451, alpha: 1)
        }
        if indexPath.section == 5 && indexPath.row == 3 {
            cell.backgroundColor = #colorLiteral(red: 0.3098039216, green: 0.1490196078, blue: 0.5137254902, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 1, green: 0.7764705882, blue: 0.1843137255, alpha: 1)
        }
        if indexPath.section == 6 && indexPath.row == 0 {
            cell.backgroundColor = #colorLiteral(red: 0.8352941176, green: 0.03921568627, blue: 0.03921568627, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0.2039215686, green: 0.1882352941, blue: 0.168627451, alpha: 1)
        }
        if indexPath.section == 6 && indexPath.row == 1 {
            cell.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0.6549019608, green: 0.09803921569, blue: 0.1882352941, alpha: 1)
        }
        if indexPath.section == 6 && indexPath.row == 2 {
            cell.backgroundColor = #colorLiteral(red: 0, green: 0.5215686275, blue: 0.7921568627, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1254901961, alpha: 1)
        }
        if indexPath.section == 6 && indexPath.row == 3 {
            cell.backgroundColor = #colorLiteral(red: 0.8274509804, green: 0.737254902, blue: 0.5529411765, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0.06274509804, green: 0.09411764706, blue: 0.1215686275, alpha: 1)
        }
        if indexPath.section == 7 && indexPath.row == 0 {
            cell.backgroundColor = #colorLiteral(red: 0.6784313725, green: 0.6, blue: 0.3647058824, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0.6666666667, green: 0, blue: 0, alpha: 1)
        }
        if indexPath.section == 7 && indexPath.row == 1 {
            cell.backgroundColor = #colorLiteral(red: 0.5921568627, green: 0.137254902, blue: 0.2470588235, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
        if indexPath.section == 7 && indexPath.row == 2 {
            cell.backgroundColor = #colorLiteral(red: 0.5254901961, green: 0.4274509804, blue: 0.2941176471, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
        }
        if indexPath.section == 7 && indexPath.row == 3 {
            cell.backgroundColor = #colorLiteral(red: 0.6470588235, green: 0.6745098039, blue: 0.6862745098, alpha: 1)
            cell.textLabel?.textColor = #colorLiteral(red: 0, green: 0.1333333333, blue: 0.2666666667, alpha: 1)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
        selectedSection = indexPath.section
        selectedRow = indexPath.row
        performSegue(withIdentifier: "TeamDepthChart_2020", sender: self)
//        if indexPath.section == 0 && indexPath.row == 0 {
//            performSegue(withIdentifier: "BuffaloBills_2020", sender: self)
//        }
//        else if indexPath.section == 0 && indexPath.row == 1 {
//            performSegue(withIdentifier: "MiamiDolphins_2020", sender: self)
//        }
//        else if indexPath.section == 0 && indexPath.row == 2 {
//            performSegue(withIdentifier: "NewYorkJets_2020", sender: self)
//        }
//        else if indexPath.section == 0 && indexPath.row == 3 {
//            performSegue(withIdentifier: "NewEnglandPatriots_2020", sender: self)
//        }
//        else if indexPath.section == 1 && indexPath.row == 0 {
//            performSegue(withIdentifier: "CincinattiBengals_2020", sender: self)
//        }
//        else if indexPath.section == 1 && indexPath.row == 1 {
//            performSegue(withIdentifier: "ClevelandBrowns_2020", sender: self)
//        }
//        else if indexPath.section == 1 && indexPath.row == 2 {
//            performSegue(withIdentifier: "BaltimoreRavens_2020", sender: self)
//        }
//        else if indexPath.section == 1 && indexPath.row == 3 {
//            performSegue(withIdentifier: "PittsburghSteelers_2020", sender: self)
//        }
//        else if indexPath.section == 2 && indexPath.row == 0 {
//            performSegue(withIdentifier: "IndianapolisColts_2020", sender: self)
//        }
//        else if indexPath.section == 2 && indexPath.row == 1 {
//            performSegue(withIdentifier: "JacksonvilleJaguars_2020", sender: self)
//        }
//        else if indexPath.section == 2 && indexPath.row == 2 {
//            performSegue(withIdentifier: "HoustonTexans_2020", sender: self)
//        }
//        else if indexPath.section == 2 && indexPath.row == 3 {
//            performSegue(withIdentifier: "TennesseeTitans_2020", sender: self)
//        }
//        else if indexPath.section == 3 && indexPath.row == 0 {
//            performSegue(withIdentifier: "DenverBroncos_2020", sender: self)
//        }
//        else if indexPath.section == 3 && indexPath.row == 1 {
//            performSegue(withIdentifier: "LosAngelesChargers_2020", sender: self)
//        }
//        else if indexPath.section == 3 && indexPath.row == 2 {
//            performSegue(withIdentifier: "KansasCityChiefs_2020", sender: self)
//        }
//        else if indexPath.section == 3 && indexPath.row == 3 {
//            performSegue(withIdentifier: "LasVegasRaiders_2020", sender: self)
//        }
//        else if indexPath.section == 4 && indexPath.row == 0 {
//            performSegue(withIdentifier: "DallasCowboys_2020", sender: self)
//        }
//        else if indexPath.section == 4 && indexPath.row == 1 {
//            performSegue(withIdentifier: "PhiladelphiaEagles_2020", sender: self)
//        }
//        else if indexPath.section == 4 && indexPath.row == 2 {
//            performSegue(withIdentifier: "NewYorkGiants_2020", sender: self)
//        }
//        else if indexPath.section == 4 && indexPath.row == 3 {
//            performSegue(withIdentifier: "WashingtonRedskins_2020", sender: self)
//        }
//        else if indexPath.section == 5 && indexPath.row == 0 {
//            performSegue(withIdentifier: "ChicagoBears_2020", sender: self)
//        }
//        else if indexPath.section == 5 && indexPath.row == 1 {
//            performSegue(withIdentifier: "DetroitLions_2020", sender: self)
//        }
//        else if indexPath.section == 5 && indexPath.row == 2 {
//            performSegue(withIdentifier: "GreenBayPackers_2020", sender: self)
//        }
//        else if indexPath.section == 5 && indexPath.row == 3 {
//            performSegue(withIdentifier: "MinnesotaVikings_2020", sender: self)
//        }
//        else if indexPath.section == 6 && indexPath.row == 0 {
//            performSegue(withIdentifier: "TampaBayBuccaneers_2020", sender: self)
//        }
//        else if indexPath.section == 6 && indexPath.row == 1 {
//            performSegue(withIdentifier: "AtlantaFalcons_2020", sender: self)
//        }
//        else if indexPath.section == 6 && indexPath.row == 2 {
//            performSegue(withIdentifier: "CarolinaPanthers_2020", sender: self)
//        }
//        else if indexPath.section == 6 && indexPath.row == 3 {
//            performSegue(withIdentifier: "NewOrleansSaints_2020", sender: self)
//        }
//        else if indexPath.section == 7 && indexPath.row == 0 {
//            performSegue(withIdentifier: "SanFrancisco49ers_2020", sender: self)
//        }
//        else if indexPath.section == 7 && indexPath.row == 1 {
//            performSegue(withIdentifier: "ArizonaCardinals_2020", sender: self)
//        }
//        else if indexPath.section == 7 && indexPath.row == 2 {
//            performSegue(withIdentifier: "LosAngelesRams_2020", sender: self)
//        }
//        else if indexPath.section == 7 && indexPath.row == 3 {
//            performSegue(withIdentifier: "SeattleSeahawks_2020", sender: self)
//        }
//        else {
//            return
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TeamDepthChart_2020" {
            if let destVC = segue.destination as? TeamDepthChart_2020 {
                var valueToPass = RowSelected()
                let section_selected = selectedSection
                let row_selected = selectedRow
                valueToPass.row = row_selected
                valueToPass.sec = section_selected
                destVC.passedData = valueToPass
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var label: UILabel!
    
}
