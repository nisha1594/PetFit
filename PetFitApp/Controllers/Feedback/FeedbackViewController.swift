//
//  FeedbackViewController.swift
//  PetFitApp
//
//  Created by AMIIT GUPTA on 07/12/21.
//

import UIKit
import Firebase
import FirebaseAuth

class FeedbackViewController: UIViewController {

    @IBOutlet weak var emojiCollectionView: UICollectionView!
    @IBOutlet weak var categoryCollectionView: UICollectionView!
    @IBOutlet weak var feddbackField: UITextView!
    @IBOutlet weak var submitButton: UIButton!
    
    var emojiImge = [UIImage(named: "verysad"),UIImage(named: "sad"),UIImage(named: "smile"),UIImage(named: "happy"),UIImage(named: "veryhappy")]
    var emojiTitle = ["Very Dissatisfied","Dissatisfied","Average","Satisfied","Very Satisfied"]
    var categoryname = ["Suggestions","Complaints","Compliments"]
    var feedback = ""
    var feedbackCategory = ""
    var selectedIndex = Int()
    var selectedCategoryIndex = Int()
    var ref = DatabaseReference.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initialSetup()
        self.emojiCollectionView.register(UINib(nibName: EmojiCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: EmojiCollectionViewCell.reuseIdentifier)
        self.categoryCollectionView.register(UINib(nibName: CategoryCollectionViewCell.reuseIdentifier, bundle: nil), forCellWithReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier)
    }

    @IBAction func backButtonpressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitButtonTapped(_ sender: UIButton) {
        self.ref = Database.database().reference()
        let userID : String = (Auth.auth().currentUser?.uid)!
        let message = self.feddbackField.text
        guard let feedbackData = ["userID": userID,"feedbackResponse": feedback, "feedbackCategory": feedbackCategory,"feedbackMessage": message] as? [String: Any] else {return}
        self.ref.child("feedback").setValue(feedbackData)
      Utilities.showAlert(title: "Success!", message: "Feedback sent successfully", controller: self)
    }
    
}
extension FeedbackViewController {
    func initialSetup() {
        Utilities.styleFilledButton(self.submitButton)
        self.emojiCollectionView.addCornerRadius(10)
    }
}

extension FeedbackViewController: UICollectionViewDataSource, UICollectionViewDelegate  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case emojiCollectionView:
            return emojiTitle.count
        case categoryCollectionView:
            return categoryname.count
        default:
            return 0
        }
    }
    
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      if collectionView == emojiCollectionView {
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: EmojiCollectionViewCell.reuseIdentifier, for: indexPath) as? EmojiCollectionViewCell else {return UICollectionViewCell()}
         cell.emojiTitle.text = emojiTitle[indexPath.row]
         let templateImage = emojiImge[indexPath.row]?.withRenderingMode(.alwaysTemplate)
         cell.emoji.image = templateImage
         if selectedIndex == indexPath.row {
            cell.emoji.tintColor = #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1)
         } else {
            cell.emoji.tintColor = .black
         }
         return cell
      }
      if collectionView == categoryCollectionView {
         guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCollectionViewCell.reuseIdentifier, for: indexPath) as? CategoryCollectionViewCell else {return UICollectionViewCell()}
         cell.addCornerRadius(5)
         cell.categoryName.text = categoryname[indexPath.row]
         cell.backgroundColor = .black
         if selectedCategoryIndex == indexPath.row {
            cell.backgroundColor = .blue
         } else {
            cell.backgroundColor = .black
         }
         return cell
         
      }
      return UICollectionViewCell()
   }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == emojiCollectionView {
            self.feedback = emojiTitle[indexPath.row]
         selectedIndex = indexPath.row
         self.emojiCollectionView.reloadData()
        }
        if collectionView == categoryCollectionView {
            self.feedbackCategory = categoryname[indexPath.row]
         selectedCategoryIndex = indexPath.row
         self.categoryCollectionView.reloadData()
        }
        
    }
}
extension FeedbackViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == emojiCollectionView {
            return CGSize(width: (emojiCollectionView.frame.width/5)-10,height:emojiCollectionView.frame.height)
        }
        if collectionView == categoryCollectionView {
            return CGSize(width: (categoryCollectionView.frame.width/3)-10,height:emojiCollectionView.frame.height)
        }
        return CGSize()
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
