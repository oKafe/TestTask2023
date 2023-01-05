//
//  RotatedTextWithColorBackground.swift
//  TestTask2023
//
//  Created by JkPhTrue Just on 05.01.2023.
//

import SwiftUI

struct RotatedTextWithColorBackground: View {
    
    var color: Color
    
    var body: some View {
        GeometryReader { geometryProxy in
            ZStack {
                color
                Text("Hello Word")
                    .font(.system(size: 7))
                    .frame(width: geometryProxy.size.width)
                    .rotationEffect(Angle(degrees: -90))
            }
        }
    }
}

struct RotatedTextWithColorBackground_Previews: PreviewProvider {
    static var previews: some View {
        RotatedTextWithColorBackground(color: .blue)
    }
}
