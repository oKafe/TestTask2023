//
//  RotatedTextWithColorBackground.swift
//  TestTask2023
//
//  Created by JkPhTrue Just on 05.01.2023.
//

import SwiftUI

struct RotatedTextWithColorBackground: View {
    
    var color: Color
    var text: String
    
    var body: some View {
        GeometryReader { geometryProxy in
            ZStack {
                color
                Text(text)
                    .font(.system(size: 6))
                    .rotationEffect(Angle(degrees: -90))
            }
        }
    }
}

struct RotatedTextWithColorBackground_Previews: PreviewProvider {
    static var previews: some View {
        RotatedTextWithColorBackground(color: .blue, text: "Hello World")
    }
}
