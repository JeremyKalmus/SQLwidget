//
//  ContentView.swift
//  SQLwidget
//
//  Created on 2025-11-09.
//

import SwiftUI

/// Main view for the SQL Cheat Sheet popover
struct ContentView: View {
    @StateObject private var viewModel = SearchViewModel()

    var body: some View {
        VStack(spacing: 0) {
            // Header with title and search
            VStack(spacing: 12) {
                // Title
                HStack {
                    Image(systemName: "cylinder.split.1x2")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.blue)

                    Text("SQL Cheat Sheet")
                        .font(.system(size: 18, weight: .semibold))

                    Spacer()

                    // Results count
                    if !viewModel.searchQuery.isEmpty {
                        Text("\(viewModel.filteredSections.count) result\(viewModel.filteredSections.count == 1 ? "" : "s")")
                            .font(.system(size: 12))
                            .foregroundColor(.secondary)
                    }
                }

                // Search bar
                SearchBar(
                    searchText: $viewModel.searchQuery,
                    onClear: viewModel.clearSearch
                )
            }
            .padding(16)
            .background(Color(NSColor.windowBackgroundColor))

            Divider()

            // Sections list
            if viewModel.filteredSections.isEmpty {
                // No results
                VStack(spacing: 12) {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 48))
                        .foregroundColor(.secondary)

                    Text("No results found")
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(.primary)

                    Text("Try a different search term")
                        .font(.system(size: 13))
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color(NSColor.controlBackgroundColor).opacity(0.3))
            } else {
                // Scrollable list of sections
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(viewModel.filteredSections) { section in
                            SQLSectionView(
                                section: section,
                                isExpanded: viewModel.isExpanded(section.id),
                                searchQuery: viewModel.searchQuery,
                                onToggle: {
                                    viewModel.toggleSection(section.id)
                                },
                                highlightMatches: viewModel.highlightMatches
                            )
                        }
                    }
                    .padding(12)
                }
                .background(Color(NSColor.controlBackgroundColor).opacity(0.3))
            }

            Divider()

            // Footer with tips
            HStack(spacing: 16) {
                Label("⌘F to search", systemImage: "keyboard")
                    .font(.system(size: 11))
                    .foregroundColor(.secondary)

                Spacer()

                Text("\(SQLData.allSections.count) sections • \(SQLData.allSections.reduce(0) { $0 + $1.examples.count }) examples")
                    .font(.system(size: 11))
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color(NSColor.windowBackgroundColor))
        }
        .frame(width: 750, height: 600)
        .background(Color(NSColor.windowBackgroundColor))
    }
}

// MARK: - Preview
#Preview {
    ContentView()
        .frame(width: 750, height: 600)
}
