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
    @IBOutlet weak var readMoreButtonLabel: UIButton!
    @IBOutlet weak var collectionButtonLabel: UIButton!
    @IBOutlet weak var collectionButtonWidthConstraint: NSLayoutConstraint!
    
    weak var movieModel:iTunesSearchAPIResponseResult?
    var collectingActionDelegate: CollectingActionDelegateInCell?
    var expandCell: ((UIButton) -> Void)?
    var narrowCell: ((UIButton) -> Void)?
    var updateCellWhenRemoveFromCollectionView: ((UIButton) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    @IBAction func collectionButtonAction(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case "收藏":
        if let model = movieModel {
            collectingActionDelegate?.collectionDBInsertOrDelete(model: model, collectingAction: .collect, mediaType: .movie)
            sender.setTitle("取消收藏", for: .normal)
            collectionButtonWidthConstraint.constant = 80
        }
        case "取消收藏":
            if let model = movieModel {
                collectingActionDelegate?.collectionDBInsertOrDelete(model: model, collectingAction: .cancelCollet, mediaType: .movie)
                sender.setTitle("收藏", for: .normal)
                collectionButtonWidthConstraint.constant = 50
                updateCellWhenRemoveFromCollectionView?(sender)
            }
        default:
            break
        }
    }
    @IBAction func readMoreButtonAction(_ sender: UIButton) {
        if longDescriptionLabel.numberOfLines == 2 {
            expandCell?(sender)
        } else {
            narrowCell?(sender)
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
        if let trackId = model.trackId {
            let alreadyAdded = CollectionInteractor().alreadyAdded(trackId: Int(truncating: trackId))
            adjustCollectionButtonName(alreadyAdded: alreadyAdded)
        }
    }
    func setExpandCell(){
        longDescriptionLabel.numberOfLines = 0
        readMoreButtonLabel.setTitle("...read less", for: .normal)
    }
    func setNarrowCell(){
        longDescriptionLabel.numberOfLines = 2
        readMoreButtonLabel.setTitle("...read more", for: .normal)
    }
    private func adjustCollectionButtonName(alreadyAdded:Bool){
        if alreadyAdded {
            collectionButtonLabel.setTitle("取消收藏", for: .normal)
            collectionButtonWidthConstraint.constant = 80
        } else {
            collectionButtonLabel.setTitle("收藏", for: .normal)
            collectionButtonWidthConstraint.constant = 50
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
