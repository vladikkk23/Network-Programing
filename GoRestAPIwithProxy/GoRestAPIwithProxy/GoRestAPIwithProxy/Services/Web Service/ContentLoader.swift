//
//  ContentLoader.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 22/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import UIKit

class ContentLoader {
    
    //MARK: Properties
    static let shared = ContentLoader()
    
    private let webService = WebService.shared
    
    var content = [UIImage(named: "NoImage")!]
    var tempImages = [UIImage]()
    
    private init() {}
    
    //MARK: Methods
    func loadAlbumPhotos(photos: [Photo]) {
        
        for photo in photos {
            let urlString = photo.url
            
            if !self.tempImages.isEmpty {
                self.tempImages = []
            }
            
            DispatchQueue.global().async {
                if let url = URL(string: urlString) {
                    if let data = try? Data(contentsOf: url) {
                        if let image = UIImage(data: data) {
                            self.tempImages.append(image)
                        }
                    }
                }
            }
        }
    }
}
