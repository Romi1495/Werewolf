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
//let statuses = ["Alive", "Protected", "Dead", "Targeted", "Transformed", "Linked"]
let statuses = ["😁 Alive", "☠️ Dead", "🛡 Protected", "🔗 Linked", "🥸 Transformed", "🫡 Targeted"]
let wolfStatuses = ["😁 Alive", "🛡 Protected", "☠️ Dead", "🔗 Linked"]

let roleList = [
Role(name: "Werewolf", team: Team.wolf, bio: "Each night, the Werewolves wake up and select a villager to eat", weight: -6),
Role(name: "Alpha Wolf", team: Team.wolf, bio: "Each night, the Alpha wakes with the Werewolves. If another Wolf died that day, they may convert their target to a Werewolf", weight: -9),
Role(name: "Cub", team: Team.wolf, bio: "Each night, the Cub wakes with the Werewolves. If the Cub is eliminated, the Werewolves eliminate two players the following night", weight: -8),
Role(name: "Wolf Man", team: Team.wolf, bio: "The Wolf Man is a Werewolf but appears as a Villager when scanned. They shed their disguise when they are the last living Wolf", weight: -9),
Role(name: "Were-Wizard", team: Team.wolf, bio: "Once per game, the Were-Wizard may curse the Village team, causing them to lose all powers that night.", weight: -10),
Role(name: "Seer", team: Team.village, bio: "Each night, the Seer wakes up. They point at a player and learn if they are a member of the Village team or Werewolf team", weight: 7),
Role(name: "Villager", team: Team.village, bio: "Find the werewolves and kill them during the day", weight: 1),
Role(name: "Mentalist", team: Team.village, bio: "Each night, wake up and select two players. Learn if they are both on the Village team or Werewolf team", weight: 6),
Role(name: "Bodyguard", team: Team.village, bio: "Each night, the Bodyguard selects a player. That night, the selected player cannot be killed", weight: 3),
Role(name: "Lycan", team: Team.village, bio: "The Lycan is a member of the Village team, but appear as a Werewolf when scanned by other roles", weight: -1),
Role(name: "Hunter", team: Team.village, bio: "When the Hunter is eiliminated, they select a player. That player is immediately eliminated", weight: 3),
Role(name: "Witch", team: Team.village, bio: "The Witch may eliminate or protect a player at night once each per game", weight: 4),
Role(name: "Revealer", team: Team.village, bio: "Once per game, the Revealer may select a player at night. If they are a member of the Wolf team, they are eliminated. If they are not, the Revealer is eliminated", weight: 4),
Role(name: "Diseased", team: Team.village, bio: "If the Diseased is eaten by the Werewolves, they cannot eliminate a player the following night", weight: 3),
Role(name: "Cursed", team: Team.village, bio: "The Cursed is a member of the Village team. However, if they are eliminated by the Werewolves they turn into a Werewolf", weight: -3),
Role(name: "Mad Bomber", team: Team.village, bio: "When the Bomber is eliminated, the two players on their left and right are also eliminated", weight: -2),
Role(name: "Cupid", team: Team.village, bio: "At the beginning of the game, the Cupid selects two players. If one of the selected players is eliminated, the other one dies of a broken heart", weight: -3),
Role(name: "Mayor", team: Team.village, bio: "The Mayor's vote counts twice.", weight: 2),
Role(name: "Tanner", team: Team.village, bio: "The Tanner hates their job and their life. They win if they are eliminated", weight: -2),
Role(name: "P.I.", team: Team.village, bio: "Each night, the P.I. selects a player. They are told if that player or one of their neighbors is a Werewolf.", weight: 3),
Role(name: "Mason", team: Team.village, bio: "The first night, the Masons wake up to learn who the other Mason is.", weight: 3),
Role(name: "Tough Guy", team: Team.village, bio: "If the Werewolves attempt to eliminate the Tough Guy, they are not eliminated until the following night", weight: 3),
Role(name: "Huntress", team: Team.village, bio: "The Huntress may eliminate a player at night once per game", weight: 3),
Role(name: "Prince", team: Team.village, bio: "If the Prince is voted to be eliminated, their role is revealed and they may stay", weight: 3),
Role(name: "Lookout", team: Team.village, bio: "Each night, the lookout chooses a player to watch. The lookout will be told which players, if any, visited the target that night", weight: 3),

]
