//
//  DateUtils.swift
//  maishafiti-uikit
//
//  Created by Daniel Kimani on 29/09/2023.
//

import Foundation


// Function to convert Date to String
public func dateToString(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    dateFormatter.timeStyle = .none
    return dateFormatter.string(from: date)
}


public func formatDate(from inputFormat: String, to outputFormat: String, dateString: String) -> String? {
    let inputDateFormatter = DateFormatter()
    inputDateFormatter.dateFormat = inputFormat
    
    if let date = inputDateFormatter.date(from: dateString) {
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = outputFormat
        return outputDateFormatter.string(from: date)
    } else {
        return nil // Invalid input date
    }
}

public func formatTimeToShowMinandSeconds(seconds: Int) -> String {
    let minutes = seconds / 60
    let remainingSeconds = seconds % 60
    
    if minutes > 0 {
        return "\(minutes):\(String(format: "%02d", remainingSeconds)) min"
    } else {
        return "\(remainingSeconds) sec"
    }
}


public func getCurrentTimestamp() -> String {
    let dateFormatter = ISO8601DateFormatter()
    dateFormatter.formatOptions = [.withInternetDateTime, .withFractionalSeconds]
    let timestamp = dateFormatter.string(from: Date())
    return timestamp
}


public func formatDateFromyyyyMMddTHHmmssZToMMMDD(_ dateString: String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    
    if let date = dateFormatter.date(from: dateString) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "MMM dd"
        return outputFormatter.string(from: date)
    }else{
        let dateTime = dateString.split(separator: "T")
        guard let firstItem = dateTime.first else {
            Logger("\(dateString) NO VALID")
            return dateString
        }
        
        return formatToAbbreviatedMonthDay(String(firstItem))
    }
 
}

public func formatToAbbreviatedMonthDay(_ inputDate: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd" // Input date format

    if let date = dateFormatter.date(from: inputDate) {
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "MMM d" // Output date format

        return outputDateFormatter.string(from: date)
    }

    return inputDate
}

public func formatDateFromyyyyMMddTHHmmssZToyyyyMMdd(_ dateString: String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    
    if let date = dateFormatter.date(from: dateString) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd"
        return outputFormatter.string(from: date)
    }
    
    return dateString
}

public func formattedDateFromEEEMMMddToyyyyMMdd(from inputDateStr: String) -> String {
    let inputDateFormatter = DateFormatter()
    inputDateFormatter.dateFormat = "EEE MMM dd HH:mm:ss zzz yyyy"
    // Set the locale if necessary
    // inputDateFormatter.locale = Locale(identifier: "en_US_POSIX")
    
    if let inputDate = inputDateFormatter.date(from: inputDateStr) {
        let outputDateFormatter = DateFormatter()
        outputDateFormatter.dateFormat = "yyyy-MM-dd"
        
        let formattedDate = outputDateFormatter.string(from: inputDate)
        Logger("DATEOFBIRTH \(formattedDate)")
        return formattedDate
    } else {
        Logger("DATEOFBIRTH \(inputDateStr)")
        return inputDateStr //"Invalid Date"
    }
}


public func formatDateFromyyyyMMddTHHmmssToyyyyMMdd(_ dateString: String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    dateFormatter.locale = Locale(identifier: "en_US_POSIX")
    
    if let date = dateFormatter.date(from: dateString) {
        let outputFormatter = DateFormatter()
        //outputFormatter.dateFormat = "yyyy-MM-dd"
        outputFormatter.dateFormat = "dd-MM-yyyy"
        return outputFormatter.string(from: date)
    }
    
    return dateString
}

// Usage
//let inputDateString = "Sat Jan 01 00:00:00 GMT 2005"
//let formattedDateString = formattedDateyyyyMMdd(from: inputDateString)
//Logger(formattedDateString)



public func currentDateInFormatyyyyMMdd() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    let currentDate = Date()
    let formattedDate = dateFormatter.string(from: currentDate)
    
    return formattedDate
}

public func previousSunday(from date: Date) -> String {
    let calendar = Calendar.current
    let weekday = calendar.component(.weekday, from: date)
    let daysToSubtract = weekday - 1
    let previousSundayDate = calendar.date(byAdding: .day, value: -daysToSubtract, to: date)!
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    return dateFormatter.string(from: previousSundayDate)
}

public func previousSundayZ(from date: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    
    if let inputDate = dateFormatter.date(from: date) {
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: inputDate)
        let daysToSubtract = weekday - 1
        let previousSundayDate = calendar.date(byAdding: .day, value: -daysToSubtract, to: inputDate)!
        
        return dateFormatter.string(from: previousSundayDate)
    } else {
        // Handle invalid input date
        return "Invalid Date"
    }
}






