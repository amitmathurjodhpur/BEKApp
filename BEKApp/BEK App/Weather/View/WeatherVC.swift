//
//  WeatherVC.swift
//  BEKApp
//
//  Created by Bhavik on 02/03/19.
//  Copyright © 2019 Bhavik. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController {
    
    @IBOutlet weak var lblToday: UILabel!
    @IBOutlet weak var lblTemperature: UILabel!
    @IBOutlet weak var lblTemperatureInfo: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginBtnAction(_ sender: UIButton) {
        let nextVC = DashboardVC.instantiate(fromAppStoryboard: .Dashboard)
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
extension WeatherVC {
    func getWeather(lat: String, long: String) {
        let APIUrl = NSURL(string:"https://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(long)&appid=e7b2054dc37b1f464d912c00dd309595&units=Metric")
        var request = URLRequest(url:APIUrl! as URL)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
            
            if (error != nil) {
                print(error ?? "Error is empty.")
            } else {
                let httpResponse = response as? HTTPURLResponse
                print(httpResponse ?? "HTTP response is empty.")
            }
            
            guard let responseData = data else {
                print("Error: did not receive data")
                return
            }
            
            do {
                
//                let weatherData = try JSONDecoder().decode(MyWeather.self, from: responseData)
//                let ggtemp = weatherData.main?.temp
//                print(ggtemp, "THIS IS THE TEMP")
//                DispatchQueue.main.async {
//                    tempDisplay.text = String (ggtemp) + " c"
//                }
                
            } catch  {
                print("error parsing response from POST on /todos")
                return
            }
            
        })
        
        dataTask.resume()
    }
}
