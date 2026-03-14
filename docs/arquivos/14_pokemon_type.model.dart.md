# pokemon_type.model.dart

## O que esse arquivo faz

`lib/models/pokemon_type.model.dart` representa o objeto interno `type` retornado pela PokeAPI.

## Estrutura da classe

```dart
class PokemonType {
  final String name;
  final String url;
```

## O que cada campo guarda

- `name`: nome do tipo, como `grass` ou `electric`;
- `url`: URL de referencia desse tipo na API.

## Conversao do JSON

```dart
factory PokemonType.fromJson(Map<String, dynamic> json) {
  return PokemonType(name: json['name'], url: json['url']);
}
```

## Onde ele e usado

Hoje `PokemonDetails.fromJson(...)` consome apenas o objeto interno `type`:

```dart
types: (data['types'] as List<dynamic>?)
    ?.map((type) => PokemonType.fromJson(type['type']))
    .toList(),
```

Assim, o app guarda diretamente os nomes dos tipos em vez do bloco completo da API.
