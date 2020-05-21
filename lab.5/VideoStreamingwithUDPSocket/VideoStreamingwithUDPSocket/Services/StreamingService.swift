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
    private var hostUDP: NWEndpoint.Host = "127.0.0.1"
    private var portUDP: NWEndpoint.Port = 1001
    
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
        let contentToSendUDP = content.data(using: String.Encoding.utf8)
        self.connection?.send(content: contentToSendUDP, completion: NWConnection.SendCompletion.contentProcessed(({ (NWError) in
            if (NWError == nil) {
                print("Data was sent to UDP")
            } else {
                print("ERROR! Error when data (Type: Data) sending. NWError: \n \(NWError!)")
            }
        })))
    }
    
    func receive() {
        self.connection?.receiveMessage { (data, context, isComplete, error) in
            if (isComplete) {
                print("Receive is complete")
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
