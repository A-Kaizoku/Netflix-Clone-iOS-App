//
//  TitleTableViewCell.swift
//  Netflix Clone
//
//  Created by Mayank on 08/08/22.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

   static let initializer = "TitleTableViewCell"
    
    private let titlePosterUIImageView:UIImageView={
        let imageView = UIImageView()
        
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super .init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
