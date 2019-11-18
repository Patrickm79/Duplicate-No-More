//
//  PhotoModelController.swift
//  Duplicate-No-More
//
//  Created by Patrick Millet on 11/18/19.
//  Copyright © 2019 Patrick Millet. All rights reserved.
//

import UIKit

class PhotoController {
    
    init() {
        loadFromPersistentStore()
    }
    
    
    var photos: [Photo] = []
    

    
    func createPhoto(named title: String, with data: Data) {
        let photo = Photo(imageData: data, title: title)
        
        photos.append(photo)
        saveToPersistentStore()
    }
    
    func update(photo: Photo, named title: String, with data: Data) {
        guard let index = photos.firstIndex(of: photo) else { return }
        let photo = Photo(imageData: data, title: title)
        photos[index] = photo
        saveToPersistentStore()
    }
    
    func deletePhoto(photo: Photo, named title: String, with data: Data) {
        guard let index = photos.firstIndex(of: photo) else { return }
        let photo = Photo(imageData: data, title: title)
        photos[index] = photo
    }
    
    // MARK: PERSISTENCE
    
    private var persistentFileURL: URL? {
            let fm = FileManager.default
            guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
            return dir.appendingPathComponent("photos.plist")
        }

        private func saveToPersistentStore() {
            guard let url = persistentFileURL else { return }

            do {
                let encoder = PropertyListEncoder()
                let data = try encoder.encode(photos)
                try data.write(to: url)
            } catch {
                print("Error saving photos data: \(error)")
            }
        }

        private func loadFromPersistentStore() {
            let fm = FileManager.default
            guard let url = persistentFileURL,
                fm.fileExists(atPath: url.path) else { return }

            do {
                let data = try Data(contentsOf: url)
                let decoder = PropertyListDecoder()
                photos = try decoder.decode([Photo].self, from: data)
            } catch {
                print("Error loading photos data: \(error)")
        }
    }
}
