//
//  TopScorersTabItemView.swift
//  XCAfootball
//
//  Created by Bilal SIMSEK on 4.07.2023.
//

import SwiftUI
import XCAFootballDataClient

struct TopScorersTabItemView: View {
    @State var selectedCompetition:Competition?
    var body: some View {
        NavigationSplitView{
            List(Competition.defaultCompetitions, id:\.self,selection:$selectedCompetition){
                Text($0.name)
            }
            .navigationTitle("XCA Scorers")
        }detail: {
            if let selectedCompetition{
                TopScorersTableView(competition: selectedCompetition)
                    .id(selectedCompetition)
            }else{
                Text("Select Competition")
            }
        }
    }
}

#Preview {
    TopScorersTabItemView()
}
