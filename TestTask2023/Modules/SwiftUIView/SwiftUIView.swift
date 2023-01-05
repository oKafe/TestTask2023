//
//  SwiftUIView.swift
//  TestTask2023
//
//  Created by JkPhTrue Just on 05.01.2023.
//

import SwiftUI

struct SwiftUIView<T>: View where T: SwiftUIViewModel {
    
    @ObservedObject var viewModel: T
    
    private let heightMultiplier: CGFloat = 359 / 509
    
    var body: some View {
        GeometryReader { geometryProxy in
            
            let width = geometryProxy.size.width
            
            VStack {
                VStack(alignment: .trailing, spacing: 0) {
                    HStack(spacing: 0) {
                        LeftLabelsView()
                            .frame(width: width * 0.2)
                        
                        AsyncImage(url: URL(string: viewModel.graphImageUrlString)) { image in
                            image
                                .resizable(resizingMode: .stretch)
                                .aspectRatio(contentMode: .fill)
                        } placeholder: {
                            ProgressView()
                                .frame(width: width * 0.8)
                        }
                            
                    }
                    .frame(height: width * 0.8 * heightMultiplier)
                    
                    HStack {
                        Text("Hello World")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                            .padding(.leading, 8)
                        
                        Spacer()
                        
                        Text("Hello World")
                            .font(.system(size: 15, weight: .black))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Text("Hello World")
                            .font(.system(size: 15))
                            .foregroundColor(.white)
                            .padding(.trailing, 8)
                    }
                    .frame(width: width * 0.8, height: width * 0.1)
                    .background(Color(.grey))
                }
                
                Spacer()
                
                HStack(spacing: 16) {
                    Button("-") {
                        viewModel.reduce()
                    }
                    .frame(width: 35, height: 35)
                    .foregroundColor(.white)
                    .background(Color.blue.cornerRadius(4))
                    
                    Button("+") {
                        viewModel.increase()
                    }
                    .frame(width: 35, height: 35)
                    .foregroundColor(.white)
                    .background(Color.blue.cornerRadius(4))
                    
                }
            }
            .padding(.bottom, 24)
            .navigationTitle("SwiftUI")
            .onDisappear {
                viewModel.onDisapear()
            }
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView(viewModel: SwiftUIViewModelImpl(number: 130))
    }
}
