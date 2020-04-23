//
//  ContentUploader.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 23/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import UIKit

class ContentUploader {
    
    // MARK: Properties
    static let shared = ContentUploader()
    
    // Uploaded image URL
    var imgurUrl: String = ""
    
    // client ID from 'imgur'
    private let clientID = "CLIENT_ID"
    
    private init() {}
    
    // MARK: Methods

    func uploadImageToImgur(image: UIImage) {
        getBase64Image(image: image) { base64Image in
            let boundary = "Boundary-\(UUID().uuidString)"
            
            var request = URLRequest(url: URL(string: "https://api.imgur.com/3/image")!)
            request.addValue("Client-ID \(self.clientID)", forHTTPHeaderField: "Authorization")
            request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            
            request.httpMethod = "POST"
            
            var body = ""
            body += "--\(boundary)\r\n"
            body += "Content-Disposition:form-data; name=\"image\""
            body += "\r\n\r\n\(base64Image ?? "")\r\n"
            body += "--\(boundary)--\r\n"
            let postData = body.data(using: .utf8)
            
            request.httpBody = postData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    NSLog("Failed with error: \(error)")
                    return
                }
                guard let resp = response as? HTTPURLResponse,
                    (200...299).contains(resp.statusCode) else {
                        NSLog("Server Error: \(response!.description)")
                        return
                }
                if let mimeType = resp.mimeType, mimeType == "application/json", let data = data, let dataString = String(data: data, encoding: .utf8) {
                    DispatchQueue.main.async {
                        //                        self.loadingView.stop()
                    }
                    
                    print("imgur upload results: \(dataString)")
                    
                    let parsedResult: [String: AnyObject]
                    do {
                        parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: AnyObject]
                        if let dataJson = parsedResult["data"] as? [String: Any] {
                            NSLog("Link is : \(dataJson["link"] as? String ?? "Link not found")")
                            self.imgurUrl = dataJson["link"] as? String ?? ""
                        }
                    } catch {
                        // Display an error
                    }
                }
            }.resume()
        }
    }
    
    
    func getBase64Image(image: UIImage, complete: @escaping (String?) -> ()) {
        DispatchQueue.main.async {
            let imageData = image.pngData()
            let base64Image = imageData?.base64EncodedString(options: .lineLength64Characters)
            complete(base64Image)
        }
    }
}
