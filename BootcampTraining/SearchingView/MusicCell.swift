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
    @IBOutlet weak var collectionButtonLabel: UIButton!
    @IBOutlet weak var collectionButtonWidthConstraint: NSLayoutConstraint!
    
    weak var musicModel:iTunesSearchAPIResponseResult?
    weak var collectingActionDelegate: CollectingActionDelegateInCell?
    var updateCellWhenRemoveFromCollectionView: ((Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    @IBAction func collectionButtonAction(_ sender: UIButton) {
        switch sender.titleLabel?.text {
        case "收藏":
        if let model = musicModel {
            collectingActionDelegate?.collectionDBInsertOrDelete(model: model, collectingAction: .collect, mediaType: .music)
            sender.setTitle("取消收藏", for: .normal)
            collectionButtonWidthConstraint.constant = 80
        }
        case "取消收藏":
            if let model = musicModel {
                collectingActionDelegate?.collectionDBInsertOrDelete(model: model, collectingAction: .cancelCollet, mediaType: .music)
                sender.setTitle("收藏", for: .normal)
                collectionButtonWidthConstraint.constant = 50
                updateCellWhenRemoveFromCollectionView?(Int(truncating: model.trackId ?? 0))
            }
        default:
            break
        }
    }
    func setCell(model: iTunesSearchAPIResponseResult){
        musicModel = model
        trackNameLabel.text = model.trackName
        artiestNameLabel.text = model.artistName
        collectionNameLabel.text = model.collectionName
        musicTimeLabel.text = Tools().timeFromMillisToHMMSS(time: Int(truncating: model.trackTimeMillis ?? 0))
        if let artworkUrl100 = model.artworkUrl100, let url = URL(string: artworkUrl100), UIApplication.shared.canOpenURL(url) {
            photoImageView.sd_setImage(with: url, placeholderImage:UIImage.init(systemName: "music.note"))
        } else {
            photoImageView.image = UIImage.init(systemName: "music.note")
        }
    }
    func adjustCollectionButtonName(alreadyAdded:Bool){
        if alreadyAdded {
            collectionButtonLabel.setTitle("取消收藏", for: .normal)
            collectionButtonWidthConstraint.constant = 80
        } else {
            collectionButtonLabel.setTitle("收藏", for: .normal)
            collectionButtonWidthConstraint.constant = 50
        }
    }
}
