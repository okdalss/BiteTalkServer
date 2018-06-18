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
    var shuffledusers = [String: [String]]() {
        didSet {
            print("shuffledusers...")
            print(shuffledusers)
        }
    }
    var couples = [(reciever: String, sender: String)]()
    
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
        print("start \(language) match...")
        if let users = langUsers?[language] {
            if users.count < 2 {
                return
            }
            let shuffleUsers = Array.shuffleArray(array: users)
            var i = 0
            while i < (users.count-1) {
                couples.append((shuffleUsers[i], shuffleUsers[i+1]))
                i = i+1
                if i == (users.count - 1) {
                    couples.append((shuffleUsers[i], shuffleUsers[0]))
                }
            }
            shuffledusers[language] = shuffleUsers
        }
        print("end \(language) match...")
        print(couples)
    }

}
