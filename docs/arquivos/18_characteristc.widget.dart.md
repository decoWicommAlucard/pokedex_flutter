# characteristc.widget.dart

## O que esse arquivo faz

`lib/widgets/characteristc.widget.dart` cria um pequeno bloco visual para mostrar um valor e seu rotulo.

## Estrutura da classe

```dart
class Characteristc extends StatelessWidget {
  final String value;
  final String name;
```

## O que cada campo guarda

- `value`: o valor que sera mostrado;
- `name`: o nome daquele campo.

## Como ele desenha

```dart
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
```

## Onde ele e usado

Na `DetailPage`, esse widget aparece tres vezes para mostrar:

- `Height`;
- `Experience`;
- `Weight`.

## Por que esse widget existe

Sem ele, a `DetailPage` teria que repetir o mesmo bloco visual varias vezes.

Com ele, a tela fica mais organizada e facil de manter.
