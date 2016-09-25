//
// Created by cleveroad on 24.09.16.
// Copyright (c) 2016 Cleveroad. All rights reserved.
//

import Foundation
import ObjectMapper

struct ITunesModel: Mappable {

    var mName: String?
    var mArtworkUrl60: String?
    var mArtworkUrl100: String?
    var mArtworkUrl512: String?
    var mFormattedPrice: String?
    var mScreenshotUrls: Array<String>?
    var mFileSize: UInt32?
    var mVersion: String?
    var mDescription: String?
    var mReleaseDate: NSDate?
    var mAverageUserRating: Float?

    init(map: Map) {
        mapping(map: map)
    }

    mutating func mapping(map: Map) {
        mName <- map[Contracts.ITunes.kTrackName]
        mArtworkUrl60 <- map[Contracts.ITunes.kArtworkUrl60]
        mArtworkUrl100 <- map[Contracts.ITunes.kArtworkUrl100]
        mArtworkUrl512 <- map[Contracts.ITunes.kArtworkUrl512]
        mFormattedPrice <- map[Contracts.ITunes.kFormattedPrice]
        mScreenshotUrls <- map[Contracts.ITunes.kScreenshotUrls]
        mFileSize <- map[Contracts.ITunes.kFileSizeBytes]
        mVersion <- map[Contracts.ITunes.kVersion]
        mDescription <- map[Contracts.ITunes.kDescription]
        mReleaseDate <- map[Contracts.ITunes.kCurVersionReleaseDate]
        mAverageUserRating <- map[Contracts.ITunes.kAverageUserRating]
    }
}