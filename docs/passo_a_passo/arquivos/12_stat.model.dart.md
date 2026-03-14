# Recriando stat.model.dart

## Objetivo

Criar o model de cada stat detalhada do Pokemon.

## Antes de comecar

Voce ja deve ter:

- `PokemonStat`.

## Passo 1: criar o arquivo

Crie:

```text
lib/models/stat.model.dart
```

## Passo 2: adicionar o import

```dart
import 'package:pokedex_flutter/models/pokemon_stat.model.dart';
```

## Passo 3: criar a classe

```dart
class Stat {
  final int baseStat;
  final int effort;
  final PokemonStat stat;
```

## Passo 4: criar o construtor

```dart
Stat({required this.baseStat, required this.effort, required this.stat});
```

## Passo 5: criar o `fromJson`

```dart
factory Stat.fromJson(Map<String, dynamic> data) {
  return Stat(
    baseStat: data['base_stat'],
    effort: data['effort'],
    stat: PokemonStat.fromJson(data['stat']),
  );
}
```

## O que foi feito aqui

1. `base_stat` virou `baseStat`;
2. `effort` ficou como inteiro;
3. o bloco interno `stat` virou `PokemonStat`.

## Como verificar

Quando o detalhe for carregado, cada item de `pokemonDetails.stats` deve virar um `Stat`.
