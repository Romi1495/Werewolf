//
//  mainView.swift
//  WerewolfBuddy
//
//  Created by Romi Asad on 12/25/21.
//

import SwiftUI

struct mainView: View {
    
    @Binding var selectedPlayers: [Player]
    @State var showingSheet = false
    @State var rowList: [Row] = []
    @State var confirm = false
    var body: some View {
        let WCount = (selectedPlayers.filter { ($0.status == "😁 Alive" && $0.role.team == Team.wolf) || $0.status == "🥸 Transformed" }).count
        let VCount = (selectedPlayers.filter { $0.role.team == Team.village && ($0.status != "🥸 Transformed" && $0.status != "☠️ Dead") }).count
        NavigationView {
            ZStack {
                Color("Werewolf")
                    .ignoresSafeArea()
                ScrollView {
                    
                    ForEach($selectedPlayers, id :\.id) { $player in
                        if (player.role.team == Team.wolf && player.status != "☠️ Dead") {
                            let color = Color("MyRed")
                            Row(color: color, player: $player)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(color, lineWidth: 3)
                                )
                                .padding(5)
                        }
                    }
                    ForEach($selectedPlayers, id  :\.id) { $player in
                        if (player.status == "🥸 Transformed") {
                            let color = Color("MyOrange")
                            Row(color: color, player: $player)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(color, lineWidth: 3)
                                )
                                .padding(5)
                        }
                    }
                    ForEach($selectedPlayers, id  :\.id) { $player in
                        if (player.role.team == Team.village && player.status != "🥸 Transformed" && player.status != "☠️ Dead") {
                            let color = Color("MyGreen")
                            Row(color: color, player: $player)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(color, lineWidth: 3)
                                )
                                .padding(5)
                        }
                    }
                    ForEach($selectedPlayers, id  :\.id) { $player in
                        if (player.status == "☠️ Dead") {
                            let color = Color.gray
                            Row(color: color, player: $player)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(color, lineWidth: 3)
                                )
                                .padding(5)
                        }
                    }
                }
                .padding()
            }
        }
        .navigationBarTitle("Moderator View")
        .toolbar {
            ToolbarItem (placement: .principal) {
                Text("👩‍🌾: \(VCount) 🐺: \(WCount)")
                    .foregroundColor(.white)
            }
            ToolbarItem (placement: .navigationBarTrailing) {
                if (self.confirm) {
                    HStack {
                        Image(systemName: "checkmark").onTapGesture(perform: {
                            var roleList: [Role] = []
                            for player in selectedPlayers {
                                roleList.append(player.role)
                            }
                            selectedPlayers.removeAll()
                            for role in roleList {
                                selectedPlayers.append(Player(role: role))
                            }
                            self.confirm = false})
                        .foregroundColor(.green)
                        Image(systemName: "xmark.circle").onTapGesture(perform: {
                            self.confirm = false})
                        .foregroundColor(.red)
                    }
                    
                } else {
                    Text("Reset").onTapGesture(perform: {
                        self.confirm = true
                    })
                    .foregroundColor(.white)
                }

            }
        }
        .font(.custom("AmericanTypewriter", size: 25))
    }
}

struct Row: View {
    
    @State var color: Color
    @State var showingSheet =  false
    @Binding var player: Player
    @State var numberOfShakes: CGFloat = 0
    @State var status = statuses[0]
    @State var notes = ""
    
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    var body: some View {
        
        let sheet = MainSheet(notes: $notes, role: player.role)
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color("Werewolf"))
                .padding(.horizontal, 3)
            HStack {
                Button {
                    showingSheet.toggle()
                } label: {
                    Image(systemName: "paperclip")
                }
                .sheet(isPresented: $showingSheet) {
                    sheet
                }
                Text(player.role.name)
                    .foregroundColor(color)
                    .frame(width: 125, alignment: .leading)
                Spacer()
                Menu {
                    ForEach(items, id :\.self) { name in
                        Button(name.name!) {
                            player.name = name.name!
                        }
                    }
                } label: {
                    Text(player.name)
                }
                .font(.custom("AmericanTypewriter", size: 20))
                .frame(width: 100, alignment: .center)
                Spacer()
                Menu {
                    ForEach(player.role.team == Team.village ? statuses : wolfStatuses, id :\.self) { status in
                        Button(status) {
                            player.status = status
                        }
                    }
                } label: {
                    Text(player.status.prefix(1))
                }
                Spacer()
            }
            .padding()
            .font(.custom("AmericanTypewriter", size: 20))
        }
        .modifier(ShakeEffect(shakeNumber: numberOfShakes))
        .onAppear {
            withAnimation(.easeIn(duration: 1.0)) {
                numberOfShakes = 5
            }
        }
    }
}

struct MainSheet: View {
    @Environment(\.dismiss) var dismiss
    
    
    @Binding var notes: String
    @State var role: Role
    
    var body: some View {
        ZStack {
            Color("MyGray")
                .ignoresSafeArea()
            VStack {
                Spacer()
                VStack (spacing: 40) {
                    Text(role.name.uppercased())
                        .font(.custom("AmericanTypewriter", size: 40))
                        .foregroundColor(Color("Label"))
                    Text(role.bio)
                        .font(.headline)
                        .foregroundColor(Color("Label"))
                }
                .padding(40)
                TextEditor(text: $notes)
                    .frame(width: 300, height: 200)
                    .cornerRadius(10)
                Spacer()
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "x.circle")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color("Label"))
                }
                Spacer()
            }
        }
    }
}

//struct mainView_Previews: PreviewProvider {
//    @State var list = [Player(role: Werewolf), Player(role: Werewolf), Player(role: Werewolf)]
//    static var previews: some View {
//        mainView(selectedPlayers: $list)
//    }
//}


extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
struct ShakeEffect: AnimatableModifier {
    var shakeNumber: CGFloat = 0

    var animatableData: CGFloat {
        get {
            shakeNumber
        } set {
            shakeNumber = newValue
        }
    }

    func body(content: Content) -> some View {
        content
            .offset(x: sin(shakeNumber * .pi * 2) * 10)
    }
}

func resetPlayers() {

    print("HELLOOOO")
}
