//
// Created by cleveroad on 24.09.16.
// Copyright (c) 2016 Cleveroad. All rights reserved.
//

protocol MvpPresenter {
    associatedtype View

    func getView() -> View?

    func setView(view: View?)
}
