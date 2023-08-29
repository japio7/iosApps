//
//  Season.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 6/18/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import UIKit

class Season: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var data: [[String]] = [["Overall Top 200", "Top 30 Rookies"], ["Top 30 Quarterbacks", "Top 80 Running Backs", "Top 80 Wide Receivers", "Top 30 Tight Ends", "Top 20 Defenses", "Top 15 Kickers"], ["Depth Charts"], ["My Leagues"], ["Reset Draft"]
    ]
    
    var passedData = RowSelected()
    var stringPassedData = SegueString()
    var selectedSection: Int = 0
    var selectedRow: Int = 0
    
    var roster = [String]()
    var draftOrder = [PlayerData]()
    var year = ""
    var resetMessage = ""
    
    func set_draft() {
        if passedData.year == 2023 {
            roster = Database_2023.shared.roster_array()
            draftOrder = Database_2023.shared.draftList()
        }
    }
    
    func reset_draft() {
        if passedData.year == 2023 {
            Database_2023.shared.resetDraft()
        }
        resetMessage = "The \(year) Draft has been reset!"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        label.text = year
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.font = UIFont.systemFont(ofSize: 25)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedSection = indexPath.section
        selectedRow = indexPath.row
        if selectedSection == 2 {
            performSegue(withIdentifier: "DepthCharts", sender: self)
        } else if selectedSection == 3 {
            performSegue(withIdentifier: "my leagues", sender: self)
        } else if selectedSection == 4 {
            set_draft()
            if draftOrder.count != 0 {
                let alert = UIAlertController(title: "Reset Draft", message: "Are you sure you want to reset the draft?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (NoAction) in
                    return
                }))
                alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (YesAction) in
                    self.reset_draft()
                    let okayAlert = UIAlertController(title: "Reset Draft", message: self.resetMessage, preferredStyle: .alert)
                    okayAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (OkayAction) in
                    }))
                    self.present(okayAlert, animated: true)
                    return
                }))
                self.present(alert, animated: true)
            } else {
                return
            }
        } else {
            performSegue(withIdentifier: "TopPlayers", sender: self)
        }
        table.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var valueToPass = RowSelected()
        if segue.identifier == "TopPlayers" {
            if let destVC = segue.destination as? TopPlayers {
                let section_selected = selectedSection
                let row_selected = selectedRow
                valueToPass.row = row_selected
                valueToPass.sec = section_selected
                valueToPass.year = passedData.year
                destVC.passedData = valueToPass
            }
        } else if segue.identifier == "MyTeam" {
            if let destVC = segue.destination as? MyTeam {
                valueToPass.year = passedData.year
                destVC.passedData = valueToPass
            }
        } else if segue.identifier == "DraftOrder" {
            if let destVC = segue.destination as? DraftOrder {
                valueToPass.year = passedData.year
                destVC.passedData = valueToPass
            }
        } else if segue.identifier == "my leagues" {
            if let destVC = segue.destination as? MyLeagues {
                valueToPass.year = passedData.year
                destVC.passedData = valueToPass
            }
        } else if segue.identifier == "AddLeague" {
            if let destVC = segue.destination as? AddLeague {
                valueToPass.year = passedData.year
                destVC.passedData = valueToPass
            }
        } else if segue.identifier == "DepthCharts" {
            if let destVC = segue.destination as? DepthCharts {
                valueToPass.year = passedData.year
                destVC.passedData = valueToPass
            }
        }
    }
    
    func addLeagueSegue() {
        performSegue(withIdentifier: "AddLeague", sender: UIAlertAction.self)
    }
    
    @IBAction func btnMyTeam(_ sender: UIButton) {
        performSegue(withIdentifier: "MyTeam", sender: self)
    }
    
    @IBAction func btnDraftOrder(_ sender: UIButton) {
        performSegue(withIdentifier: "DraftOrder", sender: self)
    }
    
    @IBAction func btnAddLeague(_ sender: UIBarButtonItem) {
        set_draft()
        if roster == [] {
            let okayAlert = UIAlertController(title: "Empty Team!", message: "You cannot add an empty team to a league!", preferredStyle: .alert)
            okayAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (OkayAction) in
            }))
            self.present(okayAlert, animated: true)
            return
        }
        let alert = UIAlertController(title: "Add League", message: "Is your team complete and ready to be added to a league?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (NoAction) in
            return
        }))
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (YesAction) in
            self.addLeagueSegue()
        }))
        self.present(alert, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        set_draft()
    }
    
    @IBOutlet weak var table: UITableView!

    @IBOutlet weak var label: UILabel!
}

