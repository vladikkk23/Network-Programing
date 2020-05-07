////
////  ImageUploader.swift
////  ChatRoomwithTCPSocket
////
////  Created by vladikkk on 05/05/2020.
////  Copyright © 2020 PR. All rights reserved.
////
//
//import UIKit
//
//class ImageUploader {
//
//    // MARK: Properties
//    static let shared = ImageUploader()
//
//    // Uploaded image URL
//    var imageURL = ""
//
//    // client ID from 'imgur'
//    private let clientID = "6ddf45897e8c141"
//
//    private init() {}
//
//    // MARK: Methods
//
//    func uploadImageToImgur(image: UIImage) {
//        getBase64Image(image: image) { base64Image in
//            DispatchQueue.global(qos: .background).async {
//                let boundary = "Boundary-\(UUID().uuidString)"
//
//                var request = URLRequest(url: URL(string: "https://api.imgur.com/3/image")!)
//                request.addValue("Client-ID \(self.clientID)", forHTTPHeaderField: "Authorization")
//                request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
//
//                request.httpMethod = "POST"
//
//                var body = ""
//                body += "--\(boundary)\r\n"
//                body += "Content-Disposition:form-data; name=\"image\""
//                body += "\r\n\r\n\(base64Image ?? "")\r\n"
//                body += "--\(boundary)--\r\n"
//                let postData = body.data(using: .utf8)
//
//                request.httpBody = postData
//
//                URLSession.shared.dataTask(with: request) { data, response, error in
//                    if let error = error {
//                        NSLog("Failed with error: \(error)")
//                        return
//                    }
//                    guard let resp = response as? HTTPURLResponse,
//                        (200...299).contains(resp.statusCode) else {
//                            NSLog("Server Error: \(response!.description)")
//                            return
//                    }
//
//                    if let mimeType = resp.mimeType, mimeType == "application/json", let data = data {
//                        let parsedResult: [String: AnyObject]
//                        do {
//                            parsedResult = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String: AnyObject]
//                            if let dataJson = parsedResult["data"] as? [String: Any] {
//                                DispatchQueue.main.async {
//                                    self.imageURL = dataJson["link"] as? String ?? ""
//                                }
//                            }
//                        } catch {
//                            NSLog("Serialization Error: \(#line)")
//                        }
//                    }
//                }.resume()
//            }
//        }
//    }
//
//    func getBase64Image(image: UIImage, complete: @escaping (String?) -> ()) {
//        DispatchQueue.main.async {
//            let imageData = image.jpegData(compressionQuality: 0.5)
//            let base64Image = imageData?.base64EncodedString(options: .lineLength64Characters)
//            complete(base64Image)
//        }
//    }
//}
