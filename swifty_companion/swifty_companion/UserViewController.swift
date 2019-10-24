//
//  UserViewController.swift
//  swifty_companion
//
//  Created by Tyrone Stephen on 2019/10/24.
//  Copyright © 2019 Tyrone Stephen. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class UserViewController: UIViewController {

    var userToGet: String?
    var api: APIController?
    
    //MARK: main info properties
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var userLogin: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var levelProgressView: UIProgressView!
    @IBOutlet weak var levelAmountLabel: UILabel!
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let spinner = SpinnerViewController()
        
        addChild(spinner)
        spinner.view.frame = view.frame
        view.addSubview(spinner.view)
        spinner.didMove(toParent: self)
        
        api!.getUserByLogin(login: userToGet!, completion: { json in
            let u = User()
            u.login = json["login"].string
            u.email = json["email"].string
            u.profileImageUrl = json["image_url"].string
            let a = json["cursus_users"].array
            if let primaryCursus = a?.first {
                    u.level = primaryCursus["level"].double
            }
            if (u.profileImageUrl != nil) {
                Alamofire.request(u.profileImageUrl!).responseImage(completionHandler: { response in
                    
                    if let image = response.result.value {
                        DispatchQueue.main.async {
                            self.profileImage.image = image
                            self.profileImage.layer.cornerRadius = self.profileImage.frame.size.height / 2
                        }
                    }
            
                    DispatchQueue.main.async {
                        self.userLogin.text = u.login
                        self.emailLabel.text = u.email
                        self.levelAmountLabel.text = u.level?.truncatingRemainder(dividingBy: 100).description
                        self.levelProgressView.progress = Float(u.level! / 21)
                        spinner.willMove(toParent: nil)
                        spinner.view.removeFromSuperview()
                        spinner.removeFromParent()
                    }
                    
                })
            } else {
                print("no picture in url")
                DispatchQueue.main.async {
                    self.userLogin.text = u.login
                    self.emailLabel.text = u.email
                    self.levelAmountLabel.text = u.level?.truncatingRemainder(dividingBy: 100).description
                    self.levelProgressView.progress = Float(u.level! / 21)
                    
                    spinner.willMove(toParent: nil)
                    spinner.view.removeFromSuperview()
                    spinner.removeFromParent()
                }
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
