//
//  RowView.swift
//  ListPic
//
//  Created by man ching chan on 14/8/2023.
//

import SwiftUI

struct RowView: View {
    
    @StateObject  var vm = ImageViewModel()
    
    
    var product : Product
    
    
    var body: some View {
        
        
        HStack{
            
            
            //AsyncImagePic
            
            DownloadDataPic
            

            Spacer()
            
            Text(product.brand)
            
        }
        .padding()

        
        
       
    }
}

struct RowView_Previews: PreviewProvider {
    
    
    
    static var previews: some View {
        
        let product = Product(id: 1, title: "iPhone 9", thumbnail: "https://i.dummyjson.com/data/products/1/thumbnail.jpg", brand: "Apple")
        
        
        RowView(product: product)
    }
}


extension RowView{
    
    private var DownloadDataPic : some View{
        
        HStack{
            
            
            //Image(systemName: "square.and.arrow.down.fill")
            
            if let uiimage = vm.thumbnailimage{
                Image(uiImage:uiimage)
                    .resizable()
                    .scaledToFit()
                
            }
            else{
                Image(systemName: "square.and.arrow.down.fill")
                    .resizable()
                    .scaledToFit()
            }

            
        }
        .onAppear{
            vm.getImageByData(url: product.thumbnail)
        }
        
        
    }
    
    
    
    
    private var AsyncImagePic : some View{
        
        
        HStack{
            
            
            
            if (ImageViewModel.checkImageExist(url: product.thumbnail, folder: "product")){
                
                
                
            }
            else{
                
                if let url = URL(string: product.thumbnail){
                    
                    AsyncImage(url: url) { phase in
                        
                        switch phase {
                            
                        case .empty:
                            ProgressView()
                            
                        case .success(let image):
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(Circle())
                                .transition(.slide)
                            
                        case .failure(_):
                            Image(systemName: "exclamationamrk.icloud")
                                .resizable()
                                .scaledToFit()
                            
                            
                        @unknown default:
                            Image(systemName: "exclamationamrk.icloud")
                                .resizable()
                                .scaledToFit()
                            
                            
                        }
                        
                        
                    }
                    .frame(width:80,height:80)
                    .cornerRadius(20)
                    
                    
                }
                
                
                
                
            }
            
            
        }
        
        
    }
    
    
}
