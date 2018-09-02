import XCTest
@testable import NetworkSpecific

class NetworkSpecificTests: XCTestCase {

    override func setUp() {
        super.setUp()

    }

    override func tearDown() {

        super.tearDown()
    }

}

extension NetworkSpecificTests {

    // JWT
    //    func test_header_generation_successful() {
    //
    //        // GIVEN
    //        let date = Date(timeIntervalSince1970: 0)
    //        let expirationTime = TimeInterval(2 * 60)
    //        let customData: [String: Any] = [
    //            "login": "a@a.co"
    //        ]
    //
    //        // WHEN
    //        let authUtils = AuthUtils()
    //        let jwt = authUtils.apiHeader(date: date, expirationTime: expirationTime, customData: customData)
    //        let header = jwt.split(separator: ".")[0]
    //        let payload = jwt.split(separator: ".")[1]
    //        let signature = jwt.split(separator: ".")[2]
    //
    //        // THEN
    //        XCTAssert(header == "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9")
    //        XCTAssert(payload == "eyJpc3MiOiJDb2xhLUdhc3Ryb2RyaXZlLWlPUyIsImlhdCI6MCwiZXhwIjoxMjAsImxvZ2luIjoiYUBhLmNvIn0")
    //        XCTAssert(signature == "eQ5hKvTnJvdEbtuJEz_QcMTjY9k5XUWz6Bu-0dRm3Vc")
    //
    //    }

}
