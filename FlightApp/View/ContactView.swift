//
//  ContactView.swift
//  FlightApp
//
//  Created by Sergey Lukaschuk on 2023-03-21.
//

import SwiftUI

struct ContactView: View {
    let name: String
    let email: String
    let profile: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(name)
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
                
                Text(email)
                    .font(.caption)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Image(profile)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
        }
        .padding(.horizontal, 15)
    }
}
