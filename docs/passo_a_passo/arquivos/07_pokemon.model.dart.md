# Recriando pokemon.model.dart

## Objetivo

Criar o model que representa cada Pokemon individual no app.

## Passo 1: criar o arquivo

Crie:

```text
lib/models/pokemon.model.dart
```

## Passo 2: importar Material

```dart
import 'package:flutter/material.dart';
```

## Passo 3: criar a classe e os campos

```dart
class Pokemon {
  final String name;
  final String url;
  final Color color;
```

## Passo 4: criar o getter `id`

Adicione:

```dart
String get id {
  final data = url.split('/');
  data.removeLast();
  return data.last;
}
```

## Passo 5: criar o getter `imageUrl`

Adicione:

```dart
String get imageUrl =>
    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";
```

## Passo 6: criar o construtor

```dart
Pokemon({required this.name, required this.url, this.color = Colors.white});
```

## Passo 7: criar o `fromJson`

```dart
factory Pokemon.fromJson(Map<String, dynamic> json) {
  return Pokemon(name: json['name'], url: json['url']);
}
```

## Passo 8: criar o `copyWith`

```dart
Pokemon copyWith({String? name, String? url, Color? color}) {
  return Pokemon(
    name: name ?? this.name,
    url: url ?? this.url,
    color: color ?? this.color,
  );
}
```

## O que foi feito aqui

1. o model guarda nome, URL e cor;
2. o ID e derivado da URL;
3. a imagem oficial e montada a partir do ID;
4. o JSON da API vira um objeto Dart;
5. a cor pode ser atualizada com `copyWith`.

## Como verificar

Se a API retornar `url: https://pokeapi.co/api/v2/pokemon/25/`, este model deve conseguir fornecer:

- `id = 25`
- `imageUrl` apontando para a arte oficial do Pokemon 25
