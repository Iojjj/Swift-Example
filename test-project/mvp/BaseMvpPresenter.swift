//
// Created by cleveroad on 24.09.16.
// Copyright (c) 2016 Cleveroad. All rights reserved.
//

class BaseMvpPresenter<T>: MvpPresenter {
    typealias View = T

    private var mView: T?

    func getView() -> T? {
        return mView
    }

    func setView(view: T?) {
        mView = view
    }

}