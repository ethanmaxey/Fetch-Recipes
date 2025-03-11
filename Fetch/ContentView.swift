//
//  ContentView.swift
//  Fetch
//
//  Created by Ethan Maxey on 3/11/25.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        RecipeListView()
            .environmentObject(RecipeListViewModel())
    }
}

#Preview {
    ContentView()
}
