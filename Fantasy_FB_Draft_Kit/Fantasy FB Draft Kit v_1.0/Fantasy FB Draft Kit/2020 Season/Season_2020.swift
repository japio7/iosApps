//
//  Season_2020.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 6/18/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import UIKit

class Season_2020: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedSection: Int = 0
    var selectedRow: Int = 0
    
    var objectsArray: [[String]] = [["Overall Top 200", "Top 40 Rookies"], ["Top 30 Quarterbacks", "Top 80 Running Backs", "Top 80 Wide Receivers", "Top 30 Tight Ends", "Top 20 Defenses", "Top 15 Kickers"], ["Depth Charts"], ["My Leagues"], ["Reset Draft"]
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectsArray[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return objectsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        cell.textLabel?.text = objectsArray[indexPath.section][indexPath.row]
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.font = UIFont.systemFont(ofSize: 25)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedSection = indexPath.section
        selectedRow = indexPath.row
        if indexPath.section == 2 {
            performSegue(withIdentifier: "DepthCharts_2020", sender: self)
        }
        else if indexPath.section == 3 {
            performSegue(withIdentifier: "MyLeagues_2020", sender: self)
        }
        else if indexPath.section == 4 {
            let alert = UIAlertController(title: "Reset Draft", message: "Are you sure you want to reset the draft?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { (NoAction) in
                return
            }))
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { (YesAction) in
                let okayAlert = UIAlertController(title: "Reset Draft", message: "The 2020 Draft has been reset!", preferredStyle: .alert)
                Database_2020.shared.resetDraft()
                okayAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (OkayAction) in
                }))
                self.present(okayAlert, animated: true)
            }))
            self.present(alert, animated: true)
        } else {
            performSegue(withIdentifier: "TopPlayers_2020", sender: self)
        }
        table.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TopPlayers_2020" {
            if let destVC = segue.destination as? TopPlayers_2020 {
                var valueToPass = RowSelected()
                let section_selected = selectedSection
                let row_selected = selectedRow
                valueToPass.row = row_selected
                valueToPass.sec = section_selected
                destVC.passedData = valueToPass
            }
        }
    }
    
    func addLeagueSegue() {
        performSegue(withIdentifier: "AddLeague_2020", sender: UIAlertAction.self)
    }
    
    @IBAction func btnMyTeam(_ sender: UIButton) {
        performSegue(withIdentifier: "MyTeam_2020", sender: self)
    }
    
    @IBAction func btnDraftOrder(_ sender: UIButton) {
        performSegue(withIdentifier: "DraftOrder_2020", sender: self)
    }
    
    @IBAction func btnAddLeague(_ sender: UIBarButtonItem) {
        if Database_2020.shared.roster_array() == [] {
            
            let okayAlert = UIAlertController(title: "Empty Team!", message: "You cannot add an empty team to a league!", preferredStyle: .alert)
            okayAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (OkayAction) in
            }))
            self.present(okayAlert, animated: true)
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
    
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var label: UILabel!
}

