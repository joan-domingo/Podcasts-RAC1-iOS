//
//  ProgramsViewController.swift
//  Random1
//
//  Created by Joan Domingo Sallent on 21/03/2017.
//
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

class ProgramsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: - Properties
    
    private let programsViewModel: ProgramsViewModelType
    private let cellIdentifier = "ProgramTableViewCell"
    private let disposeBag = DisposeBag()
    private var programList = [Program]()
    
    // MARK: - Views
    
    private var myTableView: UITableView!
    
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
    
    // MARK: - Table
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedProgram: Program = programList[indexPath.row]
        print("Num: \(indexPath.row)")
        print("Name: \(selectedProgram.name)")
        
        let destination = HourPodcastsViewController(program: selectedProgram)
        navigationController?.pushViewController(destination, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return programList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? ProgramTableViewCell else {
            fatalError("The dequeued cell is not an instance of ProgramTableViewCell.")
        }
        
        let program = programList[indexPath.row]
        cell.titleLabel?.text = program.name
        cell.iconPhoto?.kf.setImage(with: program.imageUrl)
        
        return cell
    }
    
    //MARK: Private Methods
    
    private func setupView() {
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
        
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
        myTableView.register(ProgramTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        myTableView.dataSource = self
        myTableView.delegate = self
        self.view.addSubview(myTableView)
    }
    
    private func setupBindings() {
        self.title = NSLocalizedString("Programs", comment: "programs table title")
        
        programsViewModel.programs
            .observeOn(MainScheduler.instance)
            .subscribe(
                onNext: { programs in
                    self.programList = programs
                    self.myTableView.reloadData()
            },
                onError: { error in
                    print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }

}

