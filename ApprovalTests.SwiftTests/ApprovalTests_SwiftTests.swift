//
//  ApprovalTests_SwiftTests.swift
//  ApprovalTests.SwiftTests
//
//  Created by Industrial Logic on 9/29/18.
//  Copyright © 2018 NA. All rights reserved.
//

import XCTest
@testable import ApprovalTests_Swift

class ApprovalTests_SwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        let fileManager = FileManager.default
        let testDir = "/Users/industriallogic/Documents/Playgrounds/ApprovalTests.Swift/ApprovalTests.SwiftTests"
        fileManager.changeCurrentDirectoryPath(testDir)

    }
    
    override func tearDown() {
        super.tearDown()
    }

    func testClassName() {
        let name = Namer()
        XCTAssertEqual("ApprovalTests_SwiftTests.testClassName", name.getApprovalName())
    }
    func testEmbeddedStackName() {
        let namer = createEmbeddedNamer()
        XCTAssertEqual("ApprovalTests_SwiftTests.testEmbeddedStackName", namer.getApprovalName())
    }

    private func createEmbeddedNamer() -> Namer {
        return Namer()
    }

    func testFindReceivedFile() {
        let name = Namer()
        let fileManager = FileManager.default
        let missingFile = URL(fileURLWithPath: name.getSourceFilePath() + ".received.txt")

        XCTAssertTrue(fileManager.fileExists(atPath: missingFile.path))
    }

}
