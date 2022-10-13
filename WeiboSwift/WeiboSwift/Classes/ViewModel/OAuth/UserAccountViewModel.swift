//
//  UserAccountViewModel.swift
//  WeiboSwift
//
//  Created by zhanghan on 2022/10/10.
//

import Foundation


class UserAccountViewModel {
    
    static let shared = UserAccountViewModel()
    
    var account: UserAccount?
    private var accountPath: String {
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).last!
        return (path as NSString).appendingPathComponent("account.plist")
    }
    
    private var isExpire: Bool {
        if account?.expiresDate?.compare(Date()) == .orderedDescending {
            return false
        }
        return true
    }
    
    var userLogin: Bool {
        return account?.accessToken != nil && !isExpire
    }
    
    var avatarUrl: URL {
        return URL(string: account?.avaterLarge ?? "")!
    }
    
    private init() {
        var url: URL
        if #available(iOS 16.0, *) {
            url = URL(filePath: accountPath)
        } else {
            url = URL(fileURLWithPath: accountPath)
        }
        do {
            let data = try Data(contentsOf: url)
            do {
                try account = NSKeyedUnarchiver.unarchivedObject(ofClass: UserAccount.self, from: data)
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
                
        if isExpire {
            account = nil
        }
    }
}

extension UserAccountViewModel {
    func loadAccesToken(_ code: String, _ finished: @escaping (_ isSuccess: Bool) -> ()) {
        NetwokAPI.loadAccessToken(code) { (res, err) in
            if err != nil {
                finished(false)
                return
            }
                        
            res?.expiresDate = Date(timeIntervalSinceNow: res!.expiresIn)
            self.account = res
            self.getUerInfo(self.account!, finished)
        }
    }
    
    private func getUerInfo(_ account: UserAccount, _ finished: @escaping (_ isSuccess: Bool) -> ()) {
        NetwokAPI.loadUserInfo(account.accessToken!, account.uid!) { (res, err) in
            guard let dict = res as? [String: Any] else {
                finished(false)
                return
            }
            
            account.screenName = dict["screen_name"] as? String
            account.avaterLarge = dict["avatar_large"] as? String
            
            self.saveAccountInfo()
            finished(true)
        }
    }
    
    private func saveAccountInfo() {
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: account!, requiringSecureCoding: false)
            var url: URL
            if #available(iOS 16.0, *) {
                url = URL(filePath: accountPath)
            } else {
                url = URL(fileURLWithPath: accountPath)
            }
            do {
                try data.write(to: url)
            } catch {
                print(error)
            }
        } catch {
            print(error)
        }
    }
}
