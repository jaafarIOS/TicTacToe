//
//  Game.swift
//  TicTacFinger
//
//  Created by Jaafar Zubaidion 1/11/23.
//

import Foundation

struct Game {
    
    var currentPlayer = GamePlayer.x
    private(set) var board = GameBoard()
    
    private(set) var winner: GamePlayer?
    private var _didGameEnd = false
    
    private(set) var winsX = 0
    private(set) var winsO = 0
    
    mutating func clickTile(at index: Int) -> Bool {
        if canClickTile(at: index) {
            if board.clickTile(at: index, player: currentPlayer) {
             
                if let result = board.winner() {
                    winner = result.player
                    _didGameEnd = true
                    board.applyWinningTiles(tiles: result.tiles)
                    if winner == .x { winsX += 1 }
                    if winner == .o { winsO += 1 }
                    return true
                }
                
                if board.allTilesFaceUp() {
                    winner = nil
                    _didGameEnd = true
                    return true
                }
                
                currentPlayer = (currentPlayer == .x) ? .o : .x
            }
        }
        return false
    }
    
    func canClickTile(at index: Int) -> Bool {
        if _didGameEnd { return false }
        return board.canClickTile(at: index)
    }
    
    mutating func reset() {
        _didGameEnd = false
        board = GameBoard()
        currentPlayer = .x
    }
    
}
