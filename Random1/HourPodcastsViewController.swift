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
import Kingfisher

class HourPodcastsViewController: UITableViewController {
    
    //MARK: Properties
    
    /*
     This value is passed by `ProgramViewController` in `prepare(for:sender:)`.
     */
    var program: Program?
    
    var podcasts = [Podcast]()
    var messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        cell.podcastImageView.kf.setImage(with: podcast.imageUrl)
        
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
        case "PlayPodcast":
            
            guard let customAVPlayerViewController = segue.destination as? CustomAVPlayerViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedPodcastCell = sender as? PodcastTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedPodcastCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedPodcast = podcasts[indexPath.row]
            customAVPlayerViewController.imageUrl = selectedPodcast.imageUrl
            customAVPlayerViewController.audioUrl = selectedPodcast.audioUrl
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }
    }
    
    //MARK: Private Methods
    
    private func loadPodcasts() {
        progressBarDisplayer()
        
        Alamofire.request("http://www.rac1.cat/audioteca/api/app/v1/sessions/" + (program?.id)!).validate().responseJSON { response in
            self.hideProgressBar()
            
            switch response.result {
                
            case .success(let value):
                
                for jsonPodcast in JSON(value)["result"].array! {
                    let podcast = Podcast(title: jsonPodcast["appMobileTitle"].string!,
                                          imageUrl: (self.program?.imageUrl)!,
                                          audioUrl: jsonPodcast["path"].string!)
                    self.podcasts.append(podcast!)
                }
                
                self.tableView.reloadData()
                
            case .failure(let error):
                let alertController = UIAlertController(title: NSLocalizedString("Error", comment: "Network error"), message: error.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: NSLocalizedString("Retry", comment: "Retry loading remote data"), style: .default, handler: {
                    (alert: UIAlertAction!) in self.loadPodcasts()
                })
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true)
            }
        }
    }
    
    func progressBarDisplayer() {
        messageFrame = UIView(frame: CGRect(x: view.frame.midX - 25, y: view.frame.midY - 25 , width: 50, height: 50))
        messageFrame.layer.cornerRadius = 15
        messageFrame.backgroundColor = UIColor(white: 0, alpha: 0.7)
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        activityIndicator.startAnimating()
        
        messageFrame.addSubview(activityIndicator)
        view.addSubview(messageFrame)
    }
    
    func hideProgressBar()  {
        messageFrame.removeFromSuperview()
    }
    
}
