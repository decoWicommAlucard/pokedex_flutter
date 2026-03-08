# Recriando colors.dart

## Objetivo

Centralizar a cor principal da interface em um arquivo separado.

## Passo 1: criar o arquivo

Crie:

```text
lib/colors.dart
```

## Passo 2: importar Material

Adicione:

```dart
import 'package:flutter/material.dart';
```

## Passo 3: criar a constante de cor

Adicione:

```dart
const primaryColor = Color(0xFF2E3156);
```

## O que foi feito aqui

1. a cor principal deixou de ficar espalhada;
2. o projeto ganhou um ponto unico para reutilizar a mesma cor;
3. a tela e os cards podem importar esse valor.

## Codigo final esperado

```dart
import 'package:flutter/material.dart';

const primaryColor = Color(0xFF2E3156);
```

## Onde essa cor sera usada depois

- titulo da `HomePage`;
- subtitulo da `HomePage`;
- icone do campo de busca;
- textos dentro do `PokeCard`.
