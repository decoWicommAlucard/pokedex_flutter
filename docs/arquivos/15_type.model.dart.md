# type.model.dart

## O que esse arquivo faz

`lib/models/type.model.dart` foi criado para representar a estrutura completa de tipo retornada pela PokeAPI, incluindo `slot` e `type`.

## Estrutura da classe

```dart
class Type {
  final int slot;
  final PokemonType type;
```

## O que cada campo guarda

- `slot`: posicao daquele tipo no Pokemon;
- `type`: objeto com nome e URL do tipo.

## Conversao atual

```dart
factory Type.fromJson(Map<String, dynamic> data) {
  return Type(slot: data['slot'], type: data['type']);
}
```

## Observacao importante

Hoje esse model ainda nao faz parte do fluxo principal.

No codigo atual:

- `PokemonDetails` usa `PokemonType` diretamente;
- `Type` existe como model auxiliar;
- a interface ainda nao consome essa classe.
