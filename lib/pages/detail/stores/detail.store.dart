import 'package:mobx/mobx.dart';
import 'package:pokedex_flutter/models/pokemon_details.model.dart';
import 'package:pokedex_flutter/services/poke_api.service.dart';
part 'detail.store.g.dart';

class DetailStore = DetailStoreBase with _$DetailStore;

abstract class DetailStoreBase with Store {
  final _service = PokeApiService();

  @observable
  bool isLoading = false;

  @observable
  PokemonDetails? pokemonDetails;

  @action
  Future<void> getPokemonDetailsData(String id) async {
    isLoading = true;

    final pokeResponse = await _service.getPokemonDetail(id: id);
    pokemonDetails = pokeResponse;

    isLoading = false;
  }
}
