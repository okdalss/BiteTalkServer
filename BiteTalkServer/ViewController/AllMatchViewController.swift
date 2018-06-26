//
//  AllMatchViewController.swift
//  BiteTalkServer
//
//  Created by 신진욱 on 25/06/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit

class AllMatchViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var matchingTableview: UITableView!
    
    var viewcont: MatchUsersViewController!
    var addLangUsersIndex = true
    var langUsersIndex = [0]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        matchingTableview.dataSource = self
        if let i = navigationController?.viewControllers.index(of: self) {
            viewcont = navigationController?.viewControllers[i-1] as! MatchUsersViewController
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        addLangUsersIndex = true
        langUsersIndex = [0]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if addLangUsersIndex {
            for lang in viewcont.languages {
                langUsersIndex.append((viewcont.langUsers![lang]?.count ?? 0) + 1 + langUsersIndex.last!)
            }
            addLangUsersIndex = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var returnValue = 1
        returnValue = viewcont.languages.count
        for lang in viewcont.languages {
            returnValue = returnValue + (viewcont.couples[lang]?.count ?? 0)
        }
        
        return returnValue
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if langUsersIndex.contains(indexPath.row) {
            let cell = matchingTableview.dequeueReusableCell(withIdentifier: "language", for: indexPath)
            cell.textLabel?.text = viewcont.languages[langUsersIndex.index(of: indexPath.row)!]
            cell.detailTextLabel?.text = String(viewcont.couples[viewcont.languages[langUsersIndex.index(of: indexPath.row)!]]?.count ?? 0)
            return cell
        } else {
            let cell = matchingTableview.dequeueReusableCell(withIdentifier: "detailbyuser", for: indexPath)
//            print(cell.subviews[0].subviews[0] as? UILabel)
            if let labels = cell.subviews[0].subviews as? [UILabel] {
                for label in labels {
                    label.text = "kkk"
                }
            }
            return cell
        }
    }
    
}
