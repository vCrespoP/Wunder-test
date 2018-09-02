import XCTest
@testable import PlatformPersistenceDisk

import Domain
import SharedUtils
import RxSwift

class PlatformPersistenceDiskTests: XCTestCase {

    var disposeBag = DisposeBag()

    override func setUp() {
        super.setUp()

    }

    override func tearDown() {

        super.tearDown()
    }

}

extension PlatformPersistenceDiskTests {

    func test_Vehicles_Store_And_Read() {

        // Given
        let jsonName = "vehicles"
        let json = JSONUtils.readDictionary(resourceName: jsonName, bundle: Bundle(for: type(of: self)))
        let data = Vehicle.parseArray(fromDictionary: json!)!

        let context = OperationContext(logger: EmptyLogger())
        let expectation = XCTestExpectation(description: "\(#function)")

        // When
        let opStore = PlatformPersistenceDisk.UseCasePersistenceProvider()
            .makeUseCaseVehiclesStoreAll()
            .store(vehicles: data, context: context)

        let opRead = PlatformPersistenceDisk.UseCasePersistenceProvider()
            .makeUseCaseVehiclesGetAll()
            .readAll(context: context)

        Observable
            .concat([opStore, opRead])
            .subscribe(onNext: { vehicles in
                // Then
                XCTAssert(vehicles.count == data.count)
            }, onError: { error in
                // Then
                XCTFail()
            }, onCompleted: {

            }, onDisposed: {
                expectation.fulfill()
            })
            .disposed(by: self.disposeBag)

        // Then
        wait(for: [expectation], timeout: 2.0)
    }

    func test_Vehicles_Store_And_Read_Inexisting() {
        // Given
        let jsonName = "vehicles"
        let json = JSONUtils.readDictionary(resourceName: jsonName, bundle: Bundle(for: type(of: self)))
        let data = Vehicle.parseArray(fromDictionary: json!)!

        let context = OperationContext(logger: EmptyLogger())
        let expectation = XCTestExpectation(description: "\(#function)")

        // When
        let opStore = PlatformPersistenceDisk.UseCasePersistenceProvider()
            .makeUseCaseVehiclesStoreAll()
            .store(vehicles: data, context: context)

        let opRead = PlatformPersistenceDisk.UseCasePersistenceProvider()
            .makeUseCaseVehiclesGetAll()
            .readAll(context: context)

        Observable
            .concat([opStore, opRead])
            .subscribe(onNext: { vehicles in
                // Then
                XCTAssert(vehicles.count == data.count)
            }, onError: { error in
                // Then
                XCTFail()
            }, onCompleted: {

            }, onDisposed: {
                expectation.fulfill()
            })
            .disposed(by: self.disposeBag)

        // Then
        wait(for: [expectation], timeout: 2.0)
    }

}
