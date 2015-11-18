//
//  webEngine.swift
//  NSURLSessionEngine
//
//  Created by Ravindra Kishan on 18/11/15.
//  Copyright © 2015 Ravindra Kishan. All rights reserved.
//

import UIKit

//Delegate Protocol Methods
protocol WebEngineDelegate :NSObjectProtocol
{
    func connectionManagerDidRecieveResponse(pResultDict: NSDictionary)
    func connectionManagerDidFailWithError(error:NSError)
}

class webEngine: NSObject,NSURLSessionDelegate,NSURLSessionDataDelegate,NSURLSessionTaskDelegate
{
    weak var delegate:WebEngineDelegate?
    var m_cReceivedData = NSMutableData()
    
    //Singleton class Instance
    class var sharedInstance : webEngine
    {
        struct Static
        {
            static let instance : webEngine = webEngine()
        }
        return Static.instance
    }
    
    //MARK:- getting mysore weather details
    //http://openweathermap.org/api
    func getMysoreWeatherDetails()
    {
        let path:String = "http://api.openweathermap.org/data/2.5/weather?q=Mysore,IN&appid=89b7cd685da5329dc5e2967c9ba78eba"
        let urlPath: String = path
        let url: NSURL = NSURL(string: urlPath)!
        let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: configuration,delegate: self,
            delegateQueue:NSOperationQueue.mainQueue())
       let task = session.dataTaskWithRequest(request)
        task.resume()

    }
    
   //MARK:- NSURLSession Delegate Method
   func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveResponse response: NSURLResponse, completionHandler: (NSURLSessionResponseDisposition) -> Void)
    {
        completionHandler(NSURLSessionResponseDisposition.Allow)
        print("Recieved response")
        var statusCode:Int
        m_cReceivedData.length = 0
        let httpReponse:NSHTTPURLResponse = response as! NSHTTPURLResponse
        statusCode = httpReponse.statusCode
        print(statusCode)
    }
    
    //Handling recieved data and converting data into object using JSON serialization
    func URLSession(session: NSURLSession, dataTask: NSURLSessionDataTask, didReceiveData data: NSData)
    {
        m_cReceivedData.appendData(data)
        print(m_cReceivedData)
        
        let dataAsString: NSString = NSString(data:m_cReceivedData, encoding: NSUTF8StringEncoding)!
        print(dataAsString)
        // Convert the retrieved data in to an object through JSON deserialization
        let jsonResult: NSDictionary = (try? NSJSONSerialization.JSONObjectWithData(m_cReceivedData, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary!
        
        if delegate != nil
        {
            if (delegate?.respondsToSelector("connectionManagerDidRecieveResponse:") != nil)
            {
                delegate!.connectionManagerDidRecieveResponse(jsonResult)
            }
                
            else
            {
                print("Received data nil when converted to NSString")
                
            }
            
        }
    }
    
    //Handling Error Connection
    func URLSession(session: NSURLSession, task: NSURLSessionTask, didCompleteWithError error: NSError?)
    {
        print("Connection failed.\(error?.localizedDescription)")
        
        if delegate != nil
        {
            if (delegate?.respondsToSelector("connectionManagerDidFailWithError:") != nil)
            {
                if error == nil
                {
                    print("No connection failure")
                }
                else
                {
                    delegate!.connectionManagerDidFailWithError(error!)
                }
            }
        }
    }
    
}
