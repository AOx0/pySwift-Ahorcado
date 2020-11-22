//
//  GameView.swift
//  Ahorcado
//
//  Created by Alejandro D on 18/11/20.
//

import SwiftUI

struct GameView: View {
    @EnvironmentObject var data : EnvObject
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack (alignment: .center) {
                    Text("\(data.displayedWord)")
                        .foregroundColor(.black)
                        .font(.system(size: geo.size.height > geo.size.width ? geo.size.width * 0.2: geo.size.height * 0.2))
                    TextField("", text: $data.letter)
                        .multilineTextAlignment(.center)
                        .frame(width: geo.size.width/4, alignment: .center)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
            .frame(width: geo.size.width, height: geo.size.height, alignment: .center)
            .ignoresSafeArea(edges: .all)
        }

    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
    }
}
