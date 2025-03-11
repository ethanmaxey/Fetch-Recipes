//
//  RecipeListView.swift
//  Fetch
//
//  Created by Ethan Maxey on 3/11/25.
//

import SwiftUI

struct RecipeListView: View {
    @StateObject private var viewModel = RecipeListViewModel()

    var body: some View {
        NavigationView {
            Group {
                switch viewModel.state {
                case .idle:
                    EmptyView()
                case .loading:
                    ProgressView()
                case .loaded(let recipes):
                    ScrollView {
                        LazyVStack {
                            ForEach(recipes) { recipe in
                                RecipeRowView(recipe: recipe)
                            }
                        }
                    }
                    .refreshable {
                        await viewModel.refreshRecipes()
                    }
                case .error(let message):
                    EmptyStateView(message: message)
                }
            }
            .navigationTitle("Recipes")
            .toolbar {
                RecipeViewToolbar()
            }
        }
        .task {
            await viewModel.refreshRecipes()
        }
    }
}

#Preview {
    RecipeListView()
        .environmentObject(RecipeListViewModel())
}
