//
//  MovieCell.swift
//  BootcampTraining
//
//  Created by ESB21852 on 2021/6/22.
//

import UIKit
import SDWebImage

class MovieCell:UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artiestNameLabel: UILabel!
    @IBOutlet weak var collectionNameLabel: UILabel!
    @IBOutlet weak var movieTimeLabel: UILabel!
    @IBOutlet weak var longDescriptionLabel: UILabel!
    
    weak var _tableView:UITableView?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    @IBAction func readMoreButtonAction(_ sender: UIButton) {
        _tableView?.beginUpdates()
        if longDescriptionLabel.numberOfLines == 2 {
            longDescriptionLabel.numberOfLines = 0
            sender.setTitle("...read less", for: .normal)
        } else {
            longDescriptionLabel.numberOfLines = 2
            sender.setTitle("...read more", for: .normal)
        }
        _tableView?.endUpdates()
    }
    func setCell(model: iTunesSearchAPIResponseResult){
        trackNameLabel.text = model.trackName
        artiestNameLabel.text = model.artistName
        collectionNameLabel.text = model.collectionName
        movieTimeLabel.text = timeFromMillisToHMMSS(time: Int(truncating: model.trackTimeMillis ?? 0))
        longDescriptionLabel.text = model.longDescription
        if let artworkUrl100 = model.artworkUrl100, let url = URL(string: artworkUrl100), UIApplication.shared.canOpenURL(url) {
            photoImageView.sd_setImage(with: url)
        } else {
            photoImageView.image = UIImage.init(systemName: "tv")
        }
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
