//
//  CalendarViewController.swift
//  bon-voyage
//
//  Created by Harsil Patel on 9/5/19.
//  Copyright © 2019 Harsil Patel. All rights reserved.
//

import UIKit
import CalendarKit
import DateToolsSwift

class CalendarViewController: DayViewController {
    
    var data = [["Breakfast at Tiffany's",
                 "New York, 5th avenue"],
                
                ["Workout",
                 "Tufteparken"],
                
                ["Meeting with Alex",
                 "Home",
                 "Oslo, Tjuvholmen"],
                
                ["Beach Volleyball",
                 "Ipanema Beach",
                 "Rio De Janeiro"],
                
                ["WWDC",
                 "Moscone West Convention Center",
                 "747 Howard St"],
                
                ["Google I/O",
                 "Shoreline Amphitheatre",
                 "One Amphitheatre Parkway"],
                
                ["✈️️ to Svalbard ❄️️❄️️❄️️❤️️",
                 "Oslo Gardermoen"],
                
                ["💻📲 Developing CalendarKit",
                 "🌍 Worldwide"],
                
                ["Software Development Lecture",
                 "Mikpoli MB310",
                 "Craig Federighi"],
                
                ]
    
    var colors = [UIColor.blue,
                  UIColor.yellow,
                  UIColor.green,
                  UIColor.red]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print("hwiherw")
//        let window = UIWindow(frame: UIScreen.main.bounds)
//        window.backgroundColor = UIColor.darkGray
//        window.makeKeyAndVisible()
//        print("created window")
        
//        let calendarVC = CalendarViewController()
//        let navigationController = UINavigationController(rootViewController: calendarVC)
//        window.rootViewController = navigationController
//        print("tried doing it cannot do it")
        reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func eventsForDate(_ date: Date) -> [EventDescriptor] {
        var date = date.add(TimeChunk.dateComponents(hours: Int(arc4random_uniform(10) + 5)))
        var events = [Event]()
        
        for i in 0...4 {
            let event = Event()
            let duration = Int(arc4random_uniform(160) + 60)
            let datePeriod = TimePeriod(beginning: date,
                                        chunk: TimeChunk.dateComponents(minutes: duration))
            
            event.startDate = datePeriod.beginning!
            event.endDate = datePeriod.end!
            
            var info = data[Int(arc4random_uniform(UInt32(data.count)))]
            
            let timezone = TimeZone.ReferenceType.default
            info.append(datePeriod.beginning!.format(with: "dd.MM.YYYY", timeZone: timezone))
            info.append("\(datePeriod.beginning!.format(with: "HH:mm", timeZone: timezone)) - \(datePeriod.end!.format(with: "HH:mm", timeZone: timezone))")
            event.text = info.reduce("", {$0 + $1 + "\n"})
            event.color = colors[Int(arc4random_uniform(UInt32(colors.count)))]
            event.isAllDay = Int(arc4random_uniform(2)) % 2 == 0
            
            // Event styles are updated independently from CalendarStyle
            // hence the need to specify exact colors in case of Dark style
//            if currentStyle == .Dark {
//                event.textColor = textColorForEventInDarkTheme(baseColor: event.color)
//                event.backgroundColor = event.color.withAlphaComponent(0.6)
//            }
            
            events.append(event)
            
            let nextOffset = Int(arc4random_uniform(250) + 40)
            date = date.add(TimeChunk.dateComponents(minutes: nextOffset))
            event.userInfo = String(i)
        }
        print("returning the eventsForDate")
        return events
    }
    
    override func dayViewDidSelectEventView(_ eventView: EventView) {
        guard let descriptor = eventView.descriptor as? Event else {
            return
        }
        print("Event has been selected: \(descriptor) \(String(describing: descriptor.userInfo))")
    }
    
    override func dayViewDidLongPressEventView(_ eventView: EventView) {
        guard let descriptor = eventView.descriptor as? Event else {
            return
        }
        print("Event has been longPressed: \(descriptor) \(String(describing: descriptor.userInfo))")
    }
    
    override func dayView(dayView: DayView, willMoveTo date: Date) {
        print("DayView = \(dayView) will move to: \(date)")
    }
    
    override func dayView(dayView: DayView, didMoveTo date: Date) {
        print("DayView = \(dayView) did move to: \(date)")
    }
    
    @IBAction func openChatView(_ sender: Any) {
        navigationController?.pushViewController(BasicExampleViewController(), animated: true)
    }
    

}
