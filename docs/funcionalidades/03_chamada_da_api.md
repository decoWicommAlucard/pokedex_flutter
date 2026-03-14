# Chamada da API

## O que esta documentacao explica

Este guia acompanha o caminho completo da listagem da PokeAPI ate a interface.

## Arquivos envolvidos

- `lib/main.dart`
- `lib/pages/home/home.page.dart`
- `lib/pages/detail/detail.page.dart`
- `lib/pages/detail/stores/detail.store.dart`
- `lib/store/home.store.dart`
- `lib/services/poke_api.service.dart`
- `lib/models/poke_response.model.dart`
- `lib/models/pokemon.model.dart`
- `lib/models/pokemon_details.model.dart`
- `lib/models/stat.model.dart`
- `lib/models/pokemon_stat.model.dart`
- `lib/models/pokemon_type.model.dart`
- `lib/widgets/characteristc.widget.dart`
- `lib/widgets/percentage_indicator.widget.dart`
- `lib/widgets/poke_card.widget.dart`

## Visao geral do fluxo

1. `main.dart` abre a `HomePage`.
2. `HomePage` chama `store.loadPokemons()` no `initState`.
3. `HomeStore` delega a busca para `PokeApiService`.
4. `PokeApiService` faz `GET /pokemon?offset=...&limit=20`.
5. o JSON vira `PokeResponse`.
6. cada item de `results` vira um `Pokemon`.
7. a store adiciona os resultados em `pokemons`.
8. o `Observer` reconstrui a grade.
9. o `PokeCard` exibe nome, numero e imagem.
10. ao tocar no card, a `DetailPage` recebe o mesmo `Pokemon`.
11. a `DetailPage` cria a `DetailStore`;
12. a tela consulta `/pokemon/{id}` ao abrir.

## Quem dispara a chamada

```dart
@override
void initState() {
  super.initState();
  store.loadPokemons();
  scrollController.addListener(scrollListener);
}
```

A `HomePage` nao faz HTTP diretamente. Ela apenas pede para a store carregar os dados.

## Quem controla o carregamento

```dart
@action
Future<void> loadPokemons() async {
  isLoading = true;

  final pokeResponse = await _service.getPokemon(offset: offset);

  offset += 20;
  pokemons.addAll(pokeResponse.results);

  isLoading = false;
}
```

Papel da store:

1. ligar e desligar `isLoading`;
2. controlar `offset`;
3. salvar os itens em `pokemons`;
4. expor `filteredPokemons` para a tela.

## Onde a chamada HTTP acontece

```dart
class PokeApiService {
  late final Uno _uno;

  PokeApiService() {
    _uno = Uno(baseURL: "https://pokeapi.co/api/v2");
  }
}
```

```dart
Future<PokeResponse> getPokemon({required int offset}) async {
  final response = await _uno.get("/pokemon?offset=$offset&limit=20");

  if (response.status != HttpStatus.ok) {
    throw Exception("Failed to load pokemon");
  }

  return PokeResponse.fromJson(response.data);
}
```

O service centraliza a base URL e devolve um objeto Dart pronto para a store.

Para detalhe:

```dart
Future<PokemonDetails> getPokemonDetail({required String id}) async {
  final response = await _uno.get("/pokemon/$id");

  if (response.status != HttpStatus.ok) {
    throw Exception("Failed to load pokemon detail");
  }

  return PokemonDetails.fromJson(response.data);
}
```

## Como o JSON vira model

`PokeResponse` converte o envelope da listagem:

```dart
factory PokeResponse.fromJson(Map<String, dynamic> json) {
  return PokeResponse(
    count: json['count'],
    next: json['next'],
    previous: json['previous'],
    results: (json['results'] as List)
        .map((e) => Pokemon.fromJson(e))
        .toList(),
  );
}
```

`Pokemon` converte cada item da lista:

```dart
factory Pokemon.fromJson(Map<String, dynamic> json) {
  return Pokemon(name: json['name'], url: json['url']);
}
```

Depois disso, o model ainda calcula:

- `id`, a partir da `url`;
- `imageUrl`, a partir do `id`.

Na camada de detalhe, `PokemonDetails.fromJson(...)` tambem converte:

- `stats` em `Stat`;
- o bloco interno `stat` em `PokemonStat`;
- `types` em `PokemonType`.

## Como a interface usa esses dados

No card:

```dart
CachedNetworkImage(
  imageUrl: widget.pokemon.imageUrl,
  height: 130,
)
```

```dart
Text(widget.pokemon.name)
Text(widget.pokemon.id.padLeft(4, '0'))
```

Isso significa que a API alimenta a UI por meio do model, nao diretamente por mapas JSON.

## Como a tela de detalhe entra nesse fluxo

A `DetailPage` continua recebendo o `Pokemon` vindo da lista:

```dart
builder: (context) => DetailPage(pokemon: pokemon),
```

Com isso, nome, id, imagem e cor ja ficam disponiveis para a transicao inicial.

Ao mesmo tempo, o projeto ja possui a camada de detalhe pronta:

```dart
final pokeResponse = await _service.getPokemonDetail(id: id);
pokemonDetails = pokeResponse;
```

Ou seja, a chamada de detalhe ja faz parte do fluxo real da tela.

Depois da resposta chegar, a tela usa:

- `Characteristc` para `height`, `baseExperience` e `weight`;
- `PercentageIndicator` para cada item de `stats`.

## O que a rota de listagem entrega

A rota usada hoje e:

```text
/pokemon?offset=...&limit=20
```

Ela entrega:

- total de registros;
- URLs de paginacao;
- `name` e `url` de cada Pokemon.

Ela nao entrega nessa listagem:

- tipos completos;
- habilidades;
- peso e altura;
- stats detalhados.

## O que a rota de detalhe entrega

A rota:

```text
/pokemon/{id}
```

ja permite buscar:

- peso;
- altura;
- experiencia base;
- stats;
- tipos.

## Limitacoes atuais

- `loadPokemons()` nao impede chamadas simultaneas;
- nao existe tratamento visual de erro;
- a busca filtra apenas itens ja carregados.

## Resumo

O fluxo da API neste projeto agora tem duas frentes:

1. a `HomePage` pede dados para a store;
2. a store usa o service;
3. o service fala com a PokeAPI;
4. os models convertem a resposta;
5. a listagem vira `Pokemon` e alimenta a grade;
6. o detalhe vira `PokemonDetails` e alimenta a `DetailPage`, que mostra nome, ID, tipos, caracteristicas e stats.
