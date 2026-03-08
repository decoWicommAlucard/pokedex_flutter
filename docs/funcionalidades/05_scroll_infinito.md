# Scroll Infinito

## O que esta documentacao vai explicar

Esta documentacao mostra como o projeto carrega mais Pokemons quando o usuario chega ao fim da grade.

O foco aqui e explicar:

- quais arquivos participam;
- como o `ScrollController` funciona;
- como a store entra no processo;
- como a API e chamada novamente;
- como o loader aparece;
- quais limitacoes existem hoje.

## Arquivos envolvidos

O scroll infinito depende principalmente destes arquivos:

- `lib/pages/home/home.page.dart`
- `lib/store/home.store.dart`
- `lib/services/poke_api.service.dart`
- `lib/models/poke_response.model.dart`

## Visao geral do fluxo

O fluxo completo e este:

1. a tela cria um `ScrollController`;
2. o listener do scroll e registrado;
3. o usuario rola a grade;
4. quando a posicao chega ao final, `scrollListener()` dispara;
5. a store executa `loadPokemons()`;
6. a store chama a API com o `offset` atual;
7. novos Pokemons entram na lista;
8. a grade cresce sem apagar os itens antigos;
9. um loader aparece no fim enquanto `isLoading` estiver `true`.

## 1. Onde o controller e criado

Arquivo:

- `lib/pages/home/home.page.dart`

Trecho:

```dart
final scrollController = ScrollController();
```

Esse controller permite que a tela acompanhe a posicao atual do scroll.

## 2. Onde o listener e registrado

Trecho:

```dart
@override
void initState() {
  super.initState();
  store.loadPokemons();
  scrollController.addListener(scrollListener);
}
```

### O que isso faz

Quando a tela nasce:

1. busca os primeiros Pokemons;
2. comeca a observar o scroll.

Entao o scroll infinito e ativado logo no inicio da vida da pagina.

## 3. Regra principal do scroll infinito

Trecho:

```dart
void scrollListener() {
  if (scrollController.offset >= scrollController.position.maxScrollExtent &&
      !scrollController.position.outOfRange) {
    store.loadPokemons();
  }
}
```

## 4. Como essa condicao funciona

### `scrollController.offset`

Representa a posicao atual do scroll.

### `scrollController.position.maxScrollExtent`

Representa o limite maximo de rolagem.

### `offset >= maxScrollExtent`

Quer dizer que o usuario chegou no fim da lista, ou muito perto disso.

### `!scrollController.position.outOfRange`

Garante que o scroll nao esta em uma posicao invalida.

## 5. O que acontece quando o fim e alcancado

Quando a condicao do `if` e verdadeira:

1. a `HomePage` chama `store.loadPokemons()`;
2. a store ativa `isLoading`;
3. a store chama o service com o `offset` atual;
4. o service faz outra requisicao na PokeAPI;
5. a resposta e convertida em models;
6. a store adiciona os novos itens com `addAll`;
7. a tela cresce sem perder os cards antigos.

## 6. O papel da store no scroll infinito

Arquivo:

- `lib/store/home.store.dart`

Trecho:

```dart
int offset = 0;
```

Esse `offset` controla de onde a API vai continuar a busca.

Metodo principal:

```dart
@action
Future<void> loadPokemons() async {
  isLoading = true;

  final pokeResponse = await _service.getPokemon(offset: offset);

  offset += 20;
  pokemons.addAll(pokeResponse.results);

  isLoading = false;
}
```

### Passo a passo da store

1. ativa `isLoading`;
2. usa o `offset` atual;
3. chama a API;
4. soma 20 ao `offset`;
5. adiciona os resultados ao final da lista;
6. encerra o loading.

## 7. Como a API participa

Arquivo:

- `lib/services/poke_api.service.dart`

Trecho:

```dart
final response = await _uno.get("/pokemon?offset=$offset&limit=20");
```

O scroll infinito depende dessa URL com paginacao.

Exemplos:

- primeira chamada: `offset=0&limit=20`
- segunda chamada: `offset=20&limit=20`
- terceira chamada: `offset=40&limit=20`

Isso permite trazer a lista em blocos, em vez de baixar todos os Pokemons de uma vez.

