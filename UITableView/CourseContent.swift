//
//  CourseContent.swift
//  UITableView
//
//  Created by Kavitha Bojanapu on 12/20/21.
//

import Foundation

struct CourseContent:Codable {
    
    var name : String
    var dDescription : String
    var courses : [Course]
    
    struct Course :Codable {
        
        var id : Int
        var link : String
        var name : String
        var imageUrl : String
        var numberOfLessons : Int
    }
}
