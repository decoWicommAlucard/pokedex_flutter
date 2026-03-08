# pokedex_flutter

Pokedex em Flutter com consumo da PokeAPI, estado com MobX e interface baseada nas cores dominantes das imagens oficiais dos Pokemons.

## Recursos atuais

- carregamento paginado em lotes de 20 itens;
- filtro local por nome ou numero entre os Pokemons ja carregados;
- cards com `CachedNetworkImage`, transicao `Hero` e fundo dinamico via `PaletteGenerator`;
- tela de detalhe inicial com `SliverAppBar` e cor herdada do Pokemon selecionado;
- separacao simples entre `pages`, `widgets`, `store`, `services` e `models`.

## Documentacao

- [Guia de estudo](docs/GUIA_DE_ESTUDO.md)
- [Documentacao por arquivo](docs/arquivos/)
- [Documentacao por funcionalidade](docs/funcionalidades/)
- [Guia de recriacao](docs/passo_a_passo/GUIA_DE_RECRIACAO.md)

## Comandos uteis

```bash
flutter pub get
flutter run
dart run build_runner build --delete-conflicting-outputs
flutter analyze
```

## Fluxo principal

1. `HomePage` chama `HomeStore.loadPokemons()` no `initState`.
2. `PokeApiService` busca a listagem na PokeAPI.
3. A store popula `pokemons` e o `Observer` atualiza a grade.
4. Cada `PokeCard` extrai a cor dominante da imagem e atualiza o Pokemon na store.
5. Ao tocar em um card, o app abre `DetailPage` com animacao `Hero`.
