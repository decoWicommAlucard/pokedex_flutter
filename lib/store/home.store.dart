import 'package:mobx/mobx.dart';
import 'package:pokedex_flutter/models/pokemon.model.dart';
import 'package:pokedex_flutter/services/poke_api.service.dart';
part 'home.store.g.dart';

class HomeStore = HomeStoreBase with _$HomeStore;

abstract class HomeStoreBase with Store {
  @observable
  bool isLoading = false;

  @observable
  ObservableList<Pokemon> pokemons = <Pokemon>[].asObservable();

  @action
  Future<void> loadPokemons() async {
    isLoading = true;

    final pokeResponse = await PokeApiService().getPokemon();
    pokemons = pokeResponse.results.asObservable();

    isLoading = false;
  }
}
