//
//  APIController.swift
//  swifty_companion
//
//  Created by Tyrone STEPHEN on 2019/10/24.
//  Copyright © 2019 Tyrone Stephen. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class APIController {
    static let clientId: String = "df2ab97330f35bce3c5cc94e582647f1823bf35fef0ebbb8bdccf074e4c818b9"
    static let secret: String = "03c00ce9c5a09a4a5d13bb69e95847fade14687782d5e7da7b01aafbe90f0bb0"
    let token: String?
        
    init(token: String) {
        self.token = token
    }
    
    static func getToken(completion: @escaping (_ response: NSDictionary) -> Void) {
        let url: String = "https://api.intra.42.fr/oauth/token"
        let params: Parameters = [
            "grant_type": "client_credentials",
            "client_id": APIController.clientId,
            "client_secret": APIController.secret
        ]
        let headers: HTTPHeaders = [
            "Content-Type": "application/json"
        ]
        
        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON(completionHandler: { (response) in
            if let result = response.result.value {
                let json = result as! NSDictionary
                completion(json)
            }
        })
    }
    
    func getUserByLogin(login l: String, completion: @escaping (_ response: JSON) -> Void) {
        let url: String = "https://api.intra.42.fr/v2/users/\(l)"
//        let params: Parameters = [
//            "filter[first_name]": "\(l)"
//        ]
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(token!)"
        ]
        
        Alamofire.request(url, method: .get, encoding: URLEncoding(destination: .queryString), headers: headers).responseJSON(completionHandler: { response in
            let json = JSON(response.result.value)
            completion(json)            
        })
        
    }
    
}
