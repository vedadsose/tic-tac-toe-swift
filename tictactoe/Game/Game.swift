//
//  Game.swift
//  tictactoe
//
//  Created by Vedad Sose on 09/06/16.
//  Copyright © 2016 seeout. All rights reserved.
//

import Foundation
import SocketIOClientSwift
import SwiftyJSON

struct GameState {
  var room: Int
  var board: [[FieldState]]
  var nowPlaying: Int = 2
}

class Game {
  var state:GameState? = nil
  let socket = SocketIOClient(socketURL: NSURL(string: "http://localhost:3000")!, options: [.Log(true), .ForcePolling(true)])
  
  init(room: Int = Int.random(1000...9999)) {
    dispatch(["type": "INIT", "room": room])
    startListening(room)
  }
  
  // Subscribers handling
  private var subscribers = [SubscriberDelegate]()
  
  func subscribe(subscriber: SubscriberDelegate) {
    subscribers.append(subscriber)
  }
  
  // Notifying the subscribers
  func notify(state: GameState) {
    for subscriber in subscribers {
      subscriber.update(state)
    }
  }
  
  // Dispatch function
  func dispatch(action: JSON, fromUpdate: Bool = false) {
    print("Idemo dispatch ", action)
    self.state = mutate(action, state: state)
    print("novi state je ", self.state)
    notify(self.state!)
    if !fromUpdate && action["type"] == "MOVE" {
      var sendAction = action
      sendAction["room"].int = state!.room
      socket.emit("update", sendAction.object)
    }
  }
  
  // Web socket listener
  func startListening(room: Int) {
    socket.on("connect") {data, ack in
      self.socket.emit("join", room)
    }
    
    socket.on("update") { data, ack in
      print("Go update!", data)
      self.dispatch(JSON(arrayLiteral: data[0])[0], fromUpdate: true)
    }
    
    socket.connect()
  }
}