//
//  IdeaViewModel.swift
//  KotlinIOS
//
//  Created by Dmitri 222 on 10/11/19.


import Foundation
import SwiftUI
import Combine
import SharedCode
import Starscream

class ProgressModel : ObservableObject {
    var inProgress = true
}

public class IdeasViewModel : ObservableObject {
    
    @Published var ideas = [IdeaModel]()
    
    @Published var ideasOriginal = [IdeaModelSwift]()
    
    @Published var dataRequestInProgress = ProgressModel()
    
    @Published var inProgress : Bool = true
    
    private let repository: IdeaRepository?
    private var socket: WebSocket!
    private var hasSubscribed: Bool = false
    
    init(repository: IdeaRepository) {
        self.repository = repository
        fetchKotlin()
    }
    
    init() {
        self.repository = nil
        //dummy delay - to make sure progress indicator working
        let seconds = 1.0
        //DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.fetchNative()  // Put your code which should be executed with a delay here
       // }
       
    }
    
    var ideasSortedByAlpha : [IdeaModel] {
        return ideas.sorted {$0.alpha > $1.alpha}
    }
 
    
    
    func fetchKotlin() {
         dataRequestInProgress.inProgress = true
        inProgress = true
        let seconds = 5.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
       
            self.repository?.fetchIdeas(success: { data in
                self.ideas  = data
                self.setupSockets()
                
//            ideas.forEach {
//                var ideaExt = IdeaModelExt(id: Int($0.id), ideaModel: $0)
//                self.ideas.append(ideaExt)
//            }
            self.dataRequestInProgress.inProgress = false
                self.inProgress = false
            print(self.ideas)
        })
        }
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
      
        var urlComponents = URLComponents(string: "http://localhost:8081/api/ideas")!
       

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
    
     func setupSockets(){
        if(!self.hasSubscribed) {
         var request = URLRequest(url: URL(string: "ws://localhost:8081/ws")!)
               request.timeoutInterval = 1
               socket = WebSocket(request: request)
               socket.delegate = self
               socket.connect()
        }
    }
    
    func registerChannel()
    {
        socket.write(string: "Android client connecting")
          hasSubscribed = true
    }
}

extension IdeasViewModel : WebSocketDelegate {
    // MARK: Websocket Delegate Methods.
    
    public func websocketDidConnect(socket: WebSocketClient) {
      
        registerChannel()
        
        print("websocket is connected")
    
    }
    
    public func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        hasSubscribed = false
        if let e = error as? WSError {
            print("websocket is disconnected: \(e.message)")
        } else if let e = error {
            print("websocket is disconnected: \(e.localizedDescription)")
        } else {
             print("websocket disconnected")
        }
    }
    
    public func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("Received text: \(text)")
        if (text == "reload") {
            fetchKotlin()
        }
    }
    
    public func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("Received data: \(data.count)")
    }
    
    
}

