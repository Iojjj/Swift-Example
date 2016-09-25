//
// Created by cleveroad on 24.09.16.
// Copyright (c) 2016 Cleveroad. All rights reserved.
//

import Foundation

/// iTunes presenter protocol that allows to fetch data from iTunes
protocol MainPresenter: MvpPresenter {

    /// Search in iTunes with provided query.
    func searchFor(query: String)
}