//
//  GameBord.swift
//  TicTacFinger
//
//  Created by Jaafar Zubaidion 1/11/23.
//

import Foundation

struct GameBoard {
    
    private(set) var tiles: [GameTile]
    
    init() {
        tiles = [GameTile]()
        for i in 0..<9 {
            let newTile = GameTile(index: i)
            tiles.append(newTile)
        }
    }
    
    mutating func clickTile(at index: Int, player: GamePlayer) -> Bool {
        if canClickTile(at: index) {
            tiles[index].isFaceDown = !tiles[index].isFaceDown
            tiles[index].player = player
            return true
        }
        return false
    }
    
    func canClickTile(at index: Int) -> Bool {
        if index >= 0 && index < tiles.count {
            return tiles[index].isFaceDown
        }
        return false
    }
    
    func allTilesFaceUp() -> Bool {
        var result = false
        tiles.forEach { tile in
            if tile.isFaceDown { result = false }
        }
        return result
    }
    
    mutating func applyWinningTiles(tiles: [GameTile]) {
        tiles.map { $0.index }.forEach { index in
            self.tiles[index].isWinner = true
        }
    }
    
    func winner() -> (player: GamePlayer, tiles: [GameTile])? {
        
        var grid = [[GameTile]](repeating: [GameTile](), count: 3)
        var gridX = 0
        for i in 0..<tiles.count {
            grid[gridX].append(tiles[i])
            gridX += 1
            if gridX == 3 { gridX = 0 }
        }
        
        let checkMatch: (_ tile1: GameTile, _ tile2: GameTile, _ tile3: GameTile)
        -> (player: GamePlayer, tiles: [GameTile])? = { tile1, tile2, tile3 in
            var count = 0
            let player = tile1.player
            if !tile1.isFaceDown && tile1.player == player { count += 1 }
            if !tile2.isFaceDown && tile2.player == player { count += 1 }
            if !tile3.isFaceDown && tile3.player == player { count += 1 }
            if count == 3 {
                return (player, [tile1, tile2, tile3])
            } else {
                return nil
            }
        }
        
        for x in 0..<3 {
            if let result = checkMatch(grid[x][0], grid[x][1], grid[x][2]) {
                return result
            }
        }
        
        for y in 0..<3 {
            if let result = checkMatch(grid[0][y], grid[1][y], grid[2][y]) {
                return result
            }
        }
        
        if let result = checkMatch(grid[0][0], grid[1][1], grid[2][2]) {
            return result
        }
        
        if let result = checkMatch(grid[2][0], grid[1][1], grid[0][2]) {
            return result
        }
        
        return nil
    }
    
}
