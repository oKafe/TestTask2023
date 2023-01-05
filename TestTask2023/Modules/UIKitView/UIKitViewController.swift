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
    /*
     1. Тут гарно було б переходи зробити координатором чи рутером,
     але я порахував, що для одного переходу це ту мач
     2. На SwiftUI вюшці вирішив підгрузку картинки зробити з AsyncImage, бо не хотілось однакові моделі робити, хоча можна було заінжектити ImageLoader який вже є, тоді і кеш був би спільний
     */
    func openSwiftUIView(number: Int) {
        let swiftUIViewModel = SwiftUIViewModelImpl(number: number)
        
        swiftUIViewModel.numberForPreviousScreen
            .sink { [weak self] number in
                self?.viewModel?.setNumber(number: number)
            }
            .store(in: &bag)
            
        
        let view = SwiftUIView(viewModel: swiftUIViewModel)
        let hostingViewController = UIHostingController(rootView: view)
        
        navigationController?.pushViewController(hostingViewController, animated: true)
    }
}
