//
//  AlbumCollectionViewCell.swift
//  PetFitApp
//
//  Created by AMIIT GUPTA on 08/12/21.
//

import UIKit
import Kingfisher

class AlbumCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var petImage: UIImageView!
    var petModel: PetDataModel? {
        didSet {
            if let url = URL(string: petModel?.petImageUrl ?? "") {
                KingfisherManager.shared.retrieveImage(with: url as Resource, options: nil, progressBlock: nil) { (image, error, cache, imageUrl) in
                    self.petImage.image = image
                    self.petImage.kf.indicatorType = .activity
                }
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
