//
//  Date.swift
//  TaskManager
//
//  Created by Roman on 06.08.2020.
//  Copyright © 2020 Roman Monakhov. All rights reserved.
//
import UIKit
class DateFormat{
    
    func formatDate(_ date: Date) -> String {
        
        let format = DateFormatter()
        format.locale = Locale(identifier: "ru_RU")
        format.dateFormat = "HH:mm dd MMMM yyyy"
        let formattedDate = format.string(from: date)
        return formattedDate
    }
    
    func formatDateInHour(_ date: Date) -> String {
        
        let format = DateFormatter()
        format.locale = Locale(identifier: "ru_RU")
        format.dateFormat = "HH:mm"
        let formattedDate = format.string(from: date)
        return formattedDate
    }
    
    
    
    
}
