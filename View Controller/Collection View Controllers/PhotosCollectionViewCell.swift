//
//  PhotosCollectionViewCell.swift
//  Duplicate-No-More
//
//  Created by Patrick Millet on 11/18/19.
//  Copyright © 2019 Patrick Millet. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    var photo: Photo? {
        didSet {
            updateViews()
        }
    }
    
    @IBOutlet weak var imageOutlet: UIImageView!
    @IBOutlet weak var labelOutlet: UILabel!
    
    func updateViews() {
        guard let photo = photo else { return }
        imageOutlet.image = UIImage(data: photo.imageData)
        labelOutlet.text = photo.title
    }
}
