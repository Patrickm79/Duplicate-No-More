//
//  DupeDetectorViewController.swift
//  Duplicate-No-More
//
//  Created by Patrick Millet on 11/18/19.
//  Copyright © 2019 Patrick Millet. All rights reserved.
//

import UIKit

class DupeDetectorViewController: UIViewController {
    //MARK: PROPERTIES
    
    let photoController = PhotoController()
    let photoComparisonController = PhotoComparisonController()
    let collectionViewController = PhotosCollectionViewController()
    
    var photo: Photo?
    
    var check1: Int = 0
    var check2: Int = 0


    //MARK: OUTLETS
    
    @IBOutlet weak var imageOneOutlet: UIImageView!
    
    @IBOutlet weak var imageTwoOutlet: UIImageView!
    
    
    
    //MARK: LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    
    //MARK: ACTIONS
    
    
    @IBAction func imageOneTapped(_ sender: Any) {
        guard let selectedCell = collectionViewController.collectionView.indexPathsForSelectedItems else { return }
        
        let singleCell = collectionViewController.collectionView.cellForItem(at: <#T##IndexPath#>)
        
    }
    
    
    
    @IBAction func imageTwoTapped(_ sender: Any) {
        
        
    }
    
    
    
    @IBAction func compareTapped(_ sender: Any) {
        let result = photoComparisonController.createBitcast(photoOne: check1, photoTwo: check2)
        
        if result == 0 {
            
        }
    }
    
    
    
    //MARK: - METHODS
    
    private func updateViews() {
        guard let imageData = photo?.imageData else { return }
        imageOneOutlet.image = UIImage(data: imageData)
}
    
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ImageOneTapSegue":
            guard let detailVC = segue.destination as? PhotosCollectionViewController else { return }
            detailVC.photoController = photoController
        case "ImageTwoTapSegue":
            guard let detailVC = segue.destination as? PhotosCollectionViewController else { return }
            detailVC.photoController = photoController
        default:
            return
        }
    }
    

}
