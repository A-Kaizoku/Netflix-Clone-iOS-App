//
//  Extensions.swift
//  Netflix Clone
//
//  Created by Mayank on 07/08/22.
//

import Foundation

extension String{
    func capitalFirstLetter() -> String{
        return self.prefix(1).uppercased() + self.lowercased().dropFirst()
    }
}
