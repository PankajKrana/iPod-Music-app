//
//  IPodViewModel.swift
//  Ipod Classic
//
//  Created by Pankaj Kumar Rana on 01/01/26.
//


import SwiftUI
import Combine
import UIKit

final class IPodViewModel: ObservableObject {

    @Published var currentScreen: IPodScreenState = .menu
    @Published var selectedIndex: Int = 0

    let menuItems: [String] = [
        "Music",
        "Now Playing",
        "Settings"
    ]

    func rotateForward() {
        guard currentScreen == .menu else { return }
        selectedIndex = (selectedIndex + 1) % menuItems.count
        haptic(.light)
    }

    func rotateBackward() {
        guard currentScreen == .menu else { return }
        selectedIndex = (selectedIndex - 1 + menuItems.count) % menuItems.count
        haptic(.light)
    }

    func selectItem() {
        guard currentScreen == .menu else { return }

        switch selectedIndex {
        case 0, 1:
            currentScreen = .nowPlaying
        case 2:
            currentScreen = .settings
        default:
            break
        }

        haptic(.medium)
    }

    func goToMenu() {
        currentScreen = .menu
        haptic(.soft)
    }

    private func haptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle) {
        UIImpactFeedbackGenerator(style: style).impactOccurred()
    }
}
