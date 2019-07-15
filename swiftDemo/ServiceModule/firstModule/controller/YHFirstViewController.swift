//
//  YHFirstViewController.swift
//  swiftDemo
//
//  Created by yinghu on 2019/3/15.
//  Copyright © 2019 yinghu. All rights reserved.
//

import UIKit
import GameplayKit
//import YHFirstDetailController

class YHFirstViewController: UIViewController,UITableViewDelegate {
    
    let viewModel = ListViewModel()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = viewModel
        tableView.delegate = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44
        return tableView
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .white
        self.title = "保险问答"
        view.addSubview(tableView)
        initData()
    }
    
    func initData() {
        for _ in 0 ..< 20 {
            let row: RowType
            let i = arc4random_uniform(3)
            if i == 0 {
                row = generateTwoImageRow()
            } else if i == 1 {
                row = generateImageTextCellRow()
            } else {
                row = generateImageRow()
            }
            tableView.register(row.cellClass, forCellReuseIdentifier: row.reuseIdentifier)
            viewModel.rows.append(row)
        }
    }
    
    
    func generateTwoImageRow() -> Row<TwoImageCell> {
        let row = Row<TwoImageCell>(viewData: NoneItem())
        return row
    }
    
    func generateImageTextCellRow() -> Row<ImageTextCell> {
        let item = ImageTextCellItem(imageName: "flappy", text: "Pablo Ruiz y Picasso (25 October 1881 – 8 April 1973), also known as Pablo Picasso, was a Spanish painter, sculptor, printmaker, ceramicist, stage designer, poet and playwright who spent most of his adult life in France.")
        let row = Row<ImageTextCell>(viewData: item)
        return row
    }
    
    func generateImageRow() -> Row<ImageCell> {
        let row = Row<ImageCell>(viewData: NoneItem())
        return row
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = YHFirstDetailController()
        self.navigationController!.pushViewController(detailVC, animated:true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

class ListViewModel: NSObject, UITableViewDataSource {
    public var rows:[RowType] = []
    
    public func row(at indexPath: IndexPath) -> RowType {
        return rows[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellConfigurator = row(at: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: cellConfigurator.reuseIdentifier, for: indexPath)
        cellConfigurator.update(cell: cell)
        return cell
        
    }
    
    
    
}
