//
//  SQLContent.swift
//  SQLwidget
//
//  Created on 2025-11-09.
//

import Foundation

/// Represents a single SQL code example with optional explanation
struct SQLExample: Identifiable {
    let id = UUID()
    let code: String
    let explanation: String?
    let isMultiline: Bool

    init(code: String, explanation: String? = nil, isMultiline: Bool = true) {
        self.code = code
        self.explanation = explanation
        self.isMultiline = isMultiline
    }
}

/// Represents a section of SQL content (e.g., "Joins", "Window Functions")
struct SQLSection: Identifiable {
    let id = UUID()
    let title: String
    let description: String?
    let examples: [SQLExample]
    let keywords: [String]

    init(title: String, description: String? = nil, examples: [SQLExample], keywords: [String]) {
        self.title = title
        self.description = description
        self.examples = examples
        self.keywords = keywords
    }
}
