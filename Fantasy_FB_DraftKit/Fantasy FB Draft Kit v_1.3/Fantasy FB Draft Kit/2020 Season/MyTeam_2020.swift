//
//  MyTeam_2020.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 6/19/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import UIKit

class MyTeam_2020: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myRoster = [PlayerData]()
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myRoster = Database_2020.shared.rosterList()
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if myRoster.count == 0 {
            table.setEmptyView(message: "You Currently Do Not Have Any Players On Your Team!")
            lblMyTeam.isHidden = true
        }
        else {
            table.restore()
        }
        return myRoster.count
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let player = myRoster[indexPath.row]
        let str = "\(player.name),  \(player.team) - \(player.position) (\(player.byeWeek))"
        let defOnly = "\(player.name) - \(player.position) (\(player.byeWeek))"
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if player.position == "DEF" {
            cell.textLabel?.text = "\(indexPath.row+1).  \(defOnly)"
        } else {
            cell.textLabel?.text = "\(indexPath.row+1).  \(str)"
        }
        cell.textLabel?.adjustsFontSizeToFitWidth = true
        cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
        return cell
    }
    
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var lblMyTeam: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
