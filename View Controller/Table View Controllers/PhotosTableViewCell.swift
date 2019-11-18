//
//  PhotosTableViewCell.swift
//  Duplicate-No-More
//
//  Created by Patrick Millet on 11/18/19.
//  Copyright © 2019 Patrick Millet. All rights reserved.
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
        
    var collectionViewOffset: CGFloat {
        get {
            return collectionView.contentOffset.x
        }
        
        set {
            collectionView.contentOffset.x = newValue
        }
    }
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    
   func setCollectionViewDataSourceDelegate(dataSourceDelegate: UICollectionViewDataSource & UICollectionViewDelegate, forRow row: Int) {
       collectionView.delegate = dataSourceDelegate
       collectionView.dataSource = dataSourceDelegate
       collectionView.tag = row
       collectionView.reloadData()
   }
}
