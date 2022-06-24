//
//  ViewController.swift
//  Race
//
//  Created by Volha Furs on 3.02.22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var onStartButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var resultsButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "First VC"
        view.backgroundColor = UIColor(hex: 0xF5FFFA)
        onStartButton.applyCornerRadius(radius: 30)
        onStartButton.applyShadow(shadowOpacity: 0.5, shadowRadius: 0.5, shadowOffset: .zero, shadowColor: UIColor.lightGray.cgColor)
        onStartButton.setTitle(NSLocalizedString("button.start", comment: ""), for: .normal)
        settingsButton.setTitle(NSLocalizedString("button.settings", comment: ""), for: .normal)
        resultsButton.setTitle((NSLocalizedString("button.results", comment: "")), for: .normal)
        }

    @IBAction func onSettingsButton(_ sender: Any) {
        transitToSettingsVC()
    }
    
    @IBAction func onResultsButton(_ sender: Any) {
        transitToResultsVC()
    }
    
    @IBAction func onStartButton(_ sender: Any) {
        transitToGameVC()
    }
    
    private func transitToGameVC() {
        let storyboard = UIStoryboard(name: "GameViewController", bundle: Bundle.main)
        let vc = storyboard.instantiateInitialViewController() as! GameViewController
        
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private func transitToSettingsVC() {
        let storyboards = UIStoryboard(name: "SettingsViewController", bundle: Bundle.main)
        let vc1 = storyboards.instantiateInitialViewController() as! SettingsViewController
        
        navigationController?.pushViewController(vc1, animated: true)
    }
    
    private func transitToResultsVC() {
        let storyboards = UIStoryboard(name: "ResultsViewController", bundle: Bundle.main)
        let vc2 = storyboards.instantiateInitialViewController() as! ResultsViewController
        
        navigationController?.pushViewController(vc2, animated: true)
    }
}

