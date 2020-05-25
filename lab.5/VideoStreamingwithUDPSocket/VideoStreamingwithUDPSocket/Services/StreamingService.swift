//
//  StreamingService.swift
//  VideoStreamingwithUDPSocket
//
//  Created by vladikkk on 21/05/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import Foundation
import Network

class StreamingService {
    
    // MARK: Properties
    static let shared = StreamingService()
    
    private var connection: NWConnection?
    private var hostUDP: NWEndpoint.Host = "192.168.0.47"
    private var portUDP: NWEndpoint.Port = 10001
    
    private init() {}
    
    // MARK: Methods
    func connect() {
        
        // Get connection ready
        var x = 0
        while(x<1000000000) {
            x+=1
        }
        
        self.connection = NWConnection(host: hostUDP, port: portUDP, using: .udp)
        
        self.connection?.stateUpdateHandler = { (newState) in
            print("This is stateUpdateHandler:")
            switch (newState) {
            case .ready:
                NSLog("State: Ready\n")
                self.sendString("Connected")
                self.receive()
            case .setup:
                NSLog("State: Setup\n")
            case .cancelled:
                NSLog("State: Cancelled\n")
            case .preparing:
                NSLog("State: Preparing\n")
            default:
                NSLog("ERROR! State not defined!\n")
            }
        }
        
        self.connection?.start(queue: .global())
    }
    
    func sendString(_ content: String) {
        guard let contentToSendUDP = content.data(using: .utf8) else {
            NSLog("Error: Failed to convert string to data->\(#function)")
            
            return
        }
        
        contentToSendUDP.withUnsafeBytes { (u8Ptr: UnsafePointer<UInt8>) in
            let mutRawPointer = UnsafeMutableRawPointer(mutating: u8Ptr)
            let uploadChunkSize = 45000
            let totalSize = contentToSendUDP.count
            var offset = 0
            
            while offset < totalSize {
                
                let chunkSize = offset + uploadChunkSize > totalSize ? totalSize - offset : uploadChunkSize
                let chunk = Data(bytesNoCopy: mutRawPointer+offset, count: chunkSize, deallocator: Data.Deallocator.none)
                
                self.connection?.send(content: chunk, completion: NWConnection.SendCompletion.contentProcessed(({ (NWError) in
                    if (NWError == nil) {
                        print("Data was sent to UDP")
                    } else {
                        print("ERROR! Error when data (Type: Data) sending. NWError: \n \(NWError!)")
                    }
                })))
                
                offset += chunkSize
            }
        }
    }
    
    func sendData(_ content: Data) {
        content.withUnsafeBytes { (u8Ptr: UnsafePointer<UInt8>) in
            let mutRawPointer = UnsafeMutableRawPointer(mutating: u8Ptr)
            let uploadChunkSize = 45000
            let totalSize = content.count
            var offset = 0
            
            while offset < totalSize {
                
                let chunkSize = offset + uploadChunkSize > totalSize ? totalSize - offset : uploadChunkSize
                let chunk = Data(bytesNoCopy: mutRawPointer+offset, count: chunkSize, deallocator: Data.Deallocator.none)
                
                self.connection?.send(content: chunk, completion: NWConnection.SendCompletion.contentProcessed(({ (NWError) in
                    if (NWError == nil) {
                        print("Data was sent to UDP")
                    } else {
                        print("ERROR! Error when data (Type: Data) sending. NWError: \n \(NWError!)")
                    }
                })))
                
                offset += chunkSize
            }
        }
    }
    
    func receive() {
        self.connection?.receiveMessage { (data, context, isComplete, error) in
            if (isComplete) {
                NSLog("Content Received: \(data?.count ?? 0) bytes")
                if (data != nil) {
                    let backToString = String(decoding: data!, as: UTF8.self)
                    print("Received message: \(backToString)")
                } else {
                    print("Data == nil")
                }
            }
        }
    }
}
