//
//  NetworkData.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 17/3/22.
//

import Foundation
import Alamofire

enum NetworkData {
    case GetMotherships
    case GetOutposts
    case GetCurrentEvents
    case GetSearchedItems
    case GetItemById
    case GetMonsterById
    case GetFixById
    
    var baseURL: String {
      "https://api.chromerivals.net/"
    }
    
    func URL(_ extraUrl: String = "") -> String {
        switch self {
            case .GetMotherships: return baseURL + "info/motherships"
            case .GetOutposts: return baseURL + "info/outposts"
            case .GetCurrentEvents: return baseURL + "info/server/events"
            case .GetSearchedItems: return baseURL + "pedia/search/" + extraUrl
            case .GetItemById: return baseURL + "pedia/item/" + extraUrl
            case .GetMonsterById: return baseURL + "pedia/monster/" + extraUrl
            case .GetFixById: return baseURL + "pedia/item/" + extraUrl
        }
    }
    
    var parameters: [String: String] {
        switch self {
            case .GetMotherships: return [:]
            case .GetOutposts: return [:]
            case .GetCurrentEvents: return [:]
            case .GetSearchedItems: return [:]
            case .GetItemById: return [:]
            case .GetMonsterById: return [:]
            case .GetFixById: return [:]
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case
                .GetMotherships,
                .GetOutposts,
                .GetSearchedItems,
                .GetMonsterById,
                .GetItemById,
                .GetCurrentEvents,
                .GetFixById:
            return .get
        }
    }
    
    var encoding: URLEncoding {
        switch self {
            case
                .GetMotherships,
                .GetOutposts,
                .GetSearchedItems,
                .GetMonsterById,
                .GetItemById,
                .GetCurrentEvents,
                .GetFixById:
            return URLEncoding.default
        }
    }
    
    var headers: HTTPHeaders {
      switch self {
          case
              .GetMotherships,
              .GetOutposts,
              .GetSearchedItems,
              .GetMonsterById,
              .GetItemById,
              .GetCurrentEvents,
              .GetFixById:
          return HTTPHeaders([
            "Accept": "*/*",
            "Cr-Api-Key": "Isma-Player-NY3Cb5JOFQUE"
          ])
      }
    }

}
