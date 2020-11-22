//
//  StageViewModifier.swift
//  Ahorcado
//
//  Created by Alejandro D on 22/11/20.
//

import SwiftUI

struct StageView : ViewModifier {
    var geo : GeometryProxy
    var data : EnvObject
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
                .ignoresSafeArea(edges: .all)
            
            if data.stage != .inMenu {
                VStack{
                    HStack(alignment: .center, spacing: 0){
                        Image("BackButton").resizable()
                            .frame(width: 15, height: 15, alignment: .center)
                        Text("Back")
                            .font(.system(size: 15))
                        Spacer()
                    }
                    .foregroundColor(.black)
                    .onTapGesture {
                        
                        if data.stage == .inGame{
                            data.score = 0
                            data.lifes = 9
                        }
                        
                        withAnimation {
                            data.stage = .inMenu
                        }
                    }
                    .padding()
                    Spacer()
                }
            }
        }
    }
}
