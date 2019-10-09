//
//  ViewController.swift
//  Loadmorepulltorefresh
//
//  Created by Admin on 9/24/19.
//  Copyright © 2019 Ngoc. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    var list = [Int]()
    var pageNUmber = 0
    var pageTotal = 3
    var pageSize = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadMore()
        
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc func refreshData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.list = [Int](0...10)
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = String(list[indexPath.row])
        return cell
    }
    
    
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == list.count - 1 {
            //guard pageNUmber < pageTotal  else { return }
            loadMore()
        }
    }
    
    
    
    func loadMore(){
        //guard pageNUmber < pageTotal else { return }
        
        let lastRequest = pageNUmber == pageTotal - 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.list += [Int](0...self.pageSize)
            self.tableView.reloadData()
            self.pageNUmber += 1
            if lastRequest {
                self.activityIndicatorView.stopAnimating()
            }
        }
    }
}

