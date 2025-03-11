//
//  RecipeViewToolbar.swift
//  Fetch
//
//  Created by Ethan Maxey on 3/11/25.
//

import SwiftUI

struct RecipeViewToolbar: ToolbarContent {
    @EnvironmentObject var viewModel: RecipeListViewModel
    
    var body: some ToolbarContent {
        ToolbarItemGroup {
            if case RecipeListViewModel.State.loaded(_) = viewModel.state {
                Button {
                    Task {
                        await viewModel.refreshRecipes()
                    }
                } label: {
                    Image(systemName: "arrow.clockwise")
                }
            }
        }
    }
}

#Preview {
    RecipeListView()
        .environmentObject(RecipeListViewModel())
}
