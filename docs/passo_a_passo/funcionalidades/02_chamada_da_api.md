# Recriando a Chamada da API

## Objetivo

Refazer todo o caminho da API ate a tela.

## Passo 1: criar o model `Pokemon`

Ele sera usado para converter cada item de `results`.

## Passo 2: criar o model `PokeResponse`

Ele sera usado para converter a resposta completa da PokeAPI.

## Passo 3: criar o `PokeApiService`

No service:

1. configure o `Uno` com `baseURL`;
2. crie o metodo `getPokemon`;
3. use `offset` e `limit=20`;
4. retorne `PokeResponse.fromJson(response.data)`.

## Passo 4: ligar a API na `HomeStore`

Dentro da store:

1. crie `final _service = PokeApiService();`
2. crie `offset = 0`;
3. crie `loadPokemons()`;
4. use `_service.getPokemon(offset: offset)`;
5. adicione os resultados em `pokemons`.

## Passo 5: disparar o carregamento inicial

Na `HomePage`, dentro do `initState`, chame:

```dart
store.loadPokemons();
```

## Passo 6: mostrar os dados na tela

Use `Observer` e `GridView.builder` para renderizar `store.filteredPokemons`.

## Como verificar

Ao abrir o app, os primeiros 20 Pokemons devem aparecer.
