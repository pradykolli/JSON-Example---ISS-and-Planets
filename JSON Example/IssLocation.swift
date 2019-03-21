//
//  IssLocation.swift
//  JSON Example
//
//  Created by Michael Rogers on 3/20/19.
//  Copyright © 2019 Michael Rogers. All rights reserved.
//

import Foundation

struct IssLocation : Codable {
    var message:String
    var timestamp:Int
    var iss_position:Position
}

struct Position : Codable {
    var latitude:String
    var longitude:String
}
    
