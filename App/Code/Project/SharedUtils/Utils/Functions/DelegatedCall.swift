import Foundation

// Callbacks with autoweak self: https://medium.com/anysuggestion/preventing-memory-leaks-with-swift-compile-time-safety-49b845df4dc6
public struct DelegatedCall<Input> {

    private(set) var callback: ((Input) -> Void)?

    mutating func delegate<Object: AnyObject>(to object: Object, with callback: @escaping (Object, Input) -> Void) {
        self.callback = { [weak object] input in
            guard let object = object else {
                return
            }
            callback(object, input)
        }
    }
}
