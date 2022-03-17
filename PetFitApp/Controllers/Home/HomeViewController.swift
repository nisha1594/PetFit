//
//  HomeViewController.swift
//  PetFitApp
//
//  Created by AMIIT GUPTA on 26/11/21.
//

import UIKit
import Firebase
class HomeViewController: BaseViewController {
    
    @IBOutlet weak var detailTableView: UITableView!
    
    var petdata = [PetDataModel]()
    var ref = DatabaseReference.init()
    let addVc = AddNewPetViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        addVc.del = self
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.tableFooterView = UIView()
        detailTableView.register(UINib(nibName: "PetTableViewCell", bundle: nil), forCellReuseIdentifier: "PetTableViewCell")
        self.getAllPetData()
        
        
        
        
//        let userID : String = (Auth.auth().currentUser?.uid)!
//            print("Current user ID is" + userID)
//
//           self.ref.child("users").child(userID).observeSingleEvent(of: .value, with: {(snapshot) in
//                print(snapshot.value)
//
//                let username = (snapshot.value as! NSDictionary)["firstName"] as! String
//                print(username)
//
//
//            })
        
        
    }
}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petdata.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "PetTableViewCell", for: indexPath) as? PetTableViewCell else {return  UITableViewCell()}
        cell.petModel = petdata[indexPath.row]

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let show = PetDetailViewController.loadController()
        show.modalPresentationStyle = .fullScreen
        show.petModel = petdata[indexPath.row]
        self.present(show, animated: true, completion: nil)
        
    }
}

extension HomeViewController: RefreshData {
    func toCallDataAgain() {
        self.getAllPetData()
    }
}

extension HomeViewController {
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
                        self.detailTableView.reloadData()
                    }
                }
            }
            
        }
    }
}
