//
//  CardView.swift
//  FlightApp
//
//  Created by Sergey Lukaschuk on 2023-03-21.
//

import SwiftUI

struct CardView: View {
    var index: Int
    
    var body: some View {
        GeometryReader { proxy in
            let size = proxy.size
            let minY = proxy.frame(in: .named("SCROLL")).minY
            let prograss = minY / size.height
            let constrainedProgress = prograss > 1 ? 1 : prograss < 0 ? 0 : prograss
            
            Image(sampleCards[index].cardImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size.width, height: size.height)
                .shadow(color: .black.opacity(0.5), radius: 8, x: 6, y: 6)
                .rotation3DEffect(.init(degrees: constrainedProgress * 40.0),
                                  axis: (x: 1, y: 0, z: 0),
                                  anchor: .bottom)
                .padding(.top, prograss * -160)
                .offset(y: prograss < 0 ? prograss * 250 : 0)
        }
        .frame(height: 200)
        .zIndex(Double(sampleCards.count - index))
        .onTapGesture {
            print(index)
        }
    }
}
