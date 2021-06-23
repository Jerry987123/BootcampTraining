//
//  MusicCell.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/22.
//

import UIKit

class MusicCell:UITableViewCell {
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artiestNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var musicTimeLabel: UILabel!
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    func setCell(model: iTunesSearchAPIResponseResult){
        trackNameLabel.text = model.trackName
        artiestNameLabel.text = model.artistName
        collectionNameLabel.text = model.collectionName
        musicTimeLabel.text = timeFromMillisToHMMSS(time: model.trackTimeMillis)
    }
    private func timeFromMillisToHMMSS(time:Int) -> String {
        let min = time/1000/60
        let sec = time/1000%60
        return "\(min):\(Tools().make0To00(number: sec))"
    }
}
