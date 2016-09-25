//
// Created by cleveroad on 24.09.16.
// Copyright (c) 2016 Cleveroad. All rights reserved.
//

import ObjectMapper

struct ITunesResponse: Mappable {

    var mItems: Array<ITunesModel>?

    init?(map: Map) {
        mapping(map: map)
    }

    mutating func mapping(map: Map) {
        mItems <- map[Contracts.ITunesResponse.kResults]
    }
}
