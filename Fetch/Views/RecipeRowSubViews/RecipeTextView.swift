//
//  RecipeTextView.swift
//  Fetch
//
//  Created by Ethan Maxey on 3/11/25.
//

import SwiftUI

struct RecipeTextView: View {
    let recipe: Recipe
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(recipe.name)
                .font(.headline)
            Text(recipe.cuisine)
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
