//
//  SwiftUIViewModel.swift
//  TestTask2023
//
//  Created by JkPhTrue Just on 05.01.2023.
//

import Foundation
import Combine

@MainActor protocol SwiftUIViewModel: ObservableObject {
    var graphImageUrlString: String { get }
    var numberForPreviousScreen: AnyPublisher<Int, Never> { get }
    
    func reduce()
    func increase()
    func onDisapear()
}


class SwiftUIViewModelImpl {
    @Published private var _graphImageUrlString: String = ""
    
    private var _numberForPreviousScreen = PassthroughSubject<Int, Never>()
    private var currentNumber: Int
    
    init(number: Int) {
        self.currentNumber = number
        self._graphImageUrlString =  urlString
    }
    
    deinit {
        print("lol")
    }
}


extension SwiftUIViewModelImpl: SwiftUIViewModel {
    var graphImageUrlString: String {
        _graphImageUrlString
    }
    
    var numberForPreviousScreen: AnyPublisher<Int, Never> {
        _numberForPreviousScreen.eraseToAnyPublisher()
    }
    
    func reduce() {
        if currentNumber > 1 {
            currentNumber -= 1
            _graphImageUrlString =  urlString
        }
    }
    
    func increase() {
        if currentNumber < 180 {
            currentNumber += 1
            _graphImageUrlString =  urlString
        }
    }
    
    func onDisapear() {
        _numberForPreviousScreen.send(currentNumber)
        _numberForPreviousScreen.send(completion: .finished)
    }
}

private extension SwiftUIViewModelImpl {
    var urlString: String {
        return "https://job-server.net/images/padacura/score/\(currentNumber).png"
    }
}
