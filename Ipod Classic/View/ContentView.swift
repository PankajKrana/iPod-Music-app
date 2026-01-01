//
//  ContentView.swift
//  Ipod Classic
//
//  Created by Pankaj Kumar Rana on 31/12/25.
//

import SwiftUI
import Foundation

struct ContentView: View {

    @StateObject private var vm = IPodViewModel()

    var body: some View {
        ZStack {
            Color.gray.ignoresSafeArea()

            VStack(spacing: 30) {

                // Screen
                IPodScreen {
                    switch vm.currentScreen {
                    case .menu:
                        MenuView(vm: vm)

                    case .nowPlaying:
                        NowPlayingView()

                    case .settings:
                        SettingsView()
                    }
                }

                // Click Wheel
                selectButtonView(
                    onMenu: vm.goToMenu,
                    onForward: vm.rotateForward,
                    onBackward: vm.rotateBackward,
                    onSelect: vm.selectItem
                )

                Spacer()
            }
        }
    }
}


extension View {

    func selectButtonView(
        onMenu: @escaping () -> Void,
        onForward: @escaping () -> Void,
        onBackward: @escaping () -> Void,
        onSelect: @escaping () -> Void
    ) -> some View {

        ClickWheelView(
            onMenu: onMenu,
            onForward: onForward,
            onBackward: onBackward,
            onSelect: onSelect
        )
    }
}

struct ClickWheelView: View {

    let onMenu: () -> Void
    let onForward: () -> Void
    let onBackward: () -> Void
    let onSelect: () -> Void

    @State private var lastAngle: CGFloat = 0
    @State private var accumulatedRotation: CGFloat = 0

    var body: some View {
        ZStack {

            Circle()
                .stroke(Color.black, lineWidth: 70)
                .frame(width: 260)

            // MENU
            Button("MENU", action: onMenu)
                .font(.caption)
                .fontWeight(.bold)
                .positionOnCircle(radius: 120, angle: -90)

            // Backward
            actionButton(systemImage: "backward.fill", action: onBackward)
                .positionOnCircle(radius: 120, angle: 180)

            // Forward
            actionButton(systemImage: "forward.fill", action: onForward)
                .positionOnCircle(radius: 120, angle: 0)

            // Play / Pause
            actionButton(systemImage: "playpause.fill") {}
                .positionOnCircle(radius: 120, angle: 90)

            // Center SELECT
            Button(action: onSelect) {
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
        .gesture(rotationGesture)
    }

    // MARK: - Rotation Gesture
    private var rotationGesture: some Gesture {
        DragGesture(minimumDistance: 0)
            .onChanged { value in
                let center = CGPoint(x: 130, y: 130)
                let location = value.location

                let angle = atan2(
                    location.y - center.y,
                    location.x - center.x
                )

                let delta = angle - lastAngle
                accumulatedRotation += delta

                let threshold: CGFloat = 0.35   // sensitivity

                if accumulatedRotation > threshold {
                    onForward()
                    accumulatedRotation = 0
                } else if accumulatedRotation < -threshold {
                    onBackward()
                    accumulatedRotation = 0
                }

                lastAngle = angle
            }
            .onEnded { _ in
                accumulatedRotation = 0
            }
    }

    // MARK: - Action Button
    private func actionButton(
        systemImage: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Image(systemName: systemImage)
                .font(.title2)
        }
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


extension View {
    func positionOnCircle(radius: CGFloat, angle: CGFloat) -> some View {
        let radians = angle * .pi / 180
        return self.offset(
            x: cos(radians) * radius,
            y: sin(radians) * radius
        )
    }
}


#Preview {
    ContentView()
}
