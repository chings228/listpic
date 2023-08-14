//
//  ContentView.swift
//  ListPic
//
//  Created by man ching chan on 13/8/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var vm = ViewModel()
    
    
    var body: some View {
        VStack {

            
            List{
                ForEach(vm.dataList){ data in
                    
                    
                    Text(data.title)
                        .font(.title)
                        .bold()
                    
                    
                    
                }
            }
            
            
            
        }
        .padding()
        .task {
            vm.getProductList()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
