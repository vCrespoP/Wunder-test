import XCTest
@testable import PlatformPersistenceStatic

import Domain
import RxSwift

class PlatformPersistenceStaticTests: XCTestCase {

    // MARK: Prroperties
    let disposeBag = DisposeBag()

    // MARK: Life Cycle
    override func setUp() {
        super.setUp()

    }

    override func tearDown() {

        super.tearDown()
    }

    func test_Users_Parsing() {

        // GIVEN
        let testExpectation = expectation(description: "Should parse ok")

        // WHEN
        let provider = UseCasePersistenceProvider(responseType: ResponseType.success(code: 200), delay: 0.0)
        provider
            .makeUseCaseLogin()
            .login(user: "user1", password: "pass1")
            .subscribe(
                onNext: { _ in
                    testExpectation.fulfill()
            }, onError: { _ in

            }, onCompleted: {

            }, onDisposed: {

            })
            .disposed(by: self.disposeBag)

        // THEN
        waitForExpectations(timeout: 0.2, handler: nil)

    }

    func test_Customers_Parsing() {

        // GIVEN
        let testExpectation = expectation(description: "Should parse ok")
        let territoryCode = "TestBdTerritory2"

        // WHEN
        let provider = UseCasePersistenceProvider(responseType: ResponseType.success(code: 200), delay: 0.0)
        provider
            .makeUseCaseGetCustomersPersistence()
            .getCustomers(territoryCode: territoryCode)
            .subscribe(
                onNext: { customers in
                    XCTAssertNotNil(customers)
                    XCTAssert(customers.count > 0)
                    testExpectation.fulfill()
            }, onError: { _ in

            }, onCompleted: {

            }, onDisposed: {

            })
            .disposed(by: self.disposeBag)

        // THEN
        waitForExpectations(timeout: 0.2, handler: nil)

    }

    func test_Categories_Parsing() {

        // GIVEN
        let testExpectation = expectation(description: "Should parse ok")

        // WHEN
        let provider = UseCasePersistenceProvider(responseType: ResponseType.success(code: 200), delay: 0.0)
        provider
            .makeUseCaseGetCategoriesPersistence()
            .getCategories()
            .subscribe(
                onNext: { categories in
                    XCTAssertNotNil(categories)
                    XCTAssert(categories.count > 0)
                    testExpectation.fulfill()
            }, onError: { _ in

            }, onCompleted: {

            }, onDisposed: {

            })
            .disposed(by: self.disposeBag)

        // THEN
        waitForExpectations(timeout: 0.2, handler: nil)

    }

    func test_Formats_Parsing() {

        // GIVEN
        let testExpectation = expectation(description: "Should parse ok")

        // WHEN
        let provider = UseCasePersistenceProvider(responseType: ResponseType.success(code: 200), delay: 0.0)
        provider
            .makeUseCaseGetFormatsPersistence()
            .getFormats()
            .subscribe(
                onNext: { formats in
                    XCTAssertNotNil(formats)
                    XCTAssert(formats.count > 0)
                    testExpectation.fulfill()
            }, onError: { _ in

            }, onCompleted: {

            }, onDisposed: {

            })
            .disposed(by: self.disposeBag)

        // THEN
        waitForExpectations(timeout: 0.2, handler: nil)

    }

    func test_Forms_Parsing() {

        // GIVEN
        let testExpectation = expectation(description: "Should parse ok")
        let categoryId = "category4"
        let formatId = "format0"

        // WHEN
        let provider = UseCasePersistenceProvider(responseType: ResponseType.success(code: 200), delay: 0.0)
        provider
            .makeUseCaseLoadFormsPersistence()
            .loadForms(categoryId: categoryId, formatId: formatId)
            .subscribe(
                onNext: { forms in
                    XCTAssertNotNil(forms)
                    XCTAssert(forms.count > 0)
                    testExpectation.fulfill()
            }, onError: { _ in

            }, onCompleted: {

            }, onDisposed: {

            })
            .disposed(by: self.disposeBag)

        // THEN
        waitForExpectations(timeout: 0.2, handler: nil)

    }
}
