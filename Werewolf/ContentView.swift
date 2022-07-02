//
//  ContentView.swift
//  Shared
//
//  Created by Romi Asad on 12/23/21.
//

import SwiftUI

struct NavigationBarColor: ViewModifier {
    
  init(backgroundColor: UIColor, tintColor: UIColor) {
    let coloredAppearance = UINavigationBarAppearance()
    coloredAppearance.configureWithOpaqueBackground()
    coloredAppearance.backgroundColor = backgroundColor
    coloredAppearance.titleTextAttributes = [.foregroundColor: tintColor]
    coloredAppearance.largeTitleTextAttributes = [.foregroundColor: tintColor]
                   
    UINavigationBar.appearance().standardAppearance = coloredAppearance
    UINavigationBar.appearance().scrollEdgeAppearance = coloredAppearance
    UINavigationBar.appearance().compactAppearance = coloredAppearance
    UINavigationBar.appearance().tintColor = tintColor
  }

  func body(content: Content) -> some View {
    content
  }
}

extension View {
  func navigationBarColor(backgroundColor: UIColor, tintColor: UIColor) -> some View {
    self.modifier(NavigationBarColor(backgroundColor: backgroundColor, tintColor: tintColor))
  }
}

struct ContentView: View {

    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("Werewolf")
                    .ignoresSafeArea()
                GeometryReader { geometry in
                    VStack (alignment: .center, spacing: 40) {
                        if (items.count < 4) {
                            Text("Name \(4 - items.count) villagers to continue")
                                .font(.custom("AmericanTypewriter", size: 20))
                        }
                        NavigationLink(destination: StartView(maxPlayers: items.count)) {
                            Tile(title: "Build Your Village", image: "house")
                                .frame(width: geometry.size.height * 0.50, height: geometry.size.height * 0.30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color("MyRed"), lineWidth: 5)
                                )
                        } 
                        .disabled(items.count < 4)
                        Spacer()
                        NavigationLink(destination: AddView()) {
                            Tile(title: "Name Your Villagers", image: "person.3")
                                .frame(width: geometry.size.height * 0.50, height: geometry.size.height * 0.30)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color("MyGreen"), lineWidth: 5)
                                )
                        }
                        Spacer()
                    }
                    .padding()
                }
                .padding()
            }
        .navigationBarTitle("Ultimate Werewolf")
        }
        .navigationBarColor(backgroundColor: UIColor(Color("Heading")), tintColor: .white)
    }
}

struct Tile: View {
    var title: String
    var image: String
    var body: some View {
        ZStack {
            HStack {
                Text(title)
                Image(systemName: image)
            }
            .padding(30)
            .font(.largeTitle)
        }
        .cornerRadius(30)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice(PreviewDevice(rawValue: "Iphone 12"))
    }
}


