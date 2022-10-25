//
//  HomeStatusCell.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/10/13.
//

import UIKit

class HomeStatusCell: UITableViewCell {
    
    var statusViewModel: HomeItemViewModel? {
        didSet {
            topView.statusViewModel = statusViewModel
            contentLabel.text = statusViewModel?.status.text
            pictureView.viewModel = statusViewModel
            pictureView.snp.updateConstraints { make in
                make.width.equalTo(pictureView.bounds.width)
                make.height.equalTo(pictureView.bounds.height)
                
                let offset = statusViewModel?.thumbnailUrls?.count ?? 0 > 0 ? sideMargin_ : 0
                make.top.equalTo(contentLabel.snp.bottom).offset(offset)
            }
        }
    }
    
    private lazy var headSepView: UIView = {
        let view = UIView()
        view.backgroundColor = BackColor
        return view
    }()
    
    private lazy var topView = HomeStatusTopView()
    private lazy var contentLabel = UILabel(title: "微博正文", fontSize: 15, align: .left, screenInset: sideMargin_)
    private lazy var pictureView = StatusPicureView()
    private lazy var bottomView = HomeStatusBottomView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupUI()
    }
    
    func rowHeight(vm: HomeItemViewModel) -> CGFloat {
        statusViewModel = vm
        contentView.layoutIfNeeded()
        return CGRectGetMaxY(bottomView.frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension HomeStatusCell {
    private func setupUI() {
        
        contentView.addSubview(headSepView)
        contentView.addSubview(topView)
        contentView.addSubview(contentLabel)
        contentView.addSubview(pictureView)
        contentView.addSubview(bottomView)
        
        headSepView.snp.makeConstraints { make in
            make.top.left.right.equalTo(contentView)
            make.height.equalTo(sideMargin_)
        }
        
        topView.snp.makeConstraints { make in
            make.top.equalTo(headSepView.snp.bottom)
            make.left.right.equalTo(contentView)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(sideMargin_)
            make.left.equalTo(contentView).offset(sideMargin_)
        }
        
        pictureView.snp.makeConstraints { make in
            make.top.equalTo(contentLabel.snp.bottom).offset(sideMargin_)
            make.left.equalTo(contentLabel)
            make.width.equalTo(300)
            make.height.equalTo(90)
        }
        
        bottomView.snp.makeConstraints { make in
            make.top.equalTo(pictureView.snp.bottom).offset(sideMargin_)
            make.left.right.equalTo(contentView)
            make.height.equalTo(44)
//            make.bottom.equalTo(contentView)
        }
    }
}
