//
//  ViewController.swift
//  Race
//
//  Created by Volha Furs on 3.02.22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var onStartButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "First VC"
        view.backgroundColor = UIColor(hex: 0xD0C11C)
        onStartButton.applyCornerRadius(radius: 30)
        onStartButton.applyShadow(shadowOpacity: 0.5, shadowRadius: 0.5, shadowOffset: .zero, shadowColor: UIColor.lightGray.cgColor)
        }


    @IBAction func onStartButton(_ sender: Any) {
        transitToGameVC()
    }
    
    private func transitToGameVC() {
        let storyboard = UIStoryboard(name: "GameViewController", bundle: Bundle.main)
        let vc = storyboard.instantiateInitialViewController() as! GameViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

