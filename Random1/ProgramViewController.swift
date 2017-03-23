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
    
    //MARK: Properties
    
    var programs = [Program]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
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
    
    //MARK: Private Methods
    
    private func loadPrograms() {
        
        Alamofire.request("http://www.rac1.cat/audioteca/api/app/v1/programs").validate().responseJSON { response in
            switch response.result {
                
            case .success(let value):
                
                for jsonProgram in JSON(value)["result"].array! {
                    let program = Program(name: jsonProgram["title"].string!, imageUrl: jsonProgram["images"]["person-small"].string!)
                    self.programs.append(program!)
                }
                
                self.tableView.reloadData()
                
            case .failure(let error):
                print(error)
            }
        }
    }

}

