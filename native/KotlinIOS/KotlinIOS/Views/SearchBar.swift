//
//  SearchBar.swift
//  KotlinIOS
//
//  Created by Piyush Chhabra on 11/19/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import SwiftUI

struct SearchBar : UIViewRepresentable {
    
    @Binding var text : String
    
    class Cordinator : NSObject, UISearchBarDelegate {
        
        @Binding var text : String
        
        init(text : Binding<String>) {
            _text = text
        }
        
        func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            text = searchText
        }
    }
    
    func makeCoordinator() -> SearchBar.Cordinator {
        return Cordinator(text: $text)
    }
    
    
    func makeUIView(context: UIViewRepresentableContext<SearchBar>) -> UISearchBar {
        let searchBar = UISearchBar(frame: .zero)
        searchBar.barTintColor = UIColor.white
        searchBar.backgroundColor = UIColor.clear
        searchBar.isTranslucent = true
        searchBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
//        searchBar.setImage(UIImage(named: "SearchIcon"), for: .search, state: .normal)
        if let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField,
              let glassIconView = textFieldInsideSearchBar.leftView as? UIImageView {

              textFieldInsideSearchBar.textColor = .white
                  //Magnifying glass
                  glassIconView.image = glassIconView.image?.withRenderingMode(.alwaysTemplate)
            glassIconView.tintColor = .white
          }
        
        
        searchBar.delegate = context.coordinator
        
        return searchBar
    }
    
    func updateUIView(_ uiView: UISearchBar, context: UIViewRepresentableContext<SearchBar>) {
        uiView.text = text
    }
}
