//
//  ActivityDataModel.swift
//  PetFitApp
//
//  Created by AMIIT GUPTA on 08/12/21.
//

import Foundation
import UIKit

class ActivityDataModel {
    var activity: String?
    var when: String?
    var notes: String?
    
    init(activity: String, when: String, notes: String) {
        self.activity = activity
        self.when = when
        self.notes = notes
    }
}
