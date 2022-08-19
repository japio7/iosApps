//
//  MyTeam_2020.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 6/19/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import UIKit

class MyTeam: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var passedData = RowSelected()
    
    var myRoster = [PlayerData]()
    
    func set_db() {
        if passedData.year == 0 {
            myRoster = Database_2020.shared.rosterList()
        } else if passedData.year == 1 {
            myRoster = Database_2021.shared.rosterList()
        } else if passedData.year == 2 {
            myRoster = Database_2022.shared.rosterList()
        }
    }
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        set_db()
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
        if player.position == "DST" {
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
