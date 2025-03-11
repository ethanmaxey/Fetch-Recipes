//
//  RecipeListViewModel.swift
//  Fetch
//
//  Created by Ethan Maxey on 3/11/25.
//

import Foundation

@MainActor class RecipeListViewModel: ObservableObject {
    @Published private(set) var state: State = .idle

    /// Fetches recipes and sets view model state in response to the status of the fetch request.
    func refreshRecipes() async {
        state = .loading

        do {
            let recipes = try await RecipeService.fetchRecipes()
            state = recipes.isEmpty ? .error("No recipes available.") : .loaded(recipes)
        } catch NetworkError.invalidResponse {
            state = .error("Invalid server response. Please try again later.")
        } catch {
            state = .error("Failed to load recipes. Please try again later.")
        }
    }
}

extension RecipeListViewModel {
    /// The state of the view.
    enum State {
        case idle
        case loading
        case loaded([Recipe])
        case error(String)
    }
}
