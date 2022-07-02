//
//  UltimateWerewolfApp.swift
//  UltimateWerewolf
//
//  Created by Romi Asad on 12/26/21.
//

import SwiftUI

let persistenceController = PersistenceController.shared

@main
struct WerewolfApp: App {
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
            
        }
    }
}

//let sortedNames = ["_______", "Ashley", "Dima", "Dina", "Dino", "Fairouz", "Hady", "Huda", "Maher", "Malek", "Mariam", "Mazen", "Moe", "Romi", "Sami", "Sandra", "Wesam"]
let statuses = ["Alive", "Protected", "Dead", "Targeted", "Transformed", "Linked"]
let wolfStatuses = ["Alive", "Protected", "Dead", "Linked"]

let Werewolf = Role(name: "Werewolf", team: Team.wolf, bio: "Each night, the Werewolves wake up and select a villager to eat", weight: -6)
let Alpha = Role(name: "Alpha", team: Team.wolf, bio: "Each night, the Alpha wakes with the Werewolves. If another Wolf died that day, they may convert their target to a Werewolf", weight: -9)
let Cub = Role(name: "Cub", team: Team.wolf, bio: "Each night, the Cub wakes with the Werewolves. If the Cub is eliminated, the Werewolves eliminate two players the following night", weight: -8)
let Seer = Role(name: "Seer", team: Team.village, bio: "Each night, the Seer wakes up. They point at a player and learn if they are a member of the Village team or Werewolf team", weight: 7)
let Villager = Role(name: "Villager", team: Team.village, bio: "Find the werewolves and kill them during the day", weight: 1)
let Mentalist = Role(name: "Mentalist", team: Team.village, bio: "Each night, wake up and select two players. Learn if they are both on the Village team or Werewolf team", weight: 6)
let Bodyguard = Role(name: "Bodyguard", team: Team.village, bio: "Each night, the Bodyguard selects a player. That night, the selected player cannot be killed", weight: 3)
let Lycan = Role(name: "Lycan", team: Team.village, bio: "The Lycan is a member of the Village team, but appear as a Werewolf when scanned by other roles", weight: -1)
let Hunter = Role(name: "Hunter", team: Team.village, bio: "When the Hunter is eiliminated, they select a player. That player is immediately eliminated", weight: 3)
let Witch = Role(name: "Witch", team: Team.village, bio: "The Witch may eliminate or protect a player at night once each per game", weight: 4)
let Revealer = Role(name: "Revealer", team: Team.village, bio: "Once per game, the Revealer may select a player at night. If they are a member of the Wolf team, they are eliminated. If they are not, the Revealer is eliminated", weight: 4)
let Diseased = Role(name: "Diseased", team: Team.village, bio: "If the Diseased is eaten by the Werewolves, they cannot eliminate a player the following night", weight: 3)
let Cursed = Role(name: "Cursed", team: Team.village, bio: "The Cursed is a member of the Village team. However, if they are eliminated by the Werewolves they turn into a Werewolf", weight: -3)
let Bomber = Role(name: "Mad Bomber", team: Team.village, bio: "When the Bomber is eliminated, the two players on their left and right are also eliminated", weight: -2)
let Cupid = Role(name: "Cupid", team: Team.village, bio: "At the beginning of the game, the Cupid selects two players. If one of the selected players is eliminated, the other one dies of a broken heart", weight: -3)
let Mayor = Role(name: "Mayor", team: Team.village, bio: "The Mayor's vote counts twice.", weight: 2)
let Tanner = Role(name: "Tanner", team: Team.village, bio: "The Tanner hates their job and their life. They win if they are eliminated", weight: -2)
let PI = Role(name: "P.I.", team: Team.village, bio: "Each night, the P.I. selects a player. They are told if that player or one of their neighbors is a Werewolf.", weight: 3)
let Mason = Role(name: "Mason", team: Team.village, bio: "The first night, the Masons wake up to learn who the other Mason is.", weight: 3)
let testList = [Alpha, Cub, Werewolf, Bodyguard, Bomber, Cupid, Cursed, Diseased, Hunter, Lycan, Mentalist, Mayor, PI, Revealer, Seer, Tanner, Villager, Witch]
