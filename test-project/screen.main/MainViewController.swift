//
//  MainController.swift
//  test-project
//
//  Created by cleveroad on 24.09.16.
//  Copyright (c) 2016 Cleveroad. All rights reserved.
//


import UIKit
import RxCocoa
import RxSwift
import AlamofireImage

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UINavigationBarDelegate, UISearchBarDelegate,
        MainView {

    @IBOutlet weak var mTableView: UITableView!

    @IBOutlet weak var mProgressBar: UIActivityIndicatorView!
    @IBOutlet weak var mNavigationBar: UINavigationBar!
    @IBOutlet weak var mSearchBar: UISearchBar!

    private var mPresenter: MainPresenterImpl! = MainPresenterImpl()
    private var mData: Array<ITunesModel>?
    private let mDisposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        mProgressBar.center = mTableView.center
        mPresenter.setView(view: self)
        stopLoading()
        mSearchBar.rx.text
            .debounce(0.5, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(
                onNext: { query in self.mPresenter.searchFor(query: query)},
                onError: { error in print(error)},
                onCompleted: nil,
                onDisposed: nil
            )
            .addDisposableTo(mDisposeBag)
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mData?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.kReuseCell, for: indexPath)
        let row = mData![indexPath.row] as ITunesModel
        let urlString = row.mArtworkUrl100;
        let url = URL(string: urlString!)
        cell.textLabel!.text = row.mName
        cell.imageView!.af_setImage(withURL: url!, placeholderImage: nil,
                filter: nil,
                imageTransition: .crossDissolve(0.5),
                completion: { response in
                    if (response.result.error == nil) {
                        cell.setNeedsLayout()
                    }
                })
        cell.detailTextLabel!.text = row.mFormattedPrice
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: Constants.Segues.kItemDetails, sender: self)
    }


    func display(items: Array<ITunesModel>) {
        mData = items;
        mTableView.reloadData()
    }

    func startLoading() {
        mProgressBar.isHidden = false
        mTableView.isHidden = true
        mProgressBar.startAnimating()
    }

    func stopLoading() {
        mProgressBar.stopAnimating()
        mProgressBar.isHidden = true
        mTableView.isHidden = false
    }

    override func prepare(`for` segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == Constants.Segues.kItemDetails) {
            let viewController = segue.destination as! ItemDetailsViewController
            let selectedRow = mTableView.indexPathForSelectedRow!
            let row = selectedRow.row
            viewController.mItem = mData![row]
            mTableView.deselectRow(at: selectedRow, animated: true)
        }
    }


}
