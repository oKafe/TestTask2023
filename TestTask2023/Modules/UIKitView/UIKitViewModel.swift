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
    
    func loadFirstGraph()
    
    func increase()
    func reduce()
}

class UIKitViewModelImpl {
    private let imageLoader: ImageLoadService
    private var _graphImage = PassthroughSubject<UIImage?, Never>()
    private var currentNumber = 0
    
    init(imageLoader: ImageLoadService) {
        self.imageLoader = imageLoader
    }
    
    deinit {
        print("UUPS")
    }
}

//MARK: - UIKitViewModel
extension UIKitViewModelImpl: UIKitViewModel {
    var graphImage: AnyPublisher<UIImage?, Never> {
        _graphImage.eraseToAnyPublisher()
    }
    
    func loadFirstGraph() {
        loadGraph()
    }
    
    func increase() {
        if currentNumber < 180 {
            currentNumber += 1
            loadGraph()
        }
    }
    
    func reduce() {
        if currentNumber > 1 {
            currentNumber -= 1
            loadGraph()
        }
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
