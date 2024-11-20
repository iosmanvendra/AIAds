//
//  Extensions.swift
//  Hackathon sample app
//
//  Created by Arige Maheswari (Digital Business - Technology- Visakhapatnam) on 18/11/24.
//

import UIKit

extension UITableViewCell {
    
    static var identifier:String{
        return String(describing: self)
    }
    
    static var nib:UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static func registerNib(_ tableView : UITableView) {
        tableView.register(nib, forCellReuseIdentifier: identifier)
    }
    
    func getHTDataPostTimeAndTimeToRead(postTime:String,timeToRead:String) -> String?
     {
         var postTimeAndTimeToReadStr = ""
         if(!postTime.isEmpty)
         {
             postTimeAndTimeToReadStr = postTime
         }
         if(!timeToRead.isEmpty && timeToRead != "0")
         {
             
             if postTime.isEmpty == false {
                 postTimeAndTimeToReadStr = postTimeAndTimeToReadStr + " • "
             }
             if timeToRead == "1" {
                 postTimeAndTimeToReadStr = postTimeAndTimeToReadStr + timeToRead + " min read"
             } else {
                 postTimeAndTimeToReadStr = postTimeAndTimeToReadStr + timeToRead + " mins read"
             }
         }
         return postTimeAndTimeToReadStr

     }
}

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.className, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.className)")
        }
        return cell
    }
}
protocol ClassNameProtocol {
    static var className: String {get}
    var className: String {get}
}
extension ClassNameProtocol {
    public static var className: String {
        return String(describing: self)
    }
    public var className: String {
        return type(of: self).className
    }
}
extension NSObject: ClassNameProtocol {}


extension UICollectionViewCell {
    
    static var identifier:String{
        return String(describing: self)
    }
    
    static var nib:UINib{
        return UINib(nibName: identifier, bundle: nil)
    }
    
    static func registerNib(_ collectionView : UICollectionView) {
        collectionView.register(nib, forCellWithReuseIdentifier: identifier)
    }
}

extension UICollectionView {
    func dequeueReusableCell<T: UICollectionViewCell>(forIndexPath indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.className, for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.className)")
        }
        return cell
    }
}

extension UIViewController {
    
    func setNavBarAppearance() {
        if #available(iOS 15.0, *) {
            updateNavigationForiOS15()
        } else {
            UINavigationBar.appearance().shadowImage = UIImage()
            UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        }
    }
    
    @available(iOS 15.0, *)
    func updateNavigationForiOS15() {
        let navigationBar = self.navigationController?.navigationBar
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
//        appearance.shadowColor = .clear // to remove hair line
        navigationBar?.standardAppearance = appearance
        navigationBar?.scrollEdgeAppearance = appearance
    }
}

extension Date {
    static func timeFromDate(dateString:String) -> String {
        //09/23/2019 12:40:00 PM
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "MM/dd/yyyy hh:mm:ss a"
        if let date = dateFormatter.date(from: dateString) {
            return time(date: date)
        }
        return ""
    }
    static func time(date:Date) -> String {
        let dateComponents = Calendar.current.dateComponents([.second, .minute, .hour, .day, .month, .year], from: date, to: Date())
        
        if let years = dateComponents.year, years > 0 {
            return "\(years) \(years > 1 ? "years ago" : "year ago")"
        }
        
        if let months = dateComponents.month, months > 0 {
            // return "\(months) \(months > 1 ? "months" : "month") ago"
            return Date.dateToString(date: date)
        }
        
        if let days = dateComponents.day, days > 0 {
            //            return "\(days) \(days > 1 ? "days" : "day") ago"
            return Date.dateToString(date: date)
        }
        
        if let hours = dateComponents.hour, hours > 0 {
            return "\(hours) \(hours > 1 ? "hours ago" : "hour ago")"
        }
        
        if let minutes = dateComponents.minute, minutes > 0 {
            return "\(minutes) \(minutes > 1 ? "minutes ago" : "minute ago")"
        }
        
        if let seconds = dateComponents.second, seconds > 0 {
            return "just now"
        }
        return ""
    }
    
    static func dateToString(date:Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Date.dateFormatWithSuffix(date: date)
        let newDate = dateFormatter.string(from: date)
        return newDate
    }
    
    static func dateFormatWithSuffix(date: Date) -> String {
        return "d'\(Date.daySuffix(date: date))' MMM"
    }
    
    static func daySuffix(date: Date) -> String {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.day, from: date)
        let dayOfMonth = components.day
        switch dayOfMonth {
        case 1, 21, 31:
            return "st"
        case 2, 22:
            return "nd"
        case 3, 23:
            return "rd"
        default:
            return "th"
        }
    }
}

extension UIView {
    func showActivityIndicator(asGrayColor: Bool = false, isWhiteLoader: Bool = false) {
        
        // Remove Any Last Added  Activity Indicator
        self.hideActivityIndicator()
        
        var color: UIActivityIndicatorView.Style = .white
        
        color = .gray
        
        if isWhiteLoader {
            color = .white
        }
        
        let activityIndicator = UIActivityIndicatorView(style: color)
        activityIndicator.hidesWhenStopped = true
        self.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        activityIndicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        activityIndicator.startAnimating()
    }
    
    func hideActivityIndicator() {
        for view in self.subviews {
            if let aiView = view as? UIActivityIndicatorView {
                aiView.removeFromSuperview()
                break
            }
        }
    }
}
