//
//  File.swift
//  tictactoe
//
//  Created by Vedad Sose on 11/06/16.
//  Copyright © 2016 seeout. All rights reserved.
//

import Foundation
import SwiftyJSON

func mutate(action: JSON, state: GameState) -> GameState {
  var board = state.board
  print("action: ", action)
  if action["type"].stringValue == "MOVE" {
    board[action["y"].intValue][action["x"].intValue] = action["player"].intValue == 1 ? .X : .O
  }
  return GameState(room: state.room, board: board)
}