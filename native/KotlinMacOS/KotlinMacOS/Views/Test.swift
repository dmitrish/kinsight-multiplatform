//
//  Test.swift
//  TryMacOS
//
//  Created by Dmitri  on 12/14/19.
//  Copyright © 2019 spb. All rights reserved.
//

import SwiftUI

struct Test: View {
    @State var isactive = true
    var body: some View {
        NavigationView{
            
            NavigationLink(destination: ContentView()) {
             Text("hi")
                 .foregroundColor(Color.white)
                 .fontWeight(.bold)
             }.frame(height: 500)
            
        }
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
