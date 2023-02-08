//
//  Home.swift
//  FlightApp
//
//  Created by Sergey Lukaschuk on 2023-01-10.
//

import SwiftUI

struct Home: View {
    var size: CGSize
    var safeArea: EdgeInsets
    
    var body: some View {
        VStack {
            HeaderView(size: size, safeArea: safeArea)
            
            PaymentCardView()
        }
    }
}

struct HeaderView: View {
    var size: CGSize
    var safeArea: EdgeInsets
    
    var body: some View {
        VStack {
            Image("air-canada-logo_002")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size.width * 0.6)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            HStack {
                FlightDetailView(alignment: .leading,
                                 place: "Los Angeles",
                                 code: "LAS",
                                 timing: "23 Nov, 03:47")
                
                VStack(spacing: 8) {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                    
                    Text("4h 28m")
                }
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                
                FlightDetailView(alignment: .trailing,
                                 place: "New York",
                                 code: "NYC",
                                 timing: "23 Nov, 07:15")
            }
            .padding(.top, 15)
            
            Image("airplane_001")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 160)
                .padding(.bottom, -20)
                .padding(.top)
        }
        .padding(15)
        .padding(.top, safeArea.top)
        .padding(.bottom)
        .background {
            Rectangle()
                .fill(.linearGradient(colors: [Color.blue.opacity(0.5), Color.pink.opacity(0.7), Color.red.opacity(0.9)], startPoint: .top, endPoint: .bottom))
        }
    }
}

struct FlightDetailView: View {
    var alignment: HorizontalAlignment
    var place: String
    var code: String
    var timing: String
    
    var body: some View {
        VStack(alignment: alignment, spacing: 6) {
            Text(place)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
            
            Text(code)
                .font(.title)
                .foregroundColor(.white)
            
            Text(timing)
                .font(.caption)
                .foregroundColor(.white.opacity(0.8))
        }
        .frame(maxWidth: .infinity)
    }
}

struct PaymentCardView: View {
    var body: some View {
        VStack {
            Text("SELECT PAYMENT METHOD")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
                .padding(.vertical)
            
            GeometryReader { _ in
                VStack(spacing: 0) {
                    ForEach(sampleCards.indices, id: \.self) { index in
                        CardView(index: index)
                    }
                    .padding(.horizontal, 30)
                }
                .coordinateSpace(name: "SCROLL")
            }
        }
    }
}

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
        }
        .frame(height: 200)
        .zIndex(Double(sampleCards.count - index))
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
