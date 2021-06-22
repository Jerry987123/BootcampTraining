//
//  MovieCell.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/22.
//

import UIKit

class MovieCell:UITableViewCell {
    
    @IBOutlet weak var trackNameLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    func setCell(model: MovieModel){
        trackNameLabel.text = model.trackName
    }
}
