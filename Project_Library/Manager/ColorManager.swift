//
//  ColorManager.swift
//  Project_Library
//
//  Created by Gyuni on 2021/03/07.
//

import UIKit

extension UIColor {
    
    static var gray000: UIColor {
        return fetchColor(#function)
    }
    
    static var gray100: UIColor {
        return fetchColor(#function)
    }
    
    static var gray200: UIColor {
        return fetchColor(#function)
    }
    
    static var gray300: UIColor {
        return fetchColor(#function)
    }
    
    static var gray400: UIColor {
        return fetchColor(#function)
    }
    
    static var gray500: UIColor {
        return fetchColor(#function)
    }
    
    static var gray600: UIColor {
        return fetchColor(#function)
    }
    
    static var gray700: UIColor {
        return fetchColor(#function)
    }
    
    static var gray800: UIColor {
        return fetchColor(#function)
    }
    
    static var gray900: UIColor {
        return fetchColor(#function)
    }
    
    static var black000: UIColor {
        return fetchColor(#function)
    }
    
    static var white000: UIColor {
        return fetchColor(#function)
    }
    
    private static func fetchColor(_ name: String) -> UIColor {
            guard let color = UIColor(named: name) else {
                return .red
            }
            return color
        }

}


