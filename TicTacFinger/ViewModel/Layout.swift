//
//  Layout.swift
//  TicTacFinger
//
//  Created by Jaafar Zubaidion 1/12/23.
//

import Foundation

struct Layout {
    
    private static let separatorThickness = Device.isIpad ? 10 : 6
    
    
    struct LayoutItem: Identifiable {
        var x: CGFloat
        var y: CGFloat
        var width: CGFloat
        var height: CGFloat
        var id: String {
            let xi = Int(x + 0.5)
            let yi = Int(y + 0.5)
            let widthi = Int(width + 0.5)
            let heighti = Int(height + 0.5)
            return "\(xi)_\(yi)_\(widthi)_\(heighti)"
        }
    }
    typealias Separator = LayoutItem
    typealias Tile = LayoutItem
    
    private var _worldWidth: Int = 320
    private var _worldHeight: Int = 320
    
    private(set) var boardX: Int = 0
    private(set) var boardY: Int = 0
    private(set) var boardWidth: Int = 0
    private(set) var boardHeight: Int = 0
    
    private(set) var separators = [Separator]()
    private(set) var tiles = [Tile]()
    
    init() {
        separators = [Separator](repeating: Separator(x: 0.0, y: 0.0, width: 0.0, height: 0.0), count: 4)
        tiles = [Tile](repeating: Tile(x: 0.0, y: 0.0, width: 0.0, height: 0.0), count: 9)
    }
    
