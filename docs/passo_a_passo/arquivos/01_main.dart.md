# Recriando main.dart

## Objetivo

Criar o ponto de entrada do app e fazer a aplicacao abrir direto na `HomePage`.

## Antes de comecar

Voce ja deve ter:

- o projeto Flutter criado;
- a `HomePage` existente em `lib/pages/home/home.page.dart`.

## Passo 1: importar a tela inicial

No topo do arquivo, adicione:

```dart
import 'package:flutter/material.dart';
import 'package:pokedex_flutter/pages/home/home.page.dart';
```

## Passo 2: criar a funcao principal

Adicione:

```dart
void main() {
  runApp(const MyApp());
}
```

## Passo 3: criar o widget raiz

Adicione:

```dart
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
```

## O que foi feito aqui

1. o Flutter agora tem um ponto de entrada;
2. `runApp` inicializa a interface;
3. `MaterialApp` vira a base visual;
4. `HomePage` passa a ser a primeira tela.

## Codigo final esperado

```dart
import 'package:flutter/material.dart';
import 'package:pokedex_flutter/pages/home/home.page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
```

## Como verificar

Rode:

```bash
flutter run
```

Se estiver certo, o app abre direto na tela principal da Pokedex.
