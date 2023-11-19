//
//  ViewController.swift
//  RESTAPIIntegration
//
//  Created by Swayam Patel on 18/11/23.
//

import UIKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //API Reference
        //https://dummy.restapiexample.com/
        
        //GET - This type of API is used to only get data from the backend
        //Example - General User List
        var getAPI = "https://dummy.restapiexample.com/api/v1/employees"
        
        self.restGetAPICallwithJSONSerialization(apiName: getAPI)
        
        //POST - This type of API is used to CRUD(create,read,update,delete) particular data
        //Example - Modifying a particular user's details
        
        var postAPI = "https://dummy.restapiexample.com/api/v1/create"
        self.restPostAPICallwithJSONSerialization(apiName: postAPI)
        // Do any additional setup after loading the view.
    }
    
    //MARK: - GET API Call
    func restGetAPICallwithJSONSerialization(apiName: String){
        if let url = URL(string: apiName){
            //Step 1: Create a request with the choice of url
            var request = URLRequest(url: url)
            
            //Step 2: Setting the HTTP METHOD
            request.httpMethod = "GET"
            
            //Step 3: Create a URL Session
            let session = URLSession.shared
            
            //Step 4: Creating a task for parsing the request
            let task = session.dataTask(with: request) { (data, response, error) in
                
                //Step 5: if let casing to prevent crashes if there data = nil
                if let data = data {
                    do {
                        let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                        
                        //Step 6: Accessing the data by unwrapping the JSON object
                        //NOTE: The unwrapping of the API Response will differ from API to API
                        if let json = jsonObject as? [String:Any] {
                            print(json)
                            if let success = json["status"] as? String {
                                
                                //Step 7: Success of the API Call is checked. It can have value "yes",200 (status code), etc...
                                if success == "success" {
                                    
                                    //Step 8: Access the data
                                    if let dict = json["data"] as? [[String:Any]] {
                                        print(dict)
                                        //Other code...
                                    }
                                } else {
                                    //The API Call returned an error or other status
                                }
                            } else {
                                // The success key of the API is not properly unwrapped i.e. not the given data type or is not present in the API Call
                            }
                        } else {
                            // The JSON Object is not properly unwrapped i.e. not the given data type
                        }
                    }
                } else {
                    //Show alert that something went wrong or even error
                    //if let casing to prevent crashes if data is not properly decoded
                    if let error = error {
                        //Show alert
                    }
                }
            }
            
            //Resumes the datatask if it is suspended i.e. it is the API Call
            task.resume()

        } else {
            print("Invalid API URL")
        }
    }
    
    
    //MARK: - POST API Call
    func restPostAPICallwithJSONSerialization(apiName: String){
        if let url = URL(string: apiName){
            //Step 1: Create a request with the choice of url
            var request = URLRequest(url: url)
            
            //Step 2: Setting the HTTP METHOD
            request.httpMethod = "POST"

            //Step 2.1: Setting the headers
            //These will change from server to server
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")

            //Step 3: Setting the parameters to be sent
            let parameters: [String: Any] = ["name":"test","salary":"123","age":"23"]
            
            do {
                // convert parameters to Data and assign dictionary to httpBody of request
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .withoutEscapingSlashes)
            } catch let error {
                print(error.localizedDescription)
                
            }

            //Step 4: Create a URL Session
            let session = URLSession.shared
            
            //Step 5: Creating a task for parsing the request
            let task = session.dataTask(with: request) { (data, response, error) in
                
                //Step 6: if let casing to prevent crashes if there data = nil
                if let data = data {
                    do {
                        let jsonObject = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                        
                        //Step 7: Accessing the data by unwrapping the JSON object
                        //NOTE: The unwrapping of the API Response will differ from API to API
                        if let json = jsonObject as? [String:Any] {
                            print(json)
                            if let success = json["status"] as? String {
                                
                                //Step 8: Success of the API Call is checked. It can have value "yes",200 (status code), etc...
                                if success == "success" {
                                    //The API Call was a success and perform any function here that are required after the success
                                } else {
                                    //The API Call returned an error or other status
                                }
                            } else {
                                // The success key of the API is not properly unwrapped i.e. not the given data type or is not present in the API Call
                            }
                        } else {
                            // The JSON Object is not properly unwrapped i.e. not the given data type
                        }
                    }
                } else {
                    //Show alert that something went wrong or even error
                    //if let casing to prevent crashes if data is not properly decoded
                    if let error = error {
                        //Show alert
                        print(error.localizedDescription)
                    }
                }
            }
            
            //Resumes the datatask if it is suspended i.e. it is the API Call
            task.resume()

        } else {
            print("Invalid API URL")
        }
    }

}

