//
//  AlbumViewController.swift
//  PetFitApp
//
//  Created by AMIIT GUPTA on 08/12/21.
//

import UIKit
import Firebase
class AlbumViewController: UIViewController {

    @IBOutlet weak var albumCollectionView: UICollectionView!
    var petdata = [PetDataModel]()
    var ref = DatabaseReference.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        self.getAllPetData()
        albumCollectionView.register(UINib(nibName: AlbumCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: AlbumCollectionViewCell.reuseIdentifier)
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func getAllPetData() {
        self.ref.child("pet").queryOrderedByKey().observe(.value){ (snapshot) in
            self.petdata.removeAll()
            if let snapShot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapShot {
                    if let mainDict = snap.value as? [String: AnyObject] {
                        let name = mainDict["petName"] as? String ?? ""
                        let age = mainDict["petDOB"] as? String ?? ""
                        let location = mainDict["petLocation"] as? String ?? ""
                        let breed = mainDict["petBreed"] as? String ?? ""
                        let imageUrl = mainDict["petImageUrl"] as? String ?? ""
                        let ownerDetail = mainDict["ownerDetails"] as? String ?? ""
                        self.petdata.append(PetDataModel(petName: name, petDOB: age, petLocation: location, petBreed: breed, petImageUrl: imageUrl, ownerDetails: ownerDetail))
                        self.albumCollectionView.reloadData()
                    }
                }
            }
            
        }
    }
}
extension AlbumViewController: UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return petdata.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumCollectionViewCell.reuseIdentifier, for: indexPath) as? AlbumCollectionViewCell else { return UICollectionViewCell()}
        cell.petModel = petdata[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let show = PetDetailViewController.loadController()
        show.modalPresentationStyle = .fullScreen
        show.petModel = petdata[indexPath.row]
        self.present(show, animated: true, completion: nil)
    }
}
extension AlbumViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            return CGSize(width: (albumCollectionView.frame.width/3)-10,height:(albumCollectionView.frame.width/3)-10)
      
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 5
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }
}
