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


enum NetworkManagerError : LocalizedError{
    
    
    case invalidResponse
    case invalidData
    case invalidURL
    case unknownError
    
    
    public var errorDescription: String{
        
        switch self{
        case .invalidURL :
            return "Invalid URL"
        case .invalidData :
            return "Invalid Data"
        
        case .invalidResponse :
            return "Invalid REsponse"
            
        default :
            return "Unknown Error"
            
        }
        
    }
    
    
}


class NetworkManager{
    
    
    
    static func getAsset(url:String, completionHandler : @escaping (_ data : Data)->()){
        
        guard let url = URL(string: url) else {return}
        
        let request = URLRequest(url: url,cachePolicy: .reloadIgnoringLocalCacheData)
        
        URLSession.shared.dataTask(with: request){ data ,response,error in
            
            guard let data = data else { return }
            
            
            completionHandler(data)
            
            
        }
        .resume()

        
    }
    
    
    
    
    static func getDataByAsync<T:Decodable>(url : String , classtype : T.Type) async throws -> Any{
        
        print(url)
        
        guard let url = URL(string: url) else {throw NetworkManagerError.invalidURL}
        
        
        do {
            
            let (data, response) =  try await URLSession.shared.data(from: url)
            
           
           
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw NetworkManagerError.invalidResponse
            }
            

            print(data)
            
            guard let list = try? JSONDecoder().decode(classtype, from: data) else {
                
                print("invalid data")
                throw NetworkManagerError.invalidData
            }
            
           
            
            return list
            
            
            
        }catch{
            print("DEBUG error \(error.localizedDescription)")
            throw NetworkManagerError.unknownError
        }
        
        
        
        
        
    }
    
    
    
    
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
                
                print(data)

                guard let list = try? JSONDecoder().decode(classtype, from: data) else {
                    
                    return
                    
                }
                
                completionHandler(list,nil)
            }
            
            
            
        }
        .resume()
        
        
    }
    
    
}
