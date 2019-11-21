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
    
    func hammingDistance(photoOne: String, photoTwo: String) -> Int? {
        guard !photoOne.isEmpty, !photoTwo.isEmpty, photoOne.count == photoTwo.count else {
            return nil
        }

        var w1Iterator = photoOne.makeIterator()
        var w2Iterator = photoTwo.makeIterator()

        var distance = 0;
        while let w1Char = w1Iterator.next(), let w2Char = w2Iterator.next()  {
            distance += (w1Char != w2Char) ? 1 : 0
        }
        return distance
    }
    
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
    
    func convertPhoto(_ photo: Photo) -> String{
        let photoData = photo.imageData
        
        let photoString = photoData.base64EncodedString()

        return photoString
    }
}
