//
//  CREventsService.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 17/3/22.
//

import Foundation
import Alamofire

class CREventsService: CRNetwork {
    
    // typealias CompletionHandler = (_ response: [Event]) -> Void
    
    func getMotherships() async throws -> [Event] {
        return try await withCheckedThrowingContinuation({ continuation in
            requestWithNetworkData(NetworkData.GetMotherships).responseDecodable(of: MothershipsResponse.self)
            { response in
               switch response.result {
                   case .success(_): do {
                       if let responseResult = response.value?.result {
                           continuation.resume(returning: [
                            Event(ani: responseResult.bcu),
                            Event(bcu: responseResult.bcu)
                           ])
                       }
                   }
                   case let .failure(error): do {
                       print("ERROR: \(error)")
                       continuation.resume(returning: [])
                   }
               }
           }
        })
    }

    func getOutposts() async throws -> [Event] {
        return try await withCheckedThrowingContinuation({ continuation in
            requestWithNetworkData(NetworkData.GetOutposts).responseDecodable(of: EventResponse.self)
            { response in
               switch response.result {
                   case .success(_): do {
                       if let responseResult = response.value?.result {
                           continuation.resume(returning: responseResult)
                       }
                   }
                   case let .failure(error): do {
                       print("ERROR: \(error)")
                       continuation.resume(returning: [])
                   }
               }
           }
        })
    }

    func getCurrentEvents() async throws -> [Event] {
        return try await withCheckedThrowingContinuation({ continuation in
            requestWithNetworkData(NetworkData.GetCurrentEvents).responseDecodable(of: EventResponse.self) { response in
                switch response.result {
                    case .success(_): do {
                        continuation.resume(returning: response.value?.result ?? [])
                    }
                    case let .failure(error): do {
                        print("ERROR: \(error)")
                        continuation.resume(returning: [])
                    }
                }
            }
        })
    }
    
}
