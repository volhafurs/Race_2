//
//  SettingsViewController.swift
//  Race
//
//  Created by Volha Furs on 11.04.22.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var lowButton: UIButton!
    @IBOutlet weak var fastButton: UIButton!
    @IBOutlet weak var veryFastButton: UIButton!
    @IBOutlet weak var mainCarImage: UIImageView!
    @IBOutlet weak var mainCar2Image: UIImageView!
    
    let difficultyKey = "speedKey"
    let shuttleStyleKey = "shuttleKey"
    
    var difficulty: Difficulty = .easy
    var shuttleStyle: ShuttleStyle = .firstStyle
 
    override func viewDidLoad() {
        super.viewDidLoad()
       
        let difficultyValue = UserDefaults.standard.integer(forKey: difficultyKey)
        difficulty = Difficulty(rawValue: difficultyValue) ?? .easy
    
        if let shuttleValue = UserDefaults.standard.string(forKey: shuttleStyleKey) {
            shuttleStyle = ShuttleStyle(rawValue: shuttleValue) ?? .firstStyle }
        
        mainCarImage.backgroundColor = .yellow
        mainCar2Image.backgroundColor = nil
    
        setUpSelectedSettings()
        
        let tapRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(onMainCarClick))
        mainCarImage.addGestureRecognizer(tapRecognizer1)
        
        let tapRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(onMainCar2Click))
        mainCar2Image.addGestureRecognizer(tapRecognizer2)
    }
    
    private func setUpSelectedSettings() {
        updateSelectedSpeed()
    }
    
    private func updateSelectedSpeed() {
        lowButton.isSelected = difficulty == .easy
        fastButton.isSelected = difficulty == .normal
        veryFastButton.isSelected = difficulty == .hard
    }
    
    @IBAction private func lowSpeedButton(_ sender: Any) {
        difficulty = .easy
        updateSelectedSpeed()
    }

    @IBAction private func fastSpeedButton(_ sender: Any) {
        difficulty = .normal
        updateSelectedSpeed()
    }
    
    @IBAction private func veryfastSpeedButton(_ sender: Any) {
        difficulty = .hard
        updateSelectedSpeed()
    }
    
    @IBAction private func backButton(_ sender: Any) {
        UserDefaults.standard.set(difficulty.rawValue, forKey: difficultyKey)
        UserDefaults.standard.set(shuttleStyle.rawValue, forKey: shuttleStyleKey)
        navigationController?.popViewController(animated: true)
    }
    
    @objc func onMainCarClick() {
        shuttleStyle = .firstStyle
        mainCarImage.backgroundColor = .yellow
        mainCar2Image.backgroundColor = nil
    }
    
    @objc func onMainCar2Click() {
        shuttleStyle = .secondStyle
        mainCar2Image.backgroundColor = .yellow
        mainCarImage.backgroundColor = nil
    }
}

enum Difficulty: Int {
    case easy = 5
    case normal = 3
    case hard = 2
}

enum ShuttleStyle: String {
    case firstStyle = "ic_mainCar"
    case secondStyle = "ic_mainCar2"
}
