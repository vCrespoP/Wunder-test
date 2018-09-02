import XCTest
@testable import Domain

import RxSwift
import SharedUtils
import PlatformPersistenceStatic

class TestsDomainVehicle: XCTestCase {

    // MARK: Properties
    let disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()

    }

    override func tearDown() {

        super.tearDown()
    }

}

fileprivate extension TestsDomainVehicle {

    var testBundle: Bundle {
        return Bundle(for: type(of: self))
    }

}

extension TestsDomainVehicle {

    func test_vehicle_parsing() {

        // GIVEN
        let json = JSONUtils.readDictionary(resourceName: "Vehicle", bundle: self.testBundle)

        // WHEN
        guard let result = try? Vehicle.parse(from: json)! else {
            XCTFail()
            return
        }

        // THEN
        XCTAssertNotNil(result.address)
        XCTAssertNotNil(result.coordinates)
        XCTAssertNotNil(result.engineType)
        XCTAssertNotNil(result.exterior)
        XCTAssertNotNil(result.fuel)
        XCTAssertNotNil(result.interior)
        XCTAssertNotNil(result.name)
        XCTAssertNotNil(result.vin)

        XCTAssertEqual(result.address, "Lesserstraße 170, 22049 Hamburg")
        XCTAssertEqual(result.engineType?.rawValue, "CE")
        XCTAssertEqual(result.coordinates, [ 10.07526, 53.59301, 0 ])
        XCTAssertEqual(result.exterior?.rawValue, "UNACCEPTABLE")
        XCTAssertEqual(result.fuel, 42)
        XCTAssertEqual(result.interior?.rawValue, "UNACCEPTABLE")
        XCTAssertEqual(result.name, "HH-GO8522")
        XCTAssertEqual(result.vin, "WME4513341K565439")
    }

}

