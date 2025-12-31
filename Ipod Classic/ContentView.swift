//
//  ContentView.swift
//  Ipod Classic
//
//  Created by Pankaj Kumar Rana on 31/12/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            
            VStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.black)
                    .frame(width: 350, height: 400)
                Spacer()
                
                ZStack {
                    customCircleView()
                    selectButtonView()
                }
                
                Spacer()

            }
        }
    }
}


extension View {
    @ViewBuilder
    func customCircleView() -> some View {
        Circle()
            .stroke(Color.black, lineWidth: 80)
            .frame(width: 250)
    }
    
    func selectButtonView() -> some View {
        Button {
            print("Center button tapped")
        } label: {
            Circle()
                .fill(Color.white.opacity(0.3))
                .frame(width: 250, height: 120)
                .overlay(
                    Text("SELECT")
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                )
        }
    }
    
}

#Preview {
    ContentView()
}
