//
//  HmburgerViewController.swift
//  PetFitApp
//
//  Created by AMIIT GUPTA on 28/11/21.
//

import UIKit

class HmburgerViewController: UIViewController {
 
    @IBOutlet weak var hamburgerTableView: UITableView!
    var menuArray = ["User Profile", "Add Pet","Pet Album", "Scheduled Activity","Feedback","About","LogOut"]
    override func viewDidLoad() {
        super.viewDidLoad()
        hamburgerTableView.delegate = self
        hamburgerTableView.dataSource = self
        hamburgerTableView.tableFooterView = UIView()
        hamburgerTableView.register(UINib(nibName: "MenuTableViewCell", bundle: nil), forCellReuseIdentifier: MenuTableViewCell.reuseIdentifier)
    }

    @IBAction func closeHamburgerView(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension HmburgerViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.menuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.reuseIdentifier, for: indexPath) as? MenuTableViewCell else {return UITableViewCell()}
        cell.menuTitle.text = menuArray[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.showUserProfile()
        case 1:
            self.addPet()
        case 2:
            self.showAlbum()
        case 3:
            self.showActivity()
        case 4:
            self.showFeedback()
        case 5:
            self.showAbout()
        case 6:
            self.logoutUser()
        default:
            print("Something went wrong!")
        }
    }
}
extension HmburgerViewController {
    func addPet() {
        let addNewVc = AddNewPetViewController.loadController()
        addNewVc.modalPresentationStyle = .fullScreen
        self.present(addNewVc, animated: true, completion: nil)
    }
    func logoutUser() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let loginVc: LoginViewController = storyboard.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        loginVc.modalPresentationStyle = .fullScreen
        self.present(loginVc, animated: true, completion: nil)
    }
    func showUserProfile() {
        let showProfile = ProfileViewController.loadController()
        showProfile.modalPresentationStyle = .fullScreen
        self.present(showProfile, animated: true, completion: nil)
    }
    func showAbout() {
        let show = AboutViewController.loadController()
        show.modalPresentationStyle = .fullScreen
        self.present(show, animated: true, completion: nil)
    }
    func showFeedback() {
        let show = FeedbackViewController.loadController()
        show.modalPresentationStyle = .fullScreen
        self.present(show, animated: true, completion: nil)
    }
    func showAlbum() {
        let show = AlbumViewController.loadController()
        show.modalPresentationStyle = .fullScreen
        self.present(show, animated: true, completion: nil)
    }
    func showActivity() {
        let show = ActivitySchduledController.loadController()
        show.modalPresentationStyle = .fullScreen
        self.present(show, animated: true, completion: nil)
    }
}
