//
//  SecretItemObj.swift
//  SecretList
//
//  Created by first on 2021/03/13.
//


import RealmSwift

class SecretItem: Object {
    @objc dynamic var id: String =  NSUUID().uuidString
    @objc dynamic var serviceName:String! = ""
    @objc dynamic var formId: String! = ""
    @objc dynamic var password: String! = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
