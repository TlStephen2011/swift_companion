//
//  UserViewController.swift
//  swifty_companion
//
//  Created by Tyrone Stephen on 2019/10/24.
//  Copyright © 2019 Tyrone Stephen. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    var userToGet: String?
    var api: APIController?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let spinner = SpinnerViewController()
        
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
        
        api!.getUserByLogin(login: userToGet!, completion: { json in
            print(json)
            DispatchQueue.main.async {
                spinner.willMove(toParent: nil)
                spinner.view.removeFromSuperview()
                spinner.removeFromParent()
            }
        })
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
