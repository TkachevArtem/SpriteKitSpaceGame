//
//  RecordsTableViewController.swift
//  AstonSpaceProject
//
//  Created by Artem Tkachev on 27.08.23.
//

import UIKit

class RecordsTableView: UITableView, UITableViewDelegate, UITableViewDataSource {
    
    var records = RecordManager.shared.loadRecords()

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.delegate = self
        self.dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecordTableViewCell", for: indexPath) as? RecordTableViewCell else {
            return UITableViewCell()
        }
        
        if let recordName = records.sorted(by: {$0.score ?? 0 > $1.score ?? 0})[indexPath.row].name {
            cell.nameLabel.text = "\(recordName)"
        }

        if let recordScore = records.sorted(by: {$0.score ?? 0 > $1.score ?? 0})[indexPath.row].score {
            cell.scoreLabel.text = "\(recordScore)"
        }

        cell.nameLabel.textColor = .white
        cell.nameLabel.font = UIFont(name: "Chalkduster", size: 25)
        cell.nameLabel.textAlignment = .center

        cell.scoreLabel.textColor = .white
        cell.scoreLabel.font = UIFont(name: "Chalkduster", size: 25)
        cell.scoreLabel.textAlignment = .center

        cell.backgroundColor = .clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
