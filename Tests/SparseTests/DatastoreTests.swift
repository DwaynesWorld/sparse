import XCTest
@testable import multibase

final class DatastoreTests: XCTestCase {
  func testDefaultInitialization() {
    let store = try! Datastore()
    
    XCTAssertNotNil(store)
    XCTAssertNil(store.filename)
    XCTAssertNil(store.compareStrings)
    XCTAssertTrue(store.inMemoryOnly)
    XCTAssertFalse(store.autoload)
    XCTAssertFalse(store.timestampData)
  }
  
  static var allTests = [
    ("testDefaultInitialization", testDefaultInitialization),
  ]
}
