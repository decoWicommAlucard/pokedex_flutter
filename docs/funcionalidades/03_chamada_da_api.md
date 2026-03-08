# Chamada da API

## O que esta documentacao explica

Este guia acompanha o caminho completo da listagem da PokeAPI ate a interface.

## Arquivos envolvidos

- `lib/main.dart`
- `lib/pages/home/home.page.dart`
- `lib/store/home.store.dart`
- `lib/services/poke_api.service.dart`
- `lib/models/poke_response.model.dart`
- `lib/models/pokemon.model.dart`
- `lib/widgets/poke_card.widget.dart`
- `lib/pages/detail/detail.page.dart`

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

## Como a tela de detalhe usa o resultado da listagem

A `DetailPage` ainda nao faz uma chamada extra para detalhes. Ela reaproveita o `Pokemon` recebido da lista:

```dart
builder: (context) => DetailPage(pokemon: pokemon),
```

Com isso, nome, id, imagem e cor ja ficam disponiveis para a transicao inicial.

## O que a rota atual entrega

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

## Limitacoes atuais

- `loadPokemons()` nao impede chamadas simultaneas;
- nao existe tratamento visual de erro;
- a busca filtra apenas itens ja carregados;
- a `DetailPage` nao consulta um endpoint de detalhes.

## Resumo

O fluxo da API neste projeto e:

1. a `HomePage` pede dados para a store;
2. a store usa o service;
3. o service fala com a PokeAPI;
4. os models convertem a resposta;
5. a store salva os objetos;
6. a UI exibe os dados e reaproveita o mesmo `Pokemon` na tela de detalhe.
