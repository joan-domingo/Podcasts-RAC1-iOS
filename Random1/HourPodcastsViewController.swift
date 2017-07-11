//
//  HourPodcastsViewController.swift
//  Random1
//
//  Created by Joan Domingo Sallent on 27/03/2017.
//
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class HourPodcastsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK: Properties
    
    private let podcastsViewModel: PodcastsViewModelType
    private let cellIdentifier = "PodcastTableViewCell"
    private var selectedProgram: Program
    private var podcastList = [Podcast]()
    private let disposeBag = DisposeBag()
    
    // MARK: - Views
    
    private var myTableView: UITableView!
    
    // MARK: - Initialization
    
    init(program: Program) {
        self.selectedProgram = program
        self.podcastsViewModel = PodcastsViewModel(program: program)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupBindings()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedPodcast: Podcast = podcastList[indexPath.row]
        print("Num: \(indexPath.row)")
        print("Name: \(selectedPodcast.title)")
        
        /*let destination = HourPodcastsViewController(program: selectedProgram)
        navigationController?.pushViewController(destination, animated: true)*/
        
        // TODO
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcastList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? PodcastTableViewCell else {
            fatalError("The dequeued cell is not an instance of PodcastTableViewCell.")
        }
        
        let podcast = podcastList[indexPath.row]
        cell.titleLabel?.text = podcast.title
        cell.iconPhoto?.kf.setImage(with: podcast.imageUrl)
        
        return cell
    }
    
    //MARK: Private Methods
    
    private func setupView() {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        myTableView.register(PodcastTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
    }
    
    private func setupBindings() {
        self.title = selectedProgram.name
        
        podcastsViewModel.podcasts
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { podcasts in
                    self.podcastList = podcasts
                    self.myTableView.reloadData()
            },
                onError: { error in
                    print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    
    /*
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
        
        Alamofire.request("http://www.rac1.cat/audioteca/api/app/v1/sessions/" + (program.id)).validate().responseJSON { response in
            
            switch response.result {
                
            case .success(let value):
                
                for jsonPodcast in JSON(value)["result"].array! {
                    let podcast = Podcast(title: jsonPodcast["appMobileTitle"].string!,
                                          imageUrl: (self.program.imageUrl),
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
    }*/
}
