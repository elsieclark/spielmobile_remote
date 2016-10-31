//
//  SocketIOManager.swift
//  SocketChat
//
//  Created by Will Clark on 2016-05-19.
//

import UIKit

class SocketIOManager: NSObject {
    
    static let sharedInstance = SocketIOManager()
    
    override init() {
        super.init()
    }
    
    var socket : SocketIOClient = SocketIOClient(socketURL: NSURL(string: "http://192.168.0.18:3000")! as URL)
    
    func establishConnection() {
        socket.connect()
    }
    
    func closeConnection() {
        socket.disconnect()
    }
    
    func sendMessage(message : String) {
        socket.emit("remote", message)
    }
    
    
    
}
