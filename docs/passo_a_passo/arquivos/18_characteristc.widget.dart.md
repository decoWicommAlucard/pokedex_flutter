# Recriando characteristc.widget.dart

## Objetivo

Criar o widget pequeno usado para mostrar um valor e um nome na tela de detalhe.

## Passo 1: criar o arquivo

Crie:

```text
lib/widgets/characteristc.widget.dart
```

## Passo 2: adicionar os imports

```dart
import 'package:flutter/material.dart';
import 'package:pokedex_flutter/colors.dart';
```

## Passo 3: criar a classe

```dart
class Characteristc extends StatelessWidget {
  final String value;
  final String name;
```

## Passo 4: criar o construtor

```dart
const Characteristc({super.key, required this.value, required this.name});
```

## Passo 5: montar o widget

```dart
@override
Widget build(BuildContext context) {
  return Column(
    children: [
      Text(
        value,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: primaryColor,
        ),
      ),
      Text(name, style: TextStyle(color: primaryColor)),
    ],
  );
}
```

## Onde ele sera usado

Na `DetailPage`, esse widget sera usado para:

- `Height`;
- `Experience`;
- `Weight`.
