//
//  Constants.swift
//  Chromerivals
//
//  Created by Ismael Bolaños García on 27/3/22.
//

import Foundation

struct Constants {
    
    static let serverTimeZone = TimeZone(identifier: "Europe/Paris") ?? TimeZone.current
    static let serverDateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    static let currentTimeZone = TimeZone.current
    static let imageErrorURL = "https://chromerivals.net/assets/images/icons/item_x.png"
    static let pediaImageURL = "https://download.chromerivals.net/resources/items_images/big/"
    static let calendar = Calendar(identifier: .gregorian)
    
    static let dateFormaterToServerTimeZoneWithoutTimeZoneString: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        dateFormatter.timeZone = Constants.serverTimeZone
        return dateFormatter
    }()
    
    static let dateFormaterToLocalTimeZone: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.serverDateFormat
        dateFormatter.timeZone = Constants.currentTimeZone
        return dateFormatter
    }()
    
    static let dateFormaterToServerTimeZoneWithTimeZoneString: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.serverDateFormat
        dateFormatter.timeZone = Constants.serverTimeZone
        return dateFormatter
    }()
    
}
