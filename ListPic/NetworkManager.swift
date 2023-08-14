//
//  NetworkManager.swift
//  ListPic
//
//  Created by man ching chan on 14/8/2023.
//

import Foundation


enum httpType{
    case post
    case get
}


class NetworkManager{
    
    
    static func getDataWithTypePostGet<T:Decodable>(url : String ,classtype : T.Type, httptype : httpType ,postparam : String? , completionHandler : @escaping (_ dataObject: Any , _ error:String?)->()){
        
        print("\(classtype)")
        
        
        // postparam e.g  aaa=bbbbvalue&ccc=ddddvalue
        
        
        guard let url = URL(string: url) else {return}
        
        var request = URLRequest(url:url,cachePolicy: .reloadIgnoringLocalCacheData)
        
        if (httptype == .post){
            
            request.httpMethod = "POST"
            
            print(postparam!)
            
            guard let postparam = postparam else {return}
            
            print("postparam \(postparam)")
            request.httpBody = postparam.data(using: .utf8)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                
                
                if let error = error{
                    
                    completionHandler("",error.localizedDescription)
                    return
                    
                }
                
                guard let data = data else {return}
                
               // print(data)
               // print(String(data: data, encoding: .utf8)!)
                
                guard let list = try? JSONDecoder().decode(classtype, from: data) else {
                    
                    return
                    
                }
                
                completionHandler(list,nil)
            }
            
            
            
        }
        .resume()
        
        
    }
    
    
}
