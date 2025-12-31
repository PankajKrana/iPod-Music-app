//
//  MenuView.swift
//  Ipod Classic
//
//  Created by Pankaj Kumar Rana on 31/12/25.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Music")
            Text("Videos")
            Text("Settings")
        }
        .font(.title3)
        .foregroundColor(.white)
    }
}


#Preview {
    MenuView()
}
