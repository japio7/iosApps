//
//  ViewController.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 6/18/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import UIKit

class Main: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var objectsArray: [String] = ["2020", "2021"]
    
    var cellStates: [SettingsState] = [
        SettingsState(settingLabel: "Quick Add", settingValue: false),
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objectsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = mainTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        cell.textLabel?.text = objectsArray[indexPath.row]
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = .boldSystemFont(ofSize: 25)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        mainTableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            performSegue(withIdentifier: "Season_2020", sender: self)
        }
        if indexPath.row == 1 {
            performSegue(withIdentifier: "Season_2021", sender: self)
        }
    }
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var version: UILabel!
    
    @IBAction func btnInfo(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "App_Info", sender: self)
    }
    
    @IBAction func btnSettings(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "App_Settings", sender: self)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        // Checking if version has been updated
        if UserDefaults.standard.string(forKey: "stored_version") == nil {
            // Storing app version in UserDefaults
            Database.shared.store_app_version(a: Database.shared.appVersion)
        }
        else if Database.shared.appVersion != UserDefaults.standard.string(forKey: "stored_version") {
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
        
        cellStates = [SettingsState(settingLabel: "Quick Add", settingValue: (UserDefaults.standard.object(forKey: "quickAdd") != nil))]
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

