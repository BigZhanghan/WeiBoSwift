//
//  HomeStatusTopView.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/10/13.
//

import UIKit

let sideMargin_ = 15.0
let avatarHeight = 40.0

class HomeStatusTopView: UIView {
    
    var statusViewModel: HomeItemViewModel? {
        didSet {
            avatarImageView.kf.setImage(with: statusViewModel?.profileUrl, placeholder: statusViewModel?.defaultImage)
            vipIconView.image = statusViewModel?.vipImage
            nameLabel.text = statusViewModel?.status.user?.screenName
            memberIconView.image = statusViewModel?.memberImage
            timeLabel.text = "刚刚"
            sourceLabel.text = "来自 新浪博博"
        }
    }
    
    private lazy var avatarImageView = UIImageView("avatar_default")
    private lazy var memberIconView = UIImageView("common_icon_membership_level1")
    private lazy var vipIconView = UIImageView("avatar_vgirl")
    private lazy var nameLabel = UILabel(title: "涵涵", fontSize: 14)
    private lazy var timeLabel = UILabel(title: "刚刚", fontSize: 12, color: .orange)
    private lazy var sourceLabel = UILabel(title: "新浪博博", fontSize: 12)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeStatusTopView {
    private func setupUI() {
        addSubview(avatarImageView)
        addSubview(memberIconView)
        addSubview(vipIconView)
        addSubview(nameLabel)
        addSubview(timeLabel)
        addSubview(sourceLabel)
        
        avatarImageView.snp.makeConstraints { make in
            make.left.top.equalTo(self).offset(sideMargin_)
            make.size.equalTo(avatarHeight)
            make.bottom.equalTo(self)
        }
        
        vipIconView.snp.makeConstraints { make in
            make.centerX.equalTo(avatarImageView.snp.right)
            make.centerY.equalTo(avatarImageView.snp.bottom)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView.snp.right).offset(sideMargin_)
            make.top.equalTo(avatarImageView)
        }
        
        memberIconView.snp.makeConstraints { make in
            make.left.equalTo(nameLabel.snp.right).offset(sideMargin_)
            make.centerY.equalTo(nameLabel)
        }
        
        timeLabel.snp.makeConstraints { make in
            make.left.equalTo(avatarImageView.snp.right).offset(sideMargin_)
            make.bottom.equalTo(avatarImageView)
        }
        
        sourceLabel.snp.makeConstraints { make in
            make.left.equalTo(timeLabel.snp.right).offset(sideMargin_)
            make.centerY.equalTo(timeLabel)
        }
    }
}
