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
    var movieModel:iTunesSearchAPIResponseResult?
    var expandCell: ((UIButton, Int) -> Void)?
    var narrowCell: ((UIButton, Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    @IBAction func collectionButtonAction(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case "收藏":
        if let model = movieModel {
            DBDao.shared.insertData(mediaType: .movie, model: model)
            sender.setTitle("取消收藏", for: .normal)
        }
        case "取消收藏":
            if let model = movieModel {
                DBDao.shared.deleteData(trackId: Int(truncating: model.trackId))
                sender.setTitle("收藏", for: .normal)
            }
        default:
            break
        }
    }
    @IBAction func readMoreButtonAction(_ sender: UIButton) {
        guard let cell = sender.superview?.superview as? MovieCell else {
            return print("sender failed to get cell")
        }
        guard let indexRow = _tableView?.indexPath(for: cell) else {
            return print("cell failed to get indexRow")
        }
        if longDescriptionLabel.numberOfLines == 2 {
            expandCell?(sender, indexRow.row)
        } else {
            narrowCell?(sender, indexRow.row)
        }
    }
    func setCell(model: iTunesSearchAPIResponseResult){
        movieModel = model
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
