//
//  ProgramViewController.swift
//  Random1
//
//  Created by Joan Domingo Sallent on 21/03/2017.
//
//

import UIKit
import Alamofire
import SwiftyJSON
import Kingfisher

class ProgramViewController: UITableViewController {
    
    var programs = [Program]()
    var messageFrame = UIView()
    var activityIndicator = UIActivityIndicatorView()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //show activity indicator
        progressBarDisplayer()
        
        loadPrograms()
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
        return programs.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "ProgramTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ProgramTableViewCell  else {
            fatalError("The dequeued cell is not an instance of ProgramTableViewCell.")
        }
        
        // Fetches the appropriate program for the data source layout.
        let program = programs[indexPath.row]
        
        cell.programNameLabel.text = program.name
        cell.programImageView.kf.setImage(with: program.imageUrl)
        
        return cell
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        switch(segue.identifier ?? "") {
            
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
        }
    }
    
    //MARK: Private Methods
    
    private func loadPrograms() {
        
        Alamofire.request("http://www.rac1.cat/audioteca/api/app/v1/programs").validate().responseJSON { response in
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
                print(error)
            }
            self.hideProgressBar()
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

