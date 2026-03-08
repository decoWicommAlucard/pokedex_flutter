# Como o Projeto Foi Montado

## O que esta documentacao vai explicar

Aqui a ideia e reconstruir, de forma didatica, a ordem mais provavel em que este projeto foi montado.

Nao e uma garantia historica exata do que aconteceu, mas e uma sequencia coerente com o codigo que existe hoje.

Isso ajuda muito no estudo porque mostra:

- o que provavelmente veio primeiro;
- por que cada etapa faz sentido;
- como uma camada depende da outra;
- em que momento cada funcionalidade entrou.

## Visao geral da ordem

Uma sequencia muito plausivel para este projeto e:

1. criar o projeto Flutter;
2. instalar dependencias;
3. criar os models;
4. criar o service da API;
5. criar a store com MobX;
6. gerar o arquivo `.g.dart`;
7. montar a `HomePage`;
8. criar o `PokeCard`;
9. ligar tudo no `main.dart`;
10. iniciar a `DetailPage` como proxima etapa futura.

## 1. Criacao do projeto Flutter

O primeiro passo mais provavel foi:

```bash
flutter create pokedex_flutter
```

Esse comando gera a estrutura base:

- `lib/`
- `android/`
- `ios/`
- `web/`
- `windows/`
- `linux/`
- `macos/`

### Por que isso vem primeiro

Porque todo o resto depende da estrutura inicial do Flutter.

## 2. Instalacao das dependencias

Pelo `pubspec.yaml`, estas dependencias foram adicionadas:

```yaml
dependencies:
  flutter:
    sdk: flutter
  uno: ^1.1.6
  mobx: ^2.6.0
  flutter_mobx: ^2.3.0
  palette_generator: ^0.3.3+2
```

E estas para desenvolvimento:

```yaml
dev_dependencies:
  build_runner: ^2.10.5
  mobx_codegen: ^2.7.6
```

Comandos equivalentes:

```bash
flutter pub add uno mobx flutter_mobx palette_generator
flutter pub add --dev build_runner mobx_codegen
```

### Por que isso entra cedo

Porque a arquitetura do projeto depende dessas bibliotecas:

- `uno` para HTTP;
- `mobx` para estado;
- `flutter_mobx` para reatividade na interface;
- `palette_generator` para as cores dos cards;
- `build_runner` e `mobx_codegen` para gerar a store.

## 3. Criacao dos models

Arquivos:

- `lib/models/pokemon.model.dart`
- `lib/models/poke_response.model.dart`

### O que provavelmente foi pensado aqui

Antes de montar tela e store, alguem precisou decidir como os dados da API seriam representados em Dart.

No `pokemon.model.dart`:

- foi criado o campo `name`;
- foi criado o campo `url`;
- foi criado o campo `color`;
- foi criado o getter `id`;
- foi criado o getter `imageUrl`;
- foi criado o `fromJson`;
- foi criado o `copyWith`.

No `poke_response.model.dart`:

- foram criados `count`, `next`, `previous` e `results`;
- foi feito o mapeamento da lista JSON para `List<Pokemon>`.

### Por que isso faz sentido antes da store

Porque a store precisa trabalhar com objetos claros, nao com mapas JSON crus.

## 4. Criacao do service da API

Arquivo:

- `lib/services/poke_api.service.dart`

Metodo principal:

```dart
Future<PokeResponse> getPokemon({required int offset}) async {
  final response = await _uno.get("/pokemon?offset=$offset&limit=20");

  if (response.status != HttpStatus.ok) {
    throw Exception("Failed to load pokemon");
  }

  return PokeResponse.fromJson(response.data);
}
```

### O que provavelmente foi feito nessa etapa

- configurar o `Uno` com `baseURL`;
- criar a rota de listagem;
- definir a paginacao com `offset` e `limit`;
- transformar a resposta em `PokeResponse`.

### Por que isso vem antes da tela

Porque a interface precisa de uma fonte de dados pronta para consumir.

## 5. Criacao da store com MobX

Arquivo:

- `lib/store/home.store.dart`

Nessa etapa, o projeto provavelmente passou a concentrar:

- estado de carregamento;
- texto da busca;
- lista de Pokemons;
- filtro computado;
- carregamento paginado;
- atualizacao das cores.

Trechos principais:

```dart
@observable
bool isLoading = false;
```

```dart
@observable
String? search;
```

```dart
@observable
ObservableList<Pokemon> pokemons = <Pokemon>[].asObservable();
```

```dart
@computed
List<Pokemon> get filteredPokemons { ... }
```

```dart
@action
Future<void> loadPokemons() async { ... }
```

```dart
@action
void updatePokemonColor({required String pokemonId, required Color color}) { ... }
```

### Por que essa etapa e central

Aqui o projeto deixa de ser apenas "buscar dados" e passa a ter regra de negocio organizada.

## 6. Geracao do arquivo do MobX

Como a store usa anotacoes do MobX, foi necessario gerar:

- `lib/store/home.store.g.dart`

Comando:

```bash
dart run build_runner build
```

Ou:

```bash
dart run build_runner watch
```

