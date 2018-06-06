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
    
    let languages = ["English", "한국어 (Korean)", "中文 (Chinese)", "日本語 (Japanese)", "Español (Spanish)", "Français (French)", "Deutsche (German)",
                     "Pусский (Russian)", "Português (Portuguese)", "Italiano (Italian)", "Türkçe (Turkish)", "Nederlands (Dutch)", "العربية (Arabic)",
                     "ภาษาไทย (Thai)", "Svenska (Swedish)", "Dansk (Danish)", "Tiếng Việt (Vietnamese)", "Norsk (Norwegin)", "Polski (Polish)",
                     "Suomi (finnish)", "Bahasa Indonesia (Indonesian)", "עִברִית (Hebrew)", "Ελληνικά (Greek)", "Română (Romanian)", "Magyar (Hungarian)", "čeština (Czech)", "Català (Caralan)", "Slovenčina (Slovak)", "Українська (Ukrainian)", "Hrvatski (Croatian)", "Hahasa Melayu (Malay)", "हिंदी (Hindi)"]
    var users = [User]() {
        didSet {
            print("users didSet...")
            for user in users {
                print(user.nickname)
            }
            print("")
        }
    }
//    var users: [String: [User]]?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
            print("childAdded...")
            let code = snap.key
            let dic = snap.value as? [String: Any]
            print(dic)
            let user = User(code: code)
            user.settingFromDic(dic: dic)
            self.users.append(user)
        }
    }

}
