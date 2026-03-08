# Recriacao Completa

## Objetivo

Ter um roteiro unico para refazer o projeto inteiro do zero.

## Ordem completa

1. crie o projeto Flutter;
2. instale `uno`, `mobx`, `flutter_mobx`, `palette_generator`, `cached_network_image`, `build_runner` e `mobx_codegen`;
3. organize as pastas de `lib/`;
4. crie `pokemon.model.dart`;
5. crie `poke_response.model.dart`;
6. crie `poke_api.service.dart`;
7. crie `home.store.dart`;
8. gere `home.store.g.dart`;
9. crie `colors.dart`;
10. crie `detail.page.dart`;
11. crie `poke_card.widget.dart`;
12. crie `home.page.dart`;
13. ajuste `main.dart` para abrir a `HomePage`.

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
