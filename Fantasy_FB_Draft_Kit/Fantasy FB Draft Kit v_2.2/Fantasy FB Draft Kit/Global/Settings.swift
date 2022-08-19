//
//  Settings.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 8/28/21.
//  Copyright © 2021 Jared Pino. All rights reserved.
//

import UIKit

class Settings: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cellStates: [SettingsState] = [
        SettingsState(settingLabel: "Quick Add", settingValue: false)
    ]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellStates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SettingsCustomCell
        cell.state = cellStates[indexPath.row]
        
        return cell
    }
    
    @IBOutlet weak var table: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        cellStates = [
            SettingsState(settingLabel: "Quick Add", settingValue: (UserDefaults.standard.bool(forKey: "quickAdd")))
        ]
    }
}
