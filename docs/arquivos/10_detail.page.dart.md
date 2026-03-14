# detail.page.dart

## O que esse arquivo faz hoje

`lib/pages/detail/detail.page.dart` renderiza a tela de detalhe do Pokemon selecionado na `HomePage` e ja dispara o carregamento dos dados detalhados.

## O que a tela recebe

```dart
final Pokemon pokemon;
```

A `HomePage` envia esse objeto quando o usuario toca em um card.

## Estado usado pela tela

```dart
final DetailStore store = DetailStore();

DetailPage({super.key, required this.pokemon}) {
  store.getPokemonDetailsData(pokemon.id);
}
```

Ou seja:

1. a tela cria a `DetailStore`;
2. assim que e instanciada, ela pede os detalhes pelo `id`;
3. o carregamento ja comeca antes do `build`.

## Estrutura atual

```dart
return Scaffold(
  body: CustomScrollView(
    slivers: [
      SliverAppBar(
        backgroundColor: pokemon.color,
        pinned: false,
        floating: true,
        collapsedHeight: 60,
        expandedHeight: 300,
        flexibleSpace: FlexibleSpaceBar(
          background: Hero(
            tag: ValueKey(pokemon.id),
            child: CachedNetworkImage(imageUrl: pokemon.imageUrl),
          ),
        ),
      ),

      Observer(
        builder: (ctx) {
          final pokemonDetails = store.pokemonDetails;

          return store.isLoading
              ? SliverToBoxAdapter(
                  child: Center(child: CircularProgressIndicator()),
                )
              : SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Text(pokemonDetails!.name.toUpperCase()),
                        Text("#${store.pokemonDetails!.id}"),
                        Wrap(
                          spacing: 10,
                          children: [
                            ...(store.pokemonDetails?.types
                                    ?.map(
                                      (type) => Chip(
                                        label: Text(type.name),
                                        backgroundColor: pokemon.color,
                                      ),
                                    )
                                    .toList() ??
                                <Widget>[]),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
        },
      ),
    ],
  ),
);
```

## O que isso entrega

- fundo do `SliverAppBar` usando `pokemon.color`;
- imagem oficial em destaque;
- animacao `Hero` conectada ao card da lista;
- disparo da busca de detalhe pela `DetailStore`;
- observacao do loading com `Observer`;
- exibicao do nome em caixa alta;
- exibicao do numero da Pokedex;
- exibicao dos tipos com `Chip`;
- estrutura pronta para crescer com mais secoes no `CustomScrollView`.

## Como ela entra no fluxo do app

1. o usuario toca em um `PokeCard`;
2. a `HomePage` faz `Navigator.push`;
3. a `DetailPage` recebe o `Pokemon`;
4. a mesma imagem e animada entre lista e detalhe via `Hero`.

## Relacao com a nova camada de detalhe

O projeto agora ja possui:

- `PokeApiService.getPokemonDetail(...)`;
- `PokemonDetails`;
- `DetailStore`.

Aqui essa camada ja esta sendo usada para iniciar o carregamento quando a tela abre.

## Limitacao atual

Hoje a `DetailPage` ja busca os detalhes e ja renderiza parte de `pokemonDetails` no corpo da tela.

No estado atual, ela mostra:

- nome;
- ID;
- tipos.

Ela ainda pode crescer para exibir peso, altura, experiencia base e stats.
