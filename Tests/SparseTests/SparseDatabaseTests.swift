import XCTest
@testable import Sparse

final class SparseDatabaseTests: XCTestCase {
  func testDefaultInitialization() {
    let db = try! SparseDatabase("testDb")
    let coll = try! SparseCollection("test", database: db)
    
    XCTAssertNotNil(db)
    XCTAssertNotNil(coll)
  }
  
  static var allTests = [
    ("testDefaultInitialization", testDefaultInitialization),
  ]
}
