//
//  HomeListViewModel.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/10/13.
//

import Foundation

class HomeListViewModel {
    lazy var statusList = [HomeItemViewModel]()
    
    func loadList(_ finished: @escaping (_ isSuccess: Bool) -> ()) {
        NetwokAPI.loadHomeList { (res, err) in
            if err != nil {
                
                finished(false)
                return
            }
            
            guard let dict = res as? [String: Any], let array = dict["statuses"] as? [[String: Any]] else {
                
                finished(false)
                return
            }
            
            var list = [HomeItemViewModel]()
            for dict in array {
                let model = JsonUtil.dictionaryToModel(dict, StatusListModel.self) as! StatusListModel
                list.append(HomeItemViewModel(status: model))
            }
            
            self.statusList = list + self.statusList
                                    
            finished(true)
        }
    }
}
