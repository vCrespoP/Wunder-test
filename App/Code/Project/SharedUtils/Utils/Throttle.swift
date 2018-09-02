import Foundation

public class Throttle {

    public var interval: TimeInterval

    fileprivate var action: (() -> ())?
    fileprivate var lastRun: Date?

    fileprivate var queued = false

    public init(interval: TimeInterval) {
        self.interval = interval
    }

}

// MARK: Public Methods
public extension Throttle {

    func run(_ action:@escaping () -> ()) {
        self.action = action

        guard self.shouldRun() else {
            if !queued {
                queued = true
                DispatchQueue.main.asyncAfter(deadline: .now() + self.interval) {
                    self.update()
                }
            }

            return
        }

        self.update()
    }

}

// MARK: Private Methods
fileprivate extension Throttle {

    func shouldRun() -> Bool {
        guard let lastRun = self.lastRun else { return true }

        return abs(lastRun.timeIntervalSinceNow) > self.interval
    }

    func update() {
        self.action?()
        self.lastRun = Date()
        self.action = nil
        self.queued = false
    }
}
