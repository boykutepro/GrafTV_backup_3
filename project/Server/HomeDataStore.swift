//
//  HomeDataStore.swift
//  project
//
//  Created by tranthanh on 7/17/20.
//  Copyright © 2020 tranthanh. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class HomeDataStore {
    static var share = HomeDataStore()
    init (){
        
    }
    
    func urlRequest(pathURL: String) -> String {
        let strURL = API.baseURL + pathURL
           return strURL
    }
    
    
    func getListHome(responses : @escaping (_ homeObj : ProductHomeGrafsound?)->() , actionFail: @escaping(_ error : String?)->()){
      
        let urlRequest = self.urlRequest(pathURL: API.homeApiVideo)
        
        let productHome: ProductHomeGrafsound = ProductHomeGrafsound()
        Alamofire.request(urlRequest, method: .post, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON(queue: DispatchQueue.global(), options: .allowFragments) { ( response) in
            switch response.result {
            case .success(let result):
                let result = JSON(result)
                let jsonDataList = result["data"]
                
                // banner
                let array_list_banners = jsonDataList["list_banners"].arrayValue
                let arr_banners  =  array_list_banners.map { (Video(json: $0))}
                productHome.list_banners =  arr_banners
                
                //list_new_releases
                let array_new_releases = jsonDataList["list_new_releases"].arrayValue
                let arrnew_releases =  array_new_releases.map { (Video(json: $0))}
                productHome.list_new =  arrnew_releases
                               
                //list_charts
                let arraylist_charts = jsonDataList["list_charts"].arrayValue
                let arr_charts = arraylist_charts.map{ (Video(json: $0))}
                productHome.list_charts = arr_charts
                
                //list_artists
                let arraylist_artists = jsonDataList["list_artists"].arrayValue
                let arr_artists  =  arraylist_artists.map{ (Video(json: $0))}
                productHome.list_artists = arr_artists
                
               
                let array_list_genres = jsonDataList["list_genres"].arrayValue
                let arrList_genres =  array_list_genres.map{ (Video(json: $0))}
                productHome.list_genres =  arrList_genres
                
            
            case .failure(let error):
                actionFail(error.localizedDescription)
            }
            responses(productHome)
        }
    }
    
    
    
}
