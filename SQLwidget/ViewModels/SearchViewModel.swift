//
//  SearchViewModel.swift
//  SQLwidget
//
//  Created on 2025-11-09.
//

import Foundation
import Combine

/// Manages search state and filtering logic
class SearchViewModel: ObservableObject {
    @Published var searchQuery: String = ""
    @Published var filteredSections: [SQLSection] = []
    @Published var expandedSections: Set<UUID> = []

    private let allSections: [SQLSection]
    private var cancellables = Set<AnyCancellable>()

    init() {
        self.allSections = SQLData.allSections
        self.filteredSections = allSections

        // Set up real-time search filtering
        $searchQuery
            .debounce(for: .milliseconds(100), scheduler: DispatchQueue.main)
            .sink { [weak self] query in
                self?.filterSections(query: query)
            }
            .store(in: &cancellables)
    }

    /// Filter sections based on search query
    private func filterSections(query: String) {
        let trimmedQuery = query.trimmingCharacters(in: .whitespaces)

        // Show all sections if query is empty
        guard !trimmedQuery.isEmpty else {
            filteredSections = allSections
            expandedSections.removeAll()  // Collapse all sections when search is cleared
            return
        }

        let lowercaseQuery = trimmedQuery.lowercased()

        // Filter sections that match the query
        filteredSections = allSections.filter { section in
            matchesSection(section, query: lowercaseQuery)
        }

        // Auto-expand all sections when searching
        if !trimmedQuery.isEmpty {
            expandedSections = Set(filteredSections.map { $0.id })
        }
    }

    /// Check if a section matches the search query
    private func matchesSection(_ section: SQLSection, query: String) -> Bool {
        // Search in title
        if section.title.lowercased().contains(query) {
            return true
        }

        // Search in description
        if let description = section.description, description.lowercased().contains(query) {
            return true
        }

        // Search in keywords
        if section.keywords.contains(where: { $0.lowercased().contains(query) }) {
            return true
        }

        // Search in code examples
        if section.examples.contains(where: { example in
            example.code.lowercased().contains(query)
        }) {
            return true
        }

        // Search in explanations
        if section.examples.contains(where: { example in
            example.explanation?.lowercased().contains(query) ?? false
        }) {
            return true
        }

        return false
    }

    /// Toggle section expansion
    func toggleSection(_ sectionId: UUID) {
        if expandedSections.contains(sectionId) {
            expandedSections.remove(sectionId)
        } else {
            expandedSections.insert(sectionId)
        }
    }

    /// Check if section is expanded
    func isExpanded(_ sectionId: UUID) -> Bool {
        expandedSections.contains(sectionId)
    }

    /// Clear search query
    func clearSearch() {
        searchQuery = ""
        expandedSections.removeAll()
    }

    /// Highlight matching text in a string
    func highlightMatches(in text: String) -> [(String, Bool)] {
        let trimmedQuery = searchQuery.trimmingCharacters(in: .whitespaces)
        guard !trimmedQuery.isEmpty else {
            return [(text, false)]
        }

        let lowercaseText = text.lowercased()
        let lowercaseQuery = trimmedQuery.lowercased()

        var result: [(String, Bool)] = []
        var lastIndex = text.startIndex

        while let range = lowercaseText[lastIndex...].range(of: lowercaseQuery) {
            // Add non-matching text before the match
            if lastIndex < range.lowerBound {
                let beforeMatch = String(text[lastIndex..<range.lowerBound])
                result.append((beforeMatch, false))
            }

            // Add matching text
            let match = String(text[range])
            result.append((match, true))

            lastIndex = range.upperBound
        }

        // Add remaining non-matching text
        if lastIndex < text.endIndex {
            let remaining = String(text[lastIndex...])
            result.append((remaining, false))
        }

        return result.isEmpty ? [(text, false)] : result
    }
}
