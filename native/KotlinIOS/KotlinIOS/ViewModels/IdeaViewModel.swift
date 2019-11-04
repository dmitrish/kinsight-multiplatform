//
//  IdeaViewModel.swift
//  KotlinIOS
//
//  Created by Dmitri 222 on 10/11/19.


import Foundation
import SwiftUI
import Combine
import SharedCode


class ProgressModel : ObservableObject {
    var inProgress = false
}

class IdeasViewModel : ObservableObject {
    
    @Published var ideas = [IdeaModel]()
    
    @Published var ideasOriginal = [IdeaModelSwift]()
    
    @Published var dataRequestInProgress = ProgressModel()
    
    private let repository: IdeaRepository?
    
    init(repository: IdeaRepository) {
        self.repository = repository
        fetchKotlin()
    }
    
    init() {
        self.repository = nil
        //dummy delay - to make sure progress indicator working
        let seconds = 5.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.fetchNative()  // Put your code which should be executed with a delay here
        }
       
    }
    
    func fetchKotlin() {
         dataRequestInProgress.inProgress = true
//        let seconds = 5.0
       // DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
       
            self.repository?.fetchIdeas(success: { data in
                self.ideas  = data
//            ideas.forEach {
//                var ideaExt = IdeaModelExt(id: Int($0.id), ideaModel: $0)
//                self.ideas.append(ideaExt)
//            }
            self.dataRequestInProgress.inProgress = false
            print(self.ideas)
        })
       // }
    }
    
    private var searchCancellable: Cancellable? {
           didSet { oldValue?.cancel() }
       }

       deinit {
           searchCancellable?.cancel()
       }

    
    func test(){
        
    }

    
    func fetchNative() {
      
        var urlComponents = URLComponents(string: "https://alphacapture.appspot.com/api/ideas")!
       

        var request = URLRequest(url: urlComponents.url!)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")

        searchCancellable = URLSession.shared.dataTaskPublisher(for: request)
            .map { $0.data }
            .decode(type: [IdeaModelSwift].self, decoder: JSONDecoder())
           // .map { $0 }
            .replaceError(with: [])
            .receive(on: RunLoop.main)
           // .sink(receiveValue: {p in print (p.count)})
            .assign(to: \.ideasOriginal, on: self)
 
 
    }
    
}

