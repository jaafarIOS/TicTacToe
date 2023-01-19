//
//  FlippableCardView.swift
//  TicTacFinger
//
//  Created by Jaafar Zubaidi on 1/11/23.
//

import SwiftUI

struct FlippableCardView<ViewType1: View, ViewType2: View>: View, Animatable {
    
    private var rotation: Double
    private var front: ViewType1
    private var back: ViewType2
    
    var animatableData: Double {
        get { return rotation }
        set { rotation = newValue }
    }
    
    var isFaceDown: Bool {
        return rotation > 90.0
    }
    
    init(isFaceDown: Bool, front: ViewType1, back: ViewType2) {
        if isFaceDown {
            self.rotation = 180.0
        } else {
            self.rotation = 0.0
        }
        
        self.front = front
        self.back = back
    }
    
    var body: some View {
        ZStack {
            back
                .scaleEffect(CGSize(width: 1.0, height: -1.0))
                .opacity(isFaceDown ? 1.0 : 0.0)
            front
                .opacity(isFaceDown ? 0.0 : 1.0)
        }
        .rotation3DEffect(Angle.degrees(rotation), axis: (x: 1.0, y: 0.0, z: 0.0))
    }
}
