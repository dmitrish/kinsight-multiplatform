//
//  HomeViewListNative.swift
//  KotlinIOS
//
//  Created by Dmitri on 10/13/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import Foundation
import SwiftUI

struct HomeViewListNative: View {
    @ObservedObject var ideaViewModel = IdeasViewModel()
    @State private var showProgress: Bool = true
   
    func stopShowing(){
        showProgress = false
    }
    
    var body: some View {
        VStack {
            
           // ActivityIndicator(isAnimating: $showProgress)
            Text("Native iOS")
            
            List(ideaViewModel.ideasOriginal) {
                idea in
                //NavigationLink(destination: IdeaView(ideaModel: idea)) {
                    HomeViewListRowNative(ideaModel: idea)
               // }
                //Text(idea.securityName)
              // HomeViewListRowNative(ideaModel: idea)
            }
        
           
         }
    }
    
    
}

struct ActivityIndicator: UIViewRepresentable {
    @Binding var isAnimating: ProgressModel
    
    func makeUIView(context: Context) -> UIActivityIndicatorView {
        let v = UIActivityIndicatorView()
        
        return v
    }
    
    func updateUIView(_ activityIndicator: UIActivityIndicatorView, context: Context) {
        if isAnimating.inProgress {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}
