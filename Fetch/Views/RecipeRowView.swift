//
//  RecipeRowView.swift
//  Fetch
//
//  Created by Ethan Maxey on 3/11/25.
//


import SwiftUI

struct RecipeRowView: View {
    let recipe: Recipe
    
    var body: some View {
        HStack {
            ImageRecipeView(recipe: recipe)
            
            Spacer()

            RecipeTextView(recipe: recipe)
        }
        .padding(.top)
        .padding(.leading)
    }
}

#Preview {
    RecipeListView()
        .environmentObject(RecipeListViewModel())
}
