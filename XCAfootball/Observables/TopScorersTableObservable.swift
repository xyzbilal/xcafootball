//
//  TopScorersTableObservable.swift
//  XCAfootball
//
//  Created by Bilal SIMSEK on 4.07.2023.
//

import Foundation
import Observation
import XCAFootballDataClient

@Observable
class TopScorersTableObservable{
    let client = FootballDataClient(apiKey: apiKey)
    
    var fetchPhase = FetchPhase<[Scorer]>.initial
    
    var scorers :[Scorer]?{fetchPhase.value}
    
    var selectedFilter = FilterOption.latest
    
    var filterOptions:[FilterOption] = {
        var date = Calendar.current.date(byAdding:.year, value: -4,to:Date())!
        var options = [FilterOption]()
        for i in 0 ..< 3 {
            if let nextYear = Calendar.current.date(byAdding:.year, value: 1,to:date){
                options.append(.year(Calendar.current.component(.year, from: nextYear)))
                date = nextYear
            }
          
        }
        options.append(.latest)
        return options
    }()
    
    
    
    
    func fetchTopScorers(competition:Competition) async{
        fetchPhase = .fetching
        
        do{
           var scorers = try await client.fetchTopScorers(competitionId: competition.id,filterOption: selectedFilter)
           // var scorers = Scorer.stubs
            scorers = scorers.enumerated().map({ index,scorer in
                var scorer = scorer
                scorer.pos = index + 1
                return scorer
            })
            if Task.isCancelled {return }
            fetchPhase = .success(scorers)
        }catch{
            if Task.isCancelled {return }
            fetchPhase = .failure(error)
        }
    }
    
    
}

extension Scorer{
    static var stubs:[Scorer]{
        let url = Bundle.main.url(forResource: "scorers", withExtension:  "json")!
        let scorerResponse:TopScorersResponse = Utilities.loadStub(url: url)
        return scorerResponse.scorers!
    }
}

