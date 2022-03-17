//
//  PetDataModel.swift
//  PetFitApp
//
//  Created by AMIIT GUPTA on 01/12/21.
//

import Foundation
import UIKit

class PetDataModel {
    var petName: String?
    var petDOB: String?
    var petLocation: String?
    var petBreed: String?
    var petImageUrl: String?
    var ownerDetails: String?
    
    init(petName: String, petDOB: String, petLocation: String,petBreed: String, petImageUrl: String, ownerDetails: String) {
        self.petName = petName
        self.petDOB = petDOB
        self.petLocation = petLocation
        self.petBreed = petBreed
        self.petImageUrl = petImageUrl
        self.ownerDetails = ownerDetails
    }
}
