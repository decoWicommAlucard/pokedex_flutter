# stat.model.dart

## O que esse arquivo faz

`lib/models/stat.model.dart` representa um item da lista de stats detalhados de um Pokemon.

## Estrutura da classe

```dart
class Stat {
  final int baseStat;
  final int effort;
  final PokemonStat stat;
```

## O que cada campo significa

- `baseStat`: valor base daquela stat;
- `effort`: effort value retornado pela API;
- `stat`: informacao basica da stat, como nome e URL.

## Conversao do JSON

```dart
factory Stat.fromJson(Map<String, dynamic> data) {
  return Stat(
    baseStat: data['base_stat'],
    effort: data['effort'],
    stat: PokemonStat.fromJson(data['stat']),
  );
}
```

## Como foi feito

1. a API devolve um objeto com `base_stat`, `effort` e `stat`;
2. `base_stat` vira `baseStat`;
3. `stat` vira um `PokemonStat`;
4. o app passa a trabalhar com um objeto Dart mais organizado.
