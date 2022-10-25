//
//  HomeTableViewController.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/9/27.
//

import UIKit

let listCellId = "listCellId"

class HomeTableViewController: VisitorTableViewController {
    
    private lazy var listViewModel = HomeListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !UserAccountViewModel.shared.userLogin {
            visitorView?.setupInfo(nil, "关注一些人，回这里看看有什么惊喜")
            return
        }
        
        
        setupTableView()
        
        loadData()
    }
    
    private func loadData() {
        
        listViewModel.loadList { isSuccess in
            if !isSuccess {
                self.view.makeToast("加载数据出错了~")
                return
            }
            
            self.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView.estimatedRowHeight = 200
        tableView.separatorStyle = .none
        tableView?.register(HomeStatusCell.self, forCellReuseIdentifier: listCellId)
    }
}

extension HomeTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listViewModel.statusList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: listCellId, for: indexPath) as! HomeStatusCell
        cell.statusViewModel = listViewModel.statusList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return listViewModel.statusList[indexPath.row].rowHeight
    }
}
