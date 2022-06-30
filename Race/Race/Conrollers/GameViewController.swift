//
//  GameViewController.swift
//  Race
//
//  Created by Volha Furs on 4.03.22.
//

import UIKit

class GameViewController: UIViewController {
    let backgrond = UIImageView(image: UIImage(named: "ic_background"))
    let mainCar = UIImageView(image: UIImage(named: "ic_mainCar"))
    let obstracleCar = UIImageView(image: UIImage(named: "ic_obstacle"))
    let bomb = UIImageView(image: UIImage(named: "ic_bomb"))
    let UFO = UIImageView(image: UIImage(named: "ic_UFO"))
    let stopGame = UILabel()
    let timeResult = UILabel()
    var background1 = UIImageView()
    var background2 = UIImageView()
    
    var pageWidth = UIScreen.main.bounds.width
    var pageHeight = UIScreen.main.bounds.height
    var sizeCar = 70
    var leftRightSize = 60
//    var labelSize = 200
    
    var difficulty = Difficulty.easy
    let difficultyKey = "speedKey"
    
    var shuttleStyle: ShuttleStyle = .firstStyle
    let shuttleStyleKey = "shuttleKey"
    
    let leftButton = UIButton()
    let rightButton = UIButton()
    
    var checkObstraclesTimer: Timer?
    var backToSrart: Timer?
    
    var scoreTime = Double()
    var finalScoreTime: String = ""
    var date = Date()
    var formatter = DateFormatter()
    var currentDate: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpBackground()
        animateBackground()
        setUpFormatter()
        
        let difficultyValue = UserDefaults.standard.integer(forKey: difficultyKey)
        difficulty = Difficulty(rawValue: difficultyValue) ?? .easy
        
        if let shuttleValue = UserDefaults.standard.string(forKey: shuttleStyleKey) {
            shuttleStyle = ShuttleStyle(rawValue: shuttleValue) ?? .firstStyle }
        
        createTimeResultLabel()
        createMainCar()
        createLeftButton()
        createRightButton()
        createObstracleCar()
        animationBomb()
        animationUFO()
        animation()
        
        checkObstraclesTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkObstracles), userInfo: NSDate(), repeats: true)
    }
    
    private func setUpFormatter() {
        formatter.dateFormat = "dd.MM.YYYY"
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        currentDate = formatter.string(from: date as Date)
    }
    
    private func setUpBackground() {
        background1.frame = view.bounds
        background1.image = UIImage(named: "ic_back")
        background1.contentMode = .scaleAspectFill
        view.addSubview(background1)
        
        background2.frame = view.bounds
        background2.frame.origin = CGPoint(x: 0, y: -view.bounds.height)
        background2.image = UIImage(named: "ic_back")
        background2.contentMode = .scaleAspectFill
        view.addSubview(background2)
    }
    
    private func animateBackground() {
        var backgroundYPoint = view.bounds.height
        var backgroundYPoint2: CGFloat = 0
        if background1.frame.origin.y == view.bounds.height {
            background1.frame.origin.y = -view.bounds.height
            backgroundYPoint = 0
            backgroundYPoint2 = view.bounds.height
        } else {
            background2.frame.origin.y = -view.bounds.height
            backgroundYPoint = view.bounds.height
            backgroundYPoint2 = 0
        }
        UIView.animate(withDuration: 3, delay: 0, options: [.curveLinear]) {
            self.background1.frame = CGRect(x: 0, y: backgroundYPoint, width: self.view.bounds.width, height: self.view.bounds.height)
            self.background2.frame = CGRect(x: 0, y: backgroundYPoint2, width: self.view.bounds.width, height: self.view.bounds.height)
        } completion: { _ in
            self.animateBackground()
        }
    }
    
    private func createMainCar() {
        mainCar.frame = CGRect(x: (Int(pageWidth) - Int(sizeCar))/2,
                               y: Int(pageHeight) - Int(sizeCar*2),
                               width: sizeCar,
                               height: sizeCar)
        mainCar.image = UIImage(named: shuttleStyle.rawValue)
        view.addSubview(mainCar)
    }
    
    private func createTimeResultLabel() {
        timeResult.frame = CGRect(x: 50, y: 100, width: 150, height: 100)
        timeResult.textColor = .white
        timeResult.font = UIFont(name: "Roboto-BlackItalic", size: 100)
        view.addSubview(timeResult)
    }
    
    private func createObstracleCar() {
        obstracleCar.frame = CGRect(x: .random(in: Int(pageWidth)/2...Int(pageWidth) - Int(sizeCar)),
                                    y: Int(-sizeCar),
                                    width: sizeCar,
                                    height: sizeCar)
        view.addSubview(obstracleCar)
    }
    
    @objc func animation() {
        UIView.animate(withDuration: Double(difficulty.rawValue),
                       delay: 1,
                       options: [.repeat]) {[self] in
            self.obstracleCar.frame = self.obstracleCar.frame.offsetBy(dx: 0, dy: 900)}
                        completion: {_ in self.animation()}
    }
                       
    private func createBomb() {
        bomb.frame = CGRect(x: .random(in: sizeCar...Int(pageWidth)/2 - Int(sizeCar)),
                            y: Int(-sizeCar),
                            width: sizeCar,
                            height: sizeCar)
        view.addSubview(bomb)
    }
    
    private func animationBomb() {
        createBomb()
        UIView.animate(withDuration: Double(difficulty.rawValue),
                       delay: 3,
                       options: [.repeat]) { [self] in
            self.bomb.frame = self.bomb.frame.offsetBy(dx: 0, dy: 1000)
                 } completion: { _ in
                     self.animation()}
    }
    
    private func createUFO() {
        UFO.frame = CGRect(x: (Int(pageWidth) - Int(sizeCar))/2 ,
                           y: Int(-sizeCar),
                           width: sizeCar,
                           height: sizeCar)
        view.addSubview(UFO)
    }
    
    private func animationUFO() {
        createUFO()
        UIView.animate(withDuration: Double(difficulty.rawValue),
                       delay: 15, options: [.repeat]) { [self] in
                    self.UFO.frame = self.UFO.frame.offsetBy(dx: 0, dy: 1000)
                    } completion: { _ in
                     self.animation()}
    }

    private func createLeftButton() {
        leftButton.backgroundColor = .orange
//        leftButton.setTitle(NSLocalizedString("left.button", comment: ""), for: .normal)
        leftButton.setImage(UIImage(named: "ic_left"), for: .normal)
        leftButton.frame = CGRect(x: 0,
                                  y: Int(pageHeight) - (sizeCar * 2),
                                  width: leftRightSize,
                                  height: leftRightSize)
        leftButton.layer.cornerRadius = 25
        leftButton.addTarget(self, action: #selector(onLeftClick), for: .touchUpInside)
        view.addSubview(leftButton)
    }
    
    private func createStopGameLabel() {
        var labelWidth: CGFloat = view.bounds.width - 100
        var labelHeight: CGFloat = 60
        stopGame.text = NSLocalizedString("label.stopgame", comment: "")
        stopGame.textColor = .red
        stopGame.font = UIFont(name: "Roboto-BlackItalic", size: 60)
        stopGame.frame = CGRect(x: view.bounds.midX - labelWidth / 2,
                                y: (view.bounds.height - labelHeight) / 2,
                                width: labelWidth,
                                height: labelHeight)
        stopGame.textAlignment = .center
        view.addSubview(stopGame)
    }
    
    @objc func onLeftClick() {
        if mainCar.frame.origin.x.isLess(than: CGFloat(leftRightSize) + CGFloat(sizeCar/2)) {
            mainCar.frame = mainCar.frame.offsetBy(dx: 0, dy: 0)
        } else {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: []) { [self] in
                self.mainCar.frame = self.mainCar.frame.offsetBy(dx: -50, dy: 0)
            } completion: { _ in
           }
        }
    }
    
    private func createRightButton() {
        rightButton.backgroundColor = .orange
//        rightButton.setTitle(NSLocalizedString("right.button", comment: ""), for: .normal)
        rightButton.setImage(UIImage(named: "ic_right"), for: .normal)
        rightButton.frame = CGRect(x: Int(pageWidth) - Int(leftRightSize),
                                   y: Int(pageHeight)-(sizeCar*2),
                                   width: leftRightSize,
                                   height: leftRightSize)
        rightButton.layer.cornerRadius = 25
        rightButton.addTarget(self, action: #selector(onRightClick), for: .touchUpInside)
        view.addSubview(rightButton)
    }
    
    @objc func onRightClick () {
        if mainCar.frame.origin.x.isLess(than: view.bounds.height - CGFloat(leftRightSize + 100)) {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           options: []) { [self] in
                self.mainCar.frame = self.mainCar.frame.offsetBy(dx: 50, dy: 0)
                } completion: { _ in }
        } else {
            mainCar.frame = mainCar.frame.offsetBy(dx: 0, dy: 0)
        }
    }
    
    @objc func backToStartFunc() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func checkObstracles() {
        guard   let imageCarView = self.mainCar.layer.presentation(),
                let imageObstracleView = self.obstracleCar.layer.presentation(),
                let imageBombView = self.bomb.layer.presentation(),
                let imageUFO2View = self.UFO.layer.presentation()
        else { return }
        scoreTime = -(self.checkObstraclesTimer?.userInfo as! NSDate).timeIntervalSinceNow
        
        timeResult.text = String(format: "%.0f", scoreTime)
        if imageCarView.frame.intersects(imageObstracleView.frame) || imageCarView.frame.intersects(imageBombView.frame) ||
            imageCarView.frame.intersects(imageUFO2View.frame) {
            finalScoreTime = String(format: "%.0f", scoreTime)
            let result = ResultGame(timeGame: finalScoreTime, date: currentDate)
            ResultsManager.saveResults(result: result)
            
            mainCar.removeFromSuperview()
            obstracleCar.removeFromSuperview()
            bomb.removeFromSuperview()
            UFO.removeFromSuperview()
                
            checkObstraclesTimer?.invalidate()
            createStopGameLabel()
                
            backToSrart = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(backToStartFunc), userInfo: nil, repeats: false)
        }
    }
}
