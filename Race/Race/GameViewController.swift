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
    
    var pageWidth = UIScreen.main.bounds.width
    var pageHeight = UIScreen.main.bounds.height
    var sizeCar = 70
    var leftRightSize = 50
    var labelSize = 200
    
    let leftButton = UIButton()
    let rightButton = UIButton()
    
    var checkObstraclesTimer: Timer?
    var backToSrart: Timer?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view = backgrond
        backgrond.isUserInteractionEnabled = true
        createMainCar()
        createLeftButton()
        createRightButton()
        createObstracleCar()
        animationBomb()
        animationUFO()
        animation()
        
        checkObstraclesTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(checkObstracles), userInfo: nil, repeats: true)
    }
    
    func createMainCar() {
        mainCar.frame = CGRect(x: (Int(pageWidth)-Int(sizeCar))/2, y: Int(pageHeight)-(sizeCar*2), width: sizeCar, height: sizeCar)
        view.addSubview(mainCar)
    }
    
    func createObstracleCar() {
        obstracleCar.frame = CGRect(x: .random(in: Int(pageWidth)/2...Int(pageWidth) - Int(sizeCar)), y: Int(-sizeCar), width: sizeCar, height: sizeCar)
        view.addSubview(obstracleCar)
    }
    
    @objc func animation() {
        UIView.animate(withDuration: 3, delay: 1, options: [.repeat]) { [self] in
            self.obstracleCar.frame = self.obstracleCar.frame.offsetBy(dx: 0, dy: 1000)
                 } completion: { _ in
                     self.animation()
                }
    }
                       
    func createBomb() {
        bomb.frame = CGRect(x: .random(in: sizeCar...Int(pageWidth)/2 - Int(sizeCar)), y: Int(-sizeCar), width: sizeCar, height: sizeCar)
        view.addSubview(bomb)
    }
    
    func animationBomb() {
        createBomb()
        UIView.animate(withDuration: 3, delay: 2, options: [.repeat]) { [self] in
            self.bomb.frame = self.bomb.frame.offsetBy(dx: 0, dy: 1000)
                 } completion: { _ in
                     self.animation()
                }
    }
    
    func createUFO() {
        UFO.frame = CGRect(x: (Int(pageWidth)-Int(sizeCar))/2 , y: Int(-sizeCar), width: sizeCar, height: sizeCar)
        view.addSubview(UFO)
    }
    
    func animationUFO() {
        createUFO()
        UIView.animate(withDuration: 3, delay: 15, options: [.repeat]) { [self] in
            self.UFO.frame = self.UFO.frame.offsetBy(dx: 0, dy: 1000)
                 } completion: { _ in
                     self.animation()
                }
    }

    func createLeftButton() {
        leftButton.backgroundColor = .orange
        leftButton.setTitle("left", for: .normal)
        leftButton.frame = CGRect(x: 0, y: Int(pageHeight)-(sizeCar*2), width: leftRightSize, height: leftRightSize)
        leftButton.layer.cornerRadius = 25
        leftButton.addTarget(self, action: #selector(onLeftClick), for: .touchUpInside)
        view.addSubview(leftButton)
    }
    
    func createStopGameLabel() {
        stopGame.text = "GAME OVER"
        stopGame.textColor = .red
        stopGame.font = UIFont(name: "Roboto-Black", size: 30)
        stopGame.frame = CGRect(x: Int(pageWidth - CGFloat(labelSize))/2, y: Int(pageHeight - CGFloat(labelSize))/2, width: labelSize, height: labelSize)
        view.addSubview(stopGame)
    }
    
    @objc func onLeftClick() {
        if mainCar.frame.origin.x.isLess(than: CGFloat(leftRightSize) + CGFloat(sizeCar/2)) {
            mainCar.frame = mainCar.frame.offsetBy(dx: 0, dy: 0)
        } else {
            UIView.animate(withDuration: 0.5, delay: 0, options: []) { [self] in
                self.mainCar.frame = self.mainCar.frame.offsetBy(dx: -50, dy: 0)
            } completion: { _ in
           }
        }
    }
    
    func createRightButton() {
        rightButton.backgroundColor = .orange
        rightButton.setTitle("right", for: .normal)
        rightButton.frame = CGRect(x: Int(pageWidth) - Int(leftRightSize), y: Int(pageHeight)-(sizeCar*2), width: leftRightSize, height: leftRightSize)
        rightButton.layer.cornerRadius = 25
        rightButton.addTarget(self, action: #selector(onRightClick), for: .touchUpInside)
        view.addSubview(rightButton)
    }
    
    @objc func onRightClick () {
        if mainCar.frame.origin.x.isLess(than: pageWidth - CGFloat(leftRightSize + 100)) {
            UIView.animate(withDuration: 0.5, delay: 0, options: []) { [self] in
                self.mainCar.frame = self.mainCar.frame.offsetBy(dx: 50, dy: 0)
            } completion: { _ in
           }
        } else {
            mainCar.frame = mainCar.frame.offsetBy(dx: 0, dy: 0)
        }
    }
    
    @objc func backToStartFunc (){
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc private func checkObstracles() {
                guard   let imageCarView = self.mainCar.layer.presentation(),
                        let imageObstracleView = self.obstracleCar.layer.presentation(),
                        let imageBombView = self.bomb.layer.presentation(),
                        let imageUFO2View = self.UFO.layer.presentation()
            else { return }
            
            if imageCarView.frame.intersects(imageObstracleView.frame) || imageCarView.frame.intersects(imageBombView.frame) || imageCarView.frame.intersects(imageUFO2View.frame)  {
                        
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
