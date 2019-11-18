//
//  PhotoModel.swift
//  Duplicate-No-More
//
//  Created by Patrick Millet on 11/18/19.
//  Copyright © 2019 Patrick Millet. All rights reserved.
//

import UIKit
import Photos

struct Photo: Equatable, Codable {
    var imageData: Data
    var title: String    

        var photo: UIImage{
            return UIImage(named: title)!
        }
    }

