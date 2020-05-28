import XCTest

import multibaseTests

var tests = [XCTestCaseEntry]()
tests += multibaseTests.allTests()
XCTMain(tests)
