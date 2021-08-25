//
//  Global.swift
//  Fantasy FB Draft Kit
//
//  Created by Jared Pino on 6/19/20.
//  Copyright © 2020 Jared Pino. All rights reserved.
//

import Foundation
import UIKit

struct RowSelected {
    var sec: Int?
    var row: Int?
}

var tableViewData = [cellData]()

struct cellData {
    var opened: Bool = false
    var title: String = ""
    var sectionData: [String] = []
    var color: UIColor? = nil
}

func generateRandomColor() -> UIColor {
    let redValue = CGFloat.random(in: 0...1)
    let greenValue = CGFloat.random(in: 0...1)
    let blueValue = CGFloat.random(in: 0...1)
    let randomColor = UIColor(red: redValue, green: greenValue, blue: blueValue, alpha: 1.0)
    
    return randomColor
}

func generateColor() -> UIColor {
    
    let myColors = [#colorLiteral(red: 1, green: 0.2705882353, blue: 0.2274509804, alpha: 1), #colorLiteral(red: 0.1960784314, green: 0.8431372549, blue: 0.2941176471, alpha: 1), #colorLiteral(red: 0.03921568627, green: 0.5176470588, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.6235294118, blue: 0.03921568627, alpha: 1), #colorLiteral(red: 1, green: 0.8392156863, blue: 0.03921568627, alpha: 1), #colorLiteral(red: 0.6745098039, green: 0.5568627451, blue: 0.4078431373, alpha: 1), #colorLiteral(red: 1, green: 0.2156862745, blue: 0.3725490196, alpha: 1), #colorLiteral(red: 0.7490196078, green: 0.3529411765, blue: 0.9490196078, alpha: 1), #colorLiteral(red: 0.01680417731, green: 0.1983509958, blue: 1, alpha: 1), #colorLiteral(red: 0.6679978967, green: 0.4751212597, blue: 0.2586010993, alpha: 1), #colorLiteral(red: 0, green: 0.9914394021, blue: 1, alpha: 1), #colorLiteral(red: 0, green: 0.9768045545, blue: 0, alpha: 1), #colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1), #colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1), #colorLiteral(red: 0.5791940689, green: 0.1280144453, blue: 0.5726861358, alpha: 1), #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1), #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1), #colorLiteral(red: 0.5787474513, green: 0.3215198815, blue: 0, alpha: 1), #colorLiteral(red: 0, green: 0.5628422499, blue: 0.3188166618, alpha: 1)]
    let colorIndex = Int(arc4random_uniform(UInt32(myColors.count)))
    let colorItem = myColors[colorIndex]
    
    return colorItem
}

// Button Features
@IBDesignable class BorderedButton: UIButton {
    
    @IBInspectable var borderColor: UIColor? {
        didSet {
            if let bColor = borderColor {
                self.layer.borderColor = bColor.cgColor
            }
        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            self.layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
           set {
               layer.cornerRadius = newValue
           }
           get {
               return layer.cornerRadius
           }
       }
    
    override var isHighlighted: Bool {
        didSet {
            guard let currentBorderColor = borderColor else {
                return
            }
            
            let fadedColor = currentBorderColor.withAlphaComponent(0.2).cgColor
            
            if isHighlighted {
                layer.borderColor = fadedColor
            } else {
                
                self.layer.borderColor = currentBorderColor.cgColor
                
                let animation = CABasicAnimation(keyPath: "borderColor")
                animation.fromValue = fadedColor
                animation.toValue = currentBorderColor.cgColor
                animation.duration = 0.4
                self.layer.add(animation, forKey: "")
            }
        }
    }
}

var strikeThroughTextBool: Bool = false

func noStrikeThroughText(_ str: String) -> NSAttributedString {
    return NSAttributedString(string: str)
}

func strikeThroughText(_ str: String) -> NSAttributedString {
    let attributedString =  NSMutableAttributedString(string: str)
    attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 1, range: NSMakeRange(0, attributedString.length))
    return attributedString
}
