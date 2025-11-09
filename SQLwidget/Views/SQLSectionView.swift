//
//  SQLSectionView.swift
//  SQLwidget
//
//  Created on 2025-11-09.
//

import SwiftUI
import AppKit

/// Displays a single SQL section with collapsible examples
struct SQLSectionView: View {
    let section: SQLSection
    let isExpanded: Bool
    let searchQuery: String
    let onToggle: () -> Void
    let highlightMatches: (String) -> [(String, Bool)]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Section header (clickable to expand/collapse)
            Button(action: onToggle) {
                HStack {
                    // Expand/collapse chevron
                    Image(systemName: isExpanded ? "chevron.down" : "chevron.right")
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundColor(.secondary)
                        .frame(width: 16)

                    // Section title with highlighting
                    HighlightedText(
                        text: section.title,
                        highlights: highlightMatches(section.title)
                    )
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.primary)

                    Spacer()

                    // Example count badge
                    Text("\(section.examples.count)")
                        .font(.system(size: 11, weight: .medium))
                        .foregroundColor(.secondary)
                        .padding(.horizontal, 6)
                        .padding(.vertical, 2)
                        .background(Color(NSColor.controlBackgroundColor))
                        .cornerRadius(4)
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .padding(.horizontal, 12)
            .padding(.vertical, 10)
            .background(Color(NSColor.controlBackgroundColor).opacity(0.5))

            // Section content (examples)
            if isExpanded {
                VStack(alignment: .leading, spacing: 12) {
                    // Description (if available)
                    if let description = section.description {
                        Text(description)
                            .font(.system(size: 13))
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 12)
                            .padding(.top, 8)
                    }

                    // Examples
                    ForEach(section.examples) { example in
                        SQLExampleView(
                            example: example,
                            searchQuery: searchQuery,
                            highlightMatches: highlightMatches
                        )
                        .padding(.horizontal, 12)
                    }
                }
                .padding(.bottom, 12)
            }
        }
        .background(Color(NSColor.controlBackgroundColor).opacity(0.3))
        .cornerRadius(8)
    }
}

/// Displays a single SQL code example with copy button
struct SQLExampleView: View {
    let example: SQLExample
    let searchQuery: String
    let highlightMatches: (String) -> [(String, Bool)]

    @State private var showCopied = false

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            // Code block with copy button
            ZStack(alignment: .topTrailing) {
                // Code text
                ScrollView(.horizontal, showsIndicators: false) {
                    Text(example.code)
                        .font(.system(size: 12, design: .monospaced))
                        .foregroundColor(.primary)
                        .padding(12)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .background(Color(NSColor.textBackgroundColor))
                .cornerRadius(6)
                .overlay(
                    RoundedRectangle(cornerRadius: 6)
                        .stroke(Color(NSColor.separatorColor), lineWidth: 1)
                )

                // Copy button
                Button(action: copyCode) {
                    HStack(spacing: 4) {
                        Image(systemName: showCopied ? "checkmark" : "doc.on.doc")
                            .font(.system(size: 11))
                        Text(showCopied ? "Copied!" : "Copy")
                            .font(.system(size: 11, weight: .medium))
                    }
                    .foregroundColor(showCopied ? .green : .secondary)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color(NSColor.controlBackgroundColor).opacity(0.9))
                    .cornerRadius(4)
                }
                .buttonStyle(.plain)
                .padding(6)
                .help("Copy code to clipboard")
            }

            // Explanation (if available)
            if let explanation = example.explanation {
                HStack(alignment: .top, spacing: 6) {
                    Image(systemName: "info.circle")
                        .font(.system(size: 11))
                        .foregroundColor(.blue)
                        .padding(.top, 2)

                    HighlightedText(
                        text: explanation,
                        highlights: highlightMatches(explanation)
                    )
                    .font(.system(size: 12))
                    .foregroundColor(.secondary)
                }
            }
        }
    }

    private func copyCode() {
        let pasteboard = NSPasteboard.general
        pasteboard.clearContents()
        pasteboard.setString(example.code, forType: .string)

        // Show feedback
        withAnimation {
            showCopied = true
        }

        // Reset after 2 seconds
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                showCopied = false
            }
        }
    }
}

/// Renders text with highlighted search matches
struct HighlightedText: View {
    let text: String
    let highlights: [(String, Bool)]

    var body: some View {
        HStack(spacing: 0) {
            ForEach(Array(highlights.enumerated()), id: \.offset) { index, item in
                let (segment, isHighlighted) = item
                Text(segment)
                    .background(isHighlighted ? Color.yellow.opacity(0.4) : Color.clear)
            }
        }
    }
}
