//
//  KotlinProjectLogo.swift
//  KotlinIOS
//
//  Created by Dmitri Shpinar on 11/26/19.
//  Copyright © 2019 Kinsight. All rights reserved.
//

import SwiftUI

struct KotlinProjectLogo: View {
    var body: some View {
       VStack {
            Text("Ex Unum, Pluribus")
                .foregroundColor(.white)
                .font(.callout)
            Text("Powered by Kotlin Multiplatform")
                .foregroundColor(.white)
            .font(.callout)
                .padding(.top, 2)
        }
    }
}

struct KotlinProjectLogo_Previews: PreviewProvider {
    static var previews: some View {
        KotlinProjectLogo().background(AnimatedBackground())
    }
}