public func calculateHoursRemaining() -> Int {
    let calendar = Calendar.current
    let now = Date()
    
    // Get the current date components
    let currentComponents = calendar.dateComponents([.hour, .minute, .second], from: now)
    
    // Create a new date with the same year, month, and day but with 23 hours, 59 minutes, and 59 seconds
    let endOfDay = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: now)
    
    // Get the date components for the end of the day
    let endOfDayComponents = calendar.dateComponents([.hour, .minute, .second], from: endOfDay!)
    
    // Calculate the hours remaining
    let hoursRemaining = endOfDayComponents.hour! - currentComponents.hour!
    
    return hoursRemaining
}


public func isDateInPast(targetDateString:String) -> Bool {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    
    Logger("TARGET DATE \(targetDateString)")
    
    if let targetDate = dateFormatter.date(from: targetDateString) {
        let currentDate = Date()
        
        Logger(currentDate > targetDate ? "<PASSED" : "FUTURE>" )
        
        return currentDate > targetDate
        
        //FOR ONGOING == currentDate > (END TARGETDATE)
        //FOR UPCOMING== currentDate > (START TARGETDATE)
        
    }
    Logger("ERROR DATE")
    return false // Invalid date format
}


public func formatDateTimeToHMMA(_ inputDate: String) -> String {
    let dateFormatter = DateFormatter()
    //dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSSS"
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
    if let date = dateFormatter.date(from: inputDate) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "h:mm a"
        return outputFormatter.string(from: date)
    } else {
        let dateTime = inputDate.split(separator: "T")
        //return String(dateTime.first)
        return formatDateTimeSSSSSSSSSZZZZZToHMMA(inputDate)
    }
}

public func formatDateTimeSSSSSSSSSZZZZZToHMMA(_ inputDate: String) -> String {
    let dateFormatter = ISO8601DateFormatter()
     dateFormatter.formatOptions = [.withFractionalSeconds, .withTimeZone, .withInternetDateTime]
    Logger("SPRITED DATE\(inputDate)",showLog: false)
     if let date = dateFormatter.date(from: inputDate) {
         let outputFormatter = DateFormatter()
         outputFormatter.dateFormat = "h:mm a"
         //outputFormatter.timeZone = TimeZone(identifier: "Africa/Nairobi")
         return outputFormatter.string(from: date)
     } else {
         let dateTime = inputDate.split(separator: "T")
        
         if dateTime.count == 2 {
             Logger("SPRITED DATE \(dateTime) and \(String(dateTime[0]))",showLog: false)
             return String(dateTime[0])
         }else{
             Logger("ESLE SPRITED DATE \(dateTime)",showLog: false)
             return  inputDate//String(dateTime[0])
         }
     }
 }

public func formatDateFromSSSSSSToYYYYMMDD(_ inputDate: String) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSSSSSS"
    
    if let date = dateFormatter.date(from: inputDate) {
        let outputFormatter = DateFormatter()
        outputFormatter.dateFormat = "yyyy-MM-dd"
        return outputFormatter.string(from: date)
    } else {
        return inputDate
    }
}



public func getCurrentTimeINHHMMSS() -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm:ss"
    let currentTime = dateFormatter.string(from: Date())
    return currentTime
}


public func addTimeStrings(time1: String, time2: String) -> String {
    Logger("time1 \(time1) time2 \(time2)")
    let timeFormatter = DateFormatter()
    timeFormatter.dateFormat = "HH:mm:ss"
    
    if let date1 = timeFormatter.date(from: time1), let date2 = timeFormatter.date(from: time2) {
        let combinedTimeInterval = date1.timeIntervalSinceReferenceDate + date2.timeIntervalSinceReferenceDate
        let combinedDate = Date(timeIntervalSinceReferenceDate: combinedTimeInterval)
        return timeFormatter.string(from: combinedDate)
    } else {
        return "00:00:00"
    }
}


public func formatTimeIntervalAsHHMMSS(_ timeInterval: TimeInterval) -> String {
    let date = Date(timeIntervalSince1970: timeInterval)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm:ss"
    dateFormatter.timeZone = TimeZone.current // You can change the time zone as needed
    return dateFormatter.string(from: date)
}


public func getEpochFromCurrentDate() -> String {
    let currentTimeInterval = Date().timeIntervalSince1970
    return  "\(currentTimeInterval)"//formatTimeIntervalAsHHMMSS(currentTimeInterval)
}

