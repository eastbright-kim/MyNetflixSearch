//
//  HistoryViewController.swift
//  MyNetflix
//
//  Created by joonwon lee on 2020/04/16.
//  Copyright © 2020 com.joonwon. All rights reserved.
//

import UIKit
import Firebase

class HistoryViewController: UIViewController {
 
    @IBOutlet weak var tableView: UITableView!
    var searchTerms: [String] = []
    
    let db = Database.database().reference().child("searchHistory")

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       db.observeSingleEvent(of: .value) { snapshot in
            guard let searchHistory = snapshot.value as? [String: String] else { return  }
            let searchTerms = searchHistory.map { (key, value) -> String in
                return value
            }
        
        self.searchTerms = searchTerms.reversed()
        self.tableView.reloadData()
            print("---> print \(searchTerms), \(snapshot.value)")
        }
    }
    
    
    


}


extension HistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell", for: indexPath) as? HistoryCell else {
            return UITableViewCell()
        }
        cell.searchTerm.text = searchTerms[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchTerms.count
    }
}

class HistoryCell: UITableViewCell {
    @IBOutlet weak var searchTerm: UILabel!
}
