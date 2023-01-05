//
//  UIKitViewController.swift
//  TestTask2023
//
//  Created by JkPhTrue Just on 05.01.2023.
//

import UIKit
import SwiftUI
import Combine

class UIKitViewController: UIViewController {

    var viewModel: UIKitViewModel?
    
    @IBOutlet private weak var graphImageView: UIImageView!
    @IBOutlet private var labelsForRotationCollection: [UILabel]!
    
    private var bag: [AnyCancellable] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        viewModel?.loadFirstGraph()
    }
}

//MARK: - Setup
private extension UIKitViewController {
    func setup() {
        setupNavigation()
        rotateLabels()
        bindViewModel()
    }
    
    func setupNavigation() {
        self.title = "UIKit"
    }
    
    func rotateLabels() {
        labelsForRotationCollection.forEach { label in
            label.transform = CGAffineTransform(rotationAngle: -(.pi / 2))
        }
    }
    
    func bindViewModel() {
        viewModel?.graphImage
            .assign(to: \.image, on: graphImageView)
            .store(in: &bag)
    }
}

//MARK: - Actions
extension UIKitViewController {
    @IBAction func tapOnGraphAction(_ sender: Any) {
        openSwiftUIView()
    }
    
    @IBAction func reduceAction(_ sender: Any) {
        viewModel?.reduce()
    }
    
    @IBAction func increaseAction(_ sender: Any) {
        viewModel?.increase()
    }
}

//MARK: - Navigate to SwiftUI View
private extension UIKitViewController {
    func openSwiftUIView() {
        
    }
}
