//
//  HomeViewController.swift
//  Netflix Clone
//
//  Created by Mayank on 04/08/22.
//

import UIKit

enum Sections : Int {
    case TrendingMovies = 0
    case TrendingTv = 1
    case Popular = 2
    case Upcoming = 3
    case TopRated = 4
}

class HomeViewController: UIViewController {
    
    let sectionTitles: [String] = ["Trending Movies", "Trending Tv", "Popular",  "Upcoming Movies", "Top rated"]
    
    private var homeFeedTable: UITableView = {
        
        //frame and style are provided to tell the tableView that we need headers
        //frame is .zero because we have later on defined the frame in viewDidLayoutSubviews()
        let table: UITableView = UITableView(frame: .zero, style: .grouped)
        table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
        return table
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(homeFeedTable)
        
        homeFeedTable.dataSource = self
        homeFeedTable.delegate = self
        
        configureNavbar()
        
        // tableHeaderView gives header to the whole table
        
        let headerView = HeroHeaderUIView.init(frame:CGRect(x: 0, y: 0, width: view.bounds.width, height: 475))
        homeFeedTable.tableHeaderView = headerView
    }
    
    private func configureNavbar(){
        var image = UIImage(named:"netflixLogo")
        //render the original image without changing inside color
        
        image = image?.resizeImageTo(size: CGSize(width: 30, height: 50))
        image = image?.withRenderingMode(.alwaysOriginal)
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        navigationItem.rightBarButtonItems = [UIBarButtonItem(image: UIImage(systemName: "person"), style: .done, target: self, action: nil),UIBarButtonItem(image: UIImage(systemName: "play.rectangle"), style: .done, target: self, action: nil)]
        
        navigationController?.navigationBar.tintColor = .white
        navigationController?.hidesBarsOnSwipe = true
    }
    
    // give frame to the newly added subview (homeFeedTable)
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
}

extension HomeViewController : UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sectionTitles[section]
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        guard let header = view as? UITableViewHeaderFooterView else {return}
        header.textLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        header.textLabel?.frame = CGRect(x: header.bounds.origin.x, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
        header.textLabel?.textColor = .white
        header.textLabel?.text = header.textLabel?.text?.capitalFirstLetter()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else{
            return UITableViewCell()
        }
        
        //let bravo=indexPath.section
        
        switch indexPath.section {
        case Sections.TrendingMovies.rawValue:
            APICaller.shared.getTrendingMovies { results in
            
            switch results{
                case .success(let titles): cell.configure(with:titles)
                case .failure(let error): print(error.localizedDescription)
            }
            
        }
        case Sections.TrendingTv.rawValue: APICaller.shared.getTrendingTvs { results in
            
            switch results{
                case .success(let titles): cell.configure(with: titles)
                case .failure(let error): print(error.localizedDescription)
            }

        }
        case Sections.Popular.rawValue: APICaller.shared.getPopularMovies { results in
            
            switch results{
                case .success(let titles): cell.configure(with: titles)
                case .failure(let error): print(error.localizedDescription)
            }

        }
        case Sections.Upcoming.rawValue: APICaller.shared.getUpcomingMovies { results in
            
            switch results{
            case .success(let titles): cell.configure(with: titles)

            case .failure(let error): print(error.localizedDescription)

            }

        }
        case Sections.TopRated.rawValue: APICaller.shared.getTopRatedMovies { results in
            
            switch results{
            case .success(let titles): cell.configure(with: titles)

            case .failure(let error): print(error.localizedDescription)

            }

        }
        default:
            return UITableViewCell()
        }
//        cell.textLabel?.text="Hello"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let defaultOffset = view.safeAreaInsets.top
//        let offset=scrollView.contentOffset.y+defaultOffset
//
//        navigationController?.navigationBar.transform = .init(translationX: 0, y: -offset)
    }
    
}

extension UIImage {
    
    func resizeImageTo(size: CGSize) -> UIImage? {
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        self.draw(in: CGRect(origin: CGPoint.zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return resizedImage
    }
}


