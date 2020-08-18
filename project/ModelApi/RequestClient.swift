//
//  RequestClient.swift
//
//

import Foundation
import Alamofire
import SwiftyJSON

struct RequestClient {
    
    //MARK: - Shared instance
    static let shared = RequestClient()
    
    //MARK: - Build URL for each API
    func urlRequest(pathURL: String) -> URL {
        let strURL = API.baseURL + pathURL
        return URL(string: strURL)!
    }
    
    
    func urlRequestSong(pathURL: String) -> URL {
           let strURL = APISong.baseURL + pathURL
           return URL(string: strURL)!
       }
    
    
    
    func sendPostRequestSong(parameters: [String: AnyObject]?, pathURL: String, completion: @escaping (_ error: FFError, _ json: JSON) -> Void) {
           let urlRequest = self.urlRequestSong(pathURL: pathURL)
           //Alamofire.request
           Alamofire.request(urlRequest,
                             method: .post,
                             parameters: parameters,
                             encoding: URLEncoding.default,
                             headers: nil)
               .responseJSON { (response) in
                   print("Respone Description:\n\(response.description)")
                   guard response.result.isSuccess else {
                       // Return error from server
                       completion(.server, JSON.null)
                       return
                   }
                   
                   guard let value = response.result.value else {
                       // Return error from parse
                       completion(.parse, JSON.null)
                       return
                   }
                   // Return value from respone api
                   completion(.none, JSON(value))
           }
       }
    
    //MARK: - Post Request
    func sendPostRequest(parameters: [String: AnyObject]?, pathURL: String, completion: @escaping (_ error: FFError, _ json: JSON) -> Void) {
        let urlRequest = self.urlRequest(pathURL: pathURL)
        print("url: \(urlRequest)")
        //Alamofire.request
        Alamofire.request(urlRequest,
                          method: .post,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: nil)
            .responseJSON { (response) in
                print("Respone Description:\n\(response.description)")
                guard response.result.isSuccess else {
                    // Return error from server
                    completion(.server, JSON.null)
                    return
                }
                
                guard let value = response.result.value else {
                    // Return error from parse
                    completion(.parse, JSON.null)
                    return
                }
                // Return value from respone api
                completion(.none, JSON(value))
        }
    }
    
    //MARK: -Get Request
    func sendGetRequest(parameters: [String: AnyObject]?, pathURL: String, completion: @escaping (_ error: FFError, _ json: JSON) -> Void) {
        let urlRequest = self.urlRequest(pathURL: pathURL)
        print("url: \(urlRequest)")
        //Alamofire.request
        Alamofire.request(urlRequest,
                          method: .get,
                          parameters: parameters,
                          encoding: URLEncoding.default,
                          headers: nil)
            .responseJSON { (response) in
                print("Respone Description:\n\(response.description)")
                guard response.result.isSuccess else {
                    // Return error from server
                    completion(.server, JSON.null)
                    return
                }
                
                guard let value = response.result.value else {
                    // Return error from parse
                    completion(.parse, JSON.null)
                    return
                }
                // Return value from respone api
                completion(.none, JSON(value))
        }
    }
    
    
    //MARK: - Request
    func sendRequest(parameters: [String: AnyObject]?, pathURL: String, completion: @escaping (_ error: FFError, _ json: JSON) -> Void) {
        let urlRequest = self.urlRequest(pathURL: pathURL)
        print("url: \(urlRequest)")
        //Alamofire.request
        Alamofire.request(urlRequest,
                          parameters: parameters)
            .responseJSON { (response) in
                print("Respone Description:\n\(response.description)")
                guard response.result.isSuccess else {
                    // Return error from server
                    completion(.server, JSON.null)
                    return
                }
                
                guard let value = response.result.value else {
                    // Return error from parse
                    completion(.parse, JSON.null)
                    return
                }
                // Return value from respone api
                completion(.none, JSON(value))
        }
    }
}

