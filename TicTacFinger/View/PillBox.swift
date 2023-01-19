//
//  PillBox.swift
//  TicTacFinger
//
//  Created by Jaafar Zubaidi on 1/12/23.
//

import SwiftUI

struct PillBox: ViewModifier {
    
    let backgroundColor: Color
    let strokeColor: Color
    let cornerRadius: CGFloat
    let strokeWidth: CGFloat
    
    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geometry in
                    ZStack {
                        RoundedRectangle(cornerRadius: cornerRadius + strokeWidth)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .foregroundColor(strokeColor)
                        
                        RoundedRectangle(cornerRadius: cornerRadius)
                            .frame(width: geometry.size.width - (strokeWidth * 2),
                                   height: geometry.size.height - (strokeWidth * 2))
                            .foregroundColor(backgroundColor)
                    }
                }
            )
    }
}

extension View {
    func pillBox(backgroundColor: Color,
                 strokeColor: Color,
                 cornerRadius: CGFloat = 12.0,
                 strokeWidth: CGFloat = 6.0) -> some View {
        modifier(PillBox(backgroundColor: backgroundColor,
                         strokeColor: strokeColor,
                         cornerRadius: cornerRadius,
                         strokeWidth: strokeWidth))
    }
}
