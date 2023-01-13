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
        }
        .padding(15)
        .padding(.top, safeArea.top)
        .padding(.bottom)
        .background {
            Rectangle()
                .fill(.linearGradient(colors: [Color.gray, Color.blue, Color.indigo], startPoint: .top, endPoint: .bottom))
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

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
