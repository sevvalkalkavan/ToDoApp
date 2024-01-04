//
//  TaskCell.swift
//  ToDo
//
//  Created by Şevval Kalkavan on 4.01.2024.
//

import UIKit

class TaskCell: UITableViewCell {

    @IBOutlet weak var dueDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
