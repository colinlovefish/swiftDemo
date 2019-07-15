//
//  DMModel.swift
//  swiftDemo
//
//  Created by yinghu on 2019/7/15.
//  Copyright © 2019 yinghu. All rights reserved.
//

import Foundation

struct DMModel: Codable {
    var code: TStrInt
    var data: DMData
    
    struct DMData: Codable {
        var stateCode: TStrInt
        var message: String
        var returnData: DMReturnData?
    }
    
    struct DMReturnData: Codable {
        var rankinglist: [DMRankingList]?
    }
    
    struct DMRankingList: Codable {
        var title: String
        var subTitle: String
        var cover: String
        var argName: String
        var argValue: TStrInt
        var rankingType: String
    }
}
