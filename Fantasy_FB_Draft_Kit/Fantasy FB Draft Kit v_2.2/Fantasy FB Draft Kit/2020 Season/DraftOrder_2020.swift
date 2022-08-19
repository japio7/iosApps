//
//  DraftOrder_2020.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 6/19/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import UIKit

class DraftOrder_2020: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var draftOrder: [PlayerData] = []
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        draftOrder = Database_2020.shared.draftList()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        table.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if draftOrder.count == 0 {
            table.setEmptyView(message: "The 2020 Fantasy Draft Has Not Started!")
            label.isHidden = true
        }
        else {
            table.restore()
        }
        return draftOrder.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let player = draftOrder[indexPath.row]
            let str = "\(player.name),  \(player.team) - \(player.position)"
            let defOnly = "\(player.name) - \(player.position)"
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var table: UITableView!
}

