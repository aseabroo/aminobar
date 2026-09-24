import SwiftUI

// MARK: - Data Model

struct AminoAcid: Identifiable, Hashable {
    var id: String { one }
    let name: String
    let three: String
    let one: String
    let group: Group
    let traits: String
    let sideChainPka: String? // show only when meaningful

    enum Group: String, CaseIterable, Identifiable {
        case nonpolarAliphatic = "Nonpolar (aliphatic)"
        case nonpolarSulfur = "Nonpolar (sulfur)"
        case cyclicImino = "Nonpolar (cyclic imino)"
        case aromaticNonpolar = "Aromatic (nonpolar)"
        case aromaticPolar = "Aromatic (polar)"
        case polarUncharged = "Polar uncharged"
        case polarAmide = "Polar (amide)"
        case acidic = "Acidic (− at phys pH)"
        case basicWeak = "Basic (weak)"
        case basicStrong = "Basic (+ at phys pH)"

        var id: String { rawValue }

        var tint: Color {
            switch self {
            case .nonpolarAliphatic, .nonpolarSulfur, .cyclicImino: return .gray
            case .aromaticNonpolar: return .purple
            case .aromaticPolar: return .indigo
            case .polarUncharged, .polarAmide: return .teal
            case .acidic: return .red
            case .basicWeak, .basicStrong: return .blue
            }
        }

        static var studyFilters: [Self?] { [nil] + Self.allCases }
        var short: String {
            switch self {
            case .nonpolarAliphatic: return "Nonpolar (aliph.)"
            case .nonpolarSulfur: return "Nonpolar (S)"
            case .cyclicImino: return "Cyclic imino"
            case .aromaticNonpolar: return "Aromatic (np)"
            case .aromaticPolar: return "Aromatic (polar)"
            case .polarUncharged: return "Polar"
            case .polarAmide: return "Polar (amide)"
            case .acidic: return "Acidic"
            case .basicWeak: return "Basic (weak)"
            case .basicStrong: return "Basic (+)"
            }
        }
    }
}

extension AminoAcid {
    static func search(_ acids: [AminoAcid], query: String, group: Group?) -> [AminoAcid] {
        let query = query.trimmingCharacters(in: .whitespacesAndNewlines)
        return acids.filter { acid in
            (group == nil || acid.group == group) &&
            (query.isEmpty || acid.name.localizedCaseInsensitiveContains(query)
             || acid.three.localizedCaseInsensitiveContains(query)
             || acid.one.localizedCaseInsensitiveContains(query)
             || acid.group.rawValue.localizedCaseInsensitiveContains(query))
        }.sorted { $0.name < $1.name }
    }
}

// Canonical set (concise, study‑oriented notes). pKa values are approximate.
let AMINO_DATA: [AminoAcid] = [
    .init(name: "Glycine", three: "Gly", one: "G", group: .nonpolarAliphatic, traits: "Small, flexible; no side chain", sideChainPka: nil),
    .init(name: "Alanine", three: "Ala", one: "A", group: .nonpolarAliphatic, traits: "Methyl side chain", sideChainPka: nil),
    .init(name: "Valine", three: "Val", one: "V", group: .nonpolarAliphatic, traits: "Branched (β‑branched)", sideChainPka: nil),
    .init(name: "Leucine", three: "Leu", one: "L", group: .nonpolarAliphatic, traits: "Branched", sideChainPka: nil),
    .init(name: "Isoleucine", three: "Ile", one: "I", group: .nonpolarAliphatic, traits: "Branched, β‑chiral", sideChainPka: nil),
    .init(name: "Methionine", three: "Met", one: "M", group: .nonpolarSulfur, traits: "Thioether; often start (AUG)", sideChainPka: nil),
    .init(name: "Proline", three: "Pro", one: "P", group: .cyclicImino, traits: "Backbone ring; helix breaker", sideChainPka: nil),
    .init(name: "Phenylalanine", three: "Phe", one: "F", group: .aromaticNonpolar, traits: "Phenyl ring; hydrophobic", sideChainPka: nil),
    .init(name: "Tryptophan", three: "Trp", one: "W", group: .aromaticNonpolar, traits: "Indole; largest residue", sideChainPka: nil),
    .init(name: "Tyrosine", three: "Tyr", one: "Y", group: .aromaticPolar, traits: "Phenol; H‑bonding; phospho‑site", sideChainPka: "≈10.1"),
    .init(name: "Serine", three: "Ser", one: "S", group: .polarUncharged, traits: "Hydroxyl; H‑bond; phospho‑site", sideChainPka: nil),
    .init(name: "Threonine", three: "Thr", one: "T", group: .polarUncharged, traits: "Hydroxyl; β‑branched; phosphorylation", sideChainPka: nil),
    .init(name: "Cysteine", three: "Cys", one: "C", group: .polarUncharged, traits: "Thiol; disulfides", sideChainPka: "≈8.3"),
    .init(name: "Asparagine", three: "Asn", one: "N", group: .polarAmide, traits: "Amide of Asp; H‑bonding", sideChainPka: nil),
    .init(name: "Glutamine", three: "Gln", one: "Q", group: .polarAmide, traits: "Amide of Glu; H‑bonding", sideChainPka: nil),
    .init(name: "Aspartate", three: "Asp", one: "D", group: .acidic, traits: "Carboxylate (−)", sideChainPka: "≈3.9"),
    .init(name: "Glutamate", three: "Glu", one: "E", group: .acidic, traits: "Carboxylate (−)", sideChainPka: "≈4.1"),
    .init(name: "Histidine", three: "His", one: "H", group: .basicWeak, traits: "Imidazole; buffer near phys pH", sideChainPka: "≈6.0"),
    .init(name: "Lysine", three: "Lys", one: "K", group: .basicStrong, traits: "ε‑amine; (+) at phys pH", sideChainPka: "≈10.5"),
    .init(name: "Arginine", three: "Arg", one: "R", group: .basicStrong, traits: "Guanidinium; very basic", sideChainPka: "≈12.5"),
]

