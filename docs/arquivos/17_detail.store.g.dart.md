# detail.store.g.dart

## O que esse arquivo faz

`lib/pages/detail/stores/detail.store.g.dart` e um arquivo gerado automaticamente pelo MobX para a `DetailStore`.

## Por que ele existe

Quando a store usa:

- `@observable`
- `@action`

o MobX gera codigo para acompanhar mudancas de estado.

## O que existe nele

- `Atom` para `isLoading`;
- `Atom` para `pokemonDetails`;
- `AsyncAction` para `getPokemonDetailsData(...)`.

## Como ele e criado

Use este comando:

```bash
dart run build_runner build
```

Ou:

```bash
dart run build_runner watch
```

## Regra importante

Nao edite esse arquivo manualmente.

Se `detail.store.dart` mudar, gere o arquivo novamente.
