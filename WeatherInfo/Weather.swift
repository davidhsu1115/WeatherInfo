//
//  Weather.swift
//  WeatherInfo
//
//  Created by fangwiehsu on 2015/10/29.
//  Copyright © 2015年 fangwiehsu. All rights reserved.
//

import Foundation

// use struct to carry the data from the internet to the View Controller
struct Weather{
    
    let cityName: String
    let temp: Double
    let description: String
    let icon: String
    let maxTemp: Double
    let minTemp: Double
    
    init(cityName:String, temp:Double, description:String, icon:String ,maxTemp:Double, minTemp:Double){
        self.cityName = cityName
        self.temp = temp
        self.description = description
        self.icon = icon
        self.maxTemp = maxTemp
        self.minTemp = minTemp
    }
    
}