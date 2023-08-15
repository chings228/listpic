//
//  LocalFileManager.swift
//  ListPic
//
//  Created by man ching chan on 15/8/2023.
//

import Foundation
import SwiftUI



class LocalFileManager{
    
    
    static let instance = LocalFileManager()
    
    private init(){}
    
    
    static func saveAsset(asset : Data , filename : String , foldername : String){
        
        print("file \(filename) folder \(foldername)")
        
        guard let filepathUrl = getFilePath(folderName: foldername, filename: filename) else {return}
        
        print(filepathUrl)
        
        do{
            try asset.write(to: filepathUrl)
        }
        catch let error{
            print("error save \(error)")
        }
        
        
        
    }
    
    
     static func getFilePath(folderName : String , filename : String ) -> URL?{
        
        
        guard let folderURL = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        else{return nil}
        
        
        return folderURL.appendingPathComponent(filename)
        

        
        
    }
    
    
    
    
    
    
}
