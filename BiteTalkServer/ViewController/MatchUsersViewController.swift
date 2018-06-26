//
//  MatchUsersViewController.swift
//  BiteTalkServer
//
//  Created by 신진욱 on 15/06/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit

class MatchUsersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var matchTableview: UITableView!
    
    let languages = ["English", "한국어 (Korean)", "中文 (Chinese)", "日本語 (Japanese)", "Español (Spanish)", "Français (French)", "Deutsche (German)",
                     "Pусский (Russian)", "Português (Portuguese)", "Italiano (Italian)", "Türkçe (Turkish)", "Nederlands (Dutch)", "العربية (Arabic)",
                     "ภาษาไทย (Thai)", "Svenska (Swedish)", "Dansk (Danish)", "Tiếng Việt (Vietnamese)", "Norsk (Norwegin)", "Polski (Polish)",
                     "Suomi (finnish)", "Bahasa Indonesia (Indonesian)", "עִברִית (Hebrew)", "Ελληνικά (Greek)", "Română (Romanian)", "Magyar (Hungarian)", "čeština (Czech)", "Català (Caralan)", "Slovenčina (Slovak)", "Українська (Ukrainian)", "Hrvatski (Croatian)", "Hahasa Melayu (Malay)", "हिंदी (Hindi)"]
    
    var langUsers: [String: [String]]?
    var couples = [String: [(sender: String, reciever: String)]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        matchTableview.dataSource = self
        matchTableview.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return languages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = matchTableview.dequeueReusableCell(withIdentifier: "matchingcell", for: indexPath)
        cell.textLabel?.text = languages[indexPath.row]
//        cell.detailTextLabel?.text =
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        match(language: languages[indexPath.row])
    }
    
    func match(language: String) {
//        print("start \(language) match...")
        if let users = langUsers?[language] {
            if users.count < 2 {
//                print("user using \(language) is you alone...")
            }
            if users.count == 2 {
                couples[language]?.removeAll()
                if couples[language]?.append((sender: users[0], reciever: users[1])) == nil {
                    couples[language] = [(sender: users[0], reciever: users[1])]
                }
                if couples[language]?.append((sender: users[1], reciever: users[0])) == nil {
                    couples[language] = [(sender: users[1], reciever: users[0])]
                }
                
            }
            let shuffleUsers = Array.shuffleArray2(array: users)
            var i = 0
            if users.count > 2 {
                couples[language]?.removeAll()
                while i < (users.count-1) {
                    if couples[language]?.append((shuffleUsers[i], shuffleUsers[i+1])) == nil {
                        couples[language] = [(shuffleUsers[i], shuffleUsers[i+1])]
                    }
                    i = i+1
                    if i == (users.count - 1) {
                        if couples[language]?.append((shuffleUsers[i], shuffleUsers[0])) == nil {
                            couples[language] = [(shuffleUsers[i], shuffleUsers[0])]
                        }
                    }
                }
            }
            langUsers![language] = shuffleUsers
        }
//        print("end \(language) match...")
//        print(couples[language])
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "allmatch" {
            for lang in languages {
                match(language: lang)
            }
        }
    }
    
    
    
    
    

}
