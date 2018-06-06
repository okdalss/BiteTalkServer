//
//  Extensions.swift
//  BiteTalkServer
//
//  Created by 신진욱 on 01/06/2018.
//  Copyright © 2018 신진욱. All rights reserved.
//

import UIKit

extension UIViewController {
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func toTheView(viewName: String) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let newviewcont = storyboard.instantiateViewController(withIdentifier: viewName)
        print("go to \(viewName)")
        self.present(newviewcont, animated: false, completion: nil)
    }
}
