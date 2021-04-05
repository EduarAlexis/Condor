//
//  GenerationViewController.swift
//  pruebaCondor
//
//  Created by Eduar Peña Velasco on 4/04/21.
//

import UIKit

class GenerationViewController: BaseViewController {

    fileprivate var viewModel = GenerationViewModel()
    private var dispatchGroup:DispatchGroup = DispatchGroup()
    public var pokemons: Generation?
    public var idGeneration: String?
    
    @IBOutlet weak var tableViewPokemons: UITableView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.navigator = self
        tableViewPokemons.delegate = self
        tableViewPokemons.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupView()
    }
       
    private func setupView() {
        titleLabel.text = "Pokemons Generation - \(idGeneration!)"
        viewModel.inicializar(dispatchGroup: dispatchGroup, idGeneration: idGeneration)
    }
    
    static func start(_ current: UIViewController, idGeneration: String?) {
        let storyboard = UIStoryboard(name: "Generation", bundle: nil)
        let new = storyboard.instantiateViewController(identifier: String(describing: self)) as GenerationViewController
        new.modalPresentationStyle = .fullScreen
        new.idGeneration = idGeneration
        current.navigationController?.pushViewController(new, animated: true)
    }
}

extension GenerationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        PokemonViewController.start(self, urlPokemon: self.pokemons?.pokemonSpecies[indexPath.row].url)
    }
}

extension GenerationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemons?.pokemonSpecies.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewPokemons.dequeueReusableCell(withIdentifier: "pokemons_cell")
        cell?.textLabel?.text = self.pokemons?.pokemonSpecies[indexPath.row].name
        cell?.textLabel?.tintColor = .darkGray
        return cell!
    }
}

extension GenerationViewController: GenerationNavigator {
    func getGeneration(generation: Generation?) {
        self.pokemons = generation
        self.tableViewPokemons.reloadData()
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
