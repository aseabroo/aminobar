import Testing
@testable import AminoBar

struct AminoBarTests {
    @Test func includesAllStandardAminoAcids() {
        #expect(AMINO_DATA.count == 20)
        #expect(Set(AMINO_DATA.map(\.one)).count == 20)
        #expect(Set(AMINO_DATA.map(\.three)).count == 20)
    }

    @Test func searchesByNameAndCodesCaseInsensitively() {
        #expect(filterAminoAcids(AMINO_DATA, query: "trypt", group: nil).map(\.name) == ["Tryptophan"])
        #expect(filterAminoAcids(AMINO_DATA, query: "lys", group: nil).map(\.name) == ["Lysine"])
        #expect(filterAminoAcids(AMINO_DATA, query: "k", group: nil).contains { $0.name == "Lysine" })
    }

    @Test func filtersByGroup() {
        let acidic = filterAminoAcids(AMINO_DATA, query: "", group: .acidic)
        #expect(Set(acidic.map(\.name)) == Set(["Aspartate", "Glutamate"]))
    }

    @Test func combinesSearchAndGroupFilter() {
        let result = filterAminoAcids(AMINO_DATA, query: "g", group: .acidic)
        #expect(result.map(\.name) == ["Glutamate"])
    }

    @Test func trimsSearchWhitespace() {
        #expect(filterAminoAcids(AMINO_DATA, query: "  Ala  ", group: nil).map(\.name) == ["Alanine"])
    }
}
