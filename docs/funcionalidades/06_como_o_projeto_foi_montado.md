# Como o Projeto Foi Montado

## O que esta documentacao explica

Aqui a ideia e reconstruir uma ordem plausivel para a evolucao do projeto com base no codigo atual.

## Visao geral da ordem

1. criar o projeto Flutter;
2. instalar dependencias;
3. modelar os dados;
4. criar o service da API;
5. criar a store com MobX;
6. gerar o `.g.dart`;
7. criar a base visual compartilhada;
8. montar a `DetailPage`;
9. montar a `HomePage`;
10. criar o `PokeCard`;
11. ligar busca, scroll, cores dinamicas e navegacao;
12. definir `HomePage` em `main.dart`.

## 1. Criacao do projeto

Passo base:

```bash
flutter create pokedex_flutter
```

Isso gera a estrutura multiplataforma usada pelo resto do codigo.

## 2. Instalacao das dependencias

Dependencias atuais mais relevantes:

```yaml
dependencies:
  uno: ^1.1.6
  mobx: ^2.6.0
  flutter_mobx: ^2.3.0
  palette_generator: ^0.3.3+2
  cached_network_image: ^3.4.1
```

```yaml
dev_dependencies:
  build_runner: ^2.10.5
  mobx_codegen: ^2.7.6
```

Comandos equivalentes:

```bash
flutter pub add uno mobx flutter_mobx palette_generator cached_network_image
flutter pub add --dev build_runner mobx_codegen
```

Motivos:

- `uno` para HTTP;
- `mobx` e `flutter_mobx` para estado reativo;
- `palette_generator` para colorir os cards;
- `cached_network_image` para exibir e reaproveitar imagens;
- `build_runner` e `mobx_codegen` para gerar a store.

## 3. Criacao dos models

Arquivos:

- `lib/models/pokemon.model.dart`
- `lib/models/poke_response.model.dart`
- `lib/models/pokemon_details.model.dart`
- `lib/models/stat.model.dart`
- `lib/models/pokemon_stat.model.dart`
- `lib/models/pokemon_type.model.dart`
- `lib/models/type.model.dart`

Essa etapa prepara o app para trabalhar com objetos Dart em vez de mapas crus.

`Pokemon` concentra:

- `name`;
- `url`;
- `color`;
- getter `id`;
- getter `imageUrl`;
- `copyWith`.

`PokeResponse` concentra:

- `count`;
- `next`;
- `previous`;
- `results`.

Depois, o projeto tambem ganhou models para o detalhe:

- `PokemonDetails`;
- `Stat`;
- `PokemonStat`;
- `PokemonType`;
- `Type`.

## 4. Criacao do service

Arquivo:

- `lib/services/poke_api.service.dart`

Trecho central:

```dart
final response = await _uno.get("/pokemon?offset=$offset&limit=20");
```

Aqui a PokeAPI foi isolada em uma camada propria, deixando a UI sem codigo HTTP.

Hoje o service tambem possui:

```dart
final response = await _uno.get("/pokemon/$id");
```

Isso mostra que a camada HTTP evoluiu da listagem para o detalhe.

## 5. Criacao da store

Arquivo:

- `lib/store/home.store.dart`

A store concentra:

- `isLoading`;
- `search`;
- `pokemons`;
- `filteredPokemons`;
- `loadPokemons()`;
- `updatePokemonColor(...)`.

Esse e o ponto onde o projeto ganha regra de negocio organizada.

Depois disso, surgiu tambem uma store especifica para o detalhe:

- `lib/pages/detail/stores/detail.store.dart`

Ela concentra:

- `isLoading`;
- `pokemonDetails`;
- `getPokemonDetailsData(...)`.

## 6. Geracao do arquivo do MobX

Arquivo gerado:

- `lib/store/home.store.g.dart`

Comando:

```bash
dart run build_runner build
```

Sem esse passo, as anotacoes do MobX nao funcionam na pratica.

## 7. Criacao da base visual compartilhada

Arquivo:

- `lib/colors.dart`

Esse arquivo provavelmente entrou cedo para centralizar a `primaryColor` usada nas telas e nos cards.

## 8. Montagem da `DetailPage`

Arquivo:

- `lib/pages/detail/detail.page.dart`

No codigo atual, a tela:

- recebe um `Pokemon`;
- usa `CustomScrollView`;
- exibe um `SliverAppBar`;
- reaproveita a imagem via `Hero`;
- usa `pokemon.color` como fundo do topo.

Ela ainda e simples, mas ja faz parte do fluxo real do app.

Hoje existe tambem uma camada adicional pronta para expandir essa tela:

- `DetailStore`;
- `PokemonDetails`;
- endpoint `/pokemon/{id}`.

## 9. Montagem da `HomePage`

Arquivo:

- `lib/pages/home/home.page.dart`

Provavel conteudo inicial:

- titulo e subtitulo;
- `TextField` de busca;
- `Observer`;
- `GridView.builder`;
- `ScrollController`.

Essa tela depende diretamente de store, models e service ja estarem prontos.

## 10. Criacao do `PokeCard`

Arquivo:

- `lib/widgets/poke_card.widget.dart`

Esse componente provavelmente foi extraido para encapsular:

- nome;
- numero;
- imagem;
- `Hero`;
- transicao de cor com `AnimatedContainer`.

Trecho visual central:

```dart
CachedNetworkImage(
  imageUrl: widget.pokemon.imageUrl,
  height: 130,
)
```

## 11. Refinamentos de comportamento

Depois da estrutura principal, o projeto ganhou os comportamentos que hoje definem a experiencia:

- scroll infinito com `offset`;
- filtro local via `search`;
- cor dominante via `PaletteGenerator`;
- abertura da `DetailPage` com `Navigator.push`.

Essa fase conecta estado, UI e navegacao.

## 12. Definicao da tela inicial

Trecho final em `main.dart`:

```dart
home: HomePage(),
```

Isso fecha o fluxo para o app iniciar direto na Pokedex.

## Ordem de estudo recomendada

1. `pokemon.model.dart`
2. `poke_response.model.dart`
3. `poke_api.service.dart`
4. `home.store.dart`
5. `pokemon_details.model.dart`
6. `detail.store.dart`
7. `home.store.g.dart`
8. `colors.dart`
9. `detail.page.dart`
10. `poke_card.widget.dart`
11. `home.page.dart`
12. `main.dart`

## O que esse projeto ensina

- separacao de camadas;
- consumo de API;
- modelagem de dados;
- MobX na pratica;
- scroll infinito;
- filtro local;
- extracao de cor;
- navegacao com `Hero`;
- preparacao de uma camada de detalhe com endpoint proprio.

## Resumo

Uma linha de montagem coerente para o projeto atual e:

1. base Flutter;
2. dependencias;
3. models;
4. service;
5. store principal;
6. camada de detalhe;
7. geracao do MobX;
8. base visual;
9. telas;
10. widget de card;
11. integracao final entre busca, scroll, cor e detalhe.
