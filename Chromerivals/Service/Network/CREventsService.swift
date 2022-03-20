//
//  CREventsService.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 17/3/22.
//

import Foundation
import Alamofire

class CREventsService: CRNetwork {
    
    typealias CompletionHandler = (_ response: [Event]) -> Void
    
    func getMotherships(_ completionHandler: @escaping CompletionHandler) -> Void {
        requestWithNetworkData(NetworkData.GetMotherships).responseDecodable(of: MothershipsResponse.self)
        { response in
           switch response.result {
               case .success(_): do {
                   if let responseResult = response.value?.result {
                       completionHandler([
                        UpcomingEvent(ani: responseResult.bcu),
                        UpcomingEvent(bcu: responseResult.bcu)
                       ])
                   }
               }
               case let .failure(error): do {
                   print("ERROR: \(error)")
                   completionHandler([])
               }
           }
       }
    }

    func getOutposts(_ completionHandler: @escaping CompletionHandler) -> Void {
        requestWithNetworkData(NetworkData.GetOutposts).responseDecodable(of: OutpostsResponse.self)
        { response in
           switch response.result {
               case .success(_): do {
                   if let responseResult = response.value?.result {
                       completionHandler(responseResult)
                   }
               }
               case let .failure(error): do {
                   print("ERROR: \(error)")
                   completionHandler([])
               }
           }
       }
    }

    func getCurrentEvents(_ completionHandler: @escaping CompletionHandler) -> Void {
        requestWithNetworkData(NetworkData.GetCurrentEvents).responseDecodable(of: CurrentEventsResponse.self) { response in
            switch response.result {
                case .success(_): do {
                    completionHandler(response.value?.result ?? [])
                }
                case let .failure(error): do {
                    print("ERROR: \(error)")
                    completionHandler([])
                }
            }
        }
    }
    
}
