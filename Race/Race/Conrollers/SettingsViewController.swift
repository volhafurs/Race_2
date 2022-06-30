//
//  SettingsViewController.swift
//  Race
//
//  Created by Volha Furs on 11.04.22.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var chooseShuttleLabel: UILabel!
    @IBOutlet weak var chooseSpeedLabel: UILabel!
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
        setUpSelectedSettings()
        setUpButtons()
        
        let difficultyValue = UserDefaults.standard.integer(forKey: difficultyKey)
        difficulty = Difficulty(rawValue: difficultyValue) ?? .easy
    
        if let shuttleValue = UserDefaults.standard.string(forKey: shuttleStyleKey) {
            shuttleStyle = ShuttleStyle(rawValue: shuttleValue) ?? .firstStyle }
    
        let tapRecognizer1 = UITapGestureRecognizer(target: self, action: #selector(onMainCarClick))
        mainCarImage.addGestureRecognizer(tapRecognizer1)
        
        let tapRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(onMainCar2Click))
        mainCar2Image.addGestureRecognizer(tapRecognizer2)
    }
    
    private func setUpButtons() {
        var mainButtonWidth: CGFloat = view.bounds.width - 100
        var mainButtonHeight: CGFloat = 50
        
        chooseSpeedLabel.text = NSLocalizedString("speed.label", comment: "")
        chooseSpeedLabel.applyCornerRadius(radius: 20)
        chooseSpeedLabel.frame = CGRect(x: (view.bounds.width - mainButtonWidth) / 2,
                                        y: view.bounds.minY + (mainButtonHeight * 2),
                                        width: mainButtonWidth,
                                        height: mainButtonHeight)
        chooseSpeedLabel.layer.borderWidth = 3
        chooseSpeedLabel.layer.borderColor = CGColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        
        var speedLabelWidth: CGFloat = mainButtonWidth / 2
        var speedLabelHeight: CGFloat = 30
        lowButton.setTitle(NSLocalizedString("low.button", comment: ""), for: .normal)
        lowButton.applyCornerRadius(radius: 15)
        lowButton.frame = chooseSpeedLabel.frame.offsetBy(dx: (mainButtonWidth - speedLabelWidth) / 2,
                                                          dy: mainButtonHeight * 1.5)
        lowButton.frame.size = CGSize(width: speedLabelWidth, height: speedLabelHeight)
        
        fastButton.applyCornerRadius(radius: 15)
        fastButton.setTitle(NSLocalizedString("fast.button", comment: ""), for: .normal)
        fastButton.frame = lowButton.frame.offsetBy(dx: 0,
                                                    dy: speedLabelHeight * 1.5)
        fastButton.frame.size = CGSize(width: speedLabelWidth, height: speedLabelHeight)
        
        veryFastButton.setTitle(NSLocalizedString("veryfast.button", comment: ""), for: .normal)
        veryFastButton.applyCornerRadius(radius: 15)
        veryFastButton.frame = fastButton.frame.offsetBy(dx: 0,
                                                    dy: speedLabelHeight * 1.5)
        veryFastButton.frame.size = CGSize(width: speedLabelWidth, height: speedLabelHeight)
        
        chooseShuttleLabel.text = NSLocalizedString("shuttle.label", comment: "")
        chooseShuttleLabel.applyCornerRadius(radius: 20)
        chooseShuttleLabel.layer.borderWidth = 3
        chooseShuttleLabel.layer.borderColor = CGColor.init(red: 1, green: 1, blue: 1, alpha: 1)
        chooseShuttleLabel.frame = veryFastButton.frame.offsetBy(dx: -((mainButtonWidth - speedLabelWidth) / 2),
                                                               dy: mainButtonHeight * 2)
        chooseShuttleLabel.frame.size = CGSize(width: mainButtonWidth,
                                            height: mainButtonHeight)
        var mainCarsize: CGFloat = 100
        
        mainCarImage.backgroundColor = .white
        mainCar2Image.backgroundColor = nil
        mainCarImage.frame = chooseShuttleLabel.frame.offsetBy(dx: (mainButtonWidth - mainCarsize) / 2 ,
                                                               dy: mainButtonHeight * 2)
        mainCarImage.frame.size = CGSize(width: mainCarsize, height: mainCarsize)
        
        mainCar2Image.frame = mainCarImage.frame.offsetBy(dx: 0, dy: mainCarsize + mainButtonHeight)
        mainCar2Image.frame.size = CGSize(width: mainCarsize, height: mainCarsize)
        
        mainCarImage.applyCornerRadius(radius: 20)
        mainCar2Image.applyCornerRadius(radius: 20)
        
        
        backButton.setTitle(NSLocalizedString("back.button", comment: ""), for: .normal)
        backButton.applyCornerRadius(radius: 20)
        backButton.frame = mainCar2Image.frame.offsetBy(dx: -((mainButtonWidth - mainCarsize) / 2),
                                                        dy: mainCarsize + speedLabelHeight)
        backButton.frame.size = CGSize(width: mainButtonWidth,
                                       height: mainButtonHeight)
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
        mainCarImage.backgroundColor = .white
        mainCar2Image.backgroundColor = nil
    }
    
    @objc func onMainCar2Click() {
        shuttleStyle = .secondStyle
        mainCar2Image.backgroundColor = .white
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
