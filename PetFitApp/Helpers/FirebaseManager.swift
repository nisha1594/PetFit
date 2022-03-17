//
//  FirebaseManager.swift
//  PetFitApp
//
//  Created by AMIIT GUPTA on 08/12/21.
//

import Foundation
import Firebase

class FirebaseManager {
   static let shared = FirebaseManager()
    let reference = Database.database().reference()
}
// MARK: - Removing functions
extension FirebaseManager {
   public func removePost(withID: String) {
     
         let reference = self.reference.child("activity").child(withID)
         reference.removeValue { error, _ in
            print(error?.localizedDescription)
         }
   }
}
