//
//  EMHelper.swift
//  NSURLSessionEngine
//
//  Created by Ravindra Kishan on 18/11/15.
//  Copyright (c) 2015 Ravindra Kishan. All rights reserved.
//

import UIKit

class EMHelper: NSObject
{
    //Not model,it just an helper class to hold the parsed object
    var weatherIcon:String!
    var weatherDescp:String!
    var temp:Int!
    var cityName:String!
    var humidity:Int!
    var windSpeed:Int!

    class var sharedInstance : EMHelper
    {
        struct Static
        {
          static let instance : EMHelper = EMHelper()
        }
        return Static.instance
    }

    //MARK:-Formatting Date Ex: Nov 1,2015
    func FormatDate(date:NSDate) -> String
    {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = NSDateFormatterStyle.LongStyle
        return dateFormatter.stringFromDate(date)
    }
    
    //MARK:- Setting weather Image
    func setWeatherImage(weatherStatus:String) -> UIImage?
    {
        var weatherStatusImage:UIImage?
        print(weatherStatusImage, terminator: "")
        switch(weatherStatus)
        {
            case "01d":
            weatherStatusImage = UIImage(named:"sunny.png")
            
            case "01n":
            weatherStatusImage = UIImage(named:"sunny_night.png")
            
            case "02d":
            weatherStatusImage = UIImage(named:"cloudy2.png")
            
            case "02n":
            weatherStatusImage = UIImage(named:"cloudy2_night.png")
            
            case "03d":
            weatherStatusImage = UIImage(named:"cloudy4.png")
            
            case "03n":
            weatherStatusImage = UIImage(named:"cloudy4_night.png")
            
            case "04d":
            weatherStatusImage = UIImage(named:"cloudy5.png")
            
            case "04n":
            weatherStatusImage = UIImage(named:"cloudy5.png")
            
            case "09d":
            weatherStatusImage = UIImage(named:"shower1.png")
            
            case "09n":
            weatherStatusImage = UIImage(named:"shower1_night.png")
            
            case "10d":
            weatherStatusImage = UIImage(named:"shower2.png")
            
            case "10n":
            weatherStatusImage = UIImage(named:"shower2_night.png")
            
            case "11d":
            weatherStatusImage = UIImage(named:"tstorm1.png")
            
            case "11n":
            weatherStatusImage = UIImage(named:"tstorm1_night.png")
            
            case "13d":
            weatherStatusImage = UIImage(named:"snow5.png")
            
            case "13n":
            weatherStatusImage = UIImage(named:"snow5.png")
            
            case "13n":
            weatherStatusImage = UIImage(named:"mist.png")
            
            case "13n":
            weatherStatusImage = UIImage(named:"mist.png")
            
        default:
            print("Weather", terminator: "")
        }
        
        return weatherStatusImage
    }
    
    //MARK:- Converting Far to Cel
    func convertToCelsius(fahrenheit:Int) -> Int
    {
        return Int(5.0 / 9.0 * (Double(fahrenheit) - 32.0))
    }
}
