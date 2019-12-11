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





public class IdeaNotificationManager: NSObject, UNUserNotificationCenterDelegate {
    
    public weak var  ideaViewModel: IdeasViewModel?
    public func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        completionHandler([.alert, .badge, .sound])
    }
    
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        ideaViewModel?.handleNotificationTap(notificationRespnse: response)
        completionHandler()
        
    }
    
}


//extension IdeaModel {
//    public var isPriceComplete : Bool
//    public var isNewIdea: Bool
//}

public class IdeasViewModel : ObservableObject {
    
    @Published var ideas = [IdeaModel]()
    
    @Published var ideasOriginal = [IdeaModelSwift]()
    
    @Published var dataRequestInProgress = ProgressModel()
    
    @Published var inProgress : Bool = true
    
    @Published var ideaId : Int32 = 0
    
    @Published var showNewIdea: Bool = false
    
    public var seletedIdea: IdeaModel = IdeaModel.init(id: Int32(0.0), securityName: "", securityTicker: "", alpha: 0.0, benchMarkTicker: "", benchMarkCurrentPrice: 0.0, benchMarkPerformance: 0.0, convictionId: Int32(0.0), currentPrice: 0.0, direction: "", directionId: 0, entryPrice: 0.0, reason: "", stockCurrency: "", stopLoss: 0, stopLossValue: 0.0, targetPrice: 0.0, targetPricePercentage: 0.0, timeHorizon: "", createdBy: "", createdFrom: "", previousCurrentPrice: 0.0, isActive: true, isPOAchieved: false, isNewIdea: false)
    
    private let repository: IdeaRepository?
    private var socket: WebSocket!
    private var hasSubscribed: Bool = false
     
    var notificationManager =  IdeaNotificationManager()
    
    
    init(repository: IdeaRepository) {
        self.repository = repository
        
        notificationManager.ideaViewModel = self
        UNUserNotificationCenter.current().delegate = notificationManager
        loadIdeas()
        
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
        return ideas.filter{$0.isActive == true}.sorted {$0.alpha > $1.alpha}
    }
 
 
    
    func loadIdeas() {
//        sendNotification()
         dataRequestInProgress.inProgress = true
        inProgress = true
        let seconds = 1.0
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
    
    
    func getUserNotificationMessage(serverMessage: String) -> NotificationMessage {
        let notificationMessageArray =  serverMessage.components(separatedBy: "|")
//         var notificationMessageArray = serverMessage.  split("|")
        let notificationMessage = NotificationMessage(messageHeader: notificationMessageArray[0],
                                                      message: notificationMessageArray[1], by: notificationMessageArray[2], from: notificationMessageArray[3], ideaId: Int32(notificationMessageArray[4]) ?? 0)
         return notificationMessage
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
            var request = URLRequest(url: URL(string: Constants.websocketUrl)!)
               request.timeoutInterval = 1
               socket = WebSocket(request: request)
               socket.delegate = self
               socket.connect()
        }
    }
    
    
    
    
    public func handleNotificationTap(notificationRespnse: UNNotificationResponse) {
        
         // Get the meeting ID from the original notification.
          let userInfo = notificationRespnse.notification.request.content.userInfo
          let ideaID = userInfo["idea"] as! Int32
          let ideaType = userInfo["type"] as! String
               
          // Perform the task associated with the action.
          switch ideaType {
            
          case  IdeaNotificationType.priceObjective.rawValue :
            
            
            
            if let  selectedIdea =  (self.ideas.filter {$0.id == ideaID }.first) {
                        selectedIdea.isPOAchieved = true
                                   selectedIdea.isNewIdea = true
                                   self.seletedIdea = selectedIdea
                    }
            self.ideaId = ideaID
            self.showNewIdea = true

            print("Ideas == \(self.ideas)")
             print("Hanlde po")
               
            
          case IdeaNotificationType.newIdea.rawValue:
            
               self.ideaId = ideaID
            
            if let  selectedIdea =  (self.ideas.filter {$0.id == ideaID }.first) {
                               selectedIdea.isNewIdea = true
                               self.seletedIdea = selectedIdea
                }
       
              self.showNewIdea = true
          // Handle other actions…
        
            
          default:
             break
          }
        
    }
    
    
    
     func sendTestNotification() {
         
        
        sendNewIdeaNotification(message: NotificationMessage.init(messageHeader: "HEADER", message: "MESSAGE", by: "PIYUSH", from: "DMITRI", ideaId: 11))
       
     }
    
    func sendPriceObjectiveNotification(message: NotificationMessage) {
        
        let identifier = "LocalNotificationPO"
        
        let content = UNMutableNotificationContent()
        
        content.title = "Aplha Capture "
        content.subtitle = message.messageHeader
        content.body = message.message
       
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        content.categoryIdentifier = IdeaNotificationType.newIdea.rawValue
        content.userInfo = ["idea": message.ideaId, "type":IdeaNotificationType.priceObjective.rawValue ]
        
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("notification Error \(error.localizedDescription)")
            }
        }
    }
    
    
    func sendNewIdeaNotification(message: NotificationMessage) {
        
        let identifier = "LocalNotificationNewIdea"
        
        let content = UNMutableNotificationContent()
        
        content.title = "Aplha Capture "
        content.subtitle = message.messageHeader
        content.body = message.message
              
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        content.categoryIdentifier = IdeaNotificationType.newIdea.rawValue
        content.userInfo = ["idea": message.ideaId, "type": IdeaNotificationType.newIdea.rawValue]
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("notification Error \(error.localizedDescription)")
            }
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
        
        
        /*
            val upperCasedMessage = it.toUpperCase()
            if (upperCasedMessage == RELOAD) {
                loadIdeas()
                notifyOnPriceChanged()
            }
            else if (upperCasedMessage.startsWith(NEW_IDEA)){
                notifyOnNewIdeaCreated(it)
            }
            else if (upperCasedMessage.startsWith(PRICE_OBJECTIVE_ACHIEVED)){
                notifyOnNewPriceObjectiveAchieved(it)
            }
            isSubscribedToLiveUpdates = true
        }
        */

        
        if (text.lowercased().hasPrefix(IdeaNotificationType.reload.rawValue)) {
            loadIdeas()
        }
        else if (text.lowercased().hasPrefix(IdeaNotificationType.newIdea.rawValue)) {
            loadIdeas()
            self.sendNewIdeaNotification(message: self.getUserNotificationMessage(serverMessage: text))
             print("New Idea")
            }
        else if (text.lowercased().hasPrefix(IdeaNotificationType.priceObjective.rawValue)) {
            loadIdeas()
            self.sendPriceObjectiveNotification(message: self.getUserNotificationMessage(serverMessage: text))
            print("Price Objective")
        }

    }
    
    public func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("Received data: \(data.count)")
    }
    
    
}

