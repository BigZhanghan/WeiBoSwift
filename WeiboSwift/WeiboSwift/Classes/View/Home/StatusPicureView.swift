//
//  StatusPicureView.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/10/14.
//

import UIKit

private let itemMargin_ = 10.0
private let itemCellId = "itemCellId"

class StatusPicureView: UICollectionView {
    
    var viewModel: HomeItemViewModel? {
        didSet {
            sizeToFit()
            reloadData()
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return calcViewSize()
    }

    init() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = itemMargin_
        layout.minimumInteritemSpacing = itemMargin_
        
        super.init(frame: CGRectZero, collectionViewLayout: layout)
        
        dataSource = self
        register(PictureCell.self, forCellWithReuseIdentifier: itemCellId)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension StatusPicureView {
    private func calcViewSize() -> CGSize {
        let rowCount: Double = 3
        let itemWidth = (UIScreen.main.bounds.width - 2 * sideMargin_ - 2 * itemMargin_) / rowCount
        
        let layout = collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        
        let count = viewModel?.thumbnailUrls?.count ?? 0
        
        if count == 0 {
            return CGSizeZero
        }
        
        if count == 1 {
            let size = CGSize(width: 100, height: 110)
            layout.itemSize = size
            return size
        }
        
        if count == 4 {
            let width = itemWidth * 2 + itemMargin_
            return CGSize(width: width, height: width)
        }
        
        let row = Double((count - 1) / Int(rowCount) + 1)
        let width = rowCount * itemWidth + (rowCount - 1) * itemMargin_
        let height = row * itemWidth + (rowCount - 1) * itemMargin_
        return CGSize(width: width, height: height)
    }
}

extension StatusPicureView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.thumbnailUrls?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: itemCellId, for: indexPath) as! PictureCell
        cell.imageUrl = viewModel!.thumbnailUrls![indexPath.item]
        return cell
    }
}

private class PictureCell: UICollectionViewCell {
    var imageUrl: URL? {
        didSet {
            iconImageView.kf.setImage(with: imageUrl)
        }
    }
    
    private lazy var iconImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.clipsToBounds = true
        return imgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(iconImageView)
        
        iconImageView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
    }
}
