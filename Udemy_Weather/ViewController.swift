//
//  ViewController.swift
//  Udemy_Weather
//
//  Created by Abdulhakim Ajetunmobi on 24/08/2016.
//  Copyright © 2016 5to9 Studios. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var cityText: UITextField!
    
    @IBOutlet weak var forecastLabel: UILabel!
    
    var message = ""

    
    @IBAction func getForecast(_ sender: AnyObject) {
        
        if let city = cityText.text{
            if let url = URL(string: "http://www.weather-forecast.com/locations/\(city)/forecasts/latest") {
                
                let request = NSMutableURLRequest(url: url)
                
                let task = URLSession.shared.dataTask(with: request as URLRequest){
                    data, response, error in
                    
                    if error != nil{
                        print("error")
                        
                    }else{
                        
                        if let unwrappedData = data {
                            
                            let dataString = NSString(data: unwrappedData, encoding: String.Encoding.utf8.rawValue)
                            
                            var stringSeparator = "Weather Forecast Summary:</b><span class=\"read-more-small\"><span class=\"read-more-content\"> <span class=\"phrase\">"
                            
                            if let contentArray = dataString?.components(separatedBy: stringSeparator) {
                                
                                if contentArray.count > 1 {
                                    
                                    stringSeparator = "</span>"
                                    
                                    let newContentArray = contentArray[1].components(separatedBy: stringSeparator)
                                    
                                    if newContentArray.count > 1 {
                                        
                                        self.message = newContentArray[0]
                                        
                                        self.message = self.message.replacingOccurrences(of: "&deg;", with: "°")

                                        
                                        
                                    }
                                    
                                    
                                }
                                
                            }
                            
                        }
                    }
                    
                    
                    if self.message == "" {
                        
                        self.message = "Sorry, Try again"
                        
                    }
                    
                    DispatchQueue.main.sync(execute: {
                        
                        self.forecastLabel.text = self.message
                    })
                }
                
                task.resume()
                
            }
            
            
        
        }
        
        
        
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

