//
//  CollectionViewTableViewCell.swift
//  Netflix Clone
//
//  Created by Mayank on 04/08/22.
//

import UIKit

class CollectionViewTableViewCell: UITableViewCell {
    
    //    override func awakeFromNib() {
    //        super.awakeFromNib()
    //        // Initialization code
    //    }
    //
    //    override func setSelected(_ selected: Bool, animated: Bool) {
    //        super.setSelected(selected, animated: animated)
    //
    //        // Configure the view for the selected state
    //    }
    
    static let identifier = "CollectionViewTableViewCell"
    
    
    //steps to create a CollectionView denoted by numbers
    
    //1)
    private let collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        
        //6) its important to give layout the scrollDirection and itemSize (for cell) otherwise it wont have any size to follw and take a very compact size
        layout.scrollDirection = .horizontal
        layout.itemSize=CGSize(width: 140, height: 200)
        
        
        let collectionView=UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    //this will get called first in the whole file whenever CollectionViewTableViewCell will be used
    
    //2)
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemPink
        contentView.addSubview(collectionView)
        
        //3)
        collectionView.delegate=self
        collectionView.dataSource=self
    }
    
    //5)
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame=contentView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}

//4)
extension CollectionViewTableViewCell : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .red
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
}
