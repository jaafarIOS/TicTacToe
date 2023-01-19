//
//  ViewModel.swift
//  TicTacFinger
//
//  Created by Jaafar Zubaidion 1/11/23.
//

import Foundation

class ViewModel: ObservableObject {
    
    static func preview() -> ViewModel {
        ViewModel()
    }
    
    @Published var game = Game()
    var layout = Layout()
    
    func clickTileIntent(at index: Int) -> Bool {
        game.clickTile(at: index)
    }
    
    
    var currentPlayer: GamePlayer { game.currentPlayer }
    var winsX: Int { game.winsX }
    var winsO: Int { game.winsO }
    
    var gameResultTest: String {
        if game.winner == .x {
            return "X Wins!"
        } else if game.winner == .o {
            return "O Wins!"
        } else {
            return "Cat's Game!"
        }
    }
    
    func resetGameIntent() {
        game.reset()
    }
    
}
