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
    
    
    func formatPickerDate(_ pickerDate: Date, _ h: Int, _ m: Int) -> DateComponents{
        var dateComponent = DateComponents()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: pickerDate) - h
        let minute = calendar.component(.minute, from: pickerDate) - m
//        let day = calendar.component(.day, from: pickerDate)

        dateComponent.hour = hour
        dateComponent.minute = minute
//        dateComponent.day = day
        
        return dateComponent
    }
    
    
    
    
}
