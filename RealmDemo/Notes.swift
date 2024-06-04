//
//  Notes.swift
//  RealmDemo
//
//  Created by charles raj on 04/06/24.
//

import Foundation
import RealmSwift

class Notes : Object, Identifiable {
    
    
    @Persisted(primaryKey : true) var _id : ObjectId
    @Persisted var name : String = ""
    @Persisted var gender : String = ""
    @Persisted var age : String = ""
    
    convenience init( name: String, gender: String, age: String) {
        self.init()
        self.name = name
        self.gender = gender
        self.age = age
    }
    
    
}
