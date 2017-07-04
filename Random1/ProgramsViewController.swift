//
//  ProgramsViewController.swift
//  Random1
//
//  Created by Joan Domingo Sallent on 21/03/2017.
//
//

import UIKit
/*import Alamofire
import SwiftyJSON
import Kingfisher*/
import RxSwift
import RxCocoa

class ProgramsViewController: UITableViewController {
    
    // MARK: - Properties
    
    private let programsViewModel: ProgramsViewModelType
    private let cellIdentifier = "ProgramTableViewCell" // Table view cells are reused and should be dequeued using a cell identifier.
    private let disposeBag = DisposeBag()
    
    // MARK: - Views
    
    var messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    
    // MARK: - Initialization
    
    init() {
        self.programsViewModel = ProgramsViewModel()
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
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 //programs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ProgramTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ProgramTableViewCell.")
        }
        
        // Fetches the appropriate program for the data source layout.
        // let program = programs[indexPath.row]
        
        // cell.programNameLabel.text = program.name
        // cell.programImageView.kf.setImage(with: program.imageUrl)
        
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        /*switch(segue.identifier ?? "") {
            
        case "ShowPodcasts":
            
            guard let hourPodcastsViewController = segue.destination as? HourPodcastsViewController else {
                fatalError("Unexpected destination: \(segue.destination)")
            }
            
            guard let selectedProgramCell = sender as? ProgramTableViewCell else {
                fatalError("Unexpected sender: \(String(describing: sender))")
            }
            
            guard let indexPath = tableView.indexPath(for: selectedProgramCell) else {
                fatalError("The selected cell is not being displayed by the table")
            }
            
            let selectedProgram = programs[indexPath.row]
            hourPodcastsViewController.program = selectedProgram
            
        default:
            fatalError("Unexpected Segue Identifier; \(String(describing: segue.identifier))")
        }*/
    }
    
    //MARK: Private Methods
    
    private func setupView() {
        tableView.register(ProgramTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
    }
    
    private func setupBindings() {
        self.title = "Some random title"
        tableView.dataSource = nil
        
        programsViewModel.programs.bind(to: tableView.rx.items(cellIdentifier: "ProgramTableViewCell")) { index, model, cell in
            cell.textLabel?.text = model.name
        }
        .disposed(by: disposeBag)
    }
    
    /*private func loadPrograms() {
        progressBarDisplayer()
        
        Alamofire.request("http://www.rac1.cat/audioteca/api/app/v1/programs").validate().responseJSON { response in
            self.hideProgressBar()
            
            switch response.result {
                
            case .success(let value):
                
                for jsonProgram in JSON(value)["result"].array! {
                    let program = Program(id: jsonProgram["id"].string!,
                                          name: jsonProgram["title"].string!,
                                          imageUrl: jsonProgram["images"]["person-small"].string!)
                    self.programs.append(program!)
                }
                
                self.tableView.reloadData()
                
            case .failure(let error):
                let alertController = UIAlertController(title: NSLocalizedString("Error", comment: "Network error"), message: error.localizedDescription, preferredStyle: .alert)
                let defaultAction = UIAlertAction(title: NSLocalizedString("Retry", comment: "Retry loading remote data"), style: .default, handler: {
                    (alert: UIAlertAction!) in self.loadPrograms()
                })
                alertController.addAction(defaultAction)
                
                self.present(alertController, animated: true)
            }
        }
    }*/
    
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

