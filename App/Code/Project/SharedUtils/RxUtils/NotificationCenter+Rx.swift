import Foundation
import UserNotifications

import RxSwift

public extension NotificationCenter {

    typealias RxNotificationHandler = (_ notification: Notification) -> Void
    static func rxSubscribe(name: Notification.Name, operation: @escaping RxNotificationHandler = { _ in }) -> Disposable {
        let observable = NotificationCenter
            .default
            .rx
            .notification(name)
            .subscribe(onNext: { notification in
                operation(notification)
            })
        return observable
    }

    static func post(name: Notification.Name, info: [String: Any]? = nil) {
        let notification = Notification(
            name: name,
            object: self,
            userInfo: info)
        NotificationCenter.default.post(notification)
    }

}
