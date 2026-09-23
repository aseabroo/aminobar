# AminoBar

A small macOS menu bar study tool for looking up amino acids, written in SwiftUI.

The source includes the 20 standard amino acids, one- and three-letter codes, group filters, short study notes, approximate side-chain pKa values, and clipboard actions. The data is stored locally in `ContentView.swift`.

## Current status

Early prototype. The Xcode project targets macOS 15.0. A clean build still needs work: both `AminoBarApp.swift` and `ContentView.swift` declare the app entry point, and the starter app references a `ContentView` type that is no longer defined. The test target still contains an empty example test.

## Explore the project

Open `AminoBar/AminoBar.xcodeproj` in Xcode on a Mac.

- [ContentView.swift](AminoBar/AminoBar/ContentView.swift): amino acid data, menu bar interface, search, and filters.
- [AminoBarApp.swift](AminoBar/AminoBar/AminoBarApp.swift): original app entry point.
- [AminoBarTests.swift](AminoBar/AminoBarTests/AminoBarTests.swift): starting point for tests.

## Next steps

1. Consolidate the app entry point and verify the build in Xcode.
2. Check keyboard shortcuts and the About window.
3. Add a real screenshot and small tests for search and group filtering.

The study notes and pKa values are approximate; check them against course materials.
