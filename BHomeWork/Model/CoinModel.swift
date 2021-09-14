//
//  CoinModel.swift
//  BHomeWork
//
//  Created by Oh june Kwon on 2021/09/14.
//

import Foundation

struct CoinModel: Codable {
    
    let coinName: String
    let coinShare: Float
    let coinColor: String
    
    enum CodingKeys: String, CodingKey {
        case coinName = "COIN_NAME"
        case coinShare = "COIN_SHARE"
        case coinColor = "COIN_COLOR"
    }
    
}
