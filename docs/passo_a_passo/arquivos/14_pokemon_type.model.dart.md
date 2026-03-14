# Recriando pokemon_type.model.dart

## Objetivo

Criar o model do bloco interno `type` vindo da PokeAPI.

## Passo 1: criar o arquivo

Crie:

```text
lib/models/pokemon_type.model.dart
```

## Passo 2: criar a classe

```dart
class PokemonType {
  final String name;
  final String url;
```

## Passo 3: criar o construtor

```dart
PokemonType({required this.name, required this.url});
```

## Passo 4: criar o `fromJson`

```dart
factory PokemonType.fromJson(Map<String, dynamic> json) {
  return PokemonType(name: json['name'], url: json['url']);
}
```

## O que foi feito aqui

1. o nome do tipo fica em `name`;
2. a URL do tipo fica em `url`;
3. esse model e usado em `pokemonDetails.types`.
