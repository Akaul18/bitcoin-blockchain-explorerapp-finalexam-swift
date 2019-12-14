////
////  SearchDetailViewController.swift
////  final-exam-swift
////
////  Created by ankur kaul on 12/12/2019.
////  Copyright © 2019 Langara. All rights reserved.
////
//import UIKit
//
//class SearchDetailViewController: UIViewController {
//    
////    @IBOutlet weak var tableView2: UITableView!
//    
//    @IBOutlet weak var tableView2: UITableView!
//    
//    private var client = APIClient()
//    private var blockStreamService: BlockStreamService?
//    var selectedQuery: String?
//    private var blockArr = [Any]()
//    private var blockArrKeys = ["height","weight","size","transaction","timestamp"]
////    let viewClass: ViewController? = nil
//    private let viewcontroller = ViewController().getquery()
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        tableView2.delegate = (self as UITableViewDelegate)
////        tableView2.dataSource = (self as UITableViewDataSource)
//        tableView2.delegate = self
//        tableView2.dataSource = self
////        let newBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItem.Style.plain, target: self, action: #selector(back))
//
//        hello()
//    }
//    
//    func updateView() {
//        DispatchQueue.main.async { [weak self] in
//            guard let strongSelf = self else { return }
//            //            strongSelf.tableView.isEditing = strongSelf.isSearching
//            //            strongSelf.activityIndicator.isHidden = !strongSelf.isSearching
//            //            strongSelf.isSearching ? self?.activityIndicator.startAnimating() : strongSelf.activityIndicator.stopAnimating()
//            strongSelf.tableView2.reloadData()
//        }
//        //        isSearching = !isSearching
//        
//    }
//    func abcd(x: AnyObject){
//        
////        print(x.value(forKey: "height")!)
//        blockArr.append(x.value(forKey: "height")!)
//        //        print(x.value(forKey: "weight")!)
//        blockArr.append(x.value(forKey: "weight")!)
//        //        print(x.value(forKey: "size")!)
//        blockArr.append(x.value(forKey: "size")!)
//        //        print(x.value(forKey: "tx_count")!)
//        blockArr.append(x.value(forKey: "tx_count")!)
//        //        print(x.value(forKey: "timestamp")!)
//        blockArr.append(x.value(forKey: "timestamp")!)
//        //        print(blockArr.count)
//        print(blockArr)
//        updateView()
//    }
////    @objc func back(sender: UIBarButtonItem) {
////        // Perform your custom actions
////        // ...
////        // Go back to the previous ViewController
////        performSegue(withIdentifier: "SearchDetail", sender: self)
////
//////        self.navigationController?.popViewController(animated: true)
////    }
//    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        if self.isMovingFromParent {
//            // Your code...
//        }
//    }
//    
//    func hello(){
//        
////        print(viewcontroller.)
//        updateView()
//        let request = APIRequest(method: .get, path: "api/blocks/\(String(describing: self.selectedQuery))")
//        request.headers = [HTTPHeader(field: "Content-Type", value: "application/json")]
//        //        print(request.path)
//        //        print(request.headers ?? "abcd")
//        //        print(request.method)
//        client.request(request) { (response, data, error) in
//            guard error == nil else {
//                self.blockStreamService?.delegate?.requestFailed(with: error!)
//                return
//            }
//            
//            if let data = data {
//                let json = (try! JSONSerialization.jsonObject(with: data)) as! [Any]
////                print(json[0])
//                self.abcd(x: json[0] as AnyObject)
//                
////                self.blockArr.append((json[0] as AnyObject).value(forKey: "height")!)
////                //        print(x.value(forKey: "weight")!)
////                self.blockArr.append((json[0] as AnyObject).value(forKey: "weight")!)
//////                //        print(x.value(forKey: "size")!)
////                self.blockArr.append((json[0] as AnyObject).value(forKey: "size")!)
//////                //        print(x.value(forKey: "tx_count")!)
////                self.blockArr.append((json[0] as AnyObject).value(forKey: "tx_count")!)
//////                //        print(x.value(forKey: "timestamp")!)
////                self.blockArr.append((json[0] as AnyObject).value(forKey: "timestamp")!)
//            }else {
//                self.blockStreamService?.delegate?.requestFailed(with: .requestFailed)
//            }
//        }
//        
//    }
//}
//
//extension SearchDetailViewController: BlockStreamDelegate {
//    func requestFailed(with error: APIError) {
//        updateView()
//    }
//    
//    func searchCompleted(with block: Blocks) {
//        updateView()
//    }
//}
//
//
//extension SearchDetailViewController: UITableViewDataSource, UITableViewDelegate {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.blockArr.count
////        return 0
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView2.dequeueReusableCell(withIdentifier: "tableCell2", for: indexPath)
//        let keys = blockArrKeys[indexPath.row]
//        let item = self.blockArr[indexPath.row]
//        cell.textLabel?.text = "\(keys)"
//        cell.detailTextLabel?.text = "\(item)"
//        if ((indexPath.row) % 5 == 0)
//        {
//            cell.backgroundColor = UIColor(red: 0.80, green: 0.6, blue: 0.0, alpha: 1.0)
//        } else {
//            cell.backgroundColor = UIColor(red: 0.80, green: 0.8, blue: 0.4, alpha: 1.0)
//        }
//        return cell
//    }
//}