### O que isso faz

Gera a parte automatica de:

- `Atom`
- `Computed`
- `ActionController`
- `AsyncAction`

Sem isso, a store anotada nao funcionaria corretamente.

## 7. Montagem da `HomePage`

Arquivo:

- `lib/pages/home/home.page.dart`

Essa etapa provavelmente montou a tela principal com:

- titulo;
- subtitulo;
- campo de busca;
- grade de cards;
- loader;
- scroll infinito;
- ligacao com o `Observer`.

Trechos importantes:

```dart
final store = HomeStore();
final scrollController = ScrollController();
```

```dart
store.loadPokemons();
scrollController.addListener(scrollListener);
```

```dart
Observer(
  builder: (_) {
    return Expanded(
      child: GridView.builder(
```

### Por que essa tela depende das etapas anteriores

Ela precisa:

- da store pronta;
- do service funcionando;
- dos models definidos;
- do MobX gerado.

## 8. Criacao do `PokeCard`

Arquivo:

- `lib/widgets/poke_card.widget.dart`

Nessa etapa foi criado o componente visual de cada Pokemon.

Ele provavelmente foi pensado para:

- mostrar a imagem;
- mostrar o nome;
- mostrar o ID com zeros a esquerda;
- aplicar a cor dominante da imagem.

Trechos principais:

```dart
Image.network(widget.pokemon.imageUrl, height: 130),
```

```dart
Text(widget.pokemon.name)
```

```dart
Text(widget.pokemon.id.padLeft(4, '0'))
```

```dart
getPaletteColor();
```

### Por que ele provavelmente veio depois da `HomePage`

Porque primeiro faz sentido montar a tela geral e depois extrair o componente de item.

## 9. Adicao da funcionalidade de cores dinamicas

Ainda dentro do `PokeCard`, uma etapa adicional provavelmente foi:

- integrar o `palette_generator`;
- extrair a cor dominante da imagem;
- mandar essa cor para a store;
- animar a troca com `AnimatedContainer`.

Isso mostra que o card nao foi so um widget visual simples.

Ele recebeu uma camada extra de comportamento.

## 10. Adicao do scroll infinito

Outra etapa importante que provavelmente entrou depois do carregamento inicial foi:

- criar o `ScrollController`;
- registrar o `scrollListener`;
- usar o `offset`;
- adicionar novos resultados com `addAll`.

Esse comportamento faz muito sentido depois que a primeira versao da listagem basica ja estava funcionando.

## 11. Adicao da filtragem

A filtragem provavelmente entrou depois que a lista basica ja carregava corretamente.

Passos provaveis:

1. criar o campo `search` na store;
2. criar `setSearch`;
3. criar o getter `filteredPokemons`;
4. ligar o `TextField` ao `onChanged`;
5. trocar a grade para usar `filteredPokemons`.

Essa ordem e bem comum em projetos Flutter com MobX.

## 12. Definicao da tela inicial no `main.dart`

Essa etapa e simples, mas essencial:

```dart
home: HomePage(),
```

Sem isso, o app nao abriria direto na tela da Pokedex.

## 13. Criacao inicial da `DetailPage`

Arquivo:

- `lib/pages/detail/detail.page.dart`

Estado atual:

- a classe existe;
- retorna um `Scaffold`;
- ainda nao recebe parametros;
- ainda nao tem layout;
- ainda nao participa da navegacao.

### O que isso sugere

Provavelmente a proxima fase do projeto seria implementar uma tela de detalhes.

## 14. Ordem de estudo recomendada

Se voce quiser seguir a mesma linha de construcao para estudar, esta ordem e boa:

1. `main.dart`
2. `pokemon.model.dart`
3. `poke_response.model.dart`
4. `poke_api.service.dart`
5. `home.store.dart`
6. `home.store.g.dart`
7. `home.page.dart`
8. `poke_card.widget.dart`
9. `detail.page.dart`

## 15. Por que essa ordem de montagem faz sentido

Ela respeita dependencias naturais:

- primeiro vem a base do app;
- depois vem os dados;
- depois vem a API;
- depois vem o estado;
- depois vem a tela;
- depois vem o refinamento visual.

Essa ordem reduz confusao porque cada etapa se apoia em uma anterior.

## 16. O que o projeto mostra como aprendizado

Mesmo sendo pequeno, este projeto ensina muita coisa:

- separacao de camadas;
- consumo de API;
- modelagem de dados;
- uso de MobX;
- reatividade com `Observer`;
- scroll infinito;
- filtro local;
- extracao de cor de imagem.

## 17. Resumo final

A construcao mais provavel do projeto foi:

1. criar o app Flutter;
2. instalar dependencias;
3. modelar os dados;
4. criar a camada de API;
5. criar a store com MobX;
6. gerar o `.g.dart`;
7. montar a `HomePage`;
8. criar o `PokeCard`;
9. adicionar filtro, scroll e cor dinamica;
10. iniciar a estrutura da `DetailPage`.

Se voce estudar nessa mesma ordem, o projeto fica bem mais facil de compreender do que tentar ler tudo ao mesmo tempo.
