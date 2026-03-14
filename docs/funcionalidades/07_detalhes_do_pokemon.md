# Detalhes do Pokemon

## O que esta documentacao explica

Este guia mostra a nova camada de detalhe adicionada ao projeto para buscar dados completos de um Pokemon especifico.

## Arquivos envolvidos

- `lib/services/poke_api.service.dart`
- `lib/pages/detail/stores/detail.store.dart`
- `lib/pages/detail/stores/detail.store.g.dart`
- `lib/models/pokemon_details.model.dart`
- `lib/models/stat.model.dart`
- `lib/models/pokemon_stat.model.dart`
- `lib/models/pokemon_type.model.dart`
- `lib/models/type.model.dart`
- `lib/pages/detail/detail.page.dart`

## Visao geral do fluxo

Hoje o fluxo de detalhe funciona assim:

1. a `HomePage` abre a `DetailPage`;
2. a `DetailPage` recebe um `Pokemon`;
3. a `DetailPage` cria uma `DetailStore`;
4. a tela chama `store.getPokemonDetailsData(pokemon.id)`;
5. a `DetailStore` usa o service;
6. o service chama `/pokemon/{id}`;
7. a resposta vira `PokemonDetails`.

## Como a `DetailPage` aciona a store

```dart
final DetailStore store = DetailStore();

DetailPage({super.key, required this.pokemon}) {
  store.getPokemonDetailsData(pokemon.id);
}
```

Isso faz a busca comecar assim que a tela e criada.

## Chamada HTTP de detalhe

No service:

```dart
Future<PokemonDetails> getPokemonDetail({required String id}) async {
  final response = await _uno.get("/pokemon/$id");

  if (response.status != HttpStatus.ok) {
    throw Exception("Failed to load pokemon detail");
  }

  return PokemonDetails.fromJson(response.data);
}
```

Essa rota consulta um Pokemon especifico e devolve dados mais ricos que a listagem.

## O que o endpoint de detalhe entrega

A rota:

```text
/pokemon/{id}
```

devolve informacoes como:

- nome;
- id;
- altura;
- peso;
- experiencia base;
- stats;
- tipos.

## Como a store de detalhe funciona

```dart
@action
Future<void> getPokemonDetailsData(String id) async {
  isLoading = true;

  final pokeResponse = await _service.getPokemonDetail(id: id);
  pokemonDetails = pokeResponse;

  isLoading = false;
}
```

Papel da `DetailStore`:

1. ligar e desligar `isLoading`;
2. pedir os dados detalhados ao service;
3. guardar o resultado em `pokemonDetails`.

## Como o JSON vira models

O model principal da camada e `PokemonDetails`:

```dart
factory PokemonDetails.fromJson(Map<String, dynamic> data) {
  return PokemonDetails(
    name: data['name'],
    id: data['id'],
    height: data['height'].toDouble(),
    weight: data['weight'].toDouble(),
    baseExperience: data['base_experience'],
    stats: (data['stats'] != null ? data['stats'] as List<dynamic> : null)
        ?.map((stat) => Stat.fromJson(stat))
        .toList(),
    types: (data['types'] as List<dynamic>?)
        ?.map((type) => PokemonType.fromJson(type['type']))
        .toList(),
  );
}
```

Ele usa models auxiliares:

- `Stat` para cada stat;
- `PokemonStat` para o bloco interno `stat`;
- `PokemonType` para o bloco interno `type`.

## Diferenca entre listagem e detalhe

Na listagem:

- o app recebe `name` e `url`;
- o model `Pokemon` monta `id` e `imageUrl`.

No detalhe:

- o app recebe peso, altura, experiencia, stats e tipos;
- o model `PokemonDetails` organiza esse bloco completo.

## Estado atual da interface

Hoje a `DetailPage` ja faz estas partes do fluxo:

- `Hero`;
- `SliverAppBar`;
- imagem;
- cor do Pokemon vindo da lista;
- carregamento via `DetailStore`;
- `Observer` para acompanhar `isLoading`.

Depois da requisicao, ela ja renderiza:

- `name` em caixa alta;
- `id`;
- lista de tipos com `Chip`.

A proxima etapa natural e ampliar essa area com peso, altura, experiencia base e stats.

## Observacao sobre `type.model.dart`

Existe um model `Type` no projeto, mas ele ainda nao participa do fluxo principal.

Hoje `PokemonDetails` usa `PokemonType` diretamente.

## Resumo

O projeto agora ja tem:

1. endpoint de detalhe no service;
2. model principal `PokemonDetails`;
3. models auxiliares para stats e tipos;
4. `DetailStore` carregando os dados ao abrir a tela;
5. `DetailPage` observando o loading;
6. corpo da tela ja mostrando nome, ID e tipos;
7. espaco para evoluir o restante dos detalhes.
