//
//  NewFeatureCollectionViewController.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/10/12.
//

import UIKit
import SnapKit

private let newFeatureCellId = "NewFeatureCellId"

class NewFeatureCollectionViewController: UICollectionViewController {
    
    private let imageCount = 3
    
    init() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = UIScreen.main.bounds.size
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        
        super.init(collectionViewLayout: layout)
        
        self.collectionView.isPagingEnabled = true
        self.collectionView.bounces = false
        self.collectionView.showsHorizontalScrollIndicator = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView!.register(NewFeatureCell.self, forCellWithReuseIdentifier: newFeatureCellId)
    }


    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageCount
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let featureCell = collectionView.dequeueReusableCell(withReuseIdentifier: newFeatureCellId, for: indexPath) as! NewFeatureCell
        featureCell.backgroundColor = indexPath.row % 2 == 0 ? .red : .green
        featureCell.imageIndex = indexPath.item
        return featureCell
    }
    
    override func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        if page != imageCount - 1 {
            return
        }
        
        let cell = collectionView.cellForItem(at: IndexPath(item: page, section: 0)) as! NewFeatureCell
        cell.showStartBtnAnimation()
        
    }

}

private class NewFeatureCell: UICollectionViewCell {
    
    private lazy var iconView = UIImageView()
    
    fileprivate var imageIndex: Int = 0 {
        didSet {
            iconView.image = UIImage(named: "new_feature_\(imageIndex + 1)")
            
            startBtn.isHidden = true
        }
    }
    
    private var startBtn: UIButton = UIButton("开始体验", .white, "new_feature_finish_button")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(iconView)
        addSubview(startBtn)
        
        iconView.frame = bounds
        
        startBtn.snp.makeConstraints { make in
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(self.snp.bottom).multipliedBy(0.9)
        }
        
        startBtn.addTarget(self, action: #selector(clcikSatrtBtn), for: .touchUpInside)
    }
    
    fileprivate func showStartBtnAnimation() {
        startBtn.isHidden = false
        
        startBtn.transform = CGAffineTransformMakeScale(0, 0)
        startBtn.isUserInteractionEnabled = false
        
        UIView.animate(
            withDuration: 1.4,
            delay: 0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 10,
            options: []
        ) {
            self.startBtn.transform = CGAffineTransformIdentity
        } completion: { Void in
            self.startBtn.isUserInteractionEnabled = true
        }
    }
    
    @objc private func clcikSatrtBtn() {
        print("开始体验")
        NotificationCenter.default.post(name: Notification.Name(SwitchRootViewControllerNotification), object: nil)
    }
}
