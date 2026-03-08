# Chamada da API

## O que esta documentacao vai explicar

Aqui a ideia nao e mostrar so o `GET`.

O objetivo e explicar o fluxo inteiro da API dentro do projeto:

- quem dispara a chamada;
- em qual arquivo ela acontece;
- como o JSON vira model;
- como os dados entram na store;
- como a tela passa a enxergar esses dados;
- como o card usa as informacoes recebidas.

## Arquivos envolvidos

A chamada da API depende de varios arquivos trabalhando juntos:

- `lib/main.dart`
- `lib/pages/home/home.page.dart`
- `lib/store/home.store.dart`
- `lib/services/poke_api.service.dart`
- `lib/models/poke_response.model.dart`
- `lib/models/pokemon.model.dart`
- `lib/widgets/poke_card.widget.dart`

## Visao geral do fluxo

O fluxo completo e este:

1. o app inicia em `main.dart`;
2. `main.dart` abre a `HomePage`;
3. `HomePage` chama `store.loadPokemons()` no `initState`;
4. `HomeStore` chama `PokeApiService.getPokemon(offset: offset)`;
5. `PokeApiService` faz a requisicao HTTP na PokeAPI;
6. a resposta JSON vira um `PokeResponse`;
7. cada item de `results` vira um objeto `Pokemon`;
8. a store adiciona esses Pokemons em `pokemons`;
9. o `Observer` reconstrui a grade;
10. o `PokeCard` usa esses dados para mostrar nome, numero e imagem.

## 1. Onde tudo comeca

Arquivo:

- `lib/main.dart`

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

Esse arquivo nao chama a API diretamente, mas e ele que inicia a aplicacao e abre a tela que vai disparar a busca.

## 2. Quem dispara a chamada de API

Arquivo:

- `lib/pages/home/home.page.dart`

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

Assim que a `HomePage` nasce:

1. a store e criada;
2. `loadPokemons()` e chamada;
3. isso dispara a primeira requisicao da API.

Entao a tela nao faz HTTP diretamente.

Ela delega isso para a store.

## 3. Quem controla o carregamento

Arquivo:

- `lib/store/home.store.dart`

Trecho:

```dart
final _service = PokeApiService();
```

Isso mostra que a store depende do service para buscar dados.

Metodo principal:

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

### Passo a passo da store

1. ativa `isLoading`;
2. chama o service com o `offset` atual;
3. espera a resposta da API;
4. recebe um `PokeResponse`;
5. aumenta o `offset` em 20;
6. adiciona os novos Pokemons na lista observavel;
7. desativa `isLoading`.

## 4. Onde a chamada HTTP realmente acontece

Arquivo:

- `lib/services/poke_api.service.dart`

Trecho:

```dart
class PokeApiService {
  late final Uno _uno;

  PokeApiService() {
    _uno = Uno(baseURL: "https://pokeapi.co/api/v2");
  }
}
```

O `Uno` foi configurado com uma `baseURL`.

Isso permite chamar apenas o caminho final da rota.

Metodo da requisicao:

```dart
Future<PokeResponse> getPokemon({required int offset}) async {
  final response = await _uno.get("/pokemon?offset=$offset&limit=20");

  if (response.status != HttpStatus.ok) {
    throw Exception("Failed to load pokemon");
  }

  return PokeResponse.fromJson(response.data);
}
```

### O que foi feito nesse metodo

1. recebeu um `offset`;
2. chamou `GET /pokemon?offset=...&limit=20`;
3. verificou se o status foi `200`;
4. converteu o JSON em `PokeResponse`;
5. devolveu esse objeto pronto para a store.

## 5. Como a resposta da API vira model

Arquivo:

- `lib/models/poke_response.model.dart`

Trecho:

```dart
class PokeResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<Pokemon> results;
```

Esse model representa a resposta geral da listagem.

Factory:

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

### O que acontece aqui

1. `count`, `next` e `previous` sao lidos diretamente do JSON;
2. `results` chega como lista de mapas;
3. cada item dessa lista passa por `Pokemon.fromJson`;
4. no final, `results` vira uma `List<Pokemon>`.

## 6. Como cada Pokemon individual vira objeto Dart

Arquivo:

- `lib/models/pokemon.model.dart`

Trecho:

```dart
class Pokemon {
  final String name;
  final String url;
  final Color color;
```

Factory:

```dart
factory Pokemon.fromJson(Map<String, dynamic> json) {
  return Pokemon(name: json['name'], url: json['url']);
}
```

### O que e importante entender aqui

A listagem da PokeAPI nao devolve tudo pronto.

Nessa rota, o Pokemon vem principalmente com:

- `name`
- `url`

