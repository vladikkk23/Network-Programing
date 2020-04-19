//
//  BottomView.swift
//  GoRestAPIwithProxy
//
//  Created by vladikkk on 19/04/2020.
//  Copyright © 2020 PR. All rights reserved.
//

import SwiftUI

struct BottomView: View {
    var body: some View {
        HStack{
             Button(action: {}){
                 Image(systemName: "house")
                 .resizable()
                 .frame(width: 30, height: 30)
             }.padding()
             
             Spacer()
             
             Button(action: {}){
                 Image(systemName: "person")
                 .resizable()
                 .frame(width: 30, height: 30)
             }.padding()
             
             Spacer()
             
             Button(action: {}){
                 Image(systemName: "plus")
                 .resizable()
                 .frame(width: 30, height: 30)
             }.padding()
             
             Spacer()
             
             Button(action: {}){
                 Image(systemName: "heart")
                 .resizable()
                 .frame(width: 30, height: 30)
             }.padding()
             
             Spacer()
             
             Button(action: {}){
                 Image(systemName: "person.fill")
                 .resizable()
                 .frame(width: 30, height: 30)
             }.padding()
        }.frame(height: 35)
    }
}

struct BottomView_Previews: PreviewProvider {
    static var previews: some View {
        BottomView()
    }
}
