//
//  HourPodcastsViewController.swift
//  Random1
//
//  Created by Joan Domingo Sallent on 27/03/2017.
//
//

import UIKit
import Alamofire
import SwiftyJSON

class HourPodcastsViewController: UITableViewController {
    
    //MARK: Properties
    
    /*
     This value is passed by `ProgramViewController` in `prepare(for:sender:)`.
     */
    var program: Program?
    
    var podcasts = [Podcast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadPodcasts()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "PodcastTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PodcastTableViewCell else {
            fatalError("The dequeued cell is not an instance of PodcastTableViewCell.")
        }
        
        // Fetches the appropriate program for the data source layout.
        let podcast = podcasts[indexPath.row]
        
        cell.podcastTitleLabel.text = podcast.title
        
        return cell
    }
    
    //MARK: Private Methods
    
    private func loadPodcasts() {
        
        Alamofire.request("http://www.rac1.cat/audioteca/api/app/v1/sessions/" + (program?.id)!).validate().responseJSON { response in
            switch response.result {
                
            case .success(let value):
                
                for jsonPodcast in JSON(value)["result"].array! {
                    let podcast = Podcast(title: jsonPodcast["appMobileTitle"].string!)
                    self.podcasts.append(podcast!)
                }
                
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
