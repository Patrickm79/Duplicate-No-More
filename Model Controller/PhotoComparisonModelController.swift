//
//  PhotoComparisonModelController.swift
//  Duplicate-No-More
//
//  Created by Patrick Millet on 11/19/19.
//  Copyright © 2019 Patrick Millet. All rights reserved.
//

import UIKit
import Photos

class PhotoComparisonController {
    
    var photos: Photo?
    var convertedArray: [Int] = []
    
    
    func createBitcast(photoOne: Int, photoTwo: Int) -> Int {
        let signedDifferentBits = photoOne ^ photoTwo
        var differentBits:UInt = UInt(bitPattern: signedDifferentBits)
        var counter = 0
        
        while differentBits > 0 {
            let maskedBits = differentBits & 1
            
            if maskedBits != 0 {
                counter += 1
            }
            differentBits = differentBits >> 1
        }
        return counter
    }
    
    func convertPhoto(_ photo: Photo) -> Int{
        let photoData = photo.imageData
        let photoString = String(data: photoData, encoding: String.Encoding.utf8)
        let photoInt = Int(photoString ?? "")
        
        return photoInt!
    }
}
