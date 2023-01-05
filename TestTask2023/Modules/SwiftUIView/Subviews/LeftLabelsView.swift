//
//  LeftLabelsView.swift
//  TestTask2023
//
//  Created by JkPhTrue Just on 05.01.2023.
//

import SwiftUI

struct LeftLabelsView: View {
    var body: some View {
        GeometryReader { geometryProxy in
            
            let height = geometryProxy.size.height
            
            HStack(spacing: 0) {
                
                ZStack {
                    Color(.grey)
                        
                    Text("Hello World")
                        .foregroundColor(.white)
                        .font(.system(size: 17, weight: .black))
                        .rotationEffect(Angle(degrees: -90))
                        .frame(width: height)
                }
                .frame(width: geometryProxy.size.width / 2)
                
                VStack(spacing: 0) {
                    RotatedTextWithColorBackground(color: Color(.cyan), text: "Hello World")
                        .frame(height: height * 0.28)
                    
                    RotatedTextWithColorBackground(color: Color(.cyanLight), text: "Hello World")
                        .frame(height: height * 0.26)
                    
                    RotatedTextWithColorBackground(color: Color(.greenLight), text: "Hello World")
                        .frame(height: height * 0.28)
                    
                    RotatedTextWithColorBackground(color: Color(.green), text: "Hello World")
                        .frame(height: height * 0.18)
                }
            }
            .clipped()
        }
    }
}

struct LeftLabelsView_Previews: PreviewProvider {
    static var previews: some View {
        LeftLabelsView()
    }
}
