# Recriacao Completa

## Objetivo

Ter um roteiro unico para refazer o projeto inteiro do zero.

## Ordem completa

1. crie o projeto Flutter;
2. instale `uno`, `mobx`, `flutter_mobx`, `palette_generator`, `cached_network_image`, `percent_indicator`, `build_runner` e `mobx_codegen`;
3. organize as pastas de `lib/`;
4. crie `pokemon.model.dart`;
5. crie `poke_response.model.dart`;
6. crie `pokemon_stat.model.dart`;
7. crie `stat.model.dart`;
8. crie `pokemon_type.model.dart`;
9. crie `type.model.dart`;
10. crie `pokemon_details.model.dart`;
11. crie `poke_api.service.dart`;
12. crie `home.store.dart`;
13. crie `detail.store.dart`;
14. gere `home.store.g.dart` e `detail.store.g.dart`;
15. crie `colors.dart`;
16. crie `detail.page.dart`;
17. crie `characteristc.widget.dart`;
18. crie `percentage_indicator.widget.dart`;
19. crie `poke_card.widget.dart`;
20. crie `home.page.dart`;
21. ajuste `main.dart` para abrir a `HomePage`.

## Ordem completa com codigo

Se quiser seguir o projeto inteiro sem procurar onde esta cada trecho, use esta sequencia:

- Estrutura inicial: [01_estrutura_base.md](01_estrutura_base.md)
- Models: [07_pokemon.model.dart.md](../arquivos/07_pokemon.model.dart.md), [08_poke_response.model.dart.md](../arquivos/08_poke_response.model.dart.md), [11_pokemon_details.model.dart.md](../arquivos/11_pokemon_details.model.dart.md), [12_stat.model.dart.md](../arquivos/12_stat.model.dart.md), [13_pokemon_stat.model.dart.md](../arquivos/13_pokemon_stat.model.dart.md), [14_pokemon_type.model.dart.md](../arquivos/14_pokemon_type.model.dart.md) e [15_type.model.dart.md](../arquivos/15_type.model.dart.md)
- Service: [06_poke_api.service.dart.md](../arquivos/06_poke_api.service.dart.md)
- Store: [04_home.store.dart.md](../arquivos/04_home.store.dart.md), [16_detail.store.dart.md](../arquivos/16_detail.store.dart.md), depois gere [05_home.store.g.dart.md](../arquivos/05_home.store.g.dart.md) e [17_detail.store.g.dart.md](../arquivos/17_detail.store.g.dart.md)
- Cores e detalhe: [02_colors.dart.md](../arquivos/02_colors.dart.md), [10_detail.page.dart.md](../arquivos/10_detail.page.dart.md), [18_characteristc.widget.dart.md](../arquivos/18_characteristc.widget.dart.md) e [19_percentage_indicator.widget.dart.md](../arquivos/19_percentage_indicator.widget.dart.md)
- Card e tela principal: [09_poke_card.widget.dart.md](../arquivos/09_poke_card.widget.dart.md), [03_home.page.dart.md](../arquivos/03_home.page.dart.md) e [01_main.dart.md](../arquivos/01_main.dart.md)

## Passo a passo por funcionalidade com trechos de codigo

Se preferir montar o projeto por fases, siga nesta ordem:

1. [01_estrutura_base.md](01_estrutura_base.md)
2. [02_chamada_da_api.md](02_chamada_da_api.md)
3. [03_filtragem.md](03_filtragem.md)
4. [04_scroll_infinito.md](04_scroll_infinito.md)
5. [05_cores_dos_cards.md](05_cores_dos_cards.md)
6. [07_detalhes_do_pokemon.md](07_detalhes_do_pokemon.md)

## Funcionalidades que entram nessa ordem

### 1. API

- models;
- service;
- `loadPokemons()`;
- chamada inicial no `initState`.

### 2. Listagem na tela

- `Observer`;
- `GridView.builder`;
- `PokeCard`.

### 3. Filtro

- `search`;
- `setSearch`;
- `filteredPokemons`;
- `TextField`.

### 4. Scroll infinito

- `ScrollController`;
- `scrollListener`;
- `offset`;
- `addAll`.

### 5. Cores dinamicas

- `color` no model;
- `PaletteGenerator`;
- `updatePokemonColor`;
- `AnimatedContainer`.

### 6. Navegacao para detalhe

- `DetailPage(pokemon: pokemon)`;
- `InkWell` no card da grade;
- `Hero` compartilhado entre lista e detalhe;
- `SliverAppBar` com a cor do Pokemon.

### 7. Detalhes completos do Pokemon

- `PokemonDetails`;
- `DetailStore`;
- `getPokemonDetail(...)`;
- nome, ID, tipos, caracteristicas e stats na `DetailPage`.

## Comandos da recriacao

```bash
flutter pub get
dart run build_runner build
flutter run
```

## Como validar cada fase

### Fase 1

O app deve abrir sem erro.

### Fase 2

Os primeiros Pokemons devem aparecer.

### Fase 3

A busca deve filtrar os cards.

### Fase 4

Ao rolar ate o fim, mais itens devem aparecer.

### Fase 5

Os cards devem trocar de branco para cores baseadas na imagem.

### Fase 6

Ao tocar em um card, a tela de detalhe deve abrir, carregar os dados e mostrar nome, ID, tipos, caracteristicas e stats.

## Melhor forma de estudar

Nao tente reconstruir tudo de uma vez.

Refaca nesta sequencia:

1. models;
2. service;
3. store;
4. detalhe;
5. card;
6. tela principal;
7. melhorias visuais.