// MARK: - Focus Search bridge (simple)

final class FocusSearchCenter {
    static let shared = FocusSearchCenter()
    private init() {}

    // Not truly global; it focuses the search field when the popover is open.
    var focusAction: (() -> Void)?
    func focusSearch() { focusAction?() }
}

// MARK: - Views

struct AminoPanel: View {
    @State private var query = ""
    @State private var selectedFilter: AminoAcid.Group? = nil
    @State private var copyConfirmation: String?

    private var filtered: [AminoAcid] {
        AminoAcid.search(AMINO_DATA, query: query, group: selectedFilter)
    }

    var body: some View {
        VStack(spacing: 10) {
            SearchBar(text: $query)
                .onAppear {
                    FocusSearchCenter.shared.focusAction = {
                        NotificationCenter.default.post(name: .focusAminoSearch, object: nil)
                    }
                }

            FilterChips(selected: $selectedFilter)

            if filtered.isEmpty {
                ContentUnavailableView("No results", systemImage: "magnifyingglass", description: Text("Try a different name, code, or group."))
                    .frame(maxWidth: .infinity, minHeight: 120)
            } else {
                List {
                    ForEach(filtered) { aa in
                        AminoRow(aa: aa) {
                            copyToPasteboard(aa)
                        }
                    }
                }
                .listStyle(.inset)
                .frame(height: min(CGFloat(filtered.count) * 44 + 12, 320))
            }

            if let copied = copyConfirmation {
                Text("Copied \(copied) to clipboard")
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                    .transition(.opacity)
            }

            HStack {
                Text("Tap a row to copy its 1-letter code; right-click for more options.")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                Spacer()
                Link(destination: URL(string: "https://en.wikipedia.org/wiki/Amino_acid")!) {
                    Image(systemName: "book")
                }
                .help("Open reference (Wikipedia)")
                .buttonStyle(.borderless)
            }
            .padding(.horizontal, 4)
        }
        .padding(.horizontal, 10)
    }

    private func copyToPasteboard(_ aa: AminoAcid) {
        copy(text: aa.one, banner: aa.one)
    }

    private func copy(text: String, banner: String) {
        let pb = NSPasteboard.general
        pb.clearContents()
        pb.setString(text, forType: .string)
        withAnimation { copyConfirmation = banner }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            withAnimation { copyConfirmation = nil }
        }
    }
}

struct AminoRow: View {
    let aa: AminoAcid
    var copyAction: () -> Void

