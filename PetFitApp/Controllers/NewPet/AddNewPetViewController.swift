//
//  AddNewPetViewController.swift
//  PetFitApp
//
//  Created by AMIIT GUPTA on 01/12/21.
//

import UIKit
import Firebase
import FirebaseStorage

protocol RefreshData {
    func toCallDataAgain()
}

class AddNewPetViewController: UIViewController {

    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var petNameTextField: UITextField!
    @IBOutlet weak var petDOBTextField: UITextField!
    @IBOutlet weak var petLocationTextField: UITextField!
    @IBOutlet weak var petBreedTextField: UITextField!
    @IBOutlet weak var ownerDetailTextField: UITextField!
    @IBOutlet weak var addButton: UIButton!
    var del: RefreshData?
    var ref = DatabaseReference.init()
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        self.setupCompnents()
    }

    func setupCompnents() {
        Utilities.styleTextField(petNameTextField)
        Utilities.styleTextField(petDOBTextField)
        Utilities.styleTextField(petLocationTextField)
        Utilities.styleTextField(petBreedTextField)
        Utilities.styleFilledButton(addButton)
        petDOBTextField.addInputViewDatePicker(target: self, selector: #selector(doneButtonPressed))
    }
    @objc func doneButtonPressed() {
        if let  datePicker = self.petDOBTextField.inputView as? UIDatePicker {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            self.petDOBTextField.text = dateFormatter.string(from: datePicker.date)
        }
        self.petDOBTextField.resignFirstResponder()
     }
    @IBAction func addPetImage(_ sender: UIButton) {
        self.setupImagePicker()
    }
    
    @IBAction func saveAllPetData(_ sender: UIButton) {
        Utilities.showAlert(title: "Success!", message: "Pet Saved successfully", controller: self)
        //self.showAlert()
        self.uploadImage(petImage.image!){ url in
            self.saveImage(self.petNameTextField.text!, profileUrl: url!){ success in
                if success != nil {
                    print("Done")
                    self.del?.toCallDataAgain()
                    
                }
            }
        }
    }
    
    @IBAction func clickedOnBackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
extension AddNewPetViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func setupImagePicker() {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.delegate = self
            imagePicker.isEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        petImage.image = image
        self.dismiss(animated: true, completion: nil)
    }
}
extension AddNewPetViewController {
    func uploadImage(_ image: UIImage, completion: @escaping ((_ url: URL?) -> ())) {
        let storageReference = Storage.storage().reference().child("petimage.png")
        let imageData = (petImage.image?.pngData())!
        let metaData = StorageMetadata()
        metaData.contentType = "image/png"
        storageReference.putData(imageData, metadata: metaData) { (metadata, error) in
            if error == nil {
                print("Success")
                storageReference.downloadURL { (url, error) in
                    if let url = url {
                        completion(url)
                    }
                }
            } else {
                print("Error in save image")
                completion(nil)
            }
            
        }
    }
    
    func saveImage(_ name: String, profileUrl: URL, completion: @escaping((_ url: URL?)->())) {
        let dict = ["petName": petNameTextField.text!, "petDOB": petDOBTextField.text!, "petLocation": petLocationTextField.text!, "petBreed": petBreedTextField.text!, "ownerDetails": ownerDetailTextField.text!, "petImageUrl": profileUrl.absoluteString] as [String : Any]
        self.ref.child("pet").childByAutoId().setValue(dict)
        
    }
//    func showAlert() {
//        let alert = UIAlertController(title: "Success!", message: "Pet Saved successfully", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
//            switch action.style{
//                case .default:
//                    self.dismiss(animated: true, completion: nil)
//                
//                case .cancel:
//                print("cancel")
//                
//                case .destructive:
//                print("destructive")
//                
//            }
//        }))
//        self.present(alert, animated: true, completion: nil)
//    }
}
