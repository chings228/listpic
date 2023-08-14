//
//  Model.swift
//  ListPic
//
//  Created by man ching chan on 14/8/2023.
//

import Foundation



struct Product : Codable,Identifiable{
    
    let id : Int
    let title : String
    let thumbnail : String
    let brand : String
    
    
    
}



struct Products : Codable{
    
    
    let products : [Product]
    
}
