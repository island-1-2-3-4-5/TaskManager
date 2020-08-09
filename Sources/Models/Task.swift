//
//  Task.swift
//  TaskManager
//
//  Created by Roman on 02.08.2020.
//  Copyright © 2020 Roman Monakhov. All rights reserved.
//

import RealmSwift
// делаем модель хранения данных как класс, с типом данных Object


class Task: Object {
    
    // данные которые мы храним
    @objc dynamic var name: String = ""
    @objc dynamic var descriptionTask: String?
    @objc dynamic var createdAt: Date!
    @objc dynamic var isCompleted = false
    
    // вспомогательный инициализатор (не является обязательным), с помощью него вносим новые значения в базу
    convenience init(name: String, descriptionTask: String?, createdAt: Date!, isCompleted: Bool){
        self.init() //  сначала инициализируется обычный инициализатор а после присваиваем новые значения
        self.name = name
        self.descriptionTask = descriptionTask
        self.createdAt = createdAt
        self.isCompleted = isCompleted
    }
    
    
}


