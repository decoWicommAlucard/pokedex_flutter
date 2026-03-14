# Recriando type.model.dart

## Objetivo

Criar o model auxiliar que junta `slot` e `type`.

## Antes de comecar

Voce ja deve ter:

- `PokemonType`.

## Passo 1: criar o arquivo

Crie:

```text
lib/models/type.model.dart
```

## Passo 2: adicionar o import

```dart
import 'package:pokedex_flutter/models/pokemon_type.model.dart';
```

## Passo 3: criar a classe

```dart
class Type {
  final int slot;
  final PokemonType type;
```

## Passo 4: criar o construtor

```dart
Type({required this.slot, required this.type});
```

## Passo 5: criar o `fromJson`

```dart
factory Type.fromJson(Map<String, dynamic> data) {
  return Type(slot: data['slot'], type: data['type']);
}
```

## Observacao importante

Hoje esse model ainda nao entra no fluxo principal da `DetailPage`.

O codigo atual usa `PokemonType` diretamente dentro de `PokemonDetails`.
