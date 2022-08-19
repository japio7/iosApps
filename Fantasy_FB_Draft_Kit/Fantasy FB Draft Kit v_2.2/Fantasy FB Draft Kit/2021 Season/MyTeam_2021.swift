//
//  MyTeam_2021.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 9/7/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import UIKit

class MyTeam_2021: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myRoster = [PlayerData]()
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myRoster = Database_2021.shared.rosterList()
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if myRoster.count == 0 {
            table.setEmptyView(message: "You Currently Do Not Have Any Players On Your Team!")
            label.isHidden = true
        }
        else {
            table.restore()
        }
        return myRoster.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let player = myRoster[indexPath.row]
        let str = "\(player.name),  \(player.team) - \(player.position) (\(player.byeWeek))"
        let dstOnly = "\(player.name) - \(player.position) (\(player.byeWeek))"
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if player.position == "DST" {
            cell.textLabel?.text = "\(indexPath.row+1).  \(dstOnly)"
        } else {
            cell.textLabel?.text = "\(indexPath.row+1).  \(str)"
        }
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var label: UILabel!
    
    
    @IBOutlet weak var table: UITableView!
    
}
