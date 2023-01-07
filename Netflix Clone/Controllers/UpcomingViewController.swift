//
//  UpcomingViewController.swift
//  Netflix Clone
//
//  Created by Mayank on 04/08/22.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    private var titles:[Title]=[Title]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(upcomingTable)
        title="Upcoming"
        navigationController?.navigationBar.prefersLargeTitles=true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        upcomingTable.dataSource = self
        upcomingTable.delegate = self
        
        fetchUpcoming()
        
    }
    
    private var upcomingTable : UITableView={
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        return table
    }()
    
    // if you will look closely you will see that even if we configure the tableView with cells we still wonnt be able to see the tableView in our UI because we havent set the Layout for it yet
    
    override func viewDidLayoutSubviews() {
      
            super.viewDidLayoutSubviews()
            upcomingTable.frame=view.bounds
        
    }
    
    public func fetchUpcoming(){
        //weak self to prevent any memory leaks
        APICaller.shared.getUpcomingMovies { [weak self] results in
            
            switch results{
            case .success(let titles): self?.titles = titles
                DispatchQueue.main.async {
                    self?.upcomingTable.reloadData()
                }

            case .failure(let error): print(error.localizedDescription)
            }
        
        }
    }

}

extension UpcomingViewController : UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        //cell.tintColor = .red
        //cell.backgroundColor = .systemPink
        cell.textLabel?.text=titles[indexPath.row].original_name ?? titles[indexPath.row].original_title ?? "Unknown"
        return cell
    }
}
