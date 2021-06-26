//
//  MusicCell.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/22.
//

import UIKit
import SDWebImage

class MusicCell:UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artiestNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var musicTimeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    func setCell(model: iTunesSearchAPIResponseResult){
        trackNameLabel.text = model.trackName
        artiestNameLabel.text = model.artistName
        collectionNameLabel.text = model.collectionName
        musicTimeLabel.text = timeFromMillisToHMMSS(time: Int(truncating: model.trackTimeMillis ?? 0))
        if let artworkUrl100 = model.artworkUrl100, let url = URL(string: artworkUrl100) {
            photoImageView.sd_setImage(with: url)
        } else {
            photoImageView.image = UIImage.init(systemName: "music.note")
        }
    }
    private func timeFromMillisToHMMSS(time:Int) -> String {
        let min = time/1000/60
        let sec = time/1000%60
        return "\(min):\(Tools().make0To00(number: sec))"
    }
}
