//
//  ImageRecipeView.swift
//  Fetch
//
//  Created by Ethan Maxey on 3/11/25.
//

import SwiftUI

struct ImageRecipeView: View {
    let recipe: Recipe
    let imageDiameter: CGFloat = 50
    
    var body: some View {
        if let imageURL = recipe.photoURLSmall {
            AsyncImage(url: URL(string: imageURL)) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: imageDiameter, height: imageDiameter)
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: imageDiameter, height: imageDiameter)
                        .clipShape(.circle)
                        .overlay(Circle().stroke(.white, lineWidth: 2))
                        .shadow(radius: 5)
                default:
                    ImageFailedView(imageDiameter: imageDiameter)
                }
            }
        } else {
            ImageFailedView(imageDiameter: imageDiameter)
        }
    }
}
