//
//  LocalNotificationManager.swift
//  SimpraFinalProject
//
//  Created by Furkan Deniz Albaylar on 24.01.2023.
//

import Foundation
import UserNotifications

final class LocalNotificationManager {
    static let shared = LocalNotificationManager()
    let center = UNUserNotificationCenter.current()
    private init(){
        center.removeAllDeliveredNotifications()
    }
    
    var permission:Bool = false
    
    func cleanNotifications(){
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func missUserNotification(day:Int){
        guard permission else {return}
        center.removePendingNotificationRequests(withIdentifiers: ["missUserNotification"])
        
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("LegandaryGame", comment: "Name of the App")
        content.body = NSLocalizedString("MISS_USER_NOTIFICATION", comment: "Missed You")
        content.sound = UNNotificationSound.default
        
        // 10 seconds for test
        let timeSecond:Double = day > 0 ? Double(day * 86400) : 10
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeSecond, repeats: false)
        let missUserNotification = UNNotificationRequest(identifier: "missUserNotification", content: content, trigger: trigger)
        center.add(missUserNotification)
        
    }
    
    func addGameReleaseNotification(gameId:Int,gameTitle:String,day:Int,month:Int,year:Int){
        guard permission else {return}
        
        center.removePendingNotificationRequests(withIdentifiers: ["\(gameId)_gameReleaseNotification"])
        
        let content = UNMutableNotificationContent()
        content.title = NSLocalizedString("LegandaryGame", comment: "Name of the App")
        content.body = "\(gameTitle), \(NSLocalizedString("Release", comment: "Missed You"))"
        content.badge = 1
        content.sound = UNNotificationSound.default
        
        var date = DateComponents()
        date.day = day
        date.month = month
        date.year = year
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
        
        let missUserNotification = UNNotificationRequest(identifier: "missUserNotification", content: content, trigger: trigger)
        
        center.add(missUserNotification)
        
    }
    
    func removeGameReleaseNotification(gameId:Int){
        guard permission else {return}
        center.removePendingNotificationRequests(withIdentifiers: ["\(gameId)_gameReleaseNotification"])
    }
}
