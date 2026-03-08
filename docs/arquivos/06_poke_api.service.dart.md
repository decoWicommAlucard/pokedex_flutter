# poke_api.service.dart

## O que esse arquivo faz

`lib/services/poke_api.service.dart` centraliza a comunicacao com a PokeAPI.

## Configuracao principal

```dart
class PokeApiService {
  late final Uno _uno;

  PokeApiService() {
    _uno = Uno(baseURL: "https://pokeapi.co/api/v2");
  }
}
```

## Por que usar `baseURL`

Assim o projeto nao precisa repetir a URL completa em todas as requisicoes.

## Metodo principal

```dart
Future<PokeResponse> getPokemon({required int offset}) async {
  final response = await _uno.get("/pokemon?offset=$offset&limit=20");

  if (response.status != HttpStatus.ok) {
    throw Exception("Failed to load pokemon");
  }

  return PokeResponse.fromJson(response.data);
}
```

## Passo a passo

1. recebe um `offset`;
2. faz um `GET` para `/pokemon`;
3. pede 20 itens por vez;
4. verifica se o status foi `200`;
5. converte o JSON em `PokeResponse`.

## O que foi feito aqui

- a regra HTTP foi separada da interface;
- a store nao conhece detalhes do pacote `Uno`;
- a resposta da API ja sai convertida em objeto Dart.

## Limite atual

Hoje esse service faz apenas a listagem dos Pokemons.

Ele ainda nao busca detalhes de um Pokemon especifico.
