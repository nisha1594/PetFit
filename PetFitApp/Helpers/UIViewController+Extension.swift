//
//  UIViewController+Extension.swift
//  PetFitApp
//
//  Created by AMIIT GUPTA on 29/11/21.
//

import Foundation
import UIKit

extension UIViewController {
    class func loadController() -> Self {
         return Self(nibName: String(describing: self), bundle: nil)
    }
}
extension UITableViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}
