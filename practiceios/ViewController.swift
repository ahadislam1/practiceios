//
//  ViewController.swift
//  practiceios
//
//  Created by Ahad Islam on 12/2/20.
//

import UIKit

class ViewController: UIViewController {
    
    /*
    https://itunes.apple.com/search?media=podcast&limit=200&term=swift
Use the endpoint above to create a model and an API Client.
Add a search bar and table view to your main view controller.
Populate the table view with the podcasts.
Each cell should at minimum display an image (use the 100px image) and the name of the Podcast.
The user should be able to search for any podcast.
Selecting a particular podcast should segue to a detail view, use the larger 600px image. If time allows:
Write adequate unit tests.
    */

    var podcasts = [Podcast]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        // Do any additional setup after loading the view.
    }

    func loadData(query: String = "swift") {
        let encodedQuery = query.lowercased().addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""

        let url = "https://itunes.apple.com/search?media=podcast&limit=200&term=" + encodedQuery
        GenericCoderAPI.manager.getJSON(objectType: PodcastCollection.self, with: url) { [weak self] result in
            switch result {
                case .failure(let error):
                print(error)
                case .success(let wrapper):
                self?.podcasts = wrapper.results
            }
        }


    }

}