public func epochFromHHMMSS(_ timeString: String) -> TimeInterval? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm:ss"
    dateFormatter.timeZone = TimeZone.current // You can change the time zone as needed
    if let date = dateFormatter.date(from: timeString) {
        return date.timeIntervalSince1970
    }
    return nil
}


public func subtractEpochs(_ epoch1: TimeInterval, _ epoch2: TimeInterval) -> TimeInterval {
    return epoch1 - epoch2
}


public func formatTimeDounbletoHHMMSS(_ time: Double) -> String {
    let hours = Int(time / 3600)
    let minutes = Int(time.remainder(dividingBy: 3600) / 60)
    
    let sec = Int(time) - (hours * 3600 + minutes * 60)
    //let seconds = Int(time.remainder(dividingBy: 60))
    Logger("Hours = \(hours), Minutes = \(minutes)")
    return String(format: "%02d:%02d:%02d", hours, minutes, sec)
}

public func formatTimeINTtoHHMMSS(_ seconds: Int) -> String {
    let hours = seconds / 3600
    let minutes = (seconds % 3600) / 60
    let seconds = seconds % 60
    return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
}

public func formatDatetoHHMMSS(_ date: Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm:ss"
    
    return dateFormatter.string(from: date)
}

public func formatAsString(_ dateString:String)->String{
    
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS"
    
    if let date = df.date(from: dateString){
        //
        df.dateFormat = "dd MMM yyyy"
        //
        var u = df.string(from: date)
        
        //
        df.dateFormat = "HH:mm"
        
        u = "\(u) | \(df.string(from: date))"
        
        return u
    }else{
        
        let dateTime = dateString.split(separator: "T")
        
        df.dateFormat = "yyyy-MM-dd"
        
        if let dstring = dateTime.first, let tstring = dateTime.last, let date = df.date(from: String(dstring)){
            //
            df.dateFormat = "dd MMM yyyy"
            //
            var u = df.string(from: date)
            
            //
            df.dateFormat = "HH:mm:ss"
            
            //
            if let time = df.date(from: String(tstring)){
                //
                df.dateFormat = "HH:mm"
                u = "\(u) | \(df.string(from: time))"
            }
            return u
        }
    }
    
    return dateString
    
}




public func formatAsStringHH(_ dateString:String)->String{
    
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.ssZ"
    
    if let date = df.date(from: dateString){
        //
        df.dateFormat = "HH"
        //
        let u = df.string(from: date)
        
        
        return u
    }else{
        let timeinhh = ""
        let dateTime = dateString.split(separator: "T")
        
        let tstring = dateTime.last
        
        let arrayTime = tstring?.split(separator: ":")
        let hh = arrayTime?.first
        
        return ""//String(hh)
    }
}



public func convertTimeHHMMSStoHHMMSS(_ timeString: String) -> String {
    let timeComponents = timeString.components(separatedBy: ":")
    
    // Ensure there are at least two components (hours and minutes)
    if timeComponents.count >= 2, let hours = Int(timeComponents[0]), let minutes = Int(timeComponents[1]),let seconds = Int(timeComponents[2]) {
        var result = ""
        
        if hours > 0 {
            result += "\(hours)h"
            if hours > 1 {
                result += "s" // Add 's' for plural hours
            }
        }
        
        if minutes > 0 {
            if !result.isEmpty {
                result += " " // Add a space between hours and minutes
            }
            result += "\(minutes)m"
        }
        
        if seconds > 0 {
            if !result.isEmpty {
                result += " " // Add a space between  minutes and seconds
            }
            result += "\(seconds)s"
        }
        
        return result
    }
    
    return timeString // Invalid time format
}

public func convertTimeHHMMSStoHHMM(_ timeString: String) -> String {
    let timeComponents = timeString.components(separatedBy: ":")
    
    // Ensure there are at least two components (hours and minutes)
    if timeComponents.count >= 2, let hours = Int(timeComponents[0]), let minutes = Int(timeComponents[1]) {
        var result = ""
        
        if hours > 0 {
            result += "\(hours)hr"
            if hours > 1 {
                result += "s" // Add 's' for plural hours
            }
        }
        
        if minutes > 0 {
            if !result.isEmpty {
                result += " " // Add a space between hours and minutes
            }
            result += "\(minutes)min"
        }
        
        return result
    }
    
    return timeString // Invalid time format
}
/*
let timeString = "01:35:45"
if let convertedTime = convertTime(timeString) {
    Logger(convertedTime) // Output: "1 hr 35 min"
} else {
    Logger("Invalid time format")
}
*/
