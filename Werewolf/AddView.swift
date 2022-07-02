//
//  ContentView.swift
//  UltimateWerewolf
//
//  Created by Romi Asad on 12/26/21.
//

import SwiftUI
import CoreData

struct AddView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.name, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    @State var newName = ""
    var body: some View {
        ZStack {
            Color("Werewolf").ignoresSafeArea()
            VStack {
                HStack (spacing: 20) {
                    TextField("New Villager", text: $newName)
                        .frame(width: 200)
                        .padding(10)
                        .overlay(RoundedRectangle(cornerRadius: 20)
                                    .stroke(Color("MyGreen"), lineWidth: 3))
                    Button {
                        addItem()
                        newName = ""
                    } label: {
                        Image(systemName: "plus")
                    }
                    .disabled(newName == "")
                    .buttonStyle(GrowingButton())
                }
                .padding()
                Text("Current Village:")
                    .font(.custom("AmericanTypewriter", size: 30))
                    .foregroundColor(Color("MyRed"))
                ScrollView {
                    ForEach(items) { item in
                        AddRow(name: item.name!, item: item, context: viewContext)
                            .frame(width: 300)
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color("MyGreen"), lineWidth: 5))
                            .padding(2)
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Name Your Villagers")
    }

    
    private func addItem() {
        withAnimation {
            let newItem = Item(context: viewContext)
            newItem.name = newName.capitalized

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}


private func deleteItem(name: NSManagedObject, context: NSManagedObjectContext) {
    withAnimation {
        context.delete(name)

        do {
            try context.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
}

struct AddViewView_Previews: PreviewProvider {
    static var previews: some View {
        AddView()
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

struct AddRow: View {
    @State var name: String
    @State var item: NSManagedObject
    @State var context: NSManagedObjectContext
    var body: some View {
        HStack {
            Button {
                deleteItem(name: item, context: context)
            } label: {
                Image(systemName: "minus.square")
                    .foregroundColor(Color("MyGreen"))
            }
            Text("\(name)")
                .font(.custom("AmericanTypewriter", size: 20))
                .foregroundColor(Color("MyGreen"))
            Spacer()
        }
        .padding()
    }
}


struct GrowingButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        MyButton(configuration: configuration)
    }
    
    struct MyButton: View {
        let configuration: ButtonStyle.Configuration
        @Environment(\.isEnabled) private var isEnabled: Bool
        var body: some View {
            configuration.label
                .padding()
                .background(!isEnabled ? Color.gray : Color("MyGreen"))
                .foregroundColor(.white)
                .clipShape(Capsule())
                .scaleEffect(configuration.isPressed ? 1.4 : 1)
                .animation(.easeOut(duration: 0.4), value: configuration.isPressed)
                .disabled(!isEnabled)
            
        }
    }
}
