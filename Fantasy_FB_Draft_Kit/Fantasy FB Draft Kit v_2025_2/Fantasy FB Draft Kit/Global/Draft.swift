//
//  Draft.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 8/6/22.
//  Copyright © 2022 Jared Pino. All rights reserved.
//

import UIKit

class Draft: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var passedData = RowSelected()
    var data = Database_2020.shared.getRankings()
    var year = ""
    
    func set_db() {
        if passedData.year == 2020 {
            data = Database_2020.shared.getRankings()
        } else if passedData.year == 2021 {
            data = Database_2021.shared.getRankings()
        } else if passedData.year == 2022 {
            data = Database_2022.shared.getRankings()
        } else if passedData.year == 2023 {
            data = Database_2023.shared.getRankings()
        } else if passedData.year == 2024 {
            data = Database_2024.shared.getRankings()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if passedData.row == 1 {
            let playerData = data[indexPath.row]
            cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = playerData
            cell.textLabel?.adjustsFontSizeToFitWidth = true
            cell.textLabel?.font = UIFont.systemFont(ofSize: 22)
            return cell
        }
        return cell
    }
    
    @IBOutlet weak var draftTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        set_db()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
