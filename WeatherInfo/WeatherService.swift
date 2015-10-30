//
//  WeatherService.swift
//  WeatherInfo
//
//  Created by fangwiehsu on 2015/10/29.
//  Copyright © 2015年 fangwiehsu. All rights reserved.
//

import Foundation

protocol WeatherServiceDelegate{
    
    //用struct 把資料打包然後傳入setWeather
    func setWeather(weather:Weather)
}

class WeatherService{

    //用delegate才可以把資料給到ViewController裡面  作關連性 設定為optional 因為可能有值也可能nil
    var delegate: WeatherServiceDelegate?
    
    
    func getWeather(city:String){
        
        //需要把空白鍵也轉成網址可以支援的字元
        let cityEscaped = city.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLHostAllowedCharacterSet())
        
        
        let path = "http://api.openweathermap.org/data/2.5/weather?q=\(cityEscaped!)&appid=8a49046459d314dde6f920c401203b9c"
        let url = NSURL(string: path)
        //session connect to the internet and ask for data and exchanges the data from the service on the internet
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithURL(url!) { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            
            //print(">>>> \(data)")
            
            //start using SwiftyJSON
            let json = JSON(data: data!)
            let lon = json["coord"]["lon"].double
            let lat = json["coord"]["lat"].double
            let temp = json["main"]["temp"].double
            let name = json["name"].string
            //openweathermap裡面 放description的weather目錄是array
            let desc  = json["weather"][0]["description"].string
            let icon = json["weather"][0]["icon"].string
            let maxTemperature = json["main"]["temp_max"].double
            let mintemperature = json["main"]["temp_min"].double
            
            let weather = Weather(cityName: name!, temp: temp!, description: desc!, icon:icon!, maxTemp: maxTemperature!, minTemp: mintemperature!)
            
            //the reason we need the "self" it's because we are inside the task block now so Xcode does't know who own's the delegate
            if self.delegate != nil{
                
    //we need to change back to the main thread , if we don't run on the main thread the interface on the main story board won't change!!
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    
                    //put self delegate inside the block
                    self.delegate?.setWeather(weather)

                    
                })
                
                
                
            }

            print("longitude: \(lon!)  latitude: \(lat!)  temperature: \(temp!)")
            
            
            
        }
        
        //need resume unless the task won't start
        task.resume()
        
        
        
        // the following code is to test the data transfer correctly
        //print("Weather Service city Name \(city)")
        
        //request weather data
        //wait...
        //process data
       /*
        let weather = Weather(cityName: city, temp: 23.5, description: "a nice day")
        
        if delegate != nil{
            delegate?.setWeather(weather)
        }
        
     */
        
    }
    
    
    
}