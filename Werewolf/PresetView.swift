//
//  SwiftUIView.swift
//  Werewolf
//
//  Created by Romi Asad on 1/13/22.
//

import SwiftUI

struct PresetView: View {
    @State var numPlayers: Int
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct PresetView_Previews: PreviewProvider {
    static var previews: some View {
        PresetView(numPlayers: 7)
    }
}
