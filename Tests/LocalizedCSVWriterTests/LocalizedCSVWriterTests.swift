import XCTest
@testable import LocalizedCSVWriter

final class LocalizedCSVWriterTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(LocalizedCSVWriter().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
