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
                       let monsters = responseResult.monsters ?? []
                       let fixes = responseResult.fixes ?? []
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
                       let result = try! JSONDecoder().decode(PediaResponse.self, from: responseResult)
                       completionHandler(result.result ?? PediaElement())
                   }
               }
               case let .failure(error): do {
                   print("ERROR: \(error)")
                   completionHandler(PediaElement())
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
                       let result = try! JSONDecoder().decode(PediaResponse.self, from: responseResult)
                       completionHandler(result.result ?? PediaElement())
                   }
               }
               case let .failure(error): do {
                   print("ERROR: \(error)")
                   completionHandler(PediaElement())
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
                       let result = try! JSONDecoder().decode(PediaResponse.self, from: responseResult)
                       completionHandler(result.result ?? PediaElement())
                   }
               }
               case let .failure(error): do {
                   print("ERROR: \(error)")
                   completionHandler(PediaElement())
               }
           }
        }
    }
    
    func getElementImage(iconId: String, _ completionHandler: @escaping CompletionHandlerImage) {
        AF.request("\(Constants.pediaImageURL)\(iconId).png").responseImage { response in
            if case .success(_) = response.result {
                completionHandler(UIImage(data: response.data!)!)
            } else {
                AF.request(Constants.imageErrorURL).responseImage { response in
                    if case .success(_) = response.result {
                        completionHandler(UIImage(data: response.data!)!)
                    }
                }
            }
        }
    }
    
}
