//
//  DetailView.swift
//  FlightApp
//
//  Created by Sergey Lukaschuk on 2023-03-21.
//

import SwiftUI

struct DetailView: View {
    var size: CGSize
    var safeArea: EdgeInsets
    
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                VStack {
                    Image("air-canada-logo_002")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 150)
                    
                    Text("Your order has submitted")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    
                    Text("We are waiting for booking confirmation")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.8))
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 30)
                .padding(.bottom, 40)
                .background {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(.white.opacity(0.2))
                }
                
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
                .padding(15)
                .padding(.bottom, 70)
                .background {
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(.ultraThinMaterial)
                }
                .padding(.top, -20)
                
            }
            .padding(.horizontal, 20)
            .padding(.top, safeArea.top + 15)
            .padding([.horizontal, .bottom], 15)
            .background {
                Rectangle()
                    .fill(.indigo)
                    .padding(.bottom, 80)
            }
            
            GeometryReader { proxy in
                ViewThatFits {
                    ContactInformation()
                    ScrollView(.vertical, showsIndicators: false) {
                        ContactInformation()
                    }
                }
            }
        }
    }
}
