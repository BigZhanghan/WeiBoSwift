//
//  HomeStatusBottomView.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/10/13.
//

import UIKit

class HomeStatusBottomView: UIView {
    private lazy var retweetedBtn = UIButton(title: "转发", color: .gray, image: "timeline_icon_retweet")
    private lazy var commentBtn = UIButton(title: "评论", color: .gray, image: "timeline_icon_comment")
    private lazy var likeBtn = UIButton(title: "赞", color: .gray, image: "timeline_icon_like")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeStatusBottomView {
    private func setupUI() {
        backgroundColor = UIColor(white: 0.98, alpha: 1.0)
        
        addSubview(retweetedBtn)
        addSubview(commentBtn)
        addSubview(likeBtn)
        
        let sepLine1 = sepLineView()
        let sepLine2 = sepLineView()
        addSubview(sepLine1)
        addSubview(sepLine2)
        
        retweetedBtn.snp.makeConstraints { make in
            make.top.left.bottom.equalTo(self)
        }
        
        commentBtn.snp.makeConstraints { make in
            make.top.bottom.equalTo(retweetedBtn)
            make.left.equalTo(retweetedBtn.snp.right)
            make.width.equalTo(retweetedBtn)
        }
        
        likeBtn.snp.makeConstraints { make in
            make.top.bottom.equalTo(retweetedBtn)
            make.left.equalTo(commentBtn.snp.right)
            make.width.equalTo(retweetedBtn)
            make.right.equalTo(self)
        }
        
        let w = 0.5
        let scale = 0.4
        
        sepLine1.snp.makeConstraints { make in
            make.right.centerY.equalTo(retweetedBtn)
            make.width.equalTo(w)
            make.height.equalTo(retweetedBtn).multipliedBy(scale)
        }
        
        sepLine2.snp.makeConstraints { make in
            make.right.centerY.equalTo(commentBtn)
            make.width.equalTo(w)
            make.height.equalTo(commentBtn).multipliedBy(scale)
        }
    }
    
    private func sepLineView() -> UIView {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }
}
