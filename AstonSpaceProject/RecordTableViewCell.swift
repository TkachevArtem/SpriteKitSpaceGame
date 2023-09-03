//
//  RecordTableViewCell.swift
//  AstonSpaceProject
//
//  Created by Artem Tkachev on 27.08.23.
//

import UIKit

class RecordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
