//
//  PokemonViewController.swift
//  pruebaCondor
//
//  Created by Eduar Peña Velasco on 4/04/21.
//

import UIKit

class PokemonViewController: BaseViewController {

    private let kLike = "LIKE"
    private let kDisLike = "DISLIKE"
    private var pokemonDetails: PokemonDetails?
    fileprivate var viewModel = PokemonViewModel()
    private var dispatchGroup:DispatchGroup = DispatchGroup()
    private var likeCount: Int32 = 0
    private var disLikeCount: Int32 = 0
    
    @IBOutlet weak var pokemonNameLbl: UILabel!
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var containerDetails: UIView!
    
    @IBOutlet weak var numLikesLbl: UILabel!
    @IBOutlet weak var numDislikeLbl: UILabel!
    
    @IBOutlet weak var pokemonDexLbl: UILabel!
    @IBOutlet weak var pokemonWeightLbl: UILabel!
    @IBOutlet weak var pokemonHeightLbl: UILabel!
    @IBOutlet weak var pokemonIsLegendaryLbl: UILabel!
    @IBOutlet weak var pokemonIsMythicalLbl: UILabel!
    @IBOutlet weak var pokemonAbilitiesLbl: UILabel!
    @IBOutlet weak var pokemonMovesLbl: UILabel!

    @IBAction func likeAction(_ sender: Any) {
        likeCount = likeCount + 1
        numLikesLbl.text = "\(likeCount)"
        UserDefaults.standard.set(likeCount, forKey: "\(kLike)_\(String(describing: pokemonDetails!.firstDetail.name))")
        UserDefaults.standard.synchronize()
    }
    
    @IBAction func dislikeAction(_ sender: Any) {
        disLikeCount = disLikeCount + 1
        numDislikeLbl.text = "\(disLikeCount)"
        UserDefaults.standard.set(disLikeCount, forKey: "\(kDisLike)_\(String(describing: pokemonDetails!.firstDetail.name))")
        UserDefaults.standard.synchronize()
    }
    
    private func getLikes() {
        if let value = UserDefaults.standard.string(forKey: "\(kLike)_\(String(describing: pokemonDetails!.firstDetail.name))") {
            likeCount = Int32(value) ?? 0
            numLikesLbl.text = "\(likeCount)"
        } else {
            likeCount = 0
        }
    }
    
    private func getDisLikes() {
        if let value = UserDefaults.standard.string(forKey: "\(kDisLike)_\(String(describing: pokemonDetails!.firstDetail.name))") {
            disLikeCount = Int32(value) ?? 0
            numDislikeLbl.text = "\(disLikeCount)"
        } else {
            disLikeCount = 0
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.navigator = self
        viewModel.inicializar(dispatchGroup: dispatchGroup)
        containerDetails.borderView(radius: 4.0)
    }

    private func loadDataView() {
        getLikes()
        getDisLikes()
        pokemonNameLbl.text = pokemonDetails?.firstDetail.name
        let urlImage = pokemonDetails?.secondDetail.sprites.frontDefault
        if urlImage != nil, let url = URL(string: urlImage!) {
            pokemonImage.load(from: url, contentMode: .scaleAspectFill) { success in
                if !success { self.pokemonImage.image = .pokemon }
            }
        } else {
            pokemonImage.image = .pokemon
        }
        
        pokemonDexLbl.text = "Pokedex: \(String(describing: pokemonDetails!.firstDetail.pokedexNumbers[0].pokedex.name)) - number  \(String(describing: pokemonDetails!.firstDetail.pokedexNumbers[0].entryNumber))"
        pokemonWeightLbl.text = "Weight: \(String(describing: pokemonDetails!.secondDetail.weight))"
        pokemonHeightLbl.text = "Height: \(String(describing: pokemonDetails!.secondDetail.height))"
        pokemonIsLegendaryLbl.text = "Is legendary: \(String(describing: pokemonDetails!.firstDetail.isLegendary))"
        pokemonIsMythicalLbl.text = "Is mythical: \(String(describing: pokemonDetails!.firstDetail.isMythical))"
        
        if (pokemonDetails!.secondDetail.abilities.count > 3 ) {
            pokemonAbilitiesLbl.text = "Abilities: \(String(describing: pokemonDetails!.secondDetail.abilities[0].ability.name)) - \(String(describing: pokemonDetails!.secondDetail.abilities[1].ability.name)) - \(String(describing: pokemonDetails!.secondDetail.abilities[2].ability.name))"
        } else {
            pokemonAbilitiesLbl.text = "Abilities: \(String(describing: pokemonDetails!.secondDetail.abilities.count > 0 ? pokemonDetails!.secondDetail.abilities[0].ability.name: "Not found"))"
        }
        
        if (pokemonDetails!.secondDetail.moves.count > 5 ) {
            pokemonMovesLbl.text = "Moves: \(String(describing: pokemonDetails!.secondDetail.moves[0].move.name)) - \(String(describing: pokemonDetails!.secondDetail.moves[1].move.name)) - \(String(describing: pokemonDetails!.secondDetail.moves[2].move.name)) - \(String(describing: pokemonDetails!.secondDetail.moves[3].move.name)) - \(String(describing: pokemonDetails!.secondDetail.moves[4].move.name))"
        } else {
            pokemonMovesLbl.text = "Moves: \(String(describing: pokemonDetails!.secondDetail.moves.count > 0 ? pokemonDetails!.secondDetail.moves[0].move.name : "Not found"))"
        }
    }
    
    static func start(_ current: UIViewController, urlPokemon: String?) {
        let storyboard = UIStoryboard(name: "Pokemon", bundle: nil)
        let new = storyboard.instantiateViewController(identifier: String(describing: self)) as PokemonViewController
        new.modalPresentationStyle = .fullScreen
        print("\(String(describing: urlPokemon!))")
        new.viewModel.urlPokemon = urlPokemon
        current.navigationController?.pushViewController(new, animated: true)
    }
}

extension PokemonViewController: PokemonNavigator {
    func showDetailsPokemon(firstDetail: FirstPokemonDetails?, secondDetail: SecondPokemonDetails?) {
        pokemonDetails = PokemonDetails(firstDetail: firstDetail!, secondDetail: secondDetail!)
        loadDataView()
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
