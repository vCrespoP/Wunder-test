import Foundation

public func delay(_ time: TimeInterval, closure: @escaping () -> ()) {
    let delayTime = DispatchTime.now() + Double(Int64(time * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC)
    DispatchQueue.main.asyncAfter(deadline: delayTime, execute: closure)
}
