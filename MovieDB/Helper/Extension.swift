//
//  Extension.swift
//  MovieDB
//
//  Created by Dmitry Shtryhel on 16.01.2020.
//  Copyright © 2020 Dean Shtryhel. All rights reserved.
//

import UIKit

extension String {
    var url: String {
        return "\(AlamofireService.urlScheme)://image.tmdb.org/t/p/w500/\(self)"
    }
    
    func getLineSpacedAttributedText(lineSpacing: CGFloat = 0) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: self)

        let paragraphStyle = NSMutableParagraphStyle()

        paragraphStyle.lineSpacing = lineSpacing

        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        return attributedString
    }
}

extension Array where Element == String {
    func getStringFromArraySeperatedByComa() -> String? {
        
        var str = ""
        self.forEach({ (stringData) in
            
            str = "\(str)\(stringData), "
        })
        
        if str.isEmpty {
            return nil
        }
        return "\(str.dropLast().dropLast())"
    }
}
extension Double {
    var stringValue: String {
        return "\(self)"
    }
}

extension UIView {
    func applyGradient(startColor: UIColor, endColor: UIColor) {
        let gradient = CAGradientLayer()
        gradient.colors = [startColor.cgColor,
                           endColor.cgColor]
        gradient.locations = [0.0, 1.0]
        gradient.frame = self.bounds
        gradient.cornerRadius = self.bounds.width / 2
        gradient.masksToBounds = true
        self.layer.insertSublayer(gradient, at: 0)
    }
}
