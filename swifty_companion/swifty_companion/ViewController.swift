//
//  ViewController.swift
//  swifty_companion
//
//  Created by Tyrone STEPHEN on 2019/10/24.
//  Copyright © 2019 Tyrone Stephen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private var api: APIController?
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleSearchButton()
        
        let spinner = SpinnerViewController()
        
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
        
        APIController.getToken(completion: { response in
            guard let token = response["access_token"] as? String else {
                print("Unable to get 42API token.")
                //Present alert and quit app
                return
            }
            self.api = APIController(token: token)
            DispatchQueue.main.async {
                spinner.willMove(toParent: nil)
                spinner.view.removeFromSuperview()
                spinner.removeFromParent()
            }
        })
    }

    func styleSearchButton() {
        searchButton.clipsToBounds = true
        searchButton.backgroundColor = UIColor(red:0.12, green:0.73, blue:0.73, alpha:1.0)
    }
}

