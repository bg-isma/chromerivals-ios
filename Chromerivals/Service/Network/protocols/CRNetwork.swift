//
//  CRNetwork.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 17/3/22.
//

import Foundation
import Alamofire

protocol CRNetwork {
    func requestWithNetworkData(_ networkData: NetworkData, _ extraUrl: String) -> DataRequest
}

extension CRNetwork {
    
    func requestWithNetworkData(_ networkData: NetworkData, _ extraUrl: String = "") -> DataRequest {
        return AF.request(
            networkData.URL(extraUrl),
            method: networkData.method,
            parameters: networkData.parameters,
            encoding: networkData.encoding,
            headers: networkData.headers
        )
    }
    
}
