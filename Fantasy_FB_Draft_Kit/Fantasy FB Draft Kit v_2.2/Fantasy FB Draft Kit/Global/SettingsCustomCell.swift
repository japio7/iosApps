//
//  SettingsCustomCell.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 8/28/21.
//  Copyright © 2021 Jared Pino. All rights reserved.
//

import UIKit
import Foundation

class SettingsCustomCell: UITableViewCell {
    @IBOutlet weak var settingLabel: UILabel!
    @IBOutlet weak var quickAddSwitch: UISwitch!
    
    var state: SettingsState? {
        didSet {
            if let state = state {
                settingLabel.text = state.settingLabel
                quickAddSwitch.isOn = state.settingValue
            }
        }
    }
    
    override func awakeFromNib() {
        quickAddSwitch.addTarget(self, action: #selector(switchValueChanged), for: .valueChanged)
    }
    
    @IBAction func switchValueChanged(_ sender: UISwitch) {
        state?.settingValue = sender.isOn
        let defaults = UserDefaults.standard
        defaults.set(quickAddSwitch.isOn, forKey: "quickAdd")
    }
}

class SettingsState {
    var settingLabel: String
    var settingValue: Bool
    
    init(settingLabel: String, settingValue: Bool) {
        self.settingLabel = settingLabel
        self.settingValue = settingValue
    }
}
