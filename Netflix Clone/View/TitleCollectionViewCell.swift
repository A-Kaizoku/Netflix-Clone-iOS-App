//
//  TitleCollectionViewCell.swift
//  Netflix Clone
//
//  Created by Mayank on 07/08/22.
//

import UIKit
import SDWebImage

class TitleCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "TitleCollectionViewCell"
    
    let posterImageView : UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(frame: CGRect) {
        super .init(frame: frame)
        contentView.addSubview(posterImageView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        posterImageView.frame=contentView.bounds
        
    }
    
    
    //using this method we'll call the url through which we will fetch the movie/series poster image
    
    public func configure(with Model:String){
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(Model)") else {return}
        print(url)
        posterImageView.sd_setImage(with: url,completed: nil)
    }
    
}
