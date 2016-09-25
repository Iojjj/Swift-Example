//
//  ItemDetailsViewController.swift
//  test-project
//
//  Created by cleveroad on 25.09.16.
//  Copyright © 2016 Cleveroad. All rights reserved.
//

import UIKit
import AlamofireImage.Swift

class ItemDetailsViewController: UIViewController {

    @IBOutlet weak var mTitle: UINavigationItem!
    @IBOutlet weak var mImage: UIImageView!

    var mItem: ITunesModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.

        title = mItem.mName
        let url = URL(string: mItem.mArtworkUrl512!)
        mImage.af_setImage(withURL: url!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
