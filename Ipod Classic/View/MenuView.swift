//
//  MenuView.swift
//  Ipod Classic
//
//  Created by Pankaj Kumar Rana on 31/12/25.
//

import SwiftUI

struct MenuView: View {

    @ObservedObject var vm: IPodViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            ForEach(vm.menuItems.indices, id: \.self) { index in
                HStack {
                    if index == vm.selectedIndex {
                        Image(systemName: "play.fill")
                            .font(.caption)
                    }

                    Text(vm.menuItems[index])
                        .fontWeight(index == vm.selectedIndex ? .bold : .regular)
                }
            }
        }
        .foregroundColor(.white)
    }
}
