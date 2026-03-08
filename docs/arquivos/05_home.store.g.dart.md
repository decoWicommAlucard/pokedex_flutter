# home.store.g.dart

## O que esse arquivo faz

`lib/store/home.store.g.dart` e um arquivo gerado automaticamente pelo MobX.

Voce nao escreve esse arquivo na mao.

## Por que ele existe

Quando voce usa:

- `@observable`
- `@action`
- `@computed`

o MobX precisa gerar codigo para controlar leitura, escrita e reatividade.

## O que existe nele

- `Atom` para observar campos;
- `Computed` para getters calculados;
- `ActionController` para actions;
- `AsyncAction` para actions assincronas.

## Exemplos do arquivo gerado

```dart
late final _$isLoadingAtom = Atom(
  name: 'HomeStoreBase.isLoading',
  context: context,
);
```

```dart
late final _$loadPokemonsAsyncAction = AsyncAction(
  'HomeStoreBase.loadPokemons',
  context: context,
);
```

## Como ele e criado

Use este comando:

```bash
dart run build_runner build
```

Ou, se quiser regenerar automaticamente durante o desenvolvimento:

```bash
dart run build_runner watch
```

## Regra importante

Nao edite esse arquivo manualmente.

Se a store mudar, gere o arquivo de novo.
