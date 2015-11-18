//
//  ViewController.swift
//  NSURLSessionEngine
//
//  Created by Ravindra Kishan on 18/11/15.
//  Copyright © 2015 Ravindra Kishan. All rights reserved.
//

import UIKit

class ViewController: UIViewController,WebEngineDelegate
{
    var weatherHelper = EMHelper()
    @IBOutlet var weatherImage: UIImageView!
    @IBOutlet var tempLabel: UILabel!
    @IBOutlet var weatherCondition: UILabel!
    @IBOutlet var dateLabel: UILabel!
    

    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        webEngine.sharedInstance.delegate = self
        ActivityIndicator.shared.startAnimating(view)
        webEngine.sharedInstance.getMysoreWeatherDetails()
    }

    //MARK:- Webengine Delegate Methods
    //On recieving response successfully
    func connectionManagerDidRecieveResponse(pResultDict: NSDictionary)
    {
       print(pResultDict)
        ActivityIndicator.shared.stopAnimating()
        let weatherArray:NSArray = pResultDict.objectForKey("weather") as! NSArray
        for weatherDict in weatherArray
        {
            weatherHelper.weatherIcon = weatherDict.objectForKey("icon") as? String
            weatherHelper.weatherDescp = weatherDict.objectForKey("description") as? String
            
        }
        weatherHelper.humidity = pResultDict.objectForKey("main")?.objectForKey("humidity") as! Int
        weatherHelper.temp = pResultDict.objectForKey("wind")?.objectForKey("deg") as! Int
        weatherHelper.windSpeed = pResultDict.objectForKey("wind")?.objectForKey("speed") as! Int
        weatherHelper.cityName = pResultDict.objectForKey("name") as! String
        setWeatherDetails()
    }
    
    //On recieving error
    func connectionManagerDidFailWithError(error: NSError)
    {
        let alert = UIAlertController(title: "Oops!", message:error.localizedDescription + "please try again", preferredStyle:UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(self, animated: true, completion: nil)
    }
    
    //MARK:- Setting Weather Information, after Parsing data from API response
    func setWeatherDetails()
    {
        let todayDate = EMHelper.sharedInstance.FormatDate(NSDate())
        dateLabel.text = todayDate;
        weatherImage.image = EMHelper.sharedInstance.setWeatherImage(weatherHelper.weatherIcon)
        print(weatherHelper.weatherDescp)
        weatherCondition.text =  weatherHelper.weatherDescp
        let temparture = String(EMHelper.sharedInstance.convertToCelsius(weatherHelper.temp))
        //tempLabel.text = String(format:"Temp: %@°C",temparture)
    }

}