## 8. Como os novos itens entram na tela

O ponto mais importante e este:

```dart
pokemons.addAll(pokeResponse.results);
```

Se a store substituisse a lista inteira, os cards antigos desapareceriam.

Como ela usa `addAll`, o comportamento fica assim:

- os itens antigos continuam;
- os novos entram depois;
- a lista visual parece "crescer".

## 9. Como o GridView participa

Arquivo:

- `lib/pages/home/home.page.dart`

Trecho:

```dart
GridView.builder(
  controller: scrollController,
  itemCount: store.filteredPokemons.length + 1,
```

### O que isso significa

- o `GridView` usa o mesmo controller observado pela pagina;
- o `itemCount` reserva um item extra para o loader do fim da lista.

## 10. Como o loader e exibido

Trecho:

```dart
if (index < store.filteredPokemons.length) {
  return PokeCard(
    pokemon: store.filteredPokemons[index],
    store: store,
  );
}
return store.isLoading
    ? Center(child: CircularProgressIndicator())
    : Container();
```

### Como isso funciona

- se o indice ainda faz parte da lista de Pokemons, a tela mostra um card;
- se o indice e a posicao extra do final, a tela mostra:
  - um `CircularProgressIndicator`, se `isLoading` for `true`;
  - um `Container()` vazio, se nao estiver carregando.

## 11. Relacao entre scroll infinito e filtro

Um detalhe importante:

o `GridView` usa `store.filteredPokemons`, nao `store.pokemons` diretamente.

Isso significa que:

- se houver busca ativa, a grade mostra apenas os itens filtrados;
- mesmo assim, o scroll ainda pode disparar `loadPokemons()`;
- os novos Pokemons sao adicionados em `pokemons`;
- se eles combinarem com a busca, entram em `filteredPokemons`.

## 12. O que acontece quando o usuario continua rolando

Na pratica, o processo se repete assim:

1. a primeira pagina carrega;
2. o usuario rola ate o fim;
3. mais 20 itens chegam;
4. ele rola de novo;
5. mais 20 itens chegam;
6. a lista vai crescendo gradualmente.

Esse e o comportamento chamado de scroll infinito.

## 13. Pontos que costumam confundir

### O scroll infinito nao esta na store sozinho

A store sabe carregar os dados, mas quem detecta o fim da lista e a pagina.

Entao essa funcionalidade esta dividida entre:

- `HomePage`, que detecta o scroll;
- `HomeStore`, que carrega os dados;
- `PokeApiService`, que busca a proxima pagina.

### O loader do final depende do `+ 1`

Sem este trecho:

```dart
itemCount: store.filteredPokemons.length + 1
```

nao existiria uma posicao extra para mostrar o spinner.

## 14. Limitacoes atuais

Hoje o scroll infinito funciona, mas tem pontos que podem melhorar:

- `loadPokemons()` nao bloqueia chamadas repetidas enquanto ja esta carregando;
- nao existe um `hasMore` para parar quando a API nao tiver mais itens;
- nao ha tratamento visual de erro se a requisicao falhar;
- o listener chama a store sempre que a condicao fica verdadeira;
- o carregamento continua dependente do fim exato da lista, sem prefetch antes do final.

## 15. Como isso poderia evoluir

Melhorias possiveis:

- retornar imediatamente se `isLoading` ja for `true`;
- criar uma flag `hasMore`;
- carregar a proxima pagina antes de chegar exatamente no final;
- mostrar erro no lugar do loader quando falhar;
- desacoplar melhor a regra de paginacao.

## 16. Resumo final

O scroll infinito neste projeto funciona assim:

1. o `GridView` usa um `ScrollController`;
2. a `HomePage` escuta esse controller;
3. ao chegar ao fim, chama `loadPokemons()`;
4. a store chama a API com o proximo `offset`;
5. os resultados entram com `addAll`;
6. o `Observer` atualiza a grade;
7. um spinner aparece no ultimo item enquanto a carga acontece.

Se voce entender `ScrollController -> scrollListener -> loadPokemons -> addAll -> GridView.builder`, essa funcionalidade ja fica bem clara.
