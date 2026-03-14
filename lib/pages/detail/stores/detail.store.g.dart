// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DetailStore on DetailStoreBase, Store {
  late final _$isLoadingAtom = Atom(
    name: 'DetailStoreBase.isLoading',
    context: context,
  );

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$pokemonDetailsAtom = Atom(
    name: 'DetailStoreBase.pokemonDetails',
    context: context,
  );

  @override
  PokemonDetails? get pokemonDetails {
    _$pokemonDetailsAtom.reportRead();
    return super.pokemonDetails;
  }

  @override
  set pokemonDetails(PokemonDetails? value) {
    _$pokemonDetailsAtom.reportWrite(value, super.pokemonDetails, () {
      super.pokemonDetails = value;
    });
  }

  late final _$getPokemonDetailsDataAsyncAction = AsyncAction(
    'DetailStoreBase.getPokemonDetailsData',
    context: context,
  );

  @override
  Future<void> getPokemonDetailsData(String id) {
    return _$getPokemonDetailsDataAsyncAction.run(
      () => super.getPokemonDetailsData(id),
    );
  }

  @override
  String toString() {
    return '''
isLoading: ${isLoading},
pokemonDetails: ${pokemonDetails}
    ''';
  }
}
