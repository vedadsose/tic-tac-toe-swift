//
//  Game.swift
//  tictactoe
//
//  Created by Vedad Sose on 09/06/16.
//  Copyright © 2016 seeout. All rights reserved.
//

import Foundation

class Game {
  var board:[[FieldState]]?
  
  init(size: Int) {
    board = parseBoard(emptyBoard(size))
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
  }
  
}