    mutating func registerGeometry(width: CGFloat, height: CGFloat) -> Bool {
        
        let newWidth = Int(width + 0.5)
        let newHeight = Int(height + 0.5)
        
        if ((newWidth != _worldWidth) || (newHeight != _worldHeight)) {
            
            _worldWidth = newWidth
            _worldHeight = newHeight
            
            if newWidth > newHeight {
                // Landscape Orientation!!!
                let size = min(_worldHeight - 32, 600)
                boardX = _worldWidth / 2 - size / 2
                boardY = _worldHeight / 2 - size / 2
                boardWidth = size
                boardHeight = size
                
                
            } else {
                // Portrait Orientation!!!
                let size = min(_worldWidth - 32, 600)
                boardX = _worldWidth / 2 - size / 2
                boardY = _worldHeight / 2 - size / 2
                boardWidth = size
                boardHeight = size
            }
            
            layoutBoard()
            
            return true
        }
        return false
    }
    
    
    private mutating func layoutBoard() {
        
        let separatorVertical_Left_X1 = (boardX + boardWidth / 3) - (Self.separatorThickness / 2)
        let separatorVertical_Left_X2 = separatorVertical_Left_X1 + Self.separatorThickness
        
        let separatorVertical_Right_X1 = (boardX + (boardWidth * 2) / 3) - (Self.separatorThickness / 2)
        let separatorVertical_Right_X2 = separatorVertical_Right_X1 + Self.separatorThickness
        
        let separatorHorizontal_Top_Y1 = (boardY + boardHeight / 3) - (Self.separatorThickness / 2)
        let separatorHorizontal_Top_Y2 = separatorHorizontal_Top_Y1 + Self.separatorThickness
        
        let separatorHorizontal_Bottom_Y1 = (boardY + (boardHeight * 2) / 3) - (Self.separatorThickness / 2)
        let separatorHorizontal_Bottom_Y2 = separatorHorizontal_Bottom_Y1 + Self.separatorThickness
        
        //vertical, left
        separators[0].x = CGFloat(separatorVertical_Left_X1)
        separators[0].y = CGFloat(boardY)
        separators[0].width = CGFloat(Self.separatorThickness)
        separators[0].height = CGFloat(boardHeight)
        
        //vertical, right
        separators[1].x = CGFloat(separatorVertical_Right_X1)
        separators[1].y = CGFloat(boardY)
        separators[1].width = CGFloat(Self.separatorThickness)
        separators[1].height = CGFloat(boardHeight)
        
        //horizontal, top
        separators[2].x = CGFloat(boardX)
        separators[2].y = CGFloat(separatorHorizontal_Top_Y1)
        separators[2].width = CGFloat(boardWidth)
        separators[2].height = CGFloat(Self.separatorThickness)
        
        //horizontal, bottom
        separators[3].x = CGFloat(boardX)
        separators[3].y = CGFloat(separatorHorizontal_Bottom_Y1)
        separators[3].width = CGFloat(boardWidth)
        separators[3].height = CGFloat(Self.separatorThickness)
        
        
        
        //top left
        tiles[0].x = CGFloat(boardX)
        tiles[0].y = CGFloat(boardY)
        tiles[0].width = CGFloat(separatorVertical_Left_X1 - boardX)
        tiles[0].height = CGFloat(separatorHorizontal_Top_Y1 - boardY)
        
        //top middle
        tiles[1].x = CGFloat(separatorVertical_Left_X2)
        tiles[1].y = CGFloat(boardY)
        tiles[1].width = CGFloat(separatorVertical_Right_X1 - separatorVertical_Left_X2)
        tiles[1].height = CGFloat(separatorHorizontal_Top_Y1 - boardY)
        
        //top right
        tiles[2].x = CGFloat(separatorVertical_Right_X2)
        tiles[2].y = CGFloat(boardY)
        tiles[2].width = CGFloat(boardWidth - (separatorVertical_Right_X2 - boardX))
        tiles[2].height = CGFloat(separatorHorizontal_Top_Y1 - boardY)
        
        
        
        //middle left
        tiles[3].x = CGFloat(boardX)
        tiles[3].y = CGFloat(separatorHorizontal_Top_Y2)
        tiles[3].width = CGFloat(separatorVertical_Left_X1 - boardX)
        tiles[3].height = CGFloat(separatorHorizontal_Bottom_Y1 - separatorHorizontal_Top_Y2)
        
        //middle middle
        tiles[4].x = CGFloat(separatorVertical_Left_X2)
        tiles[4].y = CGFloat(separatorHorizontal_Top_Y2)
        tiles[4].width = CGFloat(separatorVertical_Right_X1 - separatorVertical_Left_X2)
        tiles[4].height = CGFloat(separatorHorizontal_Bottom_Y1 - separatorHorizontal_Top_Y2)
        
        //middle right
        tiles[5].x = CGFloat(separatorVertical_Right_X2)
        tiles[5].y = CGFloat(separatorHorizontal_Top_Y2)
        tiles[5].width = CGFloat(boardWidth - (separatorVertical_Right_X2 - boardX))
        tiles[5].height = CGFloat(separatorHorizontal_Bottom_Y1 - separatorHorizontal_Top_Y2)
        
        
        
        //bottom left
        tiles[6].x = CGFloat(boardX)
        tiles[6].y = CGFloat(separatorHorizontal_Bottom_Y2)
        tiles[6].width = CGFloat(separatorVertical_Left_X1 - boardX)
        tiles[6].height = CGFloat(boardHeight - (separatorHorizontal_Bottom_Y2 - boardY))
        
        //bottom middle
        tiles[7].x = CGFloat(separatorVertical_Left_X2)
        tiles[7].y = CGFloat(separatorHorizontal_Bottom_Y2)
        tiles[7].width = CGFloat(separatorVertical_Right_X1 - separatorVertical_Left_X2)
        tiles[7].height = CGFloat(boardHeight - (separatorHorizontal_Bottom_Y2 - boardY))
        
        //bottom right
        tiles[8].x = CGFloat(separatorVertical_Right_X2)
        tiles[8].y = CGFloat(separatorHorizontal_Bottom_Y2)
        tiles[8].width = CGFloat(boardWidth - (separatorVertical_Right_X2 - boardX))
        tiles[8].height = CGFloat(boardHeight - (separatorHorizontal_Bottom_Y2 - boardY))
    }
    
    
    
}
