//
//  ActivityCell.swift
//  PetFitApp
//
//  Created by AMIIT GUPTA on 08/12/21.
//

import UIKit

protocol RemoveActivity {
    func removeIem(position: Int)
}
class ActivityCell: UITableViewCell {

    
    @IBOutlet weak var actvity: UILabel!
    @IBOutlet weak var when: UILabel!
    @IBOutlet weak var notes: UILabel!
     var del: RemoveActivity?
    var position = 0
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        del?.removeIem(position: position)
    }
}
