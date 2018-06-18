//
//  PopOverVC.swift
//  Demo
//
//  Created by Admin on 10.03.18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit
class PopOverVC: UIViewController,UIScrollViewDelegate {
    
   
    let popOverScrollView = UIScrollView()
    
    var button:UIButton?
    var priceOptions:[PriceOption] = []
    
    @objc fileprivate func actionForRetunToParentVC(sender: Any) {
        removeAnimate()
    }
    @objc fileprivate func unwindAction(sender: UIButton) {
        performSegue(withIdentifier: "unwindSrgueFromPopOverVC", sender: sender)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        popOverScrollView.backgroundColor = .white
        popOverScrollView.delegate = self
        view.addSubview(popOverScrollView)
        
        popOverScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addConstraint(NSLayoutConstraint(item: popOverScrollView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .topMargin, multiplier: 1, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: popOverScrollView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1, constant: 10))
        view.addConstraint(NSLayoutConstraint(item: view, attribute: .right, relatedBy: .equal, toItem: popOverScrollView, attribute: .right, multiplier: 1, constant: 10))
        
        for option in priceOptions {
            let button1 = UIButton()
            popOverScrollView.addSubview(button1)
            let split = option.duration.split(separator: ".")
            var durationDays = "0"
            if split.count > 1 {
                durationDays = String(split[0])
            }
            button1.setTitle("\(option.customerPrice) - \(durationDays) дней", for: .normal)
            createButtonOptions(button1)
            if let button = button {
                popOverScrollView.addConstraint(NSLayoutConstraint(item: button1, attribute: .top, relatedBy: .equal, toItem: button, attribute: .bottom, multiplier: 1, constant: 5))
            } else {
                popOverScrollView.addConstraint(NSLayoutConstraint(item: button1, attribute: .top, relatedBy: .equal, toItem: popOverScrollView, attribute: .top, multiplier: 1, constant: 5))
            }
            button1.addTarget(self, action: #selector(unwindAction(sender:)), for: .touchUpInside)
            button = button1
        }
        
        let cancelButton = UIButton()
        popOverScrollView.addSubview(cancelButton)
        createButtonOptions(cancelButton)
        cancelButton.setTitle("cancel", for: .normal)
        if let button = button {
            popOverScrollView.addConstraint(NSLayoutConstraint(item: cancelButton, attribute: .top, relatedBy: .equal, toItem: button, attribute: .bottom, multiplier: 1, constant: 5))
        } else {
            popOverScrollView.addConstraint(NSLayoutConstraint(item: cancelButton, attribute: .top, relatedBy: .equal, toItem: popOverScrollView, attribute: .top, multiplier: 1, constant: 5))
        }
        popOverScrollView.addConstraint(NSLayoutConstraint(item: popOverScrollView, attribute: .bottom, relatedBy: .equal, toItem: cancelButton, attribute: .bottom, multiplier: 1, constant: 5))
        
        if CGFloat((priceOptions.count+1)*45) > view.frame.height {
            view.addConstraint(NSLayoutConstraint(item: popOverScrollView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 10))
        } else {
            popOverScrollView.heightAnchor.constraint(equalToConstant: CGFloat((priceOptions.count+1)*40)).isActive = true
        }
        cancelButton.addTarget(self, action: #selector(actionForRetunToParentVC(sender:)), for: .touchUpInside)
        view.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(actionForRetunToParentVC(sender:))))
        
        showAnimate()
        
    }
    
    fileprivate func createButtonOptions(_ button: UIButton) {
        button.layer.cornerRadius = 5
        button.layer.borderWidth = 0.5
        button.layer.borderColor = UIColor.blue.cgColor
        button.clipsToBounds = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitleColor(.blue, for: .normal)
       popOverScrollView.addConstraint(NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: popOverScrollView, attribute: .left, multiplier: 1, constant: 10))
        popOverScrollView.addConstraint(NSLayoutConstraint(item: popOverScrollView, attribute: .right, relatedBy: .equal, toItem: button, attribute: .right, multiplier: 1, constant: 10))
    }
    func showAnimate() {
        self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
        self.view.alpha = 0.0;
        UIView.animate(withDuration: 0.25, animations: {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
        })
    }
    func removeAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1.3, y: 1.3)
            self.view.alpha = 0.0;
            
        }, completion:{(finished : Bool)  in
            guard finished else { return }
            self.view.removeFromSuperview()
        })
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? EtalonVC else { return }
        guard let sender = sender as? UIButton else { return }
        guard let title = sender.currentTitle else { return }
        let split = title.split(separator: " ")
        guard let price = Double(split[0]) else { return }
        removeAnimate()
        destination.currentPrice = price
        destination.currentDate = String(split[2])
    }
    
}
