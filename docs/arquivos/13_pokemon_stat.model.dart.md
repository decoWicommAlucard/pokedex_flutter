# pokemon_stat.model.dart

## O que esse arquivo faz

`lib/models/pokemon_stat.model.dart` representa o objeto interno `stat` retornado pela PokeAPI.

## Estrutura da classe

```dart
class PokemonStat {
  final String name;
  final String url;
```

## O que cada campo guarda

- `name`: nome da stat, como `hp` ou `attack`;
- `url`: URL de referencia dessa stat na API.

## Conversao do JSON

```dart
factory PokemonStat.fromJson(Map<String, dynamic> data) {
  return PokemonStat(name: data['name'], url: data['url']);
}
```

## Onde ele e usado

Esse model aparece dentro de `Stat`.

Ou seja:

- `Stat` guarda o valor numerico;
- `PokemonStat` guarda o nome e a URL daquela stat.
