//
//  ContentView.swift
//  TicTacFinger
//
//  Created by Jaafar Zubaidi on 1/11/23.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var viewModel: ViewModel
    @State var isShowingResultsScreen = false
    
    var body: some View {
        GeometryReader { worldGeometry in
           bodyContent(worldGeometry: worldGeometry)
        }
        .fullScreenCover(isPresented: $isShowingResultsScreen) {
            ResultsView(gameResultsText: viewModel.gameResultTest,
                        winner: viewModel.game.winner) {
                isShowingResultsScreen = false
                viewModel.resetGameIntent()
            }
        }
    }
    
    func bodyContent(worldGeometry: GeometryProxy) -> some View {
        let landscape = worldGeometry.size.width > worldGeometry.size.height
        
        return VStack {
            ScoreView(currentPlayer: viewModel.currentPlayer,
                      winsX: viewModel.winsX,
                      winsO: viewModel.winsO,
                      landscape: landscape)
            GeometryReader { layoutGeometry in
                boardContent(layoutGeometry: layoutGeometry)
            }
        }
        
    }
    
    
    func boardContent(layoutGeometry: GeometryProxy) -> some View {
        
        if viewModel.layout.registerGeometry(width: layoutGeometry.size.width,
                                             height: layoutGeometry.size.height) {
            //post an update / re-draw
            DispatchQueue.main.async {
                viewModel.objectWillChange.send()
            }
        }
        
        return ZStack(alignment: Alignment(horizontal: .leading, vertical: .top)) {
            ForEach(viewModel.layout.separators) { separator in
                separatorView(separator: separator)
            }
            ForEach(0..<9) { index in
                gameTile(index: index)
            }
            
        }
    }
    
    func separatorView(separator: Layout.Separator) -> some View {
        Capsule()
            .frame(width: separator.width, height: separator.height)
            .offset(CGSize(width: separator.x, height: separator.y))
    }
    
    func gameTile(index: Int) -> some View {
        let gameTile = viewModel.game.board.tiles[index]
        let boardTile = viewModel.layout.tiles[index]
        
        return ZStack {
            Button {
                if viewModel.clickTileIntent(at: index) {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.25) {
                        isShowingResultsScreen = true
                    }
                }
            } label: {
                GameTileView(gameTile: gameTile,
                             width: boardTile.width,
                             height: boardTile.height)
            }
            .disabled(!viewModel.game.board.canClickTile(at: index))
        }
        .offset(CGSize(width: boardTile.x, height: boardTile.y))
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: ViewModel.preview())
    }
}
