//
//  ViewController.swift
//  ToDoList
//
//  Created by Виталий Крюков on 18.06.2021.
//

import Foundation
import RealmSwift


class ToDo: Object{
    
    @objc dynamic var toDoName:String = ""
    @objc dynamic var toDoBool:Bool = false
}

class PersistanceToDo {
    
    
    var arrayName = [ToDo().toDoName]
    var arrayBool = [ToDo().toDoBool]
    
    var allData: Results<ToDo> {
        let realm = try! Realm()
        return realm.objects(ToDo.self)
    }
    
    
    let realm = try! Realm()

    func addRealm(addName:String, addBool: Bool) {
        let add = ToDo()
        add.toDoName = addName
        add.toDoBool = addBool

        try! realm.write{
            realm.add(add)
        }
    }

    func loadRealm() {
        
        arrayName = []
        arrayBool = []

        let allRealm = realm.objects(ToDo.self)
    
        for note in allRealm {
            arrayName.append(note.toDoName)
            arrayBool.append(note.toDoBool)
        }
    }
   
    func update(note: ToDo) {
        
        try! realm.write{
            note.toDoBool = !note.toDoBool
        }
    }
        
    func deleteRealm(delete: ToDo) {
        try! realm.write{
            realm.delete(delete)
        }
    }
}
    

