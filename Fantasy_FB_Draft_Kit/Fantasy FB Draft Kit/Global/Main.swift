//
//  ViewController.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 6/18/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import UIKit

class Main: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var objectsArray: [[String]] = [[String(currentYear)], ["Previous Seasons"]]
    var dataToPass = RowSelected()
    var year = ""
    var selectedSection: Int = 0
    var selectedRow: Int = 0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        objectsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        cell.textLabel?.text = objectsArray[indexPath.section][indexPath.row]
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = .boldSystemFont(ofSize: 25)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainTableView.deselectRow(at: indexPath, animated: true)
        if indexPath.section == 0 {
            year = objectsArray[0][0]
            selectedSection = indexPath.section
            selectedRow = indexPath.row
            performSegue(withIdentifier: "Season", sender: self)
        }
        else if indexPath.section == 1 {
            performSegue(withIdentifier: "previous seasons", sender: self)
        }
    }
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var version: UILabel!
    
    @IBAction func btnInfo(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "App_Info", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        var valueToPass = RowSelected()
        if segue.identifier == "Season" {
            if let destVC = segue.destination as? Season {
                let section_selected = selectedSection
                let row_selected = selectedRow
                valueToPass.row = row_selected
                valueToPass.sec = section_selected
                valueToPass.year = Int(year)
                destVC.passedData = valueToPass
            }
        }
    }
    
    @IBAction func unwindToMainViewController(_ segue : UIStoryboardSegue) {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Checking if version has been updated
        if UserDefaults.standard.string(forKey: "stored_version") == nil {
            // Storing app version in UserDefaults
            Database.shared.store_app_version(a: Database.shared.appVersion)
        } else if Database.shared.appVersion != UserDefaults.standard.string(forKey: "stored_version") {
            let okayAlert = UIAlertController(title: "Update Complete!", message: "Update to version \(Database.shared.appVersion) successful!", preferredStyle: .alert)
            okayAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (OkayAction) in
            }))
            self.present(okayAlert, animated: true)
            // Storing app version in UserDefaults
            Database.shared.store_app_version(a: Database.shared.appVersion)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        version.text = "Version \(Database.shared.appVersion)"
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateDate), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Storing app version in UserDefaults
        Database.shared.store_app_version(a: Database.shared.appVersion)
    }
    
    @objc func updateDate() {
        date.text = DateFormatter.localizedString(from: Date(), dateStyle: DateFormatter.Style.medium, timeStyle: DateFormatter.Style.none
        )
    }
    
    @objc func updateTime() {
        time.text = DateFormatter.localizedString(from: Date(), dateStyle: DateFormatter.Style.none, timeStyle: DateFormatter.Style.medium
        )
    }
}

