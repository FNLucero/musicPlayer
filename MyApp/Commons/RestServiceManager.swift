//
//  RestServiceManager.swift
//  MyApp
//
//  Created by Facundo Lucero on 13/12/2021.
//

import Foundation
import Alamofire

class RestServiceManager {
    let baseURL = "https://my-json-server.typicode.com/oguzman/music_server/"
    
    //let apiKey = "d5ec48ffb10ee60967c2003e84abb7d7638605328e3e2ba9f9810d568fbfab44"
    
    static let shared = RestServiceManager()
    
    func getToServer<T: Decodable>(responseType: T.Type, method: HTTPMethod, endpoint: String, completionHandler: @escaping (_ status: Bool, _ data: T?) -> () ) {
        
        Alamofire.Session.default.session.configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        
        var request = URLRequest(url: URL(string: "\(self.baseURL)\(endpoint)")!)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        //request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        AF.request(request)
            .validate(statusCode: 200..<300)
            .responseData { response in
                switch response.result {
                case .success(let value):
                    do {
                        print(response)
                        print(value)
                        let data = try JSONDecoder().decode(T.self, from: value)
                        completionHandler(true, data)
                    } catch {
                        print(error)
                        completionHandler(false, nil)
                    }
                    
                    break
                case .failure(let error):
                    print(error)
                    completionHandler(false, nil)
                    break
                }
            }
    }
}
