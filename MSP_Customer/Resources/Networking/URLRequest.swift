//
//  URLRequest.swift
//  TestApp
//
//  Created by Arokia IT on 8/6/20.
//  Copyright © 2020 Arokiait Pvt Ltd. All rights reserved.
//

import UIKit

extension URLRequest {
    init(baseUrl: String, path: String, method: RequestMethod, params: JSON) {
        
        let token = UserDefaults.standard.string(forKey: "TOKEN") ?? ""
        
        
        //URL part
        let url = URL(baseUrl: baseUrl, path: path, params: params, method: method)
        self.init(url: url)
        httpMethod = method.rawValue
        print(httpMethod!)
        setValue("application/json", forHTTPHeaderField: "Accept")
        setValue("application/json", forHTTPHeaderField: "Content-Type")
        setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        switch method {
        case .post, .put:
            httpBody = try! JSONSerialization.data(withJSONObject: params, options: [])
            break
        default:
            print(method)
            break
        }
    }
}
