//
//  UIKitViewModel.swift
//  TestTask2023
//
//  Created by JkPhTrue Just on 05.01.2023.
//

import Foundation
import Combine
import UIKit

protocol UIKitViewModel {
    var graphImage: AnyPublisher<UIImage?, Never> { get }
    var numberForSwiftUIView: AnyPublisher<Int, Never> { get }
    
    func loadFirstGraph()
    
    func increase()
    func reduce()
    func setNumber(number: Int)
    
    func openSwiftUIViewAction()
}

class UIKitViewModelImpl {
    private let imageLoader: ImageLoadService
    private var _graphImage = PassthroughSubject<UIImage?, Never>()
    private var _numberForSwiftUIView = PassthroughSubject<Int, Never>()
    
    private var currentNumber = 0 {
        didSet {
            loadGraph()
        }
    }
    
    init(imageLoader: ImageLoadService) {
        self.imageLoader = imageLoader
    }
}

//MARK: - UIKitViewModel
extension UIKitViewModelImpl: UIKitViewModel {
    var graphImage: AnyPublisher<UIImage?, Never> {
        _graphImage.eraseToAnyPublisher()
    }
    
    var numberForSwiftUIView: AnyPublisher<Int, Never> {
        _numberForSwiftUIView.eraseToAnyPublisher()
    }
    
    func loadFirstGraph() {
        loadGraph()
    }
    
    func increase() {
        if currentNumber < 180 {
            currentNumber += 1
        }
    }
    
    func reduce() {
        if currentNumber > 0 {
            currentNumber -= 1
        }
    }
    
    func setNumber(number: Int) {
        currentNumber = number
    }
    
    func openSwiftUIViewAction() {
        _numberForSwiftUIView.send(currentNumber)
    }
}

//MARK: - Load Images
private extension UIKitViewModelImpl {
    var urlString: String {
        return "https://job-server.net/images/padacura/score/\(currentNumber).png"
    }
    
    func loadGraph() {
        imageLoader.loadImage(urlString: urlString) { [weak self] image, error in
            self?._graphImage.send(image)
        }
    }
}
