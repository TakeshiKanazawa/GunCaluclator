//
//  ViewController.swift
//  GunCaluclator
//
//  Created by 金澤武士 on 2020/04/15.
//  Copyright © 2020 tk. All rights reserved.
//

import UIKit
import AVFoundation
    
enum Operator {
    case undefined //未定義
    case addition //(+)
    case subtraction //(-)
    case multiplication //(x)
    case division //(/)
}

class ViewController: UIViewController {
      var audioPlayerInstance : AVAudioPlayer! = nil  // 再生するサウンドのインスタンス
      


    var firstvalue = 0
    var secondvalue = 0
    var currentOperator = Operator.undefined
    
    
    @IBOutlet weak var reultsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        //サウンドファイルのパスを生成
        let soundFilePath = Bundle.main.path(forResource: "gunSound", ofType: "mp3")!
        let sound:URL = URL(fileURLWithPath: soundFilePath)
        do {
                 audioPlayerInstance = try AVAudioPlayer(contentsOf: sound, fileTypeHint:nil)
             } catch {
                 print("AVAudioPlayerインスタンス作成でエラー")
             }
             // 再生準備
             audioPlayerInstance.prepareToPlay()
    }
    
    
    @IBAction func operatorButtonTapped(_ sender: UIButton) {
        switch sender.currentTitle {
        case "+":
            currentOperator = .addition
            case "-":
                currentOperator = .subtraction
            case "x":
                currentOperator = .multiplication
            case "/":
                currentOperator = .division
            
        default:
            currentOperator = .undefined
        }
    }
    
    
    @IBAction func equalButtonTapped(_ sender: Any) {
        var value = 0
        switch currentOperator {
        case .addition:
            value = firstvalue + secondvalue
        case .subtraction:
            value = firstvalue - secondvalue
        case .multiplication:
            value = firstvalue * secondvalue
        case .division:
            value = firstvalue / secondvalue
        case .undefined:
            value = firstvalue
        }
        reultsLabel.text = "\(value)"
        firstvalue = 0
        secondvalue = 0
        currentOperator = .undefined
    }
    
    
    @IBAction func allClearButtonTapped(_ sender: Any) {
        firstvalue = 0
        secondvalue = 0
        currentOperator = .undefined
        reultsLabel.text = "0"
    }
    
    @IBAction func numberButtonTapped(_ sender: UIButton) {
        audioPlayerInstance.currentTime = 0         // 再生箇所を頭に移す
        audioPlayerInstance.play()                  // 再生する
        var value = 0
        switch sender.currentTitle {
            case "0":
            value = 0
            case "1":
                value = 1
            case "2":
                value = 2
            case "3":
                value = 3
            case "4":
                value = 4
            case "5":
                value = 5
            case "6":
                value = 6
            case "7":
                value = 7
            case "8":
                value = 8
            case "9":
                value = 9
        default:
                value = 0
        }
        if currentOperator == .undefined {
            firstvalue = firstvalue * 10 + value
            reultsLabel.text = "\(firstvalue)"
        } else {
            secondvalue = secondvalue * 10 + value
            reultsLabel.text = "\(secondvalue)"
        }
    }
}

