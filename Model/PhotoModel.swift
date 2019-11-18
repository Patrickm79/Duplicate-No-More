//
//  PhotoModel.swift
//  Duplicate-No-More
//
//  Created by Patrick Millet on 11/18/19.
//  Copyright © 2019 Patrick Millet. All rights reserved.
//

import Foundation
import UIKit

struct Photo: Equatable, Codable {
    var checkedPhoto: String
    var hasChecked: Bool = false
    
    init(selected photo: String, hasChecked: Bool) {
        self.checkedPhoto = photo
        self.hasChecked = hasChecked
        
        var photo: UIImage{
            return UIImage(named: checkedPhoto)!
        }
    }
}
