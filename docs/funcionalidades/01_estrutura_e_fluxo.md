# Estrutura e Fluxo

## O que esta documentacao vai explicar

Esta documentacao mostra como o projeto esta organizado e como os dados caminham dentro dele.

A ideia aqui e responder estas perguntas:

- onde cada responsabilidade ficou;
- quem chama quem;
- como os dados saem da API e chegam na tela;
- como a tela reage as mudancas;
- como cada parte conversa com a outra.

## Arquivos principais envolvidos

Os arquivos mais importantes do fluxo atual sao:

- `lib/main.dart`
- `lib/colors.dart`
- `lib/pages/home/home.page.dart`
- `lib/pages/detail/detail.page.dart`
- `lib/store/home.store.dart`
- `lib/store/home.store.g.dart`
- `lib/services/poke_api.service.dart`
- `lib/models/poke_response.model.dart`
- `lib/models/pokemon.model.dart`
- `lib/widgets/poke_card.widget.dart`

## Estrutura principal do projeto

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
```

## Papel de cada camada

### `main.dart`

E o ponto de entrada do aplicativo.

Ele inicia o Flutter e define qual tela abre primeiro.

### `pages/`

Contem as telas do app.

Hoje existem:

- `HomePage`, que e a tela principal e funcional;
- `DetailPage`, que existe mas ainda esta vazia.

### `widgets/`

Contem componentes visuais reutilizaveis.

No projeto atual, o principal e o `PokeCard`.

### `store/`

Contem o estado e as regras da tela.

Hoje o projeto usa `HomeStore` para:

- guardar a lista;
- carregar mais Pokemons;
- guardar a busca;
- filtrar resultados;
- atualizar as cores dos cards.

### `services/`

Contem o codigo de comunicacao com a API.

Isso evita colocar HTTP dentro da tela.

### `models/`

Contem as classes que representam os dados.

Elas transformam o JSON em objetos Dart e facilitam o acesso a informacoes como `id` e `imageUrl`.

### `colors.dart`

Centraliza uma cor reutilizada na interface.

## Como o app comeca

Tudo comeca em `lib/main.dart`.

Trecho:

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

### O que isso faz

1. o Flutter executa `main()`;
2. `runApp` injeta `MyApp`;
3. `MyApp` constroi o `MaterialApp`;
4. o `MaterialApp` abre a `HomePage`.

## Fluxo geral da aplicacao

Se voce quiser enxergar o app como um encadeamento unico, o fluxo e este:

1. `main.dart` inicia o app;
2. `HomePage` abre como tela inicial;
3. a `HomePage` cria a `HomeStore`;
4. no `initState`, a pagina chama `store.loadPokemons()`;
5. a `HomeStore` chama `PokeApiService`;
6. o `PokeApiService` faz a requisicao na PokeAPI;
7. a resposta vira `PokeResponse`;
8. cada item de `results` vira um objeto `Pokemon`;
9. a store adiciona os Pokemons na lista observavel `pokemons`;
10. o `Observer` detecta a mudanca;
11. a grade da `HomePage` e reconstruida;
12. cada item da grade vira um `PokeCard`;
13. cada `PokeCard` usa `pokemon.imageUrl` para mostrar a imagem;
14. cada `PokeCard` tenta extrair a cor dominante da imagem;
15. a store atualiza a cor daquele Pokemon;
16. o card anima a troca de cor com `AnimatedContainer`.

## Fluxo da tela inicial

Arquivo:

- `lib/pages/home/home.page.dart`

Essa tela faz cinco coisas centrais:

- mostra o titulo;
- mostra o campo de busca;
- mostra a grade de cards;
- observa mudancas do MobX;
- escuta o scroll para carregar mais itens.

Trecho importante:

```dart
final store = HomeStore();
final scrollController = ScrollController();
```

Esses dois objetos sustentam quase todo o comportamento da tela.

## Fluxo do carregamento inicial

Trecho:

```dart
@override
void initState() {
  super.initState();
  store.loadPokemons();
  scrollController.addListener(scrollListener);
}
```

### O que acontece aqui

1. a tela e criada;
2. a primeira carga da API e disparada;
3. o listener do scroll e registrado.

Sem esse `loadPokemons()`, a tela abriria vazia.

## Fluxo dos dados da API

Arquivos:

- `lib/store/home.store.dart`
- `lib/services/poke_api.service.dart`
- `lib/models/poke_response.model.dart`
- `lib/models/pokemon.model.dart`

Fluxo:

1. `HomeStore.loadPokemons()` chama `_service.getPokemon(offset: offset)`;
2. `PokeApiService` executa `GET /pokemon?offset=...&limit=20`;
3. a resposta JSON vira `PokeResponse`;
4. `results` e transformado em `List<Pokemon>`;
5. a store faz `pokemons.addAll(pokeResponse.results)`.

## Fluxo reativo com MobX

O projeto usa MobX para evitar ficar chamando `setState()` para tudo.

Arquivos envolvidos:

- `lib/store/home.store.dart`
- `lib/store/home.store.g.dart`
- `lib/pages/home/home.page.dart`

Conceitos usados:

- `@observable`
- `@action`
- `@computed`
- `Observer`

### Exemplo de estado observavel

```dart
@observable
ObservableList<Pokemon> pokemons = <Pokemon>[].asObservable();
```

### Exemplo de valor computado

```dart
@computed
List<Pokemon> get filteredPokemons { ... }
```

### Exemplo de action

```dart
@action
Future<void> loadPokemons() async { ... }
```

### Como isso chega na tela

Em `home.page.dart`:

```dart
Observer(
  builder: (_) {
    return Expanded(
      child: GridView.builder(
```

Quando `pokemons`, `filteredPokemons` ou `isLoading` mudam, o `Observer` reconstrui a parte da interface que depende desses valores.

## Fluxo da busca

Arquivos envolvidos:

- `lib/pages/home/home.page.dart`
- `lib/store/home.store.dart`

Fluxo:

1. o usuario digita no `TextField`;
2. o `onChanged` chama `store.setSearch`;
3. a `search` da store muda;
4. o getter `filteredPokemons` recalcula;
5. o `Observer` atualiza a grade.

Trecho da tela:

```dart
TextField(
  onChanged: store.setSearch,
)
```

Trecho da store:

```dart
@action
void setSearch(String text) => search = text;
```

## Fluxo do scroll infinito

Arquivos envolvidos:

- `lib/pages/home/home.page.dart`
- `lib/store/home.store.dart`
- `lib/services/poke_api.service.dart`

Fluxo:

1. o usuario rola a grade;
2. o `ScrollController` detecta a posicao;
3. ao chegar no fim, `scrollListener()` chama `store.loadPokemons()`;
4. a store busca mais 20;
5. os novos itens entram no final da lista.

Trecho:

```dart
void scrollListener() {
  if (scrollController.offset >= scrollController.position.maxScrollExtent &&
      !scrollController.position.outOfRange) {
    store.loadPokemons();
  }
}
```

## Fluxo visual de cada card

Arquivos envolvidos:

- `lib/models/pokemon.model.dart`
- `lib/widgets/poke_card.widget.dart`
- `lib/store/home.store.dart`

Fluxo:

1. a `HomePage` cria um `PokeCard` para cada Pokemon;
2. o `PokeCard` usa `pokemon.name`, `pokemon.id` e `pokemon.imageUrl`;
3. a imagem e carregada com `Image.network`;
4. o card extrai uma cor dominante da imagem;
5. a store atualiza o Pokemon com a nova cor;
6. o `AnimatedContainer` redesenha o fundo.

## Como o model ajuda o fluxo

O `Pokemon` nao guarda so os dados crus da API.

Ele tambem calcula informacoes importantes:

- `id`, extraido da `url`;
- `imageUrl`, montado a partir do `id`.

Isso simplifica muito o resto do projeto, porque:

- a store nao precisa montar URL de imagem;
- o widget nao precisa extrair ID da URL;
- a tela recebe um objeto mais pronto para uso.

## Onde a `DetailPage` entra hoje

Arquivo:

- `lib/pages/detail/detail.page.dart`

Hoje essa tela existe, mas ainda esta assim:

- sem layout;
- sem dados;
- sem navegacao vinda da `HomePage`.

Entao, no fluxo atual do projeto, ela ainda nao participa de nada importante.

## Resumo mental da arquitetura

Uma forma simples de pensar no projeto e:

- `main.dart` abre o app;
- `HomePage` cuida da tela;
- `HomeStore` cuida do estado;
- `PokeApiService` cuida da API;
- `PokeResponse` e `Pokemon` cuidam dos dados;
- `PokeCard` cuida da exibicao de cada item.

## Por que essa separacao faz sentido

Se tudo estivesse junto em `home.page.dart`, o codigo ficaria muito mais confuso.

Separando responsabilidades:

- a tela fica mais focada em interface;
- a store fica mais focada em regra;
- o service fica mais focado em rede;
- os models ficam mais focados em dados;
- o widget fica mais focado em apresentacao.

## Limitacoes atuais do fluxo

Hoje o fluxo funciona, mas ainda tem algumas limitacoes:

- nao existe tratamento visual de erro;
- o carregamento nao bloqueia chamadas duplicadas;
- a busca vale apenas para os itens ja carregados;
- a tela de detalhe ainda nao entrou no fluxo real;
- a paginacao nao controla explicitamente um estado de fim da lista.

## Resumo final

O projeto gira em torno desta cadeia:

1. a tela inicial pede dados para a store;
2. a store pede dados para o service;
3. o service fala com a API;
4. os models transformam a resposta em objetos;
5. a store salva esses objetos;
6. o `Observer` atualiza a tela;
7. o `PokeCard` exibe o resultado final.

Se voce entender bem essa cadeia, o resto do projeto fica muito mais facil de estudar.
