//
//  BaseViewController.swift
//  PetFitApp
//
//  Created by AMIIT GUPTA on 29/11/21.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationSetup()
    }
    
    func navigationSetup() {
        self.title = "PetFit"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "hamburgerIcon"), style: .plain, target: self, action: #selector(showHamburger))
        self.navigationItem.leftBarButtonItem?.tintColor = .black
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addItems))
        add.tintColor = .black
        self.navigationItem.rightBarButtonItem = add
    }
    
    @objc func showHamburger() {
        let hamburgerVc = HmburgerViewController.loadController()
        hamburgerVc.modalPresentationStyle = .fullScreen
        hamburgerVc.modalTransitionStyle = .flipHorizontal
        self.present(hamburgerVc, animated: true, completion: nil)
    }
    
    @objc func addItems() {
        let addNewVc = AddNewPetViewController.loadController()
        addNewVc.modalPresentationStyle = .fullScreen
        addNewVc.modalTransitionStyle = .flipHorizontal
        self.present(addNewVc, animated: true, completion: nil)
        
    }
}
