//
//  GameTileView.swift
//  TicTacFinger
//
//  Created by Jaafar Zubaidi on 1/11/23.
//

import SwiftUI

struct GameTileView: View {
    
    private static let padding: CGFloat = Device.isIpad ? 18.0 : 8.0
    private static let shapeInset: CGFloat = Device.isIpad ? 42.0 : 28.0
    private static let cornerRadius: CGFloat = Device.isIpad ? 18.0 : 12.0
    private static let strokeWidth: CGFloat = Device.isIpad ? 10.0 : 6.0
    
    let gameTile: GameTile
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        ZStack {
            FlippableCardView(isFaceDown: gameTile.isFaceDown,
                              front: front(),
                              back: back())
        }
        .frame(width: width,
               height: height)
    }
    
    func front() -> some View {
        ZStack {
            Image(systemName: gameTile.player.symbolName)
                .font(.system(size: width - (Self.shapeInset + Self.padding + Self.padding)))
        }
        .frame(width: width - (Self.padding + Self.padding),
               height: height - (Self.padding + Self.padding))
        .pillBox(backgroundColor: Color.black,
                 strokeColor: gameTile.isWinner ? Color.green : Color.blue,
                 cornerRadius: Self.cornerRadius,
                 strokeWidth: Self.strokeWidth)
        .foregroundColor(gameTile.isWinner ? Color.green : Color.blue)
    }
    
    func back() -> some View {
        ZStack {
            Image(systemName: "questionmark.square.fill")
                .font(.system(size: width - (Self.shapeInset + Self.padding + Self.padding)))
        }
        .frame(width: width - (Self.padding + Self.padding),
               height: height - (Self.padding + Self.padding))
        .pillBox(backgroundColor: Color.white,
                 strokeColor: Color.gray,
                 cornerRadius: Self.cornerRadius,
                 strokeWidth: Self.strokeWidth)
        .foregroundColor(.gray)
    }
    
}

struct GameTileView_Previews: PreviewProvider {
    static var previews: some View {
        GameTileView(gameTile: GameTile.preview(),
                     width: 90,
                     height: 90)
    }
}
