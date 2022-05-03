//
//  String+Size.swift
//  CSVReader
//
//  Created by Thomas Leonhardt on 03.05.22.
//

import Foundation
import UIKit

extension String {
    func size(font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return (self as NSString).size(withAttributes: fontAttributes)
    }
    
    func width(font: UIFont) -> CGFloat {
        return size(font: font).width
    }
}

