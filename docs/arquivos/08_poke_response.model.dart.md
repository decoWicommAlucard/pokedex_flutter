# poke_response.model.dart

## O que esse arquivo faz

`lib/models/poke_response.model.dart` representa a resposta da listagem da PokeAPI.

## Estrutura da classe

```dart
class PokeResponse {
  final int count;
  final String? next;
  final String? previous;
  final List<Pokemon> results;
```

## O que cada campo significa

- `count`: total de Pokemons existentes;
- `next`: URL da proxima pagina;
- `previous`: URL da pagina anterior;
- `results`: lista de Pokemons retornados na chamada atual.

## Conversao do JSON

```dart
factory PokeResponse.fromJson(Map<String, dynamic> json) {
  return PokeResponse(
    count: json['count'],
    next: json['next'],
    previous: json['previous'],
    results: (json['results'] as List)
        .map((e) => Pokemon.fromJson(e))
        .toList(),
  );
}
```

## Como foi feito

1. a API devolve um mapa JSON;
2. `results` chega como lista de mapas;
3. cada item e transformado em `Pokemon`;
4. no fim, o app recebe uma `List<Pokemon>`.
