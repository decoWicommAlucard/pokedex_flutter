# pokemon_details.model.dart

## O que esse arquivo faz

`lib/models/pokemon_details.model.dart` representa a resposta detalhada de um Pokemon especifico.

## Onde ele entra no projeto

Esse model e usado pela camada de detalhe:

- `PokeApiService.getPokemonDetail(...)`;
- `DetailStore`;
- carregamento disparado pela `DetailPage`.

## Estrutura da classe

```dart
class PokemonDetails {
  final String name;
  final int id;
  final int height;
  final int weight;
  final int baseExperience;
  final List<Stat>? stats;
  final List<PokemonType>? types;
```

## O que cada campo guarda

- `name`: nome do Pokemon;
- `id`: numero da Pokedex;
- `height`: altura retornada pela API;
- `weight`: peso retornado pela API;
- `baseExperience`: experiencia base;
- `stats`: lista de stats detalhados;
- `types`: lista de tipos do Pokemon.

## Conversao do JSON

```dart
factory PokemonDetails.fromJson(Map<String, dynamic> data) {
  return PokemonDetails(
    name: data['name'],
    id: data['id'],
    height: data['height'],
    weight: data['weight'],
    baseExperience: data['base_experience'],
    stats: (data['stats'] != null ? data['stats'] as List<dynamic> : null)
        ?.map((stat) => Stat.fromJson(stat))
        .toList(),
    types: (data['types'] as List<dynamic>?)
        ?.map((type) => PokemonType.fromJson(type['type']))
        .toList(),
  );
}
```

## Como foi feito

1. le campos simples como `name`, `id`, `height` e `weight`;
2. converte `base_experience` para `baseExperience`;
3. transforma cada item de `stats` em `Stat`;
4. transforma cada item de `types` em `PokemonType`.

## Observacao importante

Hoje esse model ja pode ser carregado quando a `DetailPage` abre.

A interface ja usa parte de `pokemonDetails` para mostrar:

- `name`;
- `id`;
- `types`.

Ainda faltam campos como peso, altura, experiencia base e stats.
