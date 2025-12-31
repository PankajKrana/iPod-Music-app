//
//  ContentView.swift
//  Ipod Classic
//
//  Created by Pankaj Kumar Rana on 31/12/25.
//

import SwiftUI
import Foundation

struct ContentView: View {
    
    @State private var screen: IPodScreenState = .menu
    
    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()
            
            VStack(spacing: 30) {
                
                // iPod Screen
                IPodScreen {
                    switch screen {
                    case .menu:
                        MenuView()
                        
                    case .nowPlaying:
                        NowPlayingView()
                        
                    case .settings:
                        SettingsView()
                    }
                }
                
                // Click Wheel
                selectButtonView(
                    onMenu: {
                        screen = .menu
                    },
                    onPlayPause: {
                        screen = .nowPlaying
                    },
                    onForward: {
                        screen = .settings
                    }
                )
                
                Spacer()
            }
        }
    }
}


extension View {
    
    func selectButtonView(
        onMenu: @escaping () -> Void,
        onPlayPause: @escaping () -> Void,
        onForward: @escaping () -> Void
    ) -> some View {
        
        ZStack {
            
            Circle()
                .stroke(Color.black, lineWidth: 70)
                .frame(width: 260)
            
            // MENU
            Button(action: onMenu) {
                Text("MENU")
                    .font(.caption)
                    .fontWeight(.bold)
            }
            .positionOnCircle(radius: 120, angle: -90)
            
            // Back (unused for now)
            actionButton(systemImage: "backward.fill") {}
                .positionOnCircle(radius: 120, angle: 180)
            
            // Forward → Settings
            actionButton(systemImage: "forward.fill", action: onForward)
                .positionOnCircle(radius: 120, angle: 0)
            
            // Play / Pause → Now Playing
            actionButton(systemImage: "playpause.fill", action: onPlayPause)
                .positionOnCircle(radius: 120, angle: 90)
            
            // Center Select
            Button {
                print("Select pressed")
            } label: {
                Circle()
                    .fill(Color.white.opacity(0.25))
                    .frame(width: 90)
                    .overlay(
                        Text("SELECT")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    )
            }
        }
        .foregroundColor(.white)
    }
    
    func actionButton(
        systemImage: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.title2)
        }
    }
    
    func positionOnCircle(radius: CGFloat, angle: CGFloat) -> some View {
        let radians = angle * .pi / 180
        return self.offset(
            x: cos(radians) * radius,
            y: sin(radians) * radius
        )
    }
}


struct IPodScreen<Content: View>: View {
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.black)
                .padding(.vertical, 20)

            
            content
                .padding()
        }
        .frame(width: 350, height: 400)
    }
}

enum IPodScreenState {
    case menu
    case nowPlaying
    case settings
}


#Preview {
    ContentView()
}
