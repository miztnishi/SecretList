//
//  SecretListDBManager.swift
//  SecretList
//
//  Created by first on 2021/03/13.
//

import Foundation
import RealmSwift




class SecretDBManager {
    private var realm: Realm?
    static let sharedInstance = SecretDBManager()
    var data: SecretItem?
    init() {
        realm = try! Realm()
    }
    /// 登録
    /// - Parameter data:SecretItem
    func add(data:SecretItem){
        try! realm?.write{
            (realm?.add(data))
        }
    }
    
    /// 全取得
    /// - Returns: リスト
    func getAll() -> Results<SecretItem>{
        return realm!.objects(SecretItem.self)
    }
    
    
    /// 全件削除
    func deleteAll(){
        try! realm?.write{
            realm!.deleteAll()
        }
    }
    
    func deleteOne(id:String){
        let result = realm!.objects(SecretItem.self).filter("id == '\(id)'")
        try! realm?.write {
            realm?.delete(result)
        }
    }
}
