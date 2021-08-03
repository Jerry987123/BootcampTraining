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
    weak var collectingActionDelegate: CollectingActionDelegateInCell?
    var expandCell: ((Int) -> Void)?
    var narrowCell: ((Int) -> Void)?
    var updateCellWhenRemoveFromCollectionView: ((Int) -> Void)?
    
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
                updateCellWhenRemoveFromCollectionView?(Int(truncating:  model.trackId ?? 0))
            }
        default:
            break
        }
    }
    @IBAction func readMoreButtonAction(_ sender: UIButton) {
        if longDescriptionLabel.numberOfLines == 2 {
            setExpandCell()
            expandCell?(Int(truncating:  movieModel?.trackId ?? 0))
        } else {
            setNarrowCell()
            narrowCell?(Int(truncating:  movieModel?.trackId ?? 0))
        }
    }
    func setCell(model: iTunesSearchAPIResponseResult){
        movieModel = model
        trackNameLabel.text = model.trackName
        artiestNameLabel.text = model.artistName
        collectionNameLabel.text = model.collectionName
        movieTimeLabel.text = Tools().timeFromMillisToHMMSS(time: Int(truncating: model.trackTimeMillis ?? 0))
        longDescriptionLabel.text = model.longDescription
        if let artworkUrl100 = model.artworkUrl100, let url = URL(string: artworkUrl100), UIApplication.shared.canOpenURL(url) {
            photoImageView.sd_setImage(with: url, placeholderImage:UIImage.init(systemName: "tv"))
        } else {
            photoImageView.image = UIImage.init(systemName: "tv")
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
