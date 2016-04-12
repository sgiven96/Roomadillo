//
//  Roommate.swift
//  Roomadillo
//
//  Created by Benjamin Devore on 3/29/16.
//  Copyright © 2016 Benjamin Devore. All rights reserved.
//

import Foundation
import Parse

class Roommate : PFObject, PFSubclassing {
    
    @NSManaged var firstName : String?
    @NSManaged var viewed : [String]?
    @NSManaged var photo : PFFile?
    @NSManaged var smoker : Bool
    
    
    override class func initialize() {
        struct Static {
            static var onceToken : dispatch_once_t = 0;
        }
        dispatch_once(&Static.onceToken) {
            self.registerSubclass()
        }
    }
    
    static func parseClassName() -> String {
        return "Roommate"
    }
    
    func indexInViewed(objectID: String) -> (index: Int, found: Bool) {
        if(viewed!.isEmpty) {
            return (0,false)
        }
        var low = 0;
        var high = viewed!.count - 1
        while (true) {
            let current = (low + high)/2
            if(viewed![current] == objectID) {
                return (current,true)
            } else if (low > high) {
                return (low,false)
            } else {
                if (viewed![current] > objectID) {
                    high = current - 1
                } else {
                    low = current + 1
                }
            }
        }
    }
    
}
