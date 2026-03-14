# Recriando detail.store.g.dart

## Objetivo

Entender o arquivo gerado do MobX para a `DetailStore`.

## Regra principal

Voce nao escreve esse arquivo manualmente.

Ele e gerado a partir de `detail.store.dart`.

## Como gerar

Rode:

```bash
dart run build_runner build
```

Ou, se quiser acompanhar durante o desenvolvimento:

```bash
dart run build_runner watch
```

## O que deve aparecer nele

- `Atom` para `isLoading`;
- `Atom` para `pokemonDetails`;
- `AsyncAction` para `getPokemonDetailsData(...)`.

## Como verificar

Depois de gerar, o arquivo `lib/pages/detail/stores/detail.store.g.dart` deve existir sem erro.
