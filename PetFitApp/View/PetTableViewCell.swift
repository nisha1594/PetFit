//
//  PetTableViewCell.swift
//  PetFitApp
//
//  Created by AMIIT GUPTA on 01/12/21.
//

import UIKit
import Kingfisher

class PetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var petImge: UIImageView!
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var petAge: UILabel!
    @IBOutlet weak var petLocation: UILabel!
    @IBOutlet weak var petBreed: UILabel!
    
    var petModel: PetDataModel? {
        didSet {
            petName.text = petModel?.petName
            
//            guard let year = petModel?.petDOB?.components(separatedBy: ",")[1] else { return  }
//            guard let months = petModel?.petDOB?.components(separatedBy: ",")[0].components(separatedBy: " ")[0] else { return  }
//            guard let date = petModel?.petDOB?.components(separatedBy: ",")[0].components(separatedBy: " ")[1] else { return  }
//            let dob = DateComponents(calendar: .current, year: Int(year), month: Int(months), day: Int(date)).date!.age
            petAge.text = petModel?.petDOB
            petLocation.text = petModel?.petLocation
            petBreed.text = petModel?.petBreed
            if let url = URL(string: petModel?.petImageUrl ?? "") {
                KingfisherManager.shared.retrieveImage(with: url as Resource, options: nil, progressBlock: nil) { (image, error, cache, imageUrl) in
                    self.petImge.image = image
                    self.petImge.kf.indicatorType = .activity
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

