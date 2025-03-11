//
//  ImageFailedView.swift
//  Fetch
//
//  Created by Ethan Maxey on 3/11/25.
//

import SwiftUI

struct ImageFailedView: View {
    let imageDiameter: CGFloat
    
    var body: some View {
        Image(systemName: "photo")
            .resizable()
            .scaledToFit()
            .frame(width: imageDiameter, height: imageDiameter)
            .background(.gray)
            .clipShape(.circle)
    }
}
