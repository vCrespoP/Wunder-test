import Foundation
import UIKit

import RxSwift

import SharedUtils

public class BasePresenter {

    // MARK: - Properties
    var disposeBag = DisposeBag()

    // MARK: - Life Cycle
    public init(view: UIViewController) {
        self.handleLifeCycle(view: view)
    }

    public func handleLifeCycle(view: UIViewController) {

        // Did Load
        view
            .rx
            .viewDidLoad.subscribe(onNext: { [weak self] in
                self?.viewDidLoad()
            })
            .disposed(by: self.disposeBag)

        view
            .rx
            .viewWillAppear
            .subscribe(onNext: { [weak self] animated in
                self?.viewWillAppear(animated: animated)
            })
            .disposed(by: self.disposeBag)

        view
            .rx
            .viewDidAppear
            .subscribe(onNext: { [weak self] animated in
                self?.viewDidAppear(animated: animated)
            })
            .disposed(by: self.disposeBag)

        view
            .rx
            .viewWillDisappear
            .subscribe(onNext: { [weak self] animated in
                self?.viewWillDisappear(animated: animated)
            })
            .disposed(by: self.disposeBag)

        view
            .rx
            .viewDidDisappear
            .subscribe(onNext: { [weak self] animated in
                self?.viewDidDisappear(animated: animated)
            })
            .disposed(by: self.disposeBag)
    }

    public func viewDidLoad() {
        Log.debug("\(#file): \(#function)")
    }

    public func viewWillAppear(animated: Bool) {
        Log.debug("\(#file): \(#function)")
    }

    public func viewDidAppear(animated: Bool) {
        Log.debug("\(#file): \(#function)")
    }

    public func viewWillDisappear(animated: Bool) {
        Log.debug("\(#file): \(#function)")
    }

    public func viewDidDisappear(animated: Bool) {
        Log.debug("\(#file): \(#function)")
    }

}

