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
    
    private var tapOnGraphRecognizer: UITapGestureRecognizer!
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
        setupTapRecognizer()
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
    
    func setupTapRecognizer() {
        tapOnGraphRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapOnGraphAction))
        graphImageView.addGestureRecognizer(tapOnGraphRecognizer)
        graphImageView.isUserInteractionEnabled = true
    }
    
    func bindViewModel() {
        viewModel?.graphImage
            .assign(to: \.image, on: graphImageView)
            .store(in: &bag)
        
        viewModel?.numberForSwiftUIView
            .sink(receiveValue: { [weak self] number in
                self?.openSwiftUIView(number: number)
            })
            .store(in: &bag)
    }
}

//MARK: - Actions
extension UIKitViewController {
    @objc func tapOnGraphAction() {
        viewModel?.openSwiftUIViewAction()
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
    func openSwiftUIView(number: Int) {
        let viewModel = SwiftUIViewModelImpl(number: number)
        viewModel.numberForPreviousScreen
            .sink { [weak self] number in
                self?.viewModel?.setNumber(number: number)
            }
            .store(in: &bag)
            
        
        let view = SwiftUIView(viewModel: viewModel)
        let hostingViewController = UIHostingController(rootView: view)
        
        navigationController?.pushViewController(hostingViewController, animated: true)
    }
}
