//
//  ViewController.swift
//  ChainAnimation
//
//  Created by Denis Evdokimov on 11/8/23.
//

import UIKit

class ViewController: UIViewController {
    
    
    private lazy var squareView: UIView = {
        let view = UIImageView()
        view.backgroundColor = .green
        view.layer.cornerRadius = 8
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var slider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.thumbTintColor = .red
        slider.minimumTrackTintColor = .systemRed
        slider.maximumTrackTintColor = .systemGray3
        slider.minimumValue = 0.0
        slider.maximumValue = 1.0
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        slider.addTarget(self, action: #selector(sliderTouchUp), for: [.touchUpInside, .touchUpOutside])
        return slider
    }()
    
    let rotation: CGFloat = .pi / 2
    let height: CGFloat = 60
    let hInset: CGFloat = 16
  
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(squareView)
        view.addSubview(slider)
        layuotSlider()
        layotSquareView()
        
    }
    
    private func layotSquareView() {
        NSLayoutConstraint.activate([
            squareView.topAnchor.constraint(equalTo: view.topAnchor, constant: 80),
            squareView.heightAnchor.constraint(equalToConstant: height),
            squareView.widthAnchor.constraint(equalToConstant: height),
            squareView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: hInset)
        ])
    }
    
    private func layuotSlider() {
        NSLayoutConstraint.activate([
            slider.topAnchor.constraint(equalTo: view.topAnchor, constant: 100 + height + hInset),
            slider.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: hInset),
            slider.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -hInset)
        ])
    }
    
    
    @objc func sliderValueChanged() {
        let currentTransform = CGFloat(slider.value * slider.maximumValue)
        let rotation = CGAffineTransform(rotationAngle: currentTransform * rotation)
        let transform = rotation.scaledBy(x: currentTransform * 0.5 + 1.0,
                                          y: currentTransform * 0.5 + 1.0)
        squareView.transform = transform
        
        let minX = hInset + squareView.frame.width / 2
        let maxX = view.frame.width - hInset - squareView.frame.width / 2
        squareView.center.x = minX + (maxX - minX) * CGFloat(slider.value)
        
    }
    
    @objc func sliderTouchUp() {
        if slider.value > 0.0 {
            UIView.animate(withDuration: 0.3) {
                self.slider.setValue(1.0, animated: true)
                self.sliderValueChanged()
            }
        }
    }
}

