//
//  ResultsView.swift
//  TicTacFinger
//
//  Created by Jaafar Zubaidi on 1/13/23.
//

import SwiftUI

struct ResultsView: View {
    
    
    private static let resultBoxHeight: CGFloat = Device.isIpad ? 80.0 : 58.0
    private static let newGameButtonHeight: CGFloat = Device.isIpad ? 80.0 : 58.0
    private static let contentSpacing: CGFloat = Device.isIpad ? 24.0 : 16.0
    private static let resultBoxPadding: CGFloat = Device.isIpad ? 36.0 : 12.0
    private static let newGameButtonPadding: CGFloat = Device.isIpad ? 36.0 : 12.0
    
    
    let gameResultsText: String
    let winner: GamePlayer?
    let newGameAction: () -> Void
    
    var body: some View {
        VStack {
            ZStack {
                VStack {
                    GeometryReader { geometry in
                        HStack {
                            Spacer()
                            mainContentView(geometry: geometry)
                            Spacer()
                        }
                    }
                }
                .padding(.all, Device.isIpad ? 36.0 : 24.0)
                .pillBox(backgroundColor: .gray,
                         strokeColor: .black)
            }
            .padding(.all, Device.isIpad ? 36.0 : 24.0)
        }
        .background(Color.gray)
    }
    
    func mainContentView(geometry: GeometryProxy) -> some View {
        
        let contentWidth: CGFloat = min(320.0, geometry.size.width - 38.0)
        var badgeHeight: CGFloat = geometry.size.height - (
            Self.resultBoxHeight + Self.newGameButtonHeight + Self.contentSpacing * 2 + Self.resultBoxPadding + Self.newGameButtonPadding
        )
        badgeHeight = min(badgeHeight, 320.0)
        
        return VStack {
            resultBoxView(contentWidth: contentWidth)
            badgeView(contentWidth: contentWidth, contentHeight: badgeHeight)
            newGameButton(contentWidth: contentWidth)
        }
        .frame(width: contentWidth, height: geometry.size.height)
    }
    
    func resultBoxView(contentWidth: CGFloat) -> some View {
        HStack {
            Spacer()
            VStack {
                Spacer()
                Text(gameResultsText)
                    .font(.system(size: Device.isIpad ? 40.0 : 28.0).bold())
                Spacer()
            }
            Spacer()
        }
        .frame(width: contentWidth, height: Self.newGameButtonHeight)
        .pillBox(backgroundColor: .gray, strokeColor: .black)
        .foregroundColor(.black)
    }
    
    func newGameButton(contentWidth: CGFloat) -> some View {
        Button {
            newGameAction()
        } label: {
            HStack {
                Spacer()
                VStack {
                    Spacer()
                    Text("New Game!")
                        .font(.system(size: Device.isIpad ? 40.0 : 28.0).bold())
                    Spacer()
                }
                Spacer()
            }
            .frame(width: contentWidth, height: Self.newGameButtonHeight)
            .pillBox(backgroundColor: .blue, strokeColor: .white)
            .foregroundColor(.white)
        }
    }
    
    func badgeView(contentWidth: CGFloat, contentHeight: CGFloat) -> some View {
        HStack {
            Spacer()
            VStack {
                if winner == .x {
                    winXGameView(contentWidth: contentWidth,
                                 contentHeight: contentHeight)
                } else if winner == .o {
                    winOGameView(contentWidth: contentWidth,
                                 contentHeight: contentHeight)
                } else {
                    catsGameView(contentWidth: contentWidth,
                                 contentHeight: contentHeight)
                }
            }
            Spacer()
        }
        .frame(width: contentWidth, height: contentHeight)
        .pillBox(backgroundColor: .gray,
                 strokeColor: .black)
    }
    
    
    func catsGameView(contentWidth: CGFloat, contentHeight: CGFloat) -> some View {
        VStack {
            Image(systemName: "flag.2.crossed.circle")
                .font(.system(size: min(contentWidth, contentHeight) * 0.666))
        }
        .foregroundColor(.black)
    }
    
    func winOGameView(contentWidth: CGFloat, contentHeight: CGFloat) -> some View {
        VStack {
            Image(systemName: GamePlayer.symbolNameO)
                .font(.system(size: min(contentWidth, contentHeight) * 0.666))
        }
        .foregroundColor(.black)
    }
    
    func winXGameView(contentWidth: CGFloat, contentHeight: CGFloat) -> some View {
        VStack {
            Image(systemName: GamePlayer.symbolNameX)
                .font(.system(size: min(contentWidth, contentHeight) * 0.666))
        }
        .foregroundColor(.black)
    }
    
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(gameResultsText: "Cat's Game!",
                    winner: nil,
                    newGameAction: { })
    }
}
