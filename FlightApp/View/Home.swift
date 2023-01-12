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


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
