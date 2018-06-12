//
//  MainViewController.swift
//  BiteTalkServer
//
//  Created by 신진욱 on 01/06/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController {
    
    var languages = ["English", "한국어 (Korean)", "中文 (Chinese)", "日本語 (Japanese)", "Español (Spanish)", "Français (French)", "Deutsche (German)",
                     "Pусский (Russian)", "Português (Portuguese)", "Italiano (Italian)", "Türkçe (Turkish)", "Nederlands (Dutch)", "العربية (Arabic)",
                     "ภาษาไทย (Thai)", "Svenska (Swedish)", "Dansk (Danish)", "Tiếng Việt (Vietnamese)", "Norsk (Norwegin)", "Polski (Polish)",
                     "Suomi (finnish)", "Bahasa Indonesia (Indonesian)", "עִברִית (Hebrew)", "Ελληνικά (Greek)", "Română (Romanian)", "Magyar (Hungarian)", "čeština (Czech)", "Català (Caralan)", "Slovenčina (Slovak)", "Українська (Ukrainian)", "Hrvatski (Croatian)", "Hahasa Melayu (Malay)", "हिंदी (Hindi)"]
    
    var allUsers = [User]() {
        didSet {
            if let user = allUsers.last {
                addUserByLanguage(user: user)
            } else {
                print("-------------------------allUsers error----------------------------")
            }
        }
    }
    
    lazy var langUsers : [String: [String]] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addKeysToUsers()
    }
    
    func addKeysToUsers() {
        print("func addKeysToUsers")
        for lang in languages {
            langUsers[lang] = [""]
        }
        print(langUsers.keys)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        addUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addUsers() {
        print("func addUsers...")
        let ref = Database.database().reference().child("users").child("after_init")
        ref.observe(.childAdded) { (snap) in
            let code = snap.key
            let dic = snap.value as? [String: Any]
            let user = User(code: code)
            user.settingFromDic(dic: dic)
            self.allUsers.append(user)
        }
    }
    
    func addUserByLanguage(user: User) {
        print("func addUserByLanguage...")
        for lang in user.language! {
            langUsers[lang]?.append(user.code!)
        }
    }
    
}
