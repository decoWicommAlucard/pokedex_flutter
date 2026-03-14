# Guia Para Iniciantes

## Para que serve este guia

Este arquivo e para quem abriu o projeto e ainda nao entende bem:

- para que serve cada arquivo;
- o que e `model`;
- o que e `fromJson`;
- o que e `copyWith`;
- o que e `service`;
- o que e `store`;
- o que o MobX esta fazendo.

Se os outros arquivos pareceram tecnicos demais, comece por aqui.

## Visao rapida do projeto

O fluxo principal e este:

```text
main.dart
  -> HomePage
  -> HomeStore
  -> PokeApiService
  -> PokeResponse
  -> Pokemon
  -> PokeCard
  -> DetailPage
```

Lendo de forma simples:

1. o app comeca em `main.dart`;
2. a tela inicial e a `HomePage`;
3. a `HomePage` pede dados para a `HomeStore`;
4. a `HomeStore` usa o `PokeApiService` para chamar a API;
5. a resposta da API vira objetos Dart (`PokeResponse` e `Pokemon`);
6. a tela mostra esses objetos usando `PokeCard`;
7. ao tocar em um card, abre a `DetailPage`.

## O que significa cada tipo de arquivo

### `page`

Uma `page` e uma tela inteira do app.

Exemplos neste projeto:

- `HomePage`: tela principal com busca e grade;
- `DetailPage`: tela que abre ao tocar em um Pokemon.

### `widget`

Um `widget` e um bloco visual reutilizavel.

Exemplo neste projeto:

- `PokeCard`: o card de cada Pokemon na grade.

### `store`

A `store` guarda estado e regras da tela.

Neste projeto, a `HomeStore` sabe:

- se esta carregando;
- qual texto foi digitado na busca;
- quais Pokemons ja foram carregados;
- como filtrar;
- como buscar mais itens;
- como atualizar a cor de um card.

### `service`

O `service` e a parte que conversa com algo externo, normalmente uma API.

Neste projeto, `PokeApiService` faz a chamada HTTP para a PokeAPI.

### `model`

`Model` e uma classe que representa um dado do sistema.

Em vez de trabalhar com JSON cru o tempo todo, o projeto transforma a resposta da API em objetos Dart.

Exemplos:

- `Pokemon`: representa um Pokemon;
- `PokeResponse`: representa a resposta completa da API.

### `arquivo gerado`

Alguns arquivos nao sao escritos manualmente. Eles sao criados por ferramentas.

Neste projeto:

- `home.store.g.dart` e gerado pelo MobX com `build_runner`.

## Para que serve cada arquivo

### `lib/main.dart`

E o ponto de entrada do app.

Ele chama:

```dart
runApp(const MyApp());
```

E dentro do `MaterialApp` define qual tela abre primeiro:

```dart
home: HomePage(),
```

Sem esse arquivo, o Flutter nao sabe por onde comecar.

### `lib/colors.dart`

Centraliza cores reutilizadas.

Hoje ele guarda:

```dart
const primaryColor = Color(0xFF2E3156);
```

Isso evita repetir o mesmo valor em varios lugares.

### `lib/models/pokemon.model.dart`

Representa um Pokemon individual.

Esse arquivo existe para reunir em um lugar so:

- `name`;
- `url`;
- `color`;
- `id`;
- `imageUrl`.

Sem esse model, a tela teria que lidar diretamente com mapas JSON e montar muita coisa na mao.

### `lib/models/poke_response.model.dart`

Representa a resposta completa da listagem da PokeAPI.

A API nao devolve so a lista de Pokemons. Ela devolve algo assim:

```text
count
next
previous
results
```

O `PokeResponse` organiza isso em uma classe Dart.

### `lib/services/poke_api.service.dart`

Faz a chamada HTTP.

Ele tem a responsabilidade de:

- configurar a URL base da PokeAPI;
- buscar a lista de Pokemons;
- validar o status da resposta;
- transformar o JSON em `PokeResponse`.

Isso evita colocar HTTP direto dentro da tela.

### `lib/store/home.store.dart`

E o cerebro da tela inicial.

