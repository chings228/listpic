//
//  ImageViewModel.swift
//  ListPic
//
//  Created by man ching chan on 15/8/2023.
//

import Foundation
import SwiftUI


enum ImageError : Error{
    
    case InvalidURL
    case InvalidFileName
    
    
}


class ImageViewModel : ObservableObject{
    
    
    @Published var thumbnailimage : UIImage?
    
    
    
    
    static func checkImageExist(url : String ,folder : String)  -> Bool {
        
        
        guard  let url = URL(string: url) else {
            return false
            
        }
        
        
        let prefix = url.pathComponents[3]
        let suffix = url.lastPathComponent

        let filename = "\(prefix)-\(suffix)"

        print(url)
        print(filename)
        print(url.pathComponents)
        

        
        return false
        
    }
    
    
    
    private func getFileName(url:String)->String{
        
        
       var filename = "";
        
        guard  let url = URL(string: url) else {
            return ""
            
        }
        
        
        
        
        let prefix = url.pathComponents[3]
        let suffix = url.lastPathComponent

        filename = "\(prefix)-\(suffix)"
        
        
        return filename
    }
    
    
     func getImageByData(url:String){
        
     
         
         let filename = getFileName(url: url)
         
         print(filename)
        
        NetworkManager.getAsset(url: url) {[weak self] data in
            
            guard let image = UIImage(data: data) else {return}
            
            print(image)
            
            DispatchQueue.main.async {


                print("download iamge \(url)")
                self?.thumbnailimage = image
                
                LocalFileManager.saveAsset(asset: data, filename: filename, foldername: "product")
            }
            
            
            
            
            
        }
            
            
        
        
        
        
        
    }
    
    
    
    
    
    
}
