# AminoBar

A lightweight macOS menu-bar study tool for quickly reviewing the 20 standard amino acids, built with SwiftUI.

AminoBar is intentionally small: it keeps amino-acid reference data one click away without turning a study lookup into a full browser or note-taking workflow.

## Features

- all 20 standard amino acids
- one- and three-letter codes
- biochemical group filters
- name/code/group search
- concise study-oriented side-chain notes
- approximate side-chain pKa values where useful
- one-click clipboard actions
- keyboard-assisted lookup and copying
- native SwiftUI `MenuBarExtra` interface

## Project structure

- [AminoBarApp.swift](AminoBar/AminoBar/AminoBarApp.swift) — macOS menu-bar application entry point
- [ContentView.swift](AminoBar/AminoBar/ContentView.swift) — model data, filtering logic, and SwiftUI interface
- [AminoBarTests.swift](AminoBar/AminoBarTests/AminoBarTests.swift) — data/search/filter tests
- [AminoBar.xcodeproj](AminoBar/AminoBar.xcodeproj) — Xcode project targeting macOS 15

## Run locally

Open `AminoBar/AminoBar.xcodeproj` in Xcode on macOS and run the `AminoBar` scheme.

The repository has been cleaned up from the original prototype so there is a single application entry point and testable filtering logic. The current automated tests cover the amino-acid dataset, search, group filtering, combined filtering, and whitespace handling.

## Study-data note

The descriptions are concise study aids rather than a biochemical reference work. Side-chain pKa values are approximate and environment-dependent; verify course-specific values and terminology against the material being studied.

## Portfolio role

AminoBar is a compact native-app project demonstrating Swift, SwiftUI, macOS menu-bar UI, state-driven filtering, clipboard integration, keyboard interaction, and small-unit testing.

It is deliberately narrower than larger portfolio applications: the goal is a focused utility that does one study task well.

## Status

The source-level prototype cleanup is complete. A clean build should still be verified in Xcode on macOS before publishing a packaged release.
