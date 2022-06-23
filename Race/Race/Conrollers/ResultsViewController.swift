//
//  ResultsViewController.swift
//  Race
//
//  Created by Volha Furs on 10.05.22.
//

import UIKit

class ResultsViewController: UIViewController {

    private var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
    }
    
    private func setUpTableView() {
        tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    override func viewWillLayoutSubviews() {
        tableView.frame = view.bounds
    }

}
extension ResultsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let dataArray = ResultsManager.loadData() else {
            return 0
        }
       return dataArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        guard let dataArray = ResultsManager.loadData() else {
            return UITableViewCell()
        }
        let currentGameResult = dataArray[indexPath.row]
        cell.textLabel?.text = "\(currentGameResult.timeGame) seconds, \(currentGameResult.date)"
        return cell
    }
     
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height: CGFloat = indexPath.row % 2 == 0 ? 80 : 80
        return height
    }
}
