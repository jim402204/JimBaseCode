import XCTest
@testable import JimBaseCode

final class JimBaseCodeTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(JimBaseCode().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
