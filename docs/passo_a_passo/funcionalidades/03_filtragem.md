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

Use este getter:

```dart
@computed
List<Pokemon> get filteredPokemons {
  if (search == null || search!.isEmpty) {
    return pokemons.toList();
  }
  return pokemons
      .where(
        (pokemon) =>
            pokemon.name.toLowerCase().contains(search!.toLowerCase()) ||
            pokemon.id == search,
      )
      .toList();
}
```

## Passo 4: ligar o `TextField` a store

Na `HomePage`, use:

```dart
TextField(
  onChanged: store.setSearch,
  decoration: InputDecoration(
    hintText: "Nome ou identificador",
    hintStyle: TextStyle(color: Color(0xFFA1AAAF)),
    filled: true,
    fillColor: Color(0xFFE9F2F2),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: BorderSide.none,
    ),
    prefixIcon: Icon(Icons.search, color: primaryColor),
  ),
)
```

## Passo 5: usar `filteredPokemons` na grade

Troque a fonte de dados da tela para:

```dart
itemCount: store.filteredPokemons.length + 1,

if (index < store.filteredPokemons.length) {
  final pokemon = store.filteredPokemons[index];
  return PokeCard(pokemon: pokemon, store: store);
}
```

## Arquivos com codigo completo desta fase

- [04_home.store.dart.md](../arquivos/04_home.store.dart.md)
- [03_home.page.dart.md](../arquivos/03_home.page.dart.md)

## Como verificar

1. digite parte do nome de um Pokemon;
2. veja se a grade filtra em tempo real;
3. digite um numero exato como `25`;
4. veja se o Pokemon correspondente aparece.
