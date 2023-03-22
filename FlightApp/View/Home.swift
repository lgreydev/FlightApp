//
//  Home.swift
//  FlightApp
//
//  Created by Sergey Lukaschuk on 2023-01-10.
//

import SwiftUI

struct Home: View {
    @State private var offsetY: CGFloat = 0
    @State private var currentCardIndex: CGFloat = 0
    @State private var showingSheet = false
    
    var size: CGSize
    var safeArea: EdgeInsets
    
    var body: some View {
        VStack {
            HeaderView(size: size, safeArea: safeArea)
                .overlay(alignment: .bottomTrailing) {
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(.gray)
                            .frame(width: 40, height: 40)
                            .background {
                                Circle()
                                    .fill(.white)
                                    .shadow(color: .black.opacity(0.35), radius: 5, x: 5, y: 5)
                            }
                    }
                    .offset(x: -15, y: 15)
                    .sheet(isPresented: $showingSheet) {
                        DetailView(size: size, safeArea: safeArea   )
                    }

                }
                .zIndex(1)
            
            PaymentCardView(offsetY: $offsetY, currentCardIndex: $currentCardIndex, safeArea: safeArea)
                .zIndex(0)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
