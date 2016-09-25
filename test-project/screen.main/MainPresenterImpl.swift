//
// Created by cleveroad on 24.09.16.
// Copyright (c) 2016 Cleveroad. All rights reserved.
//

import RxSwift

/// Implementation of MainPresenter
class MainPresenterImpl: BaseMvpPresenter<MainView>, MainPresenter {

    private var mDisposable: Disposable?

    func searchFor(query: String) {
        if (query.isEmpty) {
            // display nothing
            getView()!.display(items: [])
            return
        }
        getView()!.startLoading()
        mDisposable?.dispose()
        mDisposable = RestManager.sharedInstance
            .searchFor(query: query)
            .subscribeOn(MainScheduler.asyncInstance)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { models in
                    self.getView()!.display(items: models)
                }, onError: { error in
                    // todo: getView().showError(error)
                    print(error)
                }, onCompleted: {
                    self.getView()!.stopLoading()
                }, onDisposed: nil);
    }

}
