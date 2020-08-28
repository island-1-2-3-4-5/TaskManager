//
//  Settings.swift
//  TaskManager
//
//  Created by Roman on 22.08.2020.
//  Copyright © 2020 Roman Monakhov. All rights reserved.
//

import RealmSwift
import CoreLocation
// делаем модель хранения данных как класс, с типом данных Object


class Settings: Object {
    
    // данные которые мы храним
    @objc dynamic var numberSwitchIsOn = 2
    @objc dynamic var remindersIsOn = false
    @objc dynamic var securityIsOn = false
    @objc dynamic var faceIdIsOn = false
    @objc dynamic var touchIdIsOn = false
 
    
    // вспомогательный инициализатор (не является обязательным), с помощью него вносим новые значения в базу
    convenience init(numberSwitchIsOn: Int, remindersIsOn: Bool, securityIsOn: Bool, faceIdIsOn: Bool, touchIdIsOn: Bool){
        self.init() //  сначала инициализируется обычный инициализатор а после присваиваем новые значения
        self.numberSwitchIsOn = numberSwitchIsOn
        self.remindersIsOn = remindersIsOn
        self.securityIsOn = securityIsOn
        self.faceIdIsOn = faceIdIsOn
        self.touchIdIsOn = touchIdIsOn
    }
    
    
}
