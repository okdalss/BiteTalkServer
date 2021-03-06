//
//  MainViewController.swift
//  BiteTalkServer
//
//  Created by 신진욱 on 01/06/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit
import Firebase

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var languages = ["English", "한국어 (Korean)", "中文 (Chinese)", "日本語 (Japanese)", "Español (Spanish)", "Français (French)", "Deutsche (German)",
                     "Pусский (Russian)", "Português (Portuguese)", "Italiano (Italian)", "Türkçe (Turkish)", "Nederlands (Dutch)", "العربية (Arabic)",
                     "ภาษาไทย (Thai)", "Svenska (Swedish)", "Dansk (Danish)", "Tiếng Việt (Vietnamese)", "Norsk (Norwegin)", "Polski (Polish)",
                     "Suomi (finnish)", "Bahasa Indonesia (Indonesian)", "עִברִית (Hebrew)", "Ελληνικά (Greek)", "Română (Romanian)", "Magyar (Hungarian)", "čeština (Czech)", "Català (Caralan)", "Slovenčina (Slovak)", "Українська (Ukrainian)", "Hrvatski (Croatian)", "Hahasa Melayu (Malay)", "हिंदी (Hindi)"]
    
    var allUsers = [User]() {
        didSet {
            if let user = allUsers.last {
                addUserByLanguage(user: user)
                self.usersTableview.reloadData()
            } else {
                print("-------------------------allUsers error----------------------------")
                print("allusers: \(allUsers)")
            }
            allusersNumLabel.text = String(describing: allUsers.count)
        }
    }
    
    @IBOutlet weak var allusersNumLabel: UILabel!
    @IBOutlet weak var usersTableview: UITableView!
    
    var langUsers = [String: [String]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        usersTableview.dataSource = self
        usersTableview.delegate = self
        addUsers()
    }
    
    override func viewDidAppear(_ animated: Bool) {
//        allUsers.removeAll()
//        addUsers()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addUsers() {
//        print("func addUsers...")
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
//        print("func addUserByLanguage...")
        for lang in user.language! {
            if langUsers[lang]?.append(user.code!) == nil {
                langUsers[lang] = [user.code!]
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = usersTableview.dequeueReusableCell(withIdentifier: "userscell", for: indexPath)
        cell.textLabel?.text = languages[indexPath.row]
        cell.detailTextLabel?.text = String(describing: langUsers[languages[indexPath.row]]?.count ?? 0)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(languages[indexPath.row]) selected...")
        print(langUsers[languages[indexPath.row]])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewCont: MatchUsersViewController = segue.destination as! MatchUsersViewController
        viewCont.langUsers = langUsers
    }
    
}
