//
//  SchduleActivityController.swift
//  PetFitApp
//
//  Created by AMIIT GUPTA on 08/12/21.
//

import UIKit
import Firebase

class SchduleActivityController: UIViewController {

    
    @IBOutlet weak var activity: UITextField!
    @IBOutlet weak var when: UITextField!
    @IBOutlet weak var notes: UITextField!
    var ref = DatabaseReference.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
    }
    
    @IBAction func backClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addActivity(_ sender: Any) {
        self.detailsToAdd()
    }
    
    func initialSetup() {
        self.ref = Database.database().reference()
        Utilities.styleTextField(activity)
        Utilities.styleTextField(when)
        when.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
    }
    @objc func doneButtonPressed() {
        if let  datePicker = self.when.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            self.when.text = dateFormatter.string(from: datePicker.date)
        }
        self.when.resignFirstResponder()
     }
    func detailsToAdd() {
        let dict = ["activity": activity.text!, "when": when.text!, "notes": notes.text!] as [String : Any]
        self.ref.child("activity").childByAutoId().setValue(dict)
        Utilities.showAlert(title: "Success!", message: "Activity Schduled successfully", controller: self)
    }
}
