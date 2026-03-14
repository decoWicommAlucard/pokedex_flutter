# percentage_indicator.widget.dart

## O que esse arquivo faz

`lib/widgets/percentage_indicator.widget.dart` renderiza a barra visual usada na lista de stats do Pokemon.

## Estrutura da classe

```dart
class PercentageIndicator extends StatelessWidget {
  final String name;
  final int value;
  final Color color;
```

## O que cada campo guarda

- `name`: nome da stat;
- `value`: valor numerico daquela stat;
- `color`: cor usada na barra.

## Como ele desenha

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

## Dependencia usada

Esse widget depende do pacote `percent_indicator`.

## Onde ele e usado

Na `DetailPage`, ele aparece dentro de um `ListView.builder`.

Cada item de `pokemonDetails.stats` vira um `PercentageIndicator`.
