//
//  ContentView.swift
//  Shared
//
//  Created by Romi Asad on 12/23/21.
//
// New idea: have only one picker with a button, when button is pressed
// add a row with the selected role

import SwiftUI

struct Player: Identifiable, Hashable {
    var role: Role
    
    var status = "Alive"
    var id = UUID()
}
struct Role: Identifiable, Hashable {
    var name: String
    var team: Team
    var bio: String
    var weight: Int

    var id: String { self.name }
}

enum Team: String, Identifiable {
    case wolf
    case village
    
    var id: String { self.rawValue }
}

struct SheetView: View {
    @Environment(\.dismiss) var dismiss
    
    
    @State var color: Color
    @State var role: Role
    
    var body: some View {
        ZStack {
            color
                .ignoresSafeArea()
            VStack (spacing: 100){
                Text(role.name)
                    .font(.custom("AmericanTypewriter", size: 40))
                Text(role.bio)
                    .padding(40)
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "x.circle")
                        .resizable()
                        .frame(width: 100, height: 100)
                }
                .foregroundColor(Color("Label"))
            }
            .font(.custom("AmericanTypewriter", size: 20))

        }
    }
}

struct CreateView: View {

    @State var maxPlayers: Int
    @State var counter = 0
    @State var currentWeight = 0
    @State var selectedPlayers: [Player] = []

    func addRole(role: Role) {
        selectedPlayers.append(Player(role: role))
        counter += 1
    }
    
    var body: some View {
        let remaining = maxPlayers == counter ? "" : "(\(maxPlayers - counter))"
        ZStack {
            Color("Werewolf")
                .ignoresSafeArea()
            ScrollView {
                ForEach(testList, id :\.self) { role in
                    CreateRow(selectedPlayers: $selectedPlayers, counter: $counter, maxPlayers: $maxPlayers, currentWeight: $currentWeight, role: role, showingSheet: false)
                        .overlay(
                            RoundedRectangle(cornerRadius: 20)
                                .stroke(role.team == Team.wolf ? Color("MyRed") : Color("MyGreen"), lineWidth: 3)
                        )
                        .padding(5)
                }
                .padding()
            }
            .padding(10)
        }
        .navigationTitle("Create Your Village \(remaining)")
        .toolbar {
            ToolbarItem (placement: .navigation) {
                NavigationLink (destination: mainView(selectedPlayers: $selectedPlayers)){
                    Image(systemName: "chevron.right.2")
                }
               .disabled(counter != maxPlayers)
            }
            ToolbarItem (placement: .bottomBar) {
                Text("Current Weight: \(currentWeight)")
                    .foregroundColor(currentWeight < 0 ? Color("MyRed") : Color("MyGreen"))
                    .font(.title2)
            }
        }
    }
}

struct CreateRow: View {
    @Binding var selectedPlayers: [Player]
    @Binding var counter: Int
    @Binding var maxPlayers: Int
    @Binding var currentWeight: Int
    @State var role: Role
    @State var showingSheet: Bool
    @State var person = ""
    @State var status = ""
    @State var number = 0
    var body: some View {
        let color = role.team == Team.wolf ? Color("MyRed") : Color("MyGreen")
        HStack {
            Button {
                showingSheet.toggle()
            } label: {
                Image(systemName: "lightbulb")
                    .foregroundColor(color)
            }
            .sheet(isPresented: $showingSheet) {
                SheetView(color: color, role: role)
            }
            Text("\(role.name) (\(role.weight))")
                .font(.custom("AmericanTypewriter", size: 20))
                .foregroundColor(color)
            Spacer()
            HStack {
                Button {
                    counter -= 1
                    number -= 1
                    currentWeight -= self.role.weight
                    for index in 0..<selectedPlayers.count {
                        if (selectedPlayers[index].role == self.role) {
                            selectedPlayers.remove(at: index)
                            break
                        }
                    }
                } label: {
                    Image(systemName: "minus.square")
                }
                .foregroundColor(Color("Label"))
                .disabled(self.number == 0)
                Text("\(number)")
                .foregroundColor(Color("Label"))
                Button {
                    counter += 1
                    number += 1
                    currentWeight += self.role.weight
                    selectedPlayers.append(Player(role: role))
                } label: {
                    Image(systemName: "plus.square")
                        .foregroundColor(color)
                }
                .disabled(self.counter == self.maxPlayers)
            }
            .font(.custom("AmericanTypewriter", size: 22))
        }
        .padding()
    }
}

struct createView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView(maxPlayers: 10)
            .previewDevice(PreviewDevice(rawValue: "Iphone 12"))
    }
}
