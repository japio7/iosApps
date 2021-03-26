//
//  AppInfo.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 6/18/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import UIKit

class AppInfo: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var _arrayTitles: [String] = ["About", "How to", "The format"]
    
    var _array: [[String]] = [
        ["Fantasy Football Draft Kit is an app that allows you to keep track of all of your fantasy football leagues.", "1.  Mark players as taken when another team manager drafts them. This will also add the drafted player to the drafted order list in the order the player is drafted.", "2.  Add the player you drafted to your team. This will also add your drafted player to the drafted order list.", "3.  Check every Football teams depth chart.", "4.  Add league to leagues to keep track and manage multiple leagues in a single season."],
        ["1.  To add a player to your team or mark a drafted player as taken, swipe the player and tap the 'add' or 'taken' button and confirm the action.", "2.  To undo the previous action, swipe the player that you want to perform the undo action on and confirm.", "3.  To add a team, from the season menu, click 'Add League', confirm that you are ready to add a league, type league name, click add.", "4.  To view team or draft order, in the season menu, click 'My Team' or 'Draft Order'.", "5.  To reset the draft, from the season menu, click reset draft, confirm."],
        ["1.  When selecting a player, the format is as follows:", "Proj. Pick. Name, Team - Pos (Bye)", "2.  When viewing the depth charts, select the team, the format is as follows:", "Pos     Player name     'R'  if rookie", "3.  When viewing leagues, click on 'My Leagues', click on league name you want to view and the format is as follows:", "Proj. Pick.  Name     Team  Pos  (Bye)"]
    ]
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let header = view as? UITableViewHeaderFooterView {
            header.textLabel!.font = UIFont.boldSystemFont(ofSize: 28)
            header.textLabel?.textAlignment = .center
            header.textLabel?.backgroundColor = .systemGroupedBackground
            header.backgroundView?.backgroundColor = .systemGroupedBackground
            header.textLabel?.adjustsFontSizeToFitWidth = true
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return _arrayTitles[section]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _array[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return _array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        cell.textLabel?.text = _array[indexPath.section][indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
