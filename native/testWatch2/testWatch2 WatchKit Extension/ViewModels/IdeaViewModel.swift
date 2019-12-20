//
//  IdeaViewModel.swift
//  testWatch2 WatchKit Extension
//
//  Created by Dmitri Shpinar on 12/14/19.
//  Copyright © 2019 spb. All rights reserved.
//

import Foundation
import SharedCode
import Combine

extension IdeaModel : Identifiable {
    // Dummy for compiler
}


public class IdeasViewModel : ObservableObject {

@Published var ideas = [IdeaModel]()
   
   @Published var ideasOriginal = [IdeaModelSwift]()
    
     private let repository: IdeaRepository?
    
    init() {
        
        repository = IdeaRepository(baseUrl: "http://35.239.179.43:8081")
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
        self.repository?.fetchIdeas(success: { data in
                        self.ideas  = data
                       
                    print("ideas from \(self.ideas)")
                })
        }
                
        //DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
           // self.fetchNative()  // Put your code which should be executed with a delay here
       
 print(self.ideasOriginal)
        
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
           
           let urlComponents = URLComponents(string: "http://35.239.179.43:8081/api/ideas")!
           
           var request = URLRequest(url: urlComponents.url!)
           request.addValue("application/json", forHTTPHeaderField: "Content-Type")

           searchCancellable = URLSession.shared.dataTaskPublisher(for: request)
               .map { $0.data }
               .decode(type: [IdeaModelSwift].self, decoder: JSONDecoder())
              // .map { $0 }
        .print()
               .replaceError(with: [])
               .receive(on: RunLoop.main)
              // .sink(receiveValue: {p in print (p.count)})
               .assign(to: \.ideasOriginal, on: self)
    
    
       }
       

}
