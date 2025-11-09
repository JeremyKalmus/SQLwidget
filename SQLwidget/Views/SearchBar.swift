//
//  SearchBar.swift
//  SQLwidget
//
//  Created on 2025-11-09.
//

import SwiftUI

/// Search bar component for filtering SQL content
struct SearchBar: View {
    @Binding var searchText: String
    @FocusState private var isFocused: Bool
    var onClear: () -> Void

    var body: some View {
        HStack(spacing: 8) {
            // Search icon
            Image(systemName: "magnifyingglass")
                .foregroundColor(.secondary)
                .font(.system(size: 14))

            // Text field
            TextField("Search SQL syntax...", text: $searchText)
                .textFieldStyle(.plain)
                .font(.system(size: 14))
                .focused($isFocused)

            // Clear button
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                    onClear()
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.secondary)
                        .font(.system(size: 14))
                }
                .buttonStyle(.plain)
                .help("Clear search")
            }
        }
        .padding(10)
        .background(Color(NSColor.controlBackgroundColor))
        .cornerRadius(8)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color(NSColor.separatorColor), lineWidth: 1)
        )
        .onAppear {
            // Auto-focus on appear
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                isFocused = true
            }
        }
    }
}
