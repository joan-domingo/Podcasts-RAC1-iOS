//
//  ProgramViewController.swift
//  Random1
//
//  Created by Joan Domingo Sallent on 21/03/2017.
//
//

import UIKit
import Alamofire

class ProgramViewController: UITableViewController {
    
    //MARK: Properties
    
    //var programs = [Program]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        loadPrograms()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Private Methods
    
    private func loadPrograms() {
        
        Alamofire.request("http://www.rac1.cat/audioteca/api/app/v1/programs").responseString { response in
            print("Success: \(response.result.isSuccess)")
            print("Response String: \(response.result.value)")
        }
    }

}

