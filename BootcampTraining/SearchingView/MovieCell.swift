//
//  MovieCell.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/22.
//

import UIKit

class MovieCell:UITableViewCell {
    
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artiestNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var movieTimeLabel: UILabel!
    @IBOutlet weak var longDescriptionLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    func setCell(model: iTunesSearchAPIResponseResult){
        trackNameLabel.text = model.trackName
        artiestNameLabel.text = model.artistName
        collectionNameLabel.text = model.collectionName
        movieTimeLabel.text = timeFromMillisToHMMSS(time: model.trackTimeMillis)
        longDescriptionLabel.text = model.longDescription
    }
    private func timeFromMillisToHMMSS(time:Int) -> String {
        let hour = time/1000/3600
        let minMinusHour = time/1000%3600
        let min = minMinusHour/60
        let sec = minMinusHour%60
        let tools = Tools()
        return "\(hour):\(tools.make0To00(number: min)):\(tools.make0To00(number: sec))"
    }
}
