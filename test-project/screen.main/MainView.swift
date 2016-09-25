//
// Created by cleveroad on 24.09.16.
// Copyright (c) 2016 Cleveroad. All rights reserved.
//

/// Main view protocol.
protocol MainView: MvpView {

    /// Display list of items.
    func display(items: Array<ITunesModel>)

    /// Start loading animations.
    func startLoading()

    /// Stop loading animation.
    func stopLoading()
}