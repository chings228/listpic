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
        
        NavigationView {
        VStack {
            
            

          
                List{
                    ForEach(vm.dataList){ product in
                        
                        HStack{
                            
                            RowView(product:product)
                        }
                        .frame(height:80)
                        

                    }

                    
                }
                .background(Color.white)
                .scrollContentBackground(.hidden)
                .navigationTitle("Brand Product")
            }
        
            
            


        }
      
//        .padding()
        .ignoresSafeArea()
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
