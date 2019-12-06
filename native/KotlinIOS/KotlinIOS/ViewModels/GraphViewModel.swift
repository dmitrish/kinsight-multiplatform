//
//  GraphViewModel.swift
//  KotlinIOS
//
//  Created by Lee, Mark on 12/6/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import SwiftUI
import SharedCode

class GraphProgressModel : ObservableObject {
    var inProgress = true
}

public class GraphViewModel : ObservableObject {
    
    @Published var graphModel: GraphModel?
    @Published var dataRequestInProgress = ProgressModel()
    @Published var inProgress : Bool = true
    
    private let repository: IdeaRepository?
    private let ideaModel: IdeaModel?
    
    init(repository: IdeaRepository, ideaModel: IdeaModel) {
        self.repository = repository
        self.ideaModel = ideaModel
        fetchKotlin()
    }
    
    func fetchKotlin() {
        dataRequestInProgress.inProgress = true
        
        if let ideaId = ideaModel?.id {
            repository?.fetchGraph(ideaId: ideaId, success: { data in
                self.graphModel = data
                self.dataRequestInProgress.inProgress = false
            })
        }
    }
}
