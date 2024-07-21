//
//  PreviousSeasons.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 8/6/22.
//  Copyright © 2022 Jared Pino. All rights reserved.
//

import UIKit

class PreviousSeasons: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var dataToPass = RowSelected()
    var year = ""
    var row = 0
    
    var seasons: [String] = ["2020", "2021", "2022", "2023"]
    var components: [String] = ["My Leagues", "Draft Rankings"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView.isEqual(seasons_table) {
            return seasons.count
        }
        if tableView.isEqual(components_table) {
            return components.count
        }
        return seasons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = seasons_table.dequeueReusableCell(withIdentifier: "cell seasons", for: indexPath as IndexPath)
        if tableView.isEqual(seasons_table) {
            cell.textLabel?.text = seasons[indexPath.row]
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.font = UIFont.systemFont(ofSize: 25)
        }
        if tableView.isEqual(components_table) {
            cell = components_table.dequeueReusableCell(withIdentifier: "cell components", for: indexPath as IndexPath)
            cell.textLabel?.text = components[indexPath.row]
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.font = UIFont.systemFont(ofSize: 25)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.isEqual(seasons_table) {
            year = seasons[indexPath.row]
            dataToPass.year = Int(year)
            lblYear.text = year
            tableView.deselectRow(at: indexPath, animated: true)
            }
        if tableView.isEqual(components_table) {
            row = indexPath.row
            if year == "" {
                tableView.deselectRow(at: indexPath, animated: true)
                return
            } else {
                if row == 0 {
                    tableView.deselectRow(at: indexPath, animated: true)
                    performSegue(withIdentifier: "my leagues", sender: self)
                } else if row == 1 {
                    tableView.deselectRow(at: indexPath, animated: true)
                    performSegue(withIdentifier: "draft", sender: self)
                } else {
                    tableView.deselectRow(at: indexPath, animated: true)
                    return
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var valueToPass = RowSelected()
        if segue.identifier == "draft" {
            if let destVC = segue.destination as? Draft {
                let row_selected = row
                valueToPass.row = row_selected
                valueToPass.year = Int(year)
                destVC.passedData = valueToPass
            }
        }
        if segue.identifier == "my leagues" {
            if let destVC = segue.destination as? PreviousSeasons_MyLeagues {
                let row_selected = row
                valueToPass.row = row_selected
                valueToPass.year = Int(year)
                destVC.passedData = valueToPass
            }
        }
    }
    
    @IBOutlet weak var seasons_table: UITableView!
    
    @IBOutlet weak var components_table: UITableView!
    @IBOutlet weak var lblYear: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        year = seasons[0]
        dataToPass.year = Int(year)
        lblYear.text = year
    }
    
}
