public enum TestUtils {

    public static var isTest: Bool {
        return NSClassFromString("XCTest") != nil
    }

}