Entao este model guarda esses valores e calcula outras informacoes depois.

### Como o ID e descoberto

```dart
String get id {
  final data = url.split('/');
  data.removeLast();
  return data.last;
}
```

Se a URL for:

```text
https://pokeapi.co/api/v2/pokemon/25/
```

o getter devolve:

```text
25
```

### Como a URL da imagem e montada

```dart
String get imageUrl =>
    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";
```

Ou seja:

- a API de listagem entrega a URL do Pokemon;
- o model extrai o ID dessa URL;
- o model monta a URL da imagem oficial usando esse ID.

## 7. Exemplo real do caminho dos dados

### Resposta vinda da API

```json
{
  "count": 1302,
  "next": "https://pokeapi.co/api/v2/pokemon?offset=20&limit=20",
  "previous": null,
  "results": [
    {
      "name": "bulbasaur",
      "url": "https://pokeapi.co/api/v2/pokemon/1/"
    }
  ]
}
```

### Depois de `PokeResponse.fromJson`

O app passa a ter algo parecido com isso:

```text
PokeResponse(
  count: 1302,
  next: "...offset=20&limit=20",
  previous: null,
  results: [Pokemon(name: "bulbasaur", url: ".../1/")]
)
```

### Depois de `Pokemon.fromJson`

Esse item consegue fornecer:

- `name = bulbasaur`
- `url = https://pokeapi.co/api/v2/pokemon/1/`
- `id = 1`
- `imageUrl = .../official-artwork/1.png`

## 8. Como os dados entram na tela

Depois que a store executa:

```dart
pokemons.addAll(pokeResponse.results);
```

a lista observavel `pokemons` recebe os novos itens.

Na tela, o `Observer` le:

```dart
store.filteredPokemons.length
store.filteredPokemons[index]
store.isLoading
```

Quando `pokemons` muda, `filteredPokemons` tambem pode mudar, e o `Observer` reconstrui a grade automaticamente.

## 9. Como o card usa os dados que vieram da API

Arquivo:

- `lib/widgets/poke_card.widget.dart`

Trechos:

```dart
Image.network(widget.pokemon.imageUrl, height: 130),
```

```dart
Text(widget.pokemon.name)
```

```dart
Text(widget.pokemon.id.padLeft(4, '0'))
```

Isso mostra que o `PokeCard` depende diretamente dos dados montados pelos models:

- nome vindo da API;
- ID extraido da URL;
- imagem montada a partir do ID.

Entao a chamada da API nao termina no service.

Ela so faz sentido porque continua ate os models, a store e a interface.

## 10. Como a paginacao funciona

O projeto usa `offset` para buscar 20 itens por vez.

Exemplos:

- primeira chamada: `offset=0&limit=20`
- segunda chamada: `offset=20&limit=20`
- terceira chamada: `offset=40&limit=20`

Na store:

```dart
offset += 20;
```

Isso prepara a proxima pagina.

Quando o usuario chega ao fim do scroll, `loadPokemons()` roda de novo e o mesmo fluxo inteiro se repete.

## 11. O que a rota atual da API entrega e o que ela nao entrega

A rota usada hoje e:

```text
/pokemon?offset=...&limit=20
```

Ela entrega principalmente:

- total de registros;
- URL da proxima pagina;
- URL da pagina anterior;
- nome e URL de cada Pokemon.

Ela nao entrega nessa listagem:

- tipos completos;
- habilidades;
- peso;
- altura;
- stats detalhados.

Por isso o projeto atual consegue montar a grade principal, mas ainda nao uma tela detalhada completa.

## 12. Limitacoes atuais desse fluxo

Hoje existem algumas limitacoes importantes:

- `loadPokemons()` nao bloqueia chamadas duplicadas enquanto `isLoading` esta `true`;
- nao existe `try/catch` na store para mostrar erro na interface;
- a rota atual busca apenas a listagem basica;
- a tela de detalhe ainda existe, mas nao usa uma chamada especifica de detalhes.

## 13. Resumo final

Para entender a chamada da API neste projeto, pense nesta cadeia:

1. `main.dart` abre a `HomePage`;
2. `HomePage` chama `loadPokemons()`;
3. `HomeStore` chama `PokeApiService`;
4. `PokeApiService` faz o `GET`;
5. `PokeResponse` converte a resposta geral;
6. `Pokemon` converte cada item individual;
7. a store salva os objetos em `pokemons`;
8. o `Observer` atualiza a tela;
9. o `PokeCard` mostra nome, ID e imagem com base nesses dados.

Se voce dominar esses arquivos juntos, a chamada da API deixa de parecer um bloco isolado e passa a fazer sentido dentro do projeto inteiro.