    var body: some View {
        HStack(spacing: 10) {
            Circle()
                .fill(aa.group.tint.gradient)
                .frame(width: 10, height: 10)

            VStack(alignment: .leading, spacing: 2) {
                HStack(spacing: 6) {
                    Text(aa.name).font(.subheadline.weight(.semibold))
                    Text(aa.group.short).font(.caption2).foregroundStyle(.secondary)
                }
                Text(aa.traits)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(1)
                    .help(aa.traits)
            }

            Spacer()

            VStack(alignment: .trailing, spacing: 2) {
                HStack(spacing: 6) {
                    CodeCapsule(text: aa.one)
                    CodeCapsule(text: aa.three)
                }
                if let pka = aa.sideChainPka {
                    Text("pKa \(pka)")
                        .font(.caption2)
                        .foregroundStyle(.secondary)
                        .help("Approximate side‑chain pKa (environment‑dependent)")
                }
            }
        }
        .contentShape(Rectangle())
        .onTapGesture(perform: copyAction)
        .contextMenu {
            Button("Copy 1‑letter (\(aa.one))", action: copyAction)
            Button("Copy 3‑letter (\(aa.three))") { copy(text: aa.three) }
            Button("Copy name (\(aa.name))") { copy(text: aa.name) }
            Divider()
            Button("Copy line") {
                copy(text: "\(aa.name)\t\(aa.three)\t\(aa.one)\t\(aa.group.rawValue)\t\(aa.traits)\(aa.sideChainPka.map { "\tpKa \($0)" } ?? "")")
            }
        }
    }

    private func copy(text: String) {
        let pb = NSPasteboard.general
        pb.clearContents()
        pb.setString(text, forType: .string)
    }
}

struct CodeCapsule: View {
    let text: String
    var body: some View {
        Text(text)
            .font(.caption2.monospaced())
            .padding(.horizontal, 6).padding(.vertical, 2)
            .background(.thinMaterial, in: Capsule())
    }
}

struct FilterChips: View {
    @Binding var selected: AminoAcid.Group?
    @State private var expanded = false

    var body: some View {
        VStack(spacing: 6) {
            HStack {
                Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
                Button(expanded ? "Less" : "More") { withAnimation { expanded.toggle() } }
                    .buttonStyle(.borderless)
                    .font(.caption)
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 6) {
                    FilterChip(label: "All", color: .secondary.opacity(0.4), isOn: selected == nil) { selected = nil }
                    ForEach(AminoAcid.Group.allCases) { g in
                        if expanded || (g == .acidic || g == .basicStrong || g == .polarUncharged || g == .aromaticNonpolar) {
                            FilterChip(label: g.short, color: g.tint, isOn: selected == g) { selected = g }
                        }
                    }
                }
                .padding(.vertical, 2)
            }
        }
    }
}

struct FilterChip: View {
    let label: String
    let color: Color
    let isOn: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(label)
                .font(.caption2)
                .padding(.horizontal, 8).padding(.vertical, 4)
                .background(isOn ? color.opacity(0.25) : Color.clear, in: Capsule())
                .overlay(Capsule().strokeBorder(color.opacity(isOn ? 0.8 : 0.35), lineWidth: 1))
        }
        .buttonStyle(.borderless)
        .foregroundStyle(color)
        .help("Filter: \(label)")
    }
}

// MARK: - Search Bar

extension Notification.Name { static let focusAminoSearch = Notification.Name("focusAminoSearch") }

struct SearchBar: View {
    @Binding var text: String
    @FocusState private var isFocused: Bool

    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(.secondary)
            TextField("Search name / 1‑ or 3‑letter / group", text: $text)
                .textFieldStyle(.plain)
                .focused($isFocused)
                .onReceive(NotificationCenter.default.publisher(for: .focusAminoSearch)) { _ in
                    isFocused = true
                }
            if !text.isEmpty {
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                }
                .buttonStyle(.borderless)
                .help("Clear")
            }
        }
        .padding(8)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .strokeBorder(Color.secondary.opacity(0.25), lineWidth: 1)
        )
    }
}

// MARK: - About

struct AboutView: View {
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: "testtube.2")
                .font(.system(size: 42))
            Text("AminoBar")
                .font(.title2.weight(.semibold))
            Text("A simple, ethical study aid for amino acids.\nUse responsibly. Typical side‑chain pKa values are approximate and environment‑dependent. N‑terminus ~9–10, C‑terminus ~2–3.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)
                .font(.callout)
            Spacer()
            HStack {
                Spacer()
                Button("Close") {
                    NSApp.keyWindow?.close()
                }
                .keyboardShortcut(.defaultAction)
            }
        }
        .padding()
    }
}
