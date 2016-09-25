//
// Created by cleveroad on 25.09.16.
// Copyright (c) 2016 Cleveroad. All rights reserved.
//

import RxSwift
import Alamofire
import ObjectMapper

protocol RestClient {

    func searchFor(query: String) -> Observable<Array<ITunesModel>>
}

private class RestClientImpl: RestClient {

    func searchFor(query: String) -> Observable<Array<ITunesModel>> {
        if (query.isEmpty) {
            return Observable.from([[ITunesModel]]())
        }
        var encodedQuery = query.replacingOccurrences(of: " ", with: "+", options: .caseInsensitive, range: nil);
        encodedQuery = encodedQuery.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let urlPath = "https://itunes.apple.com/search?term=\(encodedQuery)&media=software";
        return Observable.create { (observer: AnyObserver<Array<ITunesModel>>) in
            var dataRequest: DataRequest?
            let cancel = Disposables.create {
                dataRequest?.cancel()
            }
            dataRequest = Alamofire.request(urlPath).responseJSON {
                response in
                switch response.result {
                case .success:
                    let json = response.result.value;
                    let resp = Mapper<ITunesResponse>().map(JSONObject: json)
                    observer.onNext(resp!.mItems!)
                    observer.onCompleted()
                    break
                case .failure(let error):
                    observer.onError(error)
                    break
                }
            }
            return cancel
        }
    }

}

class RestManager {

    class var sharedInstance: RestClient {
        struct Static {
            static let instance = RestClientImpl()
        }
        return Static.instance
    }
}