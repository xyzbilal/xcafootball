//
//  XCAfootballApp.swift
//  XCAfootball
//
//  Created by Bilal SIMSEK on 4.07.2023.
//

import SwiftUI

let apiKey = "YOUR_API_KEY"
@main
struct XCAfootballApp: App {
    var body: some Scene {
        WindowGroup {
            TabView{
                StandingsTabItemView()
                    .tabItem {
                        Label("Standings",systemImage: "table.fill")
                    }
                
               TopScorersTabItemView()
                    .tabItem {
                        Label("Top Scorers",systemImage: "soccerball.inverse")
                    }
            }
        }
    }
}
