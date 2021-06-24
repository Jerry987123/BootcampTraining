//
//  TopicCell.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/24.
//

import UIKit

class TopicCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
