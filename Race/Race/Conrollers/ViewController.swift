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
    @IBOutlet weak var startImageView: UIImageView!
    @IBOutlet weak var starImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "STAR RACE"
        view.backgroundColor = .black
        setUpButtons()
        }

    private func setUpButtons() {
        let startImageSize: CGFloat = view.bounds.width - 100
        let startButtonWidth: CGFloat = view.bounds.width - 50
        let startButtonHeight: CGFloat = 50
        let settingsButtonWidth: CGFloat = startButtonWidth / 2.1
        
        startImageView.frame = CGRect(x: (view.bounds.width - startImageSize) / 2,
                                      y: (view.bounds.height - startImageSize) / 2,
                                      width: startImageSize,
                                      height: startImageSize)
        
        starImageView.frame = startImageView.frame.offsetBy(dx: 0, dy: -startImageSize)
        starImageView.frame.size = CGSize(width: settingsButtonWidth, height: settingsButtonWidth)
        
        onStartButton.applyShadow(shadowOpacity: 0.5, shadowRadius: 0.5, shadowOffset: .zero, shadowColor: UIColor.lightGray.cgColor)
        onStartButton.setTitle(NSLocalizedString("button.start", comment: ""), for: .normal)
        onStartButton.applyCornerRadius(radius: 20)
        onStartButton.frame = startImageView.frame.offsetBy(dx: -((startButtonWidth - startImageSize) / 2),
                                                            dy: startImageSize + startButtonHeight)
        onStartButton.frame.size = CGSize(width: startButtonWidth,
                                          height: startButtonHeight)

        settingsButton.setTitle(NSLocalizedString("button.settings", comment: ""), for: .normal)
        settingsButton.layer.borderWidth = 3
        settingsButton.layer.borderColor = CGColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        settingsButton.applyCornerRadius(radius: 20)
        settingsButton.frame = onStartButton.frame.offsetBy(dx: 0, dy: startButtonHeight * 2.8)
        settingsButton.frame.size = CGSize(width: settingsButtonWidth, height: startButtonHeight)
        
        resultsButton.setTitle((NSLocalizedString("button.results", comment: "")), for: .normal)
        resultsButton.layer.borderWidth = 3
        resultsButton.layer.borderColor = CGColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        resultsButton.applyCornerRadius(radius: 20)
        resultsButton.frame = settingsButton.frame.offsetBy(dx: (startButtonWidth - settingsButtonWidth * 2) + settingsButtonWidth, dy: 0)
        resultsButton.frame.size = CGSize(width: settingsButtonWidth, height: startButtonHeight)
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
