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
    
    @State private var offsetY: CGFloat = 0
    @State private var currentCardIndex: CGFloat = 0
    
    var body: some View {
        VStack {
            HeaderView(size: size, safeArea: safeArea)
                .zIndex(1)
            
            PaymentCardView(safeArea: safeArea, offsetY: $offsetY, currentCardIndex: $currentCardIndex)
                .zIndex(0)
        }
    }
}

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

struct FlightDetailView: View {
    var alignment: HorizontalAlignment = .leading
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
    
    var safeArea: EdgeInsets
    
    @Binding var offsetY: CGFloat
    @Binding var currentCardIndex: CGFloat
    
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
                }
                .padding(.horizontal, 30)
                .offset(y: offsetY)
                .offset(y: currentCardIndex * -200.0)
                
                Rectangle()
                    .fill(.linearGradient(colors: [
                        .clear,
                        .clear,
                        .clear,
                        .clear,
                        .white.opacity(0.3),
                        .white.opacity(0.7),
                        .white
                    ], startPoint: .top, endPoint: .bottom))
                    .allowsHitTesting(false)
                
                Button {
                    
                } label: {
                    Text("Confirm $365.00")
                        .font(.callout)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.vertical, 10)
                        .background {
                            Capsule()
                                .fill(Color.blue.gradient)
                        }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .bottom)
                .padding(.bottom, safeArea.bottom == 0 ? 15 : safeArea.bottom)
            }
            .coordinateSpace(name: "SCROLL")
        }
        .contentShape(Rectangle())
        .gesture(
            DragGesture()
                .onChanged { value in
                    offsetY = value.translation.height * 0.3
                }
                .onEnded { value in
                    let translation = value.translation.height
                    
                    withAnimation(.easeInOut) {
                        if translation > 0 && translation > 100 && currentCardIndex > 0 {
                            currentCardIndex -= 1
                        }
                        
                        if translation < 0 && -translation > 100 && currentCardIndex < CGFloat(sampleCards.count - 1) {
                            currentCardIndex += 1
                        }
                        
                        offsetY = .zero
                    }
                }
        )
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
                .offset(y: prograss < 0 ? prograss * 250 : 0)
        }
        .frame(height: 200)
        .zIndex(Double(sampleCards.count - index))
        .onTapGesture {
            print(index)
        }
    }
}

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

struct ContactInformation: View {
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                InfoView(title: "Flight", subtitle: "AR 580")
                InfoView(title: "Class", subtitle: "Premium")
                InfoView(title: "Aircraft", subtitle: "B 737-900")
                InfoView(title: "Possiblity", subtitle: "AR 580")
            }
            
            ContactView(name: "Juli", email: "juli@gmail.com", profile: "profile_001")
                .padding(.top, 30)
            ContactView(name: "Mark", email: "mark@gmail.com", profile: "profile_004")
//            ContactView(name: "Any", email: "any@gmail.com", profile: "profile_002")
//            ContactView(name: "Kristi", email: "kristi@gmail.com", profile: "profile_003")
            
            VStack(alignment: .leading, spacing: 5) {
                Text("Total Price")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
                Text("$1,522.00 CAD")
                    .fontWeight(.semibold)
                    .foregroundColor(.black)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 20)
            .padding(.leading, 15)
            
            
            Button {
                // transition
            } label: {
                Text("Go to Home Screen")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .padding(.vertical, 10)
                    .background {
                        Capsule()
                            .fill(Color.indigo.gradient)
                    }
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 30)
        }
        .padding(15)
        .padding(.top, 20)
    }
}

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

struct InfoView: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Text(title)
                .font(.caption2)
                .fontWeight(.semibold)
                .foregroundColor(.gray)
            
            Text(subtitle)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.black)
        }
        .frame(maxWidth: .infinity)
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//        DetailView()
    }
}
