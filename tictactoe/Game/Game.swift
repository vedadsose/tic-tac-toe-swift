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
}

class Game {
  var state:GameState? = nil
  let socket = SocketIOClient(socketURL: NSURL(string: "http://localhost:3000")!, options: [.Log(true), .ForcePolling(true)])
  
  init(size: Int) {
    let board = parseBoard(emptyBoard(size))
    state = GameState(room: 420, board: board)
    startListening()
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
  func dispatch(action: JSON) {
    guard let state = state else {
      print("State not initialized")
      return
    }
    
    self.state = mutate(action, state: state)
    notify(self.state!)
    if action["type"] == "MOVE" {
      socket.emit("update", action.object)
    }
  }
  
  // Web socket listener
  func startListening() {
    socket.on("connect") {data, ack in
      self.socket.emit("join", 420)
    }
    
    socket.on("update") { data, ack in
      self.dispatch(JSON(arrayLiteral: data[0])[0])
    }
    
    socket.connect()
  }
  
  // Create empty board
  func emptyBoard(size: Int) -> [[Int]] {
    var emptyBoard = [[Int]]()
    for _ in 0..<size {
      var row = [Int]()
      for _ in 0..<size {
        row.append(0)
      }
      
      emptyBoard.append(row)
    }
    
    return emptyBoard
  }
  
  // Transform numeric board to enum
  func parseBoard(board: [[Int]]) -> [[FieldState]] {
    var newBoard = [[FieldState]]()
    for x in 0..<board.count {
      var row = [FieldState]()
      for y in 0..<board.count {
        row.append(intToFieldState(board[x][y]))
      }
      
      newBoard.append(row)
    }
    
    return newBoard
  }
  
  func intToFieldState(i: Int) -> FieldState {
    switch i {
    case 0:
      return .Empty
    case 1:
      return .X
    case 2:
      return .O
    default:
      return .Empty
    }
  }
  /*
  func move(x: Int, y: Int) -> FieldState {
    guard var board = board else {
      print("Board not defined")
      return .Empty
    }
    
    print("New move ", x, y, board[x][y])
    if board[x][y] == FieldState.Empty || board[x][y] == FieldState.O {
      self.board![x][y] = .X
    } else {
      self.board![x][y] = .O
    }

    return self.board![x][y]
  }*/
  
}