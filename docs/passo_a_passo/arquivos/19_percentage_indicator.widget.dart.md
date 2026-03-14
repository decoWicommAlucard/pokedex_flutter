# Recriando percentage_indicator.widget.dart

## Objetivo

Criar o widget da barra de percentual usada na lista de stats.

## Antes de comecar

Voce ja deve ter instalado:

- `percent_indicator`.

## Passo 1: criar o arquivo

Crie:

```text
lib/widgets/percentage_indicator.widget.dart
```

## Passo 2: adicionar os imports

```dart
import 'package:flutter/material.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
```

## Passo 3: criar a classe

```dart
class PercentageIndicator extends StatelessWidget {
  final String name;
  final int value;
  final Color color;
```

## Passo 4: criar o construtor

```dart
const PercentageIndicator({
  super.key,
  required this.name,
  required this.value,
  required this.color,
});
```

## Passo 5: montar a barra

```dart
LinearPercentIndicator(
  lineHeight: 25,
  percent: value.toDouble() / 100,
  progressColor: color,
  animation: true,
  barRadius: const Radius.circular(20),
  backgroundColor: Colors.grey,
  center: Text("${value.toDouble()} %"),
)
```

## Onde ele sera usado

Na `DetailPage`, cada item de `pokemonDetails.stats` deve virar um `PercentageIndicator`.
