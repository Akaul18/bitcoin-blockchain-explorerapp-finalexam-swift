//
//  ViewController.swift
//  final-exam-swift
//
//  Created by ankur kaul on 07/12/2019.
//  Copyright © 2019 Langara. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var client = APIClient()
    private var block: Blocks?
    private var blockArr = [Any]()
    private var blockArrKeys = ["height","weight","size","transaction","timestamp"]
    private var blockArr2 = [Any]()
    private var blockArrKeys2 = [Any]()
//    private var dict = [Any: Any]()
    private var allDataValues = [Any]()
//    private var
//    private var arr = [Any]()
    private var isSearching = false
    private var blockStreamService: BlockStreamService?
    private let activityIndicator = UIActivityIndicatorView(style: .gray)
    var count = 0
    var count2 = 0
    var countQuery = 0
    let searchDetailController = SearchDetailViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BlockCell")
        activityIndicator.center = CGPoint(x: view.bounds.size.width / 2, y: view.bounds.size.height / 2)
        view.addSubview(activityIndicator)
        makeRequest(query: "")
        
//        self.activityIndicator.isHidden = !self.isSearching
//        self.tableView.isEditing = self.isSearching

        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
                navigationItem.title = "One"
            }
    
    
    
//
    func updateView() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
//            strongSelf.tableView.isEditing = strongSelf.isSearching
//            strongSelf.activityIndicator.isHidden = !strongSelf.isSearching
//            strongSelf.isSearching ? self?.activityIndicator.startAnimating() : strongSelf.activityIndicator.stopAnimating()
            strongSelf.tableView.reloadData()
        }
//        isSearching = !isSearching

    }
    
    
    
    func abcd(x: AnyObject){
        
        if count > 0 {
            blockArr.removeAll()
            count = 0
        }
//        print(x.value(forKey: "height")!)
        blockArr.append(x.value(forKey: "height")!)
//        print(x.value(forKey: "weight")!)
        blockArr.append(x.value(forKey: "weight")!)
//        print(x.value(forKey: "size")!)
        blockArr.append(x.value(forKey: "size")!)
//        print(x.value(forKey: "tx_count")!)
        blockArr.append(x.value(forKey: "tx_count")!)
//        print(x.value(forKey: "timestamp")!)
        blockArr.append(x.value(forKey: "timestamp")!)
//        print(blockArr.count)
        updateView()
        count += 1
        count2 = 0
    }
    
    func searchAll(queries: [AnyObject]){

//        for (key, value) in queries {
//            print("\(key) -> \(value)")
//        }
        for eachData in queries{

            blockArrKeys2.append("height")
            blockArr2.append(eachData.value(forKey: "height")!)
            blockArrKeys2.append("weight")
            blockArr2.append(eachData.value(forKey: "weight")!)
            blockArrKeys2.append("size")
            blockArr2.append(eachData.value(forKey: "size")!)
            blockArrKeys2.append("transaction")
            blockArr2.append(eachData.value(forKey: "tx_count")!)
            blockArrKeys2.append("timestamp")
            blockArr2.append(eachData.value(forKey: "timestamp")!)
        }
        count2 = 1
        updateView()
    }
    
    func makeRequest(query: String){
        
        let request = APIRequest(method: .get, path: "api/blocks/\(query)")
        request.headers = [HTTPHeader(field: "Content-Type", value: "application/json")]
        //        print(request.path)
        //        print(request.headers ?? "abcd")
        //        print(request.method)
        client.request(request) { (response, data, error) in
            guard error == nil else {
                self.blockStreamService?.delegate?.requestFailed(with: error!)
                return
            }
            
            if let data = data {
                
                let json = (try! JSONSerialization.jsonObject(with: data)) as! [Any]
                //                self.blockArr.append(json[0])
                
                if self.countQuery == 0 && query == ""{
//                    self.searchAll(data: json as AnyObject)
                    for eachData in json {
                        self.allDataValues.append(eachData)
                    }
//                    self.searchAll(queries: self.allDataValues as [AnyObject])
                    self.searchAll(queries: self.allDataValues as [AnyObject])
//                    self.searchAll(queries: (self.allDataValues as? [NSDictionary])!)
                }else{
                    self.abcd(x: json[0] as AnyObject)
                }
            }
                
            else {
                self.blockStreamService?.delegate?.requestFailed(with: .requestFailed)
            }
        }
        
    }
}

extension ViewController: BlockStreamDelegate {
    func requestFailed(with error: APIError) {
        updateView()
    }
    
    func searchCompleted(with block: Blocks) {
        updateView()
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return blockArr.count
//        print(blockArr.count)
        if count2 > 0{
            return allDataValues.count * 5
        }
        return blockArr.count
//        return 10

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlockCell", for: indexPath)
        
        if count2 > 0{
            let keys = blockArrKeys2[indexPath.row]
            let item = blockArr2[indexPath.row]
            cell.textLabel?.text = "\(keys)"
            cell.detailTextLabel?.text = "\(item)"
        }else{
            let keys = blockArrKeys[indexPath.row]
            let item = blockArr[indexPath.row]
            cell.textLabel?.text = "\(keys)"
            cell.detailTextLabel?.text = "\(item)"
        }
        if ((indexPath.row) % 5 == 0)
        {
            cell.backgroundColor = UIColor(red: 0.80, green: 0.6, blue: 0.0, alpha: 1.0)
        } else {
            cell.backgroundColor = UIColor(red: 0.80, green: 0.8, blue: 0.4, alpha: 1.0)
        }
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            DispatchQueue.main.async {
                //self.tableView.isHidden = true
                self.tableView.reloadData()
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        updateView()
//        makeRequest(query: query)
        performSegue(withIdentifier: "SearchDetail", sender: self)
        searchDetailController.selectedQuery = "\(query)"
        navigationController?.pushViewController(searchDetailController, animated: true)

    }
    
}



