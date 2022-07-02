//
//  StartView.swift
//  UltimateWerewolf
//
//  Created by Romi Asad on 12/27/21.
//

import SwiftUI

struct StartView: View {
    @State var maxPlayers: Int
    @State var numPlayers = 6
    var body: some View {
        ZStack {
            Color("Werewolf")
                .ignoresSafeArea()
            VStack {
                Spacer()
                Picker("Number", selection: $numPlayers) {
                    ForEach(4..<maxPlayers) { num in
                        Text("\(num)").tag(num)
                            .font(.largeTitle)
                        Spacer()
                    }
                }
                .foregroundColor(Color("Label"))
                .pickerStyle(.wheel)
                Spacer()
                VStack (spacing: 80) {
                    NavigationLink (destination: CreateView(maxPlayers: numPlayers)){
                        HStack (spacing: 20) {
                            Text("Custom Village")
                                .font(.title)
                                .foregroundColor(Color("Label"))
                            Image(systemName: "chevron.right.2")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color("Label"))
                        }
                    }
                    NavigationLink (destination: PresetView(numPlayers: numPlayers)){
                        HStack (spacing: 20) {
                            Text("Preset Villages")
                                .font(.title)
                                .foregroundColor(Color("Label"))
                            Image(systemName: "chevron.right.2")
                                .resizable()
                                .frame(width: 30, height: 30)
                                .foregroundColor(Color("Label"))
                        }
                    }
                }
                Spacer()
            }
        }
        .navigationTitle("Village Size")
    }
}

struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView(maxPlayers: 10)
            .previewDevice(PreviewDevice(rawValue: "Iphone 12"))
    }
}
