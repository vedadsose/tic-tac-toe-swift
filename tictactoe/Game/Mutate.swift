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
  var nextState: GameState
  if let state = state {
    nextState = state
  } else {
    nextState = GameState(room: action["room"].intValue, board: parseBoard(emptyBoard()), nowPlaying: 2)
  }
  
  switch action["type"].stringValue {
    case "MOVE":
      let x = action["x"].intValue
      let y = action["y"].intValue
      
      // Can't move if it's not user's turn to play
      if (action["player"].intValue != nextState.nowPlaying) { return nextState }
      
      // Can't play already played field
      if (nextState.board[x][y] != .Empty) { return nextState }
      
      // Can't play if someone won
      if(won(nextState.board)) { return nextState }
      
      nextState.board[x][y] = action["player"].intValue == 1 ? .X : .O
      nextState.nowPlaying = 1 + abs(nextState.nowPlaying-2)
      return nextState
    
    case "INIT":
      nextState.board = parseBoard(emptyBoard())
      return nextState
    
    default:
      return nextState
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

func won(board: [[FieldState]]) -> Bool {
  var diagonal = [[0, 0], [0, 0]]
  
  for x in 0..<board.count {
    var row = [0, 0]
    var column = [0, 0]
  
    for y in 0..<board.count {
      // Row
      if board[x][y] == .X { row[0] += 1}
      if board[x][y] == .O { row[1] += 1}
    
      // Column
      if board[y][x] == .X { column[0] += 1}
      if board[y][x] == .O { column[1] += 1}
    }
    
    // Diagonal 1
    if board[x][x] == .X { diagonal[0][0] += 1}
    if board[x][x] == .O { diagonal[0][1] += 1}
    
    // Diagonal 2
    if board[board.count-x-1][x] == .X { diagonal[1][0] += 1 }
    if board[board.count-x-1][x] == .O { diagonal[1][1] += 1 }
  
    // Check for winners in row/column
    if row[0] == board.count { return true }
    if row[1] == board.count { return true }
    
    if column[0] == board.count { return true }
    if column[1] == board.count { return true }
  }
  
  // Check for winners in diagonal
  if diagonal[0] == board.count { return true }
  if diagonal[1] == board.count { return true }
  
  return false
}
