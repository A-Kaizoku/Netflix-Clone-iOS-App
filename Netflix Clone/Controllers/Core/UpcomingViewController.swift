//
//  UpcomingViewController.swift
//  Netflix Clone
//
//  Created by Mayank on 04/08/22.
//

import UIKit

class UpcomingViewController: UIViewController {
    
    private var titles: [Title] = [Title]()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(upcomingTable)
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        upcomingTable.dataSource = self
        upcomingTable.delegate = self
        fetchUpcoming()
    }
    
    /// This is a convenient way to create and configure a UI component in Swift, and it's often used for creating views programmatically.
    
    /// = { ... }(): This is an immediately-invoked closure (sometimes called a "self-executing closure" or "auto-invoking closure"). The curly braces { ... } define the closure, and the () at the end immediately invokes it. This means that the code within the curly braces is executed right at the moment when upcomingTable is declared.
    private var upcomingTable: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.separatorStyle = .none
        table.register(TitleTableViewCell.self, forCellReuseIdentifier: TitleTableViewCell.identifier)
        return table
    }()
    
    // if you will look closely you will see that even if we configure the tableView with cells we still wont be able to see the tableView in our UI because we havent set the Layout for it yet
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        upcomingTable.frame = view.bounds
    }
    
    public func fetchUpcoming() {
        //weak self to prevent any memory leaks
        // getUcomingMovies function has a closure attached to it which will run the below code asynchronously, learn more about closures.
        APICaller.shared.getUpcomingMovies{ [weak self] results in
        switch results {
            case .success(let titles): self?.titles = titles
                DispatchQueue.main.async {
                    self?.upcomingTable.reloadData()
                }
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
}

extension UpcomingViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell: TitleTableViewCell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as? TitleTableViewCell else { return UITableViewCell() }
        let title = titles[indexPath.row]
        cell.configure(with: TitleViewModel(titleName: (title.original_name ?? title.original_title) ?? "Unknown titlename ", posterURL: title.poster_path ?? ""))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
}
