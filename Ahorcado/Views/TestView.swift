//
//  TestView.swift
//  Ahorcado
//
//  Created by Alejandro D on 21/11/20.
//

import SwiftUI

struct TestView: View {
    
    var body: some View {
        Text("New Game")
            .font(.system(size: 50))
            .padding()
            .foregroundColor(.black)
            .ignoresSafeArea(edges: .all)
            .onTapGesture {
            }
            .background(
                RoundedRectangle(cornerRadius: 25.0)
                    .foregroundColor(.none)
                    .border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
            )
    }
}



struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
