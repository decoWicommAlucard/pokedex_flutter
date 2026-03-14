# Estrutura e Fluxo

## O que esta documentacao explica

Este guia mostra como o projeto esta organizado e como os dados saem da PokeAPI, chegam na lista e depois seguem para a tela de detalhe.

## Arquivos principais

- `lib/main.dart`
- `lib/colors.dart`
- `lib/pages/home/home.page.dart`
- `lib/pages/detail/detail.page.dart`
- `lib/pages/detail/stores/detail.store.dart`
- `lib/pages/detail/stores/detail.store.g.dart`
- `lib/store/home.store.dart`
- `lib/store/home.store.g.dart`
- `lib/services/poke_api.service.dart`
- `lib/models/poke_response.model.dart`
- `lib/models/pokemon.model.dart`
- `lib/models/pokemon_details.model.dart`
- `lib/models/stat.model.dart`
- `lib/models/pokemon_stat.model.dart`
- `lib/models/pokemon_type.model.dart`
- `lib/models/type.model.dart`
- `lib/widgets/poke_card.widget.dart`

## Estrutura principal

```text
lib/
|- main.dart
|- colors.dart
|- models/
|  |- poke_response.model.dart
|  |- pokemon.model.dart
|- services/
|  |- poke_api.service.dart
|- store/
|  |- home.store.dart
|  |- home.store.g.dart
|- widgets/
|  |- poke_card.widget.dart
|- pages/
   |- home/
   |  |- home.page.dart
   |- detail/
      |- detail.page.dart
      |- stores/
         |- detail.store.dart
         |- detail.store.g.dart
```

## Papel de cada camada

- `main.dart`: inicia o app e abre a `HomePage`.
- `pages/`: contem as telas e a store especifica da area de detalhe.
- `widgets/`: contem o `PokeCard`, usado na grade.
- `store/`: concentra estado da tela inicial.
- `services/`: centraliza o acesso HTTP a PokeAPI para listagem e detalhe.
- `models/`: transformam JSON em objetos Dart para listagem e detalhe.
- `colors.dart`: centraliza a cor principal da interface.

## Como o app comeca

```dart
void main() {
  runApp(const MyApp());
}
```

Depois:

```dart
return MaterialApp(
  title: 'Pokedex',
  debugShowCheckedModeBanner: false,
  home: HomePage(),
);
```

Fluxo inicial:

1. `main.dart` injeta `MyApp`.
2. `MaterialApp` abre a `HomePage`.
3. `HomePage` cria `HomeStore` e `ScrollController`.
4. no `initState`, chama `store.loadPokemons()`.

## Fluxo dos dados

1. `HomeStore.loadPokemons()` chama `_service.getPokemon(offset: offset)`.
2. `PokeApiService` faz `GET /pokemon?offset=...&limit=20`.
3. a resposta JSON vira `PokeResponse`.
4. cada item de `results` vira um `Pokemon`.
5. a store faz `pokemons.addAll(...)`.
6. o getter `filteredPokemons` e recalculado.
7. o `Observer` da `HomePage` reconstrui a grade.

## Fluxo de detalhe preparado

O projeto agora tambem possui uma segunda trilha de dados:

1. a camada de detalhe pode chamar `DetailStore.getPokemonDetailsData(id)`;
2. a `DetailStore` usa `_service.getPokemonDetail(id: id)`;
3. `PokeApiService` faz `GET /pokemon/{id}`;
4. a resposta JSON vira `PokemonDetails`;
5. `stats` viram `Stat`;
6. cada `Stat` guarda um `PokemonStat`;
7. `types` viram `PokemonType`.

## Fluxo reativo com MobX

O projeto usa:

- `@observable` para estados como `pokemons`, `isLoading` e `search`;
- `@computed` para `filteredPokemons`;
- `@action` para mutacoes como `loadPokemons()` e `setSearch()`;
- `Observer` para reagir na interface.

Trechos centrais:

```dart
@observable
ObservableList<Pokemon> pokemons = <Pokemon>[].asObservable();
```

```dart
@computed
List<Pokemon> get filteredPokemons { ... }
```

```dart
Observer(
  builder: (_) {
    return Expanded(
      child: GridView.builder(
```

## Fluxo da busca

1. o usuario digita no `TextField`;
2. `onChanged` chama `store.setSearch`;
3. `search` muda;
4. `filteredPokemons` recalcula;
5. o `Observer` atualiza a lista visivel.

## Fluxo do scroll infinito

```dart
void scrollListener() {
  if (scrollController.offset >= scrollController.position.maxScrollExtent &&
      !scrollController.position.outOfRange) {
    store.loadPokemons();
  }
}
```

Quando o scroll chega ao fim, a store busca mais 20 itens e adiciona o resultado no final da lista.

## Fluxo visual do card

1. a `HomePage` cria um `PokeCard` para cada `Pokemon`.
2. o card usa `pokemon.name`, `pokemon.id` e `pokemon.imageUrl`.
3. a imagem e exibida com `CachedNetworkImage`.
4. a mesma imagem fica dentro de um `Hero`.
5. o `PaletteGenerator` calcula a cor dominante.
6. a store atualiza o `pokemon.color`.
7. o `AnimatedContainer` anima a troca do fundo.

## Como o model simplifica o resto

O `Pokemon` guarda:

- `name`;
- `url`;
- `color`.

E ainda calcula:

- `id`, extraido da `url`;
- `imageUrl`, montado com base no `id`.

Assim, tela, store e widget trabalham com um objeto mais pronto para uso.

## Onde a `DetailPage` entra hoje

A `DetailPage` ja faz parte do fluxo real:

1. o usuario toca em um card na `HomePage`;
2. a tela faz `Navigator.push`;
3. a `DetailPage` recebe o `Pokemon`;
4. o `Hero` anima a imagem entre lista e detalhe;
5. o `SliverAppBar` usa `pokemon.color` como fundo.

Hoje a interface dessa tela ainda e inicial: ela mostra o topo visual do Pokemon.

Ao mesmo tempo, a camada de dados detalhados ja existe com `DetailStore` e `PokemonDetails`, pronta para ser ligada nessa tela.

## Limitacoes atuais

- nao existe tratamento visual de erro;
- `loadPokemons()` nao bloqueia chamadas duplicadas;
- a busca vale apenas para os itens ja carregados;
- a paginacao nao controla explicitamente o fim da lista;
- a `DetailPage` ainda nao usa `DetailStore` para exibir tipos, stats ou habilidades.

## Resumo

O fluxo central do projeto e:

1. `HomePage` pede dados para a store;
2. a store usa o service;
3. o service fala com a PokeAPI;
4. os models convertem o JSON;
5. a store salva os objetos;
6. o `Observer` atualiza a grade;
7. o `PokeCard` aplica a cor dinamica;
8. o toque no card abre a `DetailPage`.
