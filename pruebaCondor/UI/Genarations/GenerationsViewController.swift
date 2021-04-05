//
//  GenerationViewController.swift
//  pruebaCondor
//
//  Created by Eduar Peña Velasco on 4/04/21.
//

import UIKit

class GenerationsViewController: BaseViewController {

    @IBOutlet weak var tableViewGenerations: UITableView!
    
    var generations: Generations?
    fileprivate var viewModel = GenerationsViewModel()
    private var dispatchGroup:DispatchGroup = DispatchGroup()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewGenerations.delegate = self
        tableViewGenerations.dataSource = self
        viewModel.navigator = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
       
    private func setupView() {
        viewModel.inicializar(dispatchGroup: dispatchGroup)
    }
}

extension GenerationsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        GenerationViewController.start(self, idGeneration: "\(indexPath.row + 1)")
    }
}

extension GenerationsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        generations?.results?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewGenerations.dequeueReusableCell(withIdentifier: "generation_cell")
        cell?.textLabel?.text = self.generations?.results?[indexPath.row].name
        cell?.textLabel?.tintColor = .darkGray
        return cell!
    }
}


extension GenerationsViewController: GenerationsNavigator {

    func getGenerations(generations: Generations?) {
        self.generations = generations
        self.tableViewGenerations.reloadData()
    }
    
    func showError(error: String) {
        let alert = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func getUINotifier() -> GeneralUIControllerNotifier {
        return generalUINotifier
    }
}
