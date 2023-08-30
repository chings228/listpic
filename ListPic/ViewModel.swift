//
//  ViewModel.swift
//  ListPic
//
//  Created by man ching chan on 14/8/2023.
//

import Foundation

@MainActor

class ViewModel : ObservableObject{
    
    
    @Published var dataList : [Product] = []
    

    
    let url = "https://dummyjson.com/products"
    

    
    
    func getProductList(){
        
        
        NetworkManager.getDataWithTypePostGet(url: url, classtype: Products.self, httptype: .get, postparam: nil) { [weak self] dataObject, error in
            
            
            if let error = error {
                print(error)
                return
            }

                
            guard let list  = dataObject as? Products else {return}
            
            print("list list ")
            self?.dataList = list.products
            
            guard let first = list.products.first else {return}
            
            print(first)
            
            
            
        }

        
    }
    
    
    func getProductListByAsync() async{
        
        do{
            
            let result =  try await  NetworkManager.getDataByAsync(url: url, classtype: Products.self)
            
            
            guard let list = result as? Products else {return}
            
            self.dataList = list.products
            
        }
        catch{
            
            print("DEBUG \(error.localizedDescription)")
        }
        
    }

    
    
}
