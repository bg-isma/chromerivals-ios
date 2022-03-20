//
//  ChromerivalsService.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 14/3/22.
//

import Foundation
import Alamofire

class CRPediaService: CRNetwork {
    
    typealias CompletionHandlerArray = (_ response: [PediaElement]) -> Void
    typealias CompletionHandlerObject = (_ response: PediaElement) -> Void
    typealias CompletionHandlerImage = (_ response: UIImage) -> Void
    
    func getSearchedItems(query: String, _ completionHandler: @escaping CompletionHandlerArray) -> Void {
        requestWithNetworkData(NetworkData.GetSearchedItems, query).responseDecodable(of: SearchResponse.self)
        { response in
           switch response.result {
               case .success(_): do {
                   if let responseResult = response.value?.result {
                       let items = responseResult.items ?? []
                       let monsters = responseResult.items ?? []
                       let fixes = responseResult.items ?? []
                       completionHandler(items + monsters + fixes)
                   }
               }
               case let .failure(error): do {
                   print("ERROR: \(error)")
                   completionHandler([])
               }
           }
       }
    }
    
    func getItemById(id: String, _ completionHandler: @escaping CompletionHandlerObject) -> Void {
        requestWithNetworkData(NetworkData.GetItemById, id).response
        { response in
           switch response.result {
               case .success(_): do {
                   if let responseResult = response.data {
                       let result = try! JSONDecoder().decode(ItemResponse.self, from: responseResult)
                       completionHandler(result.result ?? Item())
                   }
               }
               case let .failure(error): do {
                   print("ERROR: \(error)")
                   completionHandler(Item())
               }
           }
        }
    }
    
    func getMonsterById(id: String, _ completionHandler: @escaping CompletionHandlerObject) -> Void {
        requestWithNetworkData(NetworkData.GetMonsterById, id).response
        { response in
           switch response.result {
               case .success(_): do {
                   if let responseResult = response.data {
                       let result = try! JSONDecoder().decode(Monster.self, from: responseResult)
                       completionHandler(result)
                   }
               }
               case let .failure(error): do {
                   print("ERROR: \(error)")
                   completionHandler(Item())
               }
           }
        }
    }
    
    func getFixById(id: String, _ completionHandler: @escaping CompletionHandlerObject) -> Void {
        requestWithNetworkData(NetworkData.GetFixById, id).response
        { response in
           switch response.result {
               case .success(_): do {
                   if let responseResult = response.data {
                       let result = try! JSONDecoder().decode(Fix.self, from: responseResult)
                       completionHandler(result)
                   }
               }
               case let .failure(error): do {
                   print("ERROR: \(error)")
                   completionHandler(Item())
               }
           }
        }
    }
    
    func getElementImage(iconId: String, _ completionHandler: @escaping CompletionHandlerImage) {
        AF.request("https://download.chromerivals.net/resources/items_images/big/\(iconId).png").responseImage { response in
            if case .success(_) = response.result {
                completionHandler(UIImage(data: response.data!)!)
            } else {
                AF.request("https://chromerivals.net/assets/images/icons/item_x.png").responseImage { response in
                    if case .success(_) = response.result {
                        completionHandler(UIImage(data: response.data!)!)
                    }
                }
            }
        }
    }
    
}


struct ItemResponse: Codable {
    var result: Item? = nil
}
struct MonsterResponse: Codable {
    var result: Monster? = nil
}
struct FixResponse: Codable {
    var result: Fix? = nil
}
