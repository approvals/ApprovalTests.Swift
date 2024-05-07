#if os(OSX)
    import ApprovalTests_Swift
#elseif os(iOS)
    import ApprovalTests_iOS
#endif
import XCTest

final class NamerTests: XCTestCase {
    func test_parameters() throws {
        try Approvals.verify("# Title\n> Quoted text", Approvals.Names.withParameters("story1").forFile.with(extensionWithDot: ".md"))
    }

  func test_parameters_async() async throws {
        try Approvals.verify("# Title\n> Quoted text", Approvals.Names.withParameters("story1").forFile.with(extensionWithDot: ".md"))
    }

    func test_multipleParameters() throws {
        let foo = Approvals.Names.withParameters("story1")
                    .and(Approvals.Names.withAdditionalParameters("part1"))
      let name: String = foo.getNamer("", #function).sourceFilePath()
        XCTAssertEqual(name, ".test_multipleParameters.story1.part1")
    }

    func test_chipArchitecture() throws {
        try Approvals.verify("chip architecture is \(getMachineArchitecture())", Approvals.Names.asChipArchitectureSpecificTest())
    }
}