Esse arquivo concentra a logica da `HomePage`.

Ele sabe:

- quando carregar;
- o que mostrar;
- como filtrar;
- quando buscar mais itens;
- como atualizar a cor de um Pokemon.

A tela fica mais simples porque so pede dados para a store.

### `lib/store/home.store.g.dart`

E o arquivo gerado pelo MobX.

Voce nao deve editar esse arquivo manualmente.

Ele existe porque o MobX precisa gerar codigo para fazer:

- reatividade;
- observacao de mudancas;
- controle das `actions`;
- suporte aos `computed`.

Quando a store muda, esse arquivo ajuda o `Observer` da interface a saber que precisa redesenhar.

### `lib/widgets/poke_card.widget.dart`

Renderiza o card de um Pokemon.

Esse widget mostra:

- imagem;
- nome;
- numero;
- cor de fundo.

Ele tambem calcula a cor dominante da imagem e envia essa cor para a store.

### `lib/pages/home/home.page.dart`

E a tela principal do app.

Ela monta a interface com:

- titulo;
- subtitulo;
- campo de busca;
- grade de cards;
- scroll infinito.

Ela nao faz HTTP diretamente. Ela conversa com a `HomeStore`.

### `lib/pages/detail/detail.page.dart`

E a tela de detalhe atual.

Hoje ela ainda e simples. Ela recebe um `Pokemon` e mostra:

- a imagem em destaque;
- o `Hero` da transicao;
- o `SliverAppBar` com a cor do Pokemon.

## Conceitos que costumam confundir

### O que e JSON

JSON e um formato de dados muito usado em APIs.

Quando o app chama a PokeAPI, ela devolve texto estruturado com chaves e valores.

Em Dart, isso normalmente vira um:

```dart
Map<String, dynamic>
```

Ou seja, um mapa com pares `chave -> valor`.

### O que e `fromJson`

`fromJson` e um metodo usado para transformar esse mapa em um objeto Dart.

Exemplo do projeto:

```dart
factory Pokemon.fromJson(Map<String, dynamic> json) {
  return Pokemon(name: json['name'], url: json['url']);
}
```

Lendo em portugues:

1. chegou um mapa chamado `json`;
2. pegue `json['name']`;
3. pegue `json['url']`;
4. monte um `Pokemon` com esses valores.

Sem `fromJson`, o resto do app teria que acessar `json['name']` e `json['url']` o tempo todo.

Com `fromJson`, o resto do app trabalha com `Pokemon`.

### O que e `factory`

`factory` e um tipo especial de construtor em Dart.

Ele e muito usado quando o objeto precisa ser criado a partir de outro formato, como JSON.

Neste projeto:

- `Pokemon.fromJson(...)` cria um `Pokemon` a partir de um mapa;
- `PokeResponse.fromJson(...)` cria um `PokeResponse` a partir da resposta da API.

### O que e `copyWith`

`copyWith` cria uma copia do objeto mudando so o que voce quiser.

No projeto:

```dart
Pokemon copyWith({String? name, String? url, Color? color}) {
  return Pokemon(
    name: name ?? this.name,
    url: url ?? this.url,
    color: color ?? this.color,
  );
}
```

Isso significa:

- se voce passar `color`, a nova copia usa a nova cor;
- se voce nao passar `name`, ele reaproveita o nome antigo;
- se voce nao passar `url`, ele reaproveita a URL antiga.

Exemplo pratico:

```dart
final novoPokemon = pokemon.copyWith(color: Colors.red);
```

Nesse caso:

- `name` continua igual;
- `url` continua igual;
- `color` muda.

### Por que usar `copyWith` aqui

No projeto, a cor do Pokemon comeca branca e depois muda quando o card descobre a cor dominante da imagem.

Entao a store faz:

```dart
pokemons[indexPokemon] = pokemons[indexPokemon].copyWith(color: color);
```

Em vez de alterar o objeto antigo na marra, ela cria uma nova versao dele com a cor atualizada.

### O que e um `getter`

Getter e uma propriedade calculada.

Neste projeto:

