//
//  File.swift
//  tictactoe
//
//  Created by Vedad Sose on 11/06/16.
//  Copyright © 2016 seeout. All rights reserved.
//

import Foundation
import SwiftyJSON

func mutate(action: JSON, state: GameState?) -> GameState {
  var nextState = state
  
  switch action["type"].stringValue {
    case "MOVE":
      nextState!.board[action["y"].intValue][action["x"].intValue] = action["player"].intValue == 1 ? .X : .O
      return nextState!
    
    case "INIT":
      return GameState(room: action["room"].intValue, board: parseBoard(emptyBoard()))
    
    default:
      return nextState!
  }
}

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

// Create empty board
func emptyBoard() -> [[Int]] {
  let size = 3
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
