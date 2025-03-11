//
//  EmptyStateView.swift
//  Fetch
//
//  Created by Ethan Maxey on 3/11/25.
//


import SwiftUI

struct EmptyStateView: View {
    let message: String

    var body: some View {
        VStack {
            Image(systemName: "exclamationmark.triangle")
                .font(.largeTitle)
                .padding()
            Text(message)
                .font(.title2)
                .multilineTextAlignment(.center)
        }
        .foregroundColor(.gray)
    }
}