```dart
String get id { ... }
String get imageUrl => ...
```

Isso permite escrever:

```dart
pokemon.id
pokemon.imageUrl
```

Mesmo que esses valores sejam calculados a partir de outros dados.

### O que e `id` nesse projeto

O `id` nao vem salvo como campo fixo no model.

Ele e extraido da `url`:

```dart
https://pokeapi.co/api/v2/pokemon/25/
```

vira:

```text
25
```

### O que e `imageUrl`

A listagem principal da PokeAPI nao entrega a arte oficial pronta no mesmo formato usado no app.

Por isso o projeto monta a URL da imagem usando o `id`.

### O que e `late final`

No service existe:

```dart
late final Uno _uno;
```

Isso significa:

- a variavel sera inicializada depois;
- ela sera inicializada uma vez so;
- depois disso nao muda mais.

No construtor:

```dart
_uno = Uno(baseURL: "https://pokeapi.co/api/v2");
```

### O que significa `_service` ou `_uno`

Em Dart, um nome com `_` no comeco indica que ele e privado daquele arquivo.

Exemplo:

- `_service`
- `_uno`

Isso comunica que esses campos sao detalhes internos da implementacao.

## Conceitos de MobX usados aqui

### `@observable`

Marca um estado que pode mudar e ser observado.

Exemplos:

```dart
@observable
bool isLoading = false;

@observable
String? search;
```

Se esses valores mudarem, a interface pode reagir.

### `@action`

Marca um metodo que altera estado.

Exemplos:

```dart
@action
void setSearch(String text) => search = text;

@action
Future<void> loadPokemons() async { ... }
```

### `@computed`

Marca um valor calculado a partir de outros estados.

Exemplo:

```dart
@computed
List<Pokemon> get filteredPokemons { ... }
```

Ele depende de:

- `pokemons`;
- `search`.

Quando algum deles muda, o resultado e recalculado.

### `Observer`

`Observer` e um widget que reconstrui a interface quando um estado observado muda.

No projeto, ele envolve a grade de cards. Entao:

- carregou mais Pokemons -> a grade atualiza;
- mudou a busca -> a grade atualiza;
- mudou a cor de um Pokemon -> o card atualiza.

### `build_runner`

E a ferramenta que gera o arquivo `home.store.g.dart`.

Comando:

```bash
dart run build_runner build
```

## Diferenca entre `StatefulWidget` e `StatelessWidget`

### `StatelessWidget`

Usado quando o widget nao precisa guardar estado proprio.

Exemplo no projeto:

- `DetailPage`.

Ela so recebe um `Pokemon` e mostra a interface.

### `StatefulWidget`

Usado quando o widget precisa de ciclo de vida ou estado interno.

Exemplos no projeto:

- `HomePage`, porque usa `initState`, `dispose` e `ScrollController`;
- `PokeCard`, porque calcula a paleta da imagem quando aparece.

## Fluxo completo em linguagem simples

1. o app abre em `main.dart`;
2. `main.dart` mostra a `HomePage`;
3. a `HomePage` chama `store.loadPokemons()`;
4. a `HomeStore` pede dados para o `PokeApiService`;
5. o service chama a PokeAPI;
6. o JSON vira `PokeResponse`;
7. cada item da lista vira `Pokemon`;
8. a store guarda esses objetos;
9. a `HomePage` mostra a lista com `PokeCard`;
10. cada card descobre sua cor dominante;
11. a store atualiza a cor com `copyWith`;
12. ao tocar em um card, abre a `DetailPage`.

## Qual doc ler depois deste

Depois deste guia, a melhor ordem e:

1. `docs/funcionalidades/01_estrutura_e_fluxo.md`
2. `docs/arquivos/07_pokemon.model.dart.md`
3. `docs/arquivos/08_poke_response.model.dart.md`
4. `docs/arquivos/06_poke_api.service.dart.md`
5. `docs/arquivos/04_home.store.dart.md`
6. `docs/arquivos/03_home.page.dart.md`
7. `docs/arquivos/09_poke_card.widget.dart.md`
8. `docs/arquivos/10_detail.page.dart.md`
