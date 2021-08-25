//
//  ViewController.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 6/18/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import UIKit

class Main: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var objectsArray: [String] = ["2020"]
    
    var appVersion: String {
       // return Bundle.main.infoDictionary![kCFBundleVersionKey as String] as! String
        return (Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String)!
    }
    
    // Store app version in UserDefaults
    func store_app_version(a: String) {
        UserDefaults.standard.set(a, forKey: "stored_version")
    }
    
    // Check if version is updated
    func chkAppVer(a: String) {
        if appVersion != UserDefaults.standard.string(forKey: "stored_version") {
            Database_2020.shared.resetDraft()
        }
    }
    
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
    }
    
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var version: UILabel!
    
    @IBAction func btnInfo(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "App_Info", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Checking if version has been updated
        chkAppVer(a: appVersion)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        version.text = "Version \(appVersion)"
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateDate), userInfo: nil, repeats: true)
        Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        // Storing app version in UserDefaults
        store_app_version(a: appVersion)
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

