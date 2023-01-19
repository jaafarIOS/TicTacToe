//
//  ScoreView.swift
//  TicTacFinger
//
//  Created by Jaafar Zubaidi on 1/13/23.
//

import SwiftUI

struct ScoreView: View {
    
    let currentPlayer: GamePlayer
    let winsX: Int
    let winsO: Int
    let landscape: Bool
    
    var body: some View {
        VStack {
            
            HStack {
                scoreBox(player: .x, wins: winsX)
                Spacer()
                
                VStack(spacing: 4.0) {
                    Text("Move")
                        .font(.system(size: Device.isIpad ? 38.0 : 24.0).bold())
                        .padding(.top, 4.0)
                    
                    ZStack {
                        Image(systemName: currentPlayer.symbolName)
                            .font(.system(size: symbolSize()))
                    }
                    .frame(width: symbolSize() + (Device.isIpad ? 12.0 : 4.0),
                           height: symbolSize() + (Device.isIpad ? 12.0 : 4.0))
                    
                    
                }
                .foregroundColor(.white)
                
                Spacer()
                scoreBox(player: .o, wins: winsO)
                
            }
            
            blackLine()
        }
        .background(Color.gray)
    }
    
    func symbolSize() -> CGFloat {
        if Device.isIpad {
            return 54.0
        } else {
            return landscape ? 30.0 : 44.0
        }
    }
    
    func scoreBox(player: GamePlayer, wins: Int) -> some View {
        ZStack {
            VStack {
                Image(systemName: player.symbolName)
                    .font(.system(size: symbolSize() * 0.666))
                HStack {
                    Text("W: \(wins)")
                        .font(.system(size: Device.isIpad ? 26.0 : 20.0).bold())
                }
            }
            .padding(.horizontal, 6.0)
            .padding(.vertical, landscape ? 2.0 : 12.0)
            .foregroundColor(.white)
        }
    }
    
    func blackLine() -> some View {
        HStack {
            Spacer()
        }
        .frame(height: 1.0)
        .background(Color.black)
    }
    
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ScoreView(currentPlayer: .x, winsX: 4, winsO: 2, landscape: false)
            ScoreView(currentPlayer: .o, winsX: 0, winsO: 0, landscape: false)
            ScoreView(currentPlayer: .x, winsX: 1, winsO: 100, landscape: true)
            ScoreView(currentPlayer: .o, winsX: 100, winsO: 1, landscape: true)
            Spacer()
        }
    }
}
