//
//  ProfileViewController.swift
//  PetFitApp
//
//  Created by AMIIT GUPTA on 06/12/21.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var profileImageView: UIView!
    @IBOutlet weak var lastName: UILabel!
    @IBOutlet weak var firstName: UILabel!
    var ref = DatabaseReference.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profileImageView.addCornerRadius(60)
        self.getUserDetails()
    }
    
    func getUserDetails() {
        self.ref = Database.database().reference()
        let userID : String = (Auth.auth().currentUser?.uid)!
        print("Current user ID is" + userID)
        
        self.ref.child("users").child(userID).observeSingleEvent(of: .value, with: {(snapshot) in
            print(snapshot.value ?? "")
            
            let firstname = (snapshot.value as! NSDictionary)["firstName"] as! String
            print(firstname)
            
            let lastName = (snapshot.value as! NSDictionary)["lastName"] as! String
            DispatchQueue.main.async {
                self.lastName.text = lastName
                self.firstName.text = firstname
            }
        })
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
