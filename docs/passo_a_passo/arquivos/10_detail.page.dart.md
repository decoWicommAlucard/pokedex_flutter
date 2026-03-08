# Recriando detail.page.dart

## Objetivo

Criar a estrutura inicial da futura tela de detalhes.

## Passo 1: criar o arquivo

Crie:

```text
lib/pages/detail/detail.page.dart
```

## Passo 2: importar Material

```dart
import 'package:flutter/material.dart';
```

## Passo 3: criar a classe

```dart
class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
```

## O que foi feito aqui

1. a estrutura da tela futura foi criada;
2. ainda nao existe layout;
3. ainda nao existe navegacao para essa tela.

## Como verificar

O arquivo deve compilar sem erro, mesmo ainda estando vazio.
