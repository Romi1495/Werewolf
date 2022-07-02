//
//  Test.swift
//  Werewolf
//
//  Created by Romi Asad on 12/28/21.
//

import SwiftUI

struct Test: View {
    @State var selection = 0
    var body: some View {
//        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//            .font(.custom("AmericanTypewriter", size: 20))
//            .onAppear {
//                for family in UIFont.familyNames.sorted() {
//                    let names = UIFont.fontNames(forFamilyName: family)
//                    print("Family: \(family) Font names: \(names)")
//                }
//            }
        HStack {
            DropdownPicker(title: "Size", selection: $selection, options: ["Small", "Medium", "Large", "X-Large"])
            DropdownPicker(title: "Size", selection: $selection, options: ["Small", "Medium", "Large", "X-Large"])
            DropdownPicker(title: "Size", selection: $selection, options: ["Small", "Medium", "Large", "X-Large"])
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}

struct DropdownPicker: View {
    
    var title: String
    @Binding var selection: Int
    var options: [String]
    
    @State private var showOptions: Bool = false
    
    var body: some View {
        ZStack {
            // Static row which shows user's current selection
            HStack {
                Text(title)
                HStack {
                Text(options[selection])
                    .foregroundColor(Color.black.opacity(0.6))
                Image(systemName: "chevron.right")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 10, height: 10)
                }
                .onTapGesture {
                    // show the dropdown options
                    withAnimation(Animation.spring().speed(2)) {
                        showOptions = true
                    }
                }
            }
            .font(Font.custom("Avenir Next", size: 16).weight(.medium))
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(Color.white)

            
            // Drop down options
            if showOptions {
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(Font.custom("Avenir Next", size: 16).weight(.semibold))
                        .foregroundColor(.white)
                    HStack {
                        Spacer()
                        ForEach(options.indices, id: \.self) { i in
                            if i == selection {
                                Text(options[i])
                                    .font(.system(size: 12))
                                    .padding(.vertical, 8)
                                    .padding(.horizontal, 12)
                                    .background(Color.white.opacity(0.2))
                                    .cornerRadius(4)
                                    .onTapGesture {
                                        // hide dropdown options - user selection didn't change
                                        withAnimation(Animation.spring().speed(2)) {
                                            showOptions = false
                                        }
                                    }
                            } else {
                                Text(options[i])
                                    .font(.system(size: 12))
                                    .onTapGesture {
                                        // update user selection and close options dropdown
                                        withAnimation(Animation.spring().speed(2)) {
                                            selection = i
                                            showOptions = false
                                        }
                                    }
                            }
                            Spacer()
                        }
                    }
                    .padding(.vertical, 2)
                    .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                    
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.black)
                .foregroundColor(.white)
                .transition(.opacity)
                
            }
            
        }
    }
}
