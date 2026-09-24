import Testing
@testable import AminoBar

struct AminoBarTests {
    @Test func dataHasUniqueStandardCodes() {
        #expect(AMINO_DATA.count == 20)
        #expect(Set(AMINO_DATA.map(\.one)).count == 20)
        #expect(Set(AMINO_DATA.map(\.three)).count == 20)
        #expect(AMINO_DATA.allSatisfy { $0.id == $0.one })
    }

    @Test func searchAndGroupIntersect() {
        let found = AminoAcid.search(AMINO_DATA, query: "  gLu  ", group: .acidic)
        #expect(found.map(\.one) == ["E"])
        #expect(AminoAcid.search(AMINO_DATA, query: "gLu", group: .polarAmide).isEmpty)
        #expect(AminoAcid.search(AMINO_DATA, query: "zzzz", group: nil).isEmpty)
    }

    @Test func fullCollectionIsSorted() {
        let result = AminoAcid.search(AMINO_DATA, query: "", group: nil)
        #expect(result.count == 20)
        #expect(result.map(\.name) == result.map(\.name).sorted())
        #expect(AminoAcid.search(AMINO_DATA, query: "K", group: nil).contains { $0.name == "Lysine" })
    }
}
