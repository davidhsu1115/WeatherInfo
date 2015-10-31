//
//  ViewController.swift
//  WeatherInfo
//
//  Created by fangwiehsu on 2015/10/26.
//  Copyright © 2015年 fangwiehsu. All rights reserved.
//

import UIKit

//用WeatherServiceDelegate 才可以在不同class中進行互相資料的傳遞
class ViewController: UIViewController, WeatherServiceDelegate {
    
    
    //WeatherService class
    let weatherService = WeatherService()
    
    
    
    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var maxTemperatureLabel: UILabel!
    @IBOutlet weak var minTemperatureLabel: UILabel!
    //@IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    
    //button to set the city and the location
    @IBAction func btnSetCity(sender: UIButton) {
        print("City setting button tapped !!")
        
        openCityAlert()
        
    }
    

    
    func openCityAlert(){
        
        //Create the AlertAction
        let alert = UIAlertController(title: "City", message: "Enter the City Name", preferredStyle: .Alert)
        
        
        //Create the cancel action
        let cancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        alert.addAction(cancel)
        
        
        //Create the ok action
        let ok = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { (action:UIAlertAction) -> Void in
            
            print("OK")
            
            //獲取在placeholder中的第一個項目  由於placeholder 內只有一個項目 所以就是我們所輸入的city name
            let textField = alert.textFields?[0]
            //print(textField?.text!)
            
            //show the cityName in the cityLabel
            //self.cityLabel.text = textField?.text!
            let cityName = textField?.text
            self.weatherService.getWeather(cityName!)
        }
        alert.addAction(ok)
        
        //Add TextField to the Alert Controller
        alert.addTextFieldWithConfigurationHandler { (textField:UITextField) -> Void in
            
            textField.placeholder = "City Name"
        }
        
        //Present the Alert Controller
        self.presentViewController(alert, animated: true, completion: nil)
        
    }
    
    
    
    // MARK: - Weather Service Delegate  需要將WeatherServiceDelegate 裡面的 func implement 上面才不會有error message!
    func setWeather(weather: Weather) {
        print("*** Set Weather")
        print("City: \(weather.cityName)  Temperature: \(weather.temp)  Description: \(weather.description)")
        
        //cityLabel.text = weather.cityName
        tempLabel.text = "\(weather.temp - 273) °C"
        descriptionLabel.text = weather.description
        
        imageIcon.image = UIImage(named: weather.icon)
        minTemperatureLabel.text = "\(weather.minTemp - 273) °C"
        maxTemperatureLabel.text = "\(weather.maxTemp - 273) °C"
        
        cityButton.setTitle(weather.cityName, forState: UIControlState.Normal)
        //(UIButton.setTitle(weather.cityName, forState: .Normal))
    }
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //assign the delegate property from weatherService to this viewController
        self.weatherService.delegate = self
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

