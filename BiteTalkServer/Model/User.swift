//
//  User.swift
//  BiteTalkServer
//
//  Created by 신진욱 on 06/06/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import Foundation

class User: NSObject {
    var code: String?
    var gender: Int?
    var language: [String]?
    var nickname: String?
    var toSay: String?
    
    init(code: String) {
        self.code = code
    }
    
    func settingFromDic(dic: [String: Any]?) {
        print("func settingFromDic...")
        gender = dic?["gender"] as? Int
        if let langArray = dic?["language"] as? [String] {
            language = langArray
        }
        nickname = dic?["nickname"] as? String
        toSay = dic?["toSay"] as? String
    }
}
