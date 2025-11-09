# SQL Cheat Sheet - macOS Menubar Widget

A native macOS menubar application that provides instant access to a comprehensive SQL syntax reference with powerful search functionality. Built with Swift 6 and SwiftUI for macOS 13.0+.

![SQL Cheat Sheet Icon](https://img.shields.io/badge/macOS-13.0+-blue)
![Swift Version](https://img.shields.io/badge/Swift-6.0-orange)
![License](https://img.shields.io/badge/license-MIT-green)

## Features

- **Instant Access**: Click the database icon in your menubar to open the SQL reference
- **Comprehensive Content**: 18 sections covering all major SQL concepts
  - Query execution order, basic queries, filtering, joins
  - Aggregate functions, window functions, CTEs
  - Date/string/math functions, conditional logic
  - Subqueries, set operations, data modification
  - Performance tips, common patterns, and best practices
- **Real-time Search**: Filter through 100+ SQL examples as you type
- **Smart Filtering**: Search by section title, SQL keywords, function names, or code content
- **Search Highlighting**: Matching terms are highlighted in yellow for easy scanning
- **One-click Copy**: Copy any code example to clipboard with a single click
- **Clean UI**: Professional design optimized for quick reference
- **Keyboard Shortcuts**: ⌘F to focus search, ESC to close

## Screenshots

The app displays as a database icon in your menubar. Click it to reveal the SQL reference popover with:
- Searchable sections (collapsible/expandable)
- Syntax-highlighted code examples
- Inline explanations and tips
- Copy buttons for quick code reuse

## Requirements

- **macOS**: 13.0 (Ventura) or later
- **Xcode**: 15.0+ (for building from source)
- **Swift**: 6.0+

## Installation

### Option 1: Build from Source (Recommended)

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/SQLwidget.git
   cd SQLwidget
   ```

2. **Open in Xcode**
   ```bash
   open SQLwidget.xcodeproj
   ```

   Note: You'll need to create the Xcode project first (see [Creating the Xcode Project](#creating-the-xcode-project) below)

3. **Build and Run**
   - Select "My Mac" as the target
   - Click the Run button (⌘R) or use Product → Run
   - The menubar icon will appear in your menubar

4. **Export for Daily Use** (Optional)
   - Product → Archive
   - Distribute App → Copy App
   - Move the exported app to your Applications folder
   - Open it to add to menubar permanently

### Creating the Xcode Project

Since this repository contains the source files but not the Xcode project configuration, you'll need to create the Xcode project:

1. **Open Xcode** and create a new project
   - File → New → Project
   - Select macOS → App
   - Click Next

2. **Configure the project**
   - Product Name: `SQLwidget`
   - Team: Select your team (or None for local development)
   - Organization Identifier: `com.yourname` (or your preferred identifier)
   - Interface: SwiftUI
   - Language: Swift
   - Click Next and save in the cloned repository directory

3. **Replace the auto-generated files**
   - Delete the auto-generated `SQLwidgetApp.swift` and `ContentView.swift`
   - Add the project files to Xcode:
     - Right-click the SQLwidget folder in Xcode
     - Select "Add Files to SQLwidget..."
     - Add all `.swift` files from the repository:
       - `SQLwidget/SQLwidgetApp.swift`
       - `SQLwidget/MenuBarController.swift`
       - `SQLwidget/Models/SQLContent.swift`
       - `SQLwidget/Models/SQLData.swift`
       - `SQLwidget/ViewModels/SearchViewModel.swift`
       - `SQLwidget/Views/ContentView.swift`
       - `SQLwidget/Views/SearchBar.swift`
       - `SQLwidget/Views/SQLSectionView.swift`

4. **Configure Info.plist**
   - Replace the auto-generated Info.plist with the one from the repository
   - Or manually add: `LSUIElement` = `YES` (makes it menubar-only)

5. **Set deployment target**
   - Select the project in Xcode
   - Go to Build Settings
   - Set "macOS Deployment Target" to 13.0

6. **Build and run** (⌘R)

### Option 2: Pre-built Binary (Coming Soon)

A signed, notarized binary will be available in the Releases section.

## Usage

### Opening the SQL Reference

1. **Click the database icon** in your menubar (🗄️)
2. The popover will appear with the full SQL cheat sheet
3. Browse through sections or use search

### Searching for SQL Syntax

1. **Focus the search bar** (auto-focused on open, or press ⌘F)
2. **Type your search query**:
   - `join` - find all JOIN-related syntax
   - `window` - find window functions
   - `date` - find date manipulation functions
   - `case` - find conditional logic examples
   - `cte` - find Common Table Expressions
3. **Results appear instantly** as you type
4. **Matching terms are highlighted** in yellow
5. **Sections auto-expand** when searching

### Using Code Examples

1. **Browse or search** to find the SQL syntax you need
2. **Click the Copy button** on any code example
3. **Paste into your SQL editor** (⌘V)
4. The "Copied!" confirmation appears briefly

### Keyboard Shortcuts

- **⌘F**: Focus search bar
- **ESC**: Close the popover
- **Click outside**: Close the popover
- **Tab**: Navigate through interactive elements

### Tips for Effective Use

- **Search by keyword**: Try `sum`, `group by`, `left join`, etc.
- **Search by function name**: `COUNT`, `ROW_NUMBER`, `COALESCE`
- **Search by concept**: `recursive`, `subquery`, `performance`
- **Expand sections**: Click section headers to expand/collapse
- **All sections visible by default**: Browse everything or search to filter

## Project Structure

```
SQLwidget/
├── SQLwidget/
│   ├── SQLwidgetApp.swift              # App entry point and AppDelegate
│   ├── MenuBarController.swift         # Menubar icon and popover management
│   │
│   ├── Models/
│   │   ├── SQLContent.swift            # Data structures (SQLSection, SQLExample)
│   │   └── SQLData.swift               # Complete SQL reference content (18 sections)
│   │
│   ├── ViewModels/
│   │   └── SearchViewModel.swift       # Search logic and filtering
│   │
│   ├── Views/
│   │   ├── ContentView.swift           # Main popover UI
│   │   ├── SearchBar.swift             # Search input component
│   │   └── SQLSectionView.swift        # Section display and code examples
│   │
│   ├── Assets.xcassets/                # App icons and images
│   └── Info.plist                      # App configuration (LSUIElement = true)
│
├── README.md                           # This file
└── .gitignore                          # Git ignore patterns
```

## SQL Content Sections

The app includes comprehensive coverage of:

1. **Query Execution Order** - Understanding SQL's execution flow
2. **Basic Queries** - SELECT, DISTINCT, aliases
3. **Filtering (WHERE)** - Operators, LIKE, IN, NULL handling
4. **Joining Tables** - INNER, LEFT, RIGHT, FULL OUTER, self joins
5. **Aggregate Functions** - COUNT, SUM, AVG, GROUP BY, HAVING
6. **Window Functions** - ROW_NUMBER, RANK, LAG/LEAD, running totals
7. **Date Functions** - Date arithmetic, formatting, extraction
8. **String Functions** - UPPER, LOWER, SUBSTRING, CONCAT, TRIM
9. **Mathematical Functions** - ROUND, CEIL, FLOOR, ABS, POWER
10. **Conditional Logic** - CASE statements, COALESCE, NULLIF
11. **Subqueries** - In SELECT, FROM, WHERE clauses
12. **CTEs (Common Table Expressions)** - Including recursive CTEs
13. **Set Operations** - UNION, INTERSECT, EXCEPT
14. **Data Modification** - INSERT, UPDATE, DELETE
15. **Common Calculations** - YoY variance, percentiles, moving averages
16. **Performance Tips** - Indexing, query optimization
17. **Common Patterns** - Real-world query templates
18. **Pro Tips** - Best practices for writing clean SQL

## Technical Details

### Architecture

- **SwiftUI** for modern, declarative UI
- **Combine** for reactive search filtering
- **NSStatusBar** for menubar integration
- **NSPopover** for the dropdown panel
- **AppKit + SwiftUI** hybrid for menubar functionality

### Performance

- **Debounced search** (100ms) for instant-feeling results
- **Lazy loading** of section views
- **Efficient filtering** algorithm
- **Minimal memory footprint** (~10MB)

### Design Decisions

1. **Menubar-only app** (LSUIElement = true) - No Dock icon, always accessible
2. **Transient popover** - Closes when clicking outside
3. **Auto-expanding search results** - All matching sections expand automatically
4. **Monospace fonts** for code (SF Mono/Menlo)
5. **System colors** for native macOS appearance
6. **Copy feedback** - Visual confirmation when copying code

## Development

### Adding New SQL Sections

Edit [SQLData.swift](SQLwidget/Models/SQLData.swift) and add a new `SQLSection` to the `allSections` array:

```swift
SQLSection(
    title: "Your Section Title",
    description: "Brief description",
    examples: [
        SQLExample(
            code: """
            SELECT example
            FROM your_table;
            """,
            explanation: "What this does"
        )
    ],
    keywords: ["keyword1", "keyword2", "function_name"]
)
```

### Customizing the UI

- **Colors**: Modify color values in [ContentView.swift](SQLwidget/Views/ContentView.swift)
- **Fonts**: Change font styles in individual view files
- **Popover size**: Adjust in [MenuBarController.swift](SQLwidget/MenuBarController.swift) (`contentSize`)
- **Search debounce**: Modify in [SearchViewModel.swift](SQLwidget/ViewModels/SearchViewModel.swift)

## Troubleshooting

### The menubar icon doesn't appear

- Check that `LSUIElement` is set to `YES` in Info.plist
- Try restarting the app
- Check Console.app for error messages

### Search isn't working

- Ensure SearchViewModel is properly initialized
- Check that the searchQuery binding is connected
- Look for errors in Xcode console

### Code won't copy to clipboard

- Check that the app has proper permissions
- Try restarting the app
- Ensure NSPasteboard is accessible

### App crashes on launch

- Verify macOS version (13.0+)
- Check Xcode version (15.0+)
- Ensure all Swift files are properly added to the target

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request. Areas for improvement:

- Additional SQL syntax examples
- Dark mode optimization
- Customizable themes
- Export favorites feature
- Custom snippet support
- Multi-database syntax variations (PostgreSQL, MySQL, SQL Server)

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Acknowledgments

- Built with Swift 6 and SwiftUI
- SF Symbols for icons
- Inspired by the need for quick SQL reference while coding

## Support

- **Issues**: Please report bugs or feature requests in the [GitHub Issues](https://github.com/yourusername/SQLwidget/issues)
- **Discussions**: For questions and discussions, use [GitHub Discussions](https://github.com/yourusername/SQLwidget/discussions)

---

**Made with ❤️ for data analysts and SQL developers**
