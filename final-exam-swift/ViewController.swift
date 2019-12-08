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
    private var blockArr = [Blocks?]()
    private var isSearching = false
    private var blockStreamService: BlockStreamService?
    private let activityIndicator = UIActivityIndicatorView(style: .gray)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        activityIndicator.center = CGPoint(x: view.bounds.size.width / 2, y: view.bounds.size.height / 2)
        view.addSubview(activityIndicator)

        // Do any additional setup after loading the view.
    }
    
    func updateView() {
        DispatchQueue.main.async { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.tableView.isEditing = strongSelf.isSearching
            strongSelf.activityIndicator.isHidden = !strongSelf.isSearching
            strongSelf.isSearching ? self?.activityIndicator.startAnimating() : strongSelf.activityIndicator.stopAnimating()
            strongSelf.tableView.reloadData()
            
        }
        isSearching = !isSearching

    }


}

extension ViewController: BlockStreamDelegate {
    func requestFailed(with error: APIError) {
        updateView()
    }
    
    func searchCompleted(with block: Blocks) {
        self.block = block
        if let bl = block.height {
            self.block?.height = bl
        }
        updateView()
    }
}


extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return blockArr.count
        return 3

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlockStreamCell", for: indexPath)
        let item = blockArr[indexPath.row]
        cell.textLabel?.text = "\(item!.height ?? 0)"
//        cell.detailTextLabel?.text = item.weight
//        cell.textLabel?.text = "hello"
        return cell
    }
}

extension ViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            DispatchQueue.main.async {
                //self.tableView.isHidden = true
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else { return }
        updateView()
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
                
//                let blocksResponse = try? JSONDecoder().decode(Blocks.self, from: data) as! [Any]
//                print(blocksResponse)
                
                let json = (try! JSONSerialization.jsonObject(with: data)) as! [Any]
                print(json)
//                for json2 in json {
//                    print(json2)
//                }
                
//
                
//                self.blockStreamService?.delegate?.searchCompleted(with: json as! Blocks)
                }
                
            else {
                self.blockStreamService?.delegate?.requestFailed(with: .requestFailed)
            }
            print("hello")
            
        }
//        blockStreamService?.allBlocks(searchHeight: query)
    }
}
//}


