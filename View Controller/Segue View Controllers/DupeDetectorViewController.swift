//
//  DupeDetectorViewController.swift
//  Duplicate-No-More
//
//  Created by Patrick Millet on 11/18/19.
//  Copyright © 2019 Patrick Millet. All rights reserved.
//

import UIKit

class DupeDetectorViewController: UIViewController, PhotoSelectionDelegate {
    
    
    //MARK: PROPERTIES
    
    let photoController = PhotoController()
    let photoComparisonController = PhotoComparisonController()
    
    var photo: Photo?
    
    var check1: String = ""
    var check2: String = ""
    
    var imageOnePhoto: Photo?
    var imageTwoPhoto: Photo?
    
    var imageOneTitle = ""
    var imageTwoTitle = ""
    
    var imageOneIndexPath: IndexPath?
    var imageTwoIndexPath: IndexPath?
    
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
        performSegue(withIdentifier: "ImageOneTapSegue", sender: nil)
    }
    
    
    @IBAction func imageTwoTapped(_ sender: Any) {
        performSegue(withIdentifier: "ImageTwoTapSegue", sender: nil)
    }
    
    
    
    @IBAction func compareTapped(_ sender: Any) {
        
        guard let photo1 = imageOnePhoto else { return }
        guard let photo2 = imageTwoPhoto else { return }
        
        let imageOneIndex = imageOneIndexPath
        let imageTwoIndex = imageTwoIndexPath
        
        let photoOneString = photoComparisonController.convertPhoto(photo1)
        let photoTwoString = photoComparisonController.convertPhoto(photo2)
        
        check1 = photoOneString
        check2 = photoTwoString
        
        guard let result = photoComparisonController.hammingDistance(photoOne: check1, photoTwo: check2) else { return }
        
        if imageOneIndex == imageTwoIndex {
            let alertController = UIAlertController(title: "CAUTION", message: "You have selcted the same initial image", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Return to selection", style: .cancel) { (_) in
                self.navigationController?.popViewController(animated: true)
            }
            alertController.addAction(alertAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        if result == 0 && imageOneIndex != imageTwoIndex {
            guard let indexPath = imageTwoIndexPath else { return }
            photoController.photos.remove(at: indexPath.item)
            photoController.saveToPersistentStore()
            
            let alertController = UIAlertController(title: "Duplicate Detected", message: "", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Delete Incoming!", style: .destructive) { (_) in
                ModalTransitionMediator.instance.sendPopoverDismissed(modelChanged: true)
                self.navigationController?.popViewController(animated: true)
                
            }
            
            alertController.addAction(alertAction)
            
            self.present(alertController, animated: true, completion: nil)
        }
        
        if result > 0 {
            let alertController = UIAlertController(title: "No Duplicate Detected", message: "", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Return", style: .cancel) { (_) in
                self.navigationController?.popViewController(animated: true)
            }
            alertController.addAction(alertAction)

            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    
    
    //MARK: - METHODS
    
    
    func selectCell(_ cell: PhotosCollectionViewCell, selectedImage: ImageSelected, indexPath: IndexPath) {
        
        guard let imageData = cell.photo?.imageData else { return }
        guard let imageTitle = cell.photo?.title else { return }
        guard let unwrappedphoto = cell.photo else { return }
        
        if selectedImage == .ImageOne {
            imageOneOutlet.image = UIImage(data: imageData)
            imageOneTitle = imageTitle
            imageOnePhoto = unwrappedphoto
            imageOneIndexPath = indexPath
        } else if selectedImage == .ImageTwo {
            imageTwoOutlet.image = UIImage(data: imageData)
            imageTwoTitle = imageTitle
            imageTwoIndexPath = indexPath
            imageTwoPhoto = unwrappedphoto
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "ImageOneTapSegue":
            guard let detailVC = segue.destination as? PhotosCollectionViewController else { return }
            detailVC.photoController = photoController
            detailVC.delegate = self
            detailVC.imageSelected = .ImageOne
        case "ImageTwoTapSegue":
            guard let detailVC = segue.destination as? PhotosCollectionViewController else { return }
            detailVC.photoController = photoController
            detailVC.delegate = self
            detailVC.imageSelected = .ImageTwo
        default:
            return
        }
    }
    
    
}

