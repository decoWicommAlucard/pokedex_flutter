# pokemon.model.dart

## O que esse arquivo faz

`lib/models/pokemon.model.dart` representa um Pokemon individual dentro do app.

## Campos da classe

```dart
class Pokemon {
  final String name;
  final String url;
  final Color color;
```

## O que cada campo guarda

- `name`: nome do Pokemon;
- `url`: URL de referencia vinda da PokeAPI;
- `color`: cor do card na interface.

## Como o ID e extraido

```dart
String get id {
  final data = url.split('/');
  data.removeLast();
  return data.last;
}
```

## Passo a passo

1. quebra a URL por `/`;
2. remove a ultima parte vazia;
3. pega o ultimo valor restante;
4. esse valor vira o ID.

Exemplo:

- `https://pokeapi.co/api/v2/pokemon/25/` vira `25`.

## Como a URL da imagem e montada

```dart
String get imageUrl =>
    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";
```

Ou seja, a imagem nao vem pronta da listagem principal.

O projeto monta a URL da arte oficial usando o ID.

## Conversao do JSON

```dart
factory Pokemon.fromJson(Map<String, dynamic> json) {
  return Pokemon(name: json['name'], url: json['url']);
}
```

## `copyWith`

```dart
Pokemon copyWith({String? name, String? url, Color? color}) {
  return Pokemon(
    name: name ?? this.name,
    url: url ?? this.url,
    color: color ?? this.color,
  );
}
```

Esse metodo permite criar uma copia do objeto mudando apenas alguns campos, principalmente a cor.
