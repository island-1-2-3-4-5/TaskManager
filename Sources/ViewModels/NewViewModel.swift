//
//  NewViewModel.swift
//  TaskManager
//
//  Created by Roman on 09.08.2020.
//  Copyright © 2020 Roman Monakhov. All rights reserved.
//
import UIKit

class NewViewModel{
    var currentTask: Task! // это свойство содержит информацию о текущей выбранной ячейке
    let date = Date()
    
    
    func descriptionUpdate() -> String{
        return currentTask.descriptionTask!
    }
             

    func nameUpdate() -> String{
        return currentTask.name
     }
    
    
    
}
