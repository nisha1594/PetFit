//
//  PetDetailViewController.swift
//  PetFitApp
//
//  Created by AMIIT GUPTA on 08/12/21.
//

import UIKit
import Kingfisher

class PetDetailViewController: UIViewController {
    
    
    @IBOutlet weak var petImage: UIImageView!
    
    @IBOutlet weak var petName: UILabel!
    @IBOutlet weak var ownerDetail: UILabel!
    
    @IBOutlet weak var petBreed: UILabel!
    
    @IBOutlet weak var petLocation: UILabel!
    @IBOutlet weak var petDOB: UILabel!
    
    
    var petModel: PetDataModel?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }

    @IBAction func backClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func showAlbum(_ sender: UIButton) {
        let show = AlbumViewController.loadController()
        show.modalPresentationStyle = .fullScreen
        self.present(show, animated: true, completion: nil)
    }
    
    @IBAction func schduleActivity(_ sender: Any) {
        let show = SchduleActivityController.loadController()
        show.modalPresentationStyle = .fullScreen
        self.present(show, animated: true, completion: nil)
    }
    
    
    @IBAction func showSchduledActivity(_ sender: Any) {
        let show = ActivitySchduledController.loadController()
        show.modalPresentationStyle = .fullScreen
        self.present(show, animated: true, completion: nil)
    }
    
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
    }
}
extension PetDetailViewController {
    func initialSetup() {
        self.petImage.addCornerRadius(20)
        petName.text = petModel?.petName
        ownerDetail.text = petModel?.ownerDetails
        petDOB.text = petModel?.petDOB
        petLocation.text = petModel?.petLocation
        petBreed.text = petModel?.petBreed
        if let url = URL(string: petModel?.petImageUrl ?? "") {
            KingfisherManager.shared.retrieveImage(with: url as Resource, options: nil, progressBlock: nil) { (image, error, cache, imageUrl) in
                self.petImage.image = image
                self.petImage.kf.indicatorType = .activity
            }
        }
        
    }
}
