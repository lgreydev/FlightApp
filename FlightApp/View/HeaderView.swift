//
//  HeaderView.swift
//  FlightApp
//
//  Created by Sergey Lukaschuk on 2023-03-21.
//

import SwiftUI

struct HeaderView: View {
    var size: CGSize
    var safeArea: EdgeInsets
    
    var body: some View {
        VStack {
            Image("air-canada-logo_005")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: size.width * 0.5)
                .frame(maxWidth: .infinity, alignment: .leading)
                .opacity(0.7)
            
            HStack {
                FlightDetailView(alignment: .leading,
                                 place: "Toronto",
                                 code: "YYZ",
                                 timing: "Tue Feb 21, 08:00")
                
                VStack(spacing: 8) {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                    
                    Text("Non-stop")
                    Text("5hr08m")
                }
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
                
                FlightDetailView(alignment: .trailing,
                                 place: "Vancouver",
                                 code: "YVR",
                                 timing: "Tue Feb 21, 10:08")
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
                .fill(.linearGradient(colors: [Color.blue, Color.pink, Color.red], startPoint: .top, endPoint: .bottom))
        }
    }
}
