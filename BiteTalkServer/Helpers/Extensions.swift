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

extension Array where Element: Equatable {
    
    static func shuffleArray(array: Array) -> Array {
//        var items = ["A", "B", "C", "D", "E", "F", "G", "H"]
        var items = array
        var last = items.count - 1
        
        while(last > 0)
        {
            let rand = Int(arc4random_uniform(UInt32(last)))
            
//            print("swap items[\(last)] = \(items[last]) with items[\(rand)] = \(items[rand])")
            
            items.swapAt(last, rand)
            
//            print(items)
            
            last -= 1
        }
        
        return items
    }
    
    static func shuffleArray2(array: Array) -> Array {
//        var items = ["A", "B", "C", "D", "E", "F", "G", "H"]
        var items = array
//        var shuffled = [String]();
        var shuffled = [Any]();
        
        for _ in 0..<items.count
        {
            let rand = Int(arc4random_uniform(UInt32(items.count)))
            
            shuffled.append(items[rand])
            
            items.remove(at: rand)
        }
        
//        print(shuffled)
        return shuffled as! Array<Element>
    }
}
