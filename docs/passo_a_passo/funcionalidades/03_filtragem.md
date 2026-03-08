# Recriando a Filtragem

## Objetivo

Permitir busca por nome ou numero da Pokedex.

## Passo 1: criar o campo `search` na store

```dart
@observable
String? search;
```

## Passo 2: criar a action `setSearch`

```dart
@action
void setSearch(String text) => search = text;
```

## Passo 3: criar o getter `filteredPokemons`

Ele deve:

1. devolver todos os itens se a busca estiver vazia;
2. filtrar por nome com `contains`;
3. filtrar por ID com `pokemon.id == search`.

## Passo 4: ligar o `TextField` a store

Na `HomePage`, use:

```dart
TextField(
  onChanged: store.setSearch,
)
```

## Passo 5: usar `filteredPokemons` na grade

Troque a fonte de dados da tela para:

```dart
store.filteredPokemons
```

## Como verificar

1. digite parte do nome de um Pokemon;
2. veja se a grade filtra em tempo real;
3. digite um numero exato como `25`;
4. veja se o Pokemon correspondente aparece.
