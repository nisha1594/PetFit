//
//  ActivitySchduledController.swift
//  PetFitApp
//
//  Created by AMIIT GUPTA on 08/12/21.
//

import UIKit
import Firebase

class ActivitySchduledController: UIViewController {

    
    @IBOutlet weak var activityTableView: UITableView!
    var activityData = [ActivityDataModel]()
    var ref = DatabaseReference.init()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.ref = Database.database().reference()
        self.getAllActivity()
        activityTableView.register(UINib(nibName: ActivityCell.reuseIdentifier, bundle: nil), forCellReuseIdentifier: ActivityCell.reuseIdentifier)

    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    func getAllActivity() {
        self.ref.child("activity").queryOrderedByKey().observe(.value){ (snapshot) in
            self.activityData.removeAll()
            if let snapShot = snapshot.children.allObjects as? [DataSnapshot] {
                for snap in snapShot {
                    if let mainDict = snap.value as? [String: AnyObject] {
                        let activity = mainDict["activity"] as? String ?? ""
                        let when = mainDict["when"] as? String ?? ""
                        let notes = mainDict["notes"] as? String ?? ""
                        self.activityData.append(ActivityDataModel(activity: activity, when: when, notes: notes))
                        self.activityTableView.reloadData()
                    }
                }
            }
            
        }
    }
}
extension  ActivitySchduledController: UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return activityData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ActivityCell.reuseIdentifier, for: indexPath) as? ActivityCell  else { return UITableViewCell()}
        cell.del = self
        cell.actvity.text = activityData[indexPath.row].activity
        cell.when.text = activityData[indexPath.row].when
        cell.notes.text = "Notes : \(activityData[indexPath.row].notes ?? "")"
        cell.position = indexPath.row
        cell.backgroundColor = .lightGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
extension ActivitySchduledController: RemoveActivity {
    func removeIem(position: Int) {
        FirebaseManager.shared.reference.child("activity").observeSingleEvent(of: .value) { (snapshot) in
            if let result = snapshot.children.allObjects as? [DataSnapshot] {
                   for child in result {
                    let orderID = child.key 
                    FirebaseManager.shared.removePost(withID: orderID)
                   }
                
            }
        }
        activityData.remove(at: position)
        activityTableView.deleteRows(at: [IndexPath(index: position)], with: UITableView.RowAnimation.automatic)
        self.activityTableView.reloadData()
    }
    
    
}
