//
//  NowPlayingView.swift
//  Ipod Classic
//
//  Created by Pankaj Kumar Rana on 31/12/25.
//

import SwiftUI

struct NowPlayingView: View {
    var body: some View {
        VStack(spacing: 12) {
            Text("Now Playing")
                .font(.headline)

            Image(systemName: "music.note")
                .font(.system(size: 60))
        }
        .foregroundColor(.white)
    }
}
