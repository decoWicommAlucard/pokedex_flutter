# Recriando pokemon_stat.model.dart

## Objetivo

Criar o model do bloco interno `stat` vindo da PokeAPI.

## Passo 1: criar o arquivo

Crie:

```text
lib/models/pokemon_stat.model.dart
```

## Passo 2: criar a classe

```dart
class PokemonStat {
  final String name;
  final String url;
```

## Passo 3: criar o construtor

```dart
PokemonStat({required this.name, required this.url});
```

## Passo 4: criar o `fromJson`

```dart
factory PokemonStat.fromJson(Map<String, dynamic> data) {
  return PokemonStat(name: data['name'], url: data['url']);
}
```

## O que foi feito aqui

1. o nome da stat fica em `name`;
2. a URL da stat fica em `url`;
3. esse model e usado dentro de `Stat`.
