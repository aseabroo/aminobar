# AminoBar

A small macOS 15+ menu-bar study tool for looking up the 20 standard amino acids. It has local data, name/code/group search, group filters, short notes, approximate side-chain pKa values and clipboard actions.

## Run and test

Open `AminoBar/AminoBar.xcodeproj` in Xcode on a Mac. Select the AminoBar scheme and run the app. Open the menu-bar icon, type a name, one-letter code, three-letter code or group, and optionally choose a filter. Click a row to copy its one-letter code; right-click for additional copy choices. “About AminoBar…” opens the About window. Run the `AminoBarTests` target from Xcode to verify data uniqueness, stable identifiers and search/filter behavior.

## Status and sources

The duplicate `@main` and missing root view have been repaired, and the search/filter operation has focused unit tests. A macOS Xcode build, UI interaction and screenshot still need verification on a Mac; Linux cannot compile SwiftUI/AppKit. No screenshot or successful Mac run is claimed here.

The one- and three-letter names/codes can be checked against the [IUPAC-IUB amino-acid nomenclature table](https://iupac.qmul.ac.uk/AminoAcid/tab1.html). For introductory structures and approximate ionizable side-chain pKa values, see [OpenStax Organic Chemistry §26.1](https://chem.libretexts.org/Bookshelves/Organic_Chemistry/Organic_Chemistry_%28OpenStax%29/26%3A_Biomolecules-_Amino_Acids_Peptides_and_Proteins/26.01%3A_Structures_of_Amino_Acids). Notes are concise study cues, not a controlled medical or biochemical reference; pKa depends on chemical environment.

The original code and app concept are by Augustus Seabrooke; this cleanup was AI-assisted and requires the Mac verification above before calling the app build-tested.
