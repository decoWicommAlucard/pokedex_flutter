# Cores dos Cards

## O que esta documentacao vai explicar

Esta documentacao mostra como o projeto define a cor de fundo de cada card.

O foco aqui e explicar:

- de onde a cor sai;
- quais arquivos participam;
- como a imagem entra nesse processo;
- como a store guarda a cor;
- como a interface reage a mudanca;
- quais limitacoes existem hoje.

## Arquivos envolvidos

O comportamento das cores depende principalmente destes arquivos:

- `lib/models/pokemon.model.dart`
- `lib/widgets/poke_card.widget.dart`
- `lib/store/home.store.dart`
- `lib/pages/home/home.page.dart`

## A ideia central

O projeto nao usa uma tabela fixa de cores.

Tambem nao pega cor pronta da API.

O que ele faz e:

1. carrega a imagem oficial do Pokemon;
2. analisa essa imagem;
3. identifica uma cor dominante;
4. salva essa cor no objeto `Pokemon`;
5. usa essa cor como fundo do card.

## 1. Onde a cor fica guardada

Arquivo:

- `lib/models/pokemon.model.dart`

Trecho:

```dart
class Pokemon {
  final String name;
  final String url;
  final Color color;
```

E no construtor:

```dart
Pokemon({required this.name, required this.url, this.color = Colors.white});
```

### O que isso significa

Todo Pokemon possui um campo `color`.

Quando ele nasce a partir da API:

- nome vem da API;
- URL vem da API;
- cor comeca como `Colors.white`.

Isso explica por que o card aparece branco no inicio.

## 2. Como a imagem do Pokemon e descoberta

Ainda no model:

```dart
String get id {
  final data = url.split('/');
  data.removeLast();
  return data.last;
}
```

Depois:

```dart
String get imageUrl =>
    "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/$id.png";
```

### Por que isso importa para a cor

O `PokeCard` nao teria como extrair cor sem uma imagem.

Entao o fluxo e:

1. a API entrega a `url` do Pokemon;
2. o model extrai o `id`;
3. o model monta `imageUrl`;
4. o card usa essa `imageUrl` para baixar a imagem;
5. a imagem e analisada para descobrir a cor dominante.

## 3. Onde a extracao da cor acontece

Arquivo:

- `lib/widgets/poke_card.widget.dart`

Trecho:

```dart
@override
void initState() {
  super.initState();
  getPaletteColor();
}
```

### O que isso faz

Assim que o card entra na tela, ele dispara uma funcao assincrona para analisar a imagem.

Por isso esse widget e `StatefulWidget`.

## 4. Metodo principal da extracao

Trecho:

```dart
Future<void> getPaletteColor() async {
  final paletteGenerator = await PaletteGenerator.fromImageProvider(
    NetworkImage(widget.pokemon.imageUrl),
  );

  if (paletteGenerator.dominantColor != null && mounted) {
    widget.store.updatePokemonColor(
      pokemonId: widget.pokemon.id,
      color: paletteGenerator.dominantColor!.color,
    );
  }
}
```

## 5. Passo a passo completo

1. o `PokeCard` aparece na grade;
2. `initState()` chama `getPaletteColor()`;
3. `NetworkImage` usa `widget.pokemon.imageUrl`;
4. `PaletteGenerator.fromImageProvider(...)` baixa e analisa a imagem;
5. o pacote calcula a cor dominante;
6. se existir uma cor e o widget ainda estiver montado, a store e chamada;
7. a store recebe `pokemonId` e `color`;
8. o Pokemon correspondente e atualizado;
9. o `Observer` percebe a mudanca;
10. o card e redesenhado com a nova cor.

## 6. Por que existe a verificacao `mounted`

Trecho:

```dart
if (paletteGenerator.dominantColor != null && mounted) {
```

O `mounted` garante que o widget ainda existe quando a operacao assincrona termina.

Sem isso, seria possivel tentar atualizar algo que ja saiu da tela.

## 7. Como a store recebe a cor

Arquivo:

- `lib/store/home.store.dart`

Trecho:

```dart
@action
void updatePokemonColor({required String pokemonId, required Color color}) {
  final indexPokemon = pokemons.indexWhere(
    (pokemon) => pokemon.id == pokemonId,
  );
  pokemons[indexPokemon] = pokemons[indexPokemon].copyWith(color: color);
}
```

### O que a store faz aqui

1. procura o Pokemon pelo ID;
2. descobre o indice dele na lista;
3. cria uma copia com a nova cor;
4. substitui o item antigo pelo novo.

## 8. Por que usar `copyWith`

Arquivo:

- `lib/models/pokemon.model.dart`

Trecho:

```dart
Pokemon copyWith({String? name, String? url, Color? color}) {
  return Pokemon(
    name: name ?? this.name,
    url: url ?? this.url,
    color: color ?? this.color,
  );
}
```

O `copyWith` permite atualizar apenas a cor sem perder:

- nome;
- URL;
- comportamento do model.

## 9. Como a nova cor aparece no card

Arquivo:

- `lib/widgets/poke_card.widget.dart`

Trecho:

```dart
AnimatedContainer(
  duration: Duration(milliseconds: 500),
  decoration: BoxDecoration(
    color: widget.pokemon.color,
    borderRadius: BorderRadius.circular(10),
  ),
```

### O que isso faz

- usa `widget.pokemon.color` como fundo;
- anima a troca de cor em 500 ms;
- deixa a transicao visual mais suave.

Por isso o card nao muda de cor de forma brusca.

## 10. Como a tela reage a mudanca

Arquivo:

- `lib/pages/home/home.page.dart`

Trecho:

```dart
Observer(
  builder: (_) {
    return Expanded(
      child: GridView.builder(
```

Quando a store substitui um Pokemon por outro com a cor nova:

1. a lista observavel muda;
2. o `Observer` detecta a mudanca;
3. o card correspondente e reconstruido;
4. o `AnimatedContainer` aplica a nova cor.

## 11. Exemplo real do fluxo da cor

Imagine o Pokemon 25:

1. a API retorna nome e URL do Pikachu;
2. o model extrai `id = 25`;
3. o model monta a URL da arte oficial;
4. o `PokeCard` baixa essa imagem;
5. o `PaletteGenerator` encontra uma cor dominante amarela;
6. a store atualiza o Pokemon 25 com essa cor;
7. o card muda de branco para amarelo de forma animada.

## 12. O que o projeto faz e o que ele nao faz

### O que ele faz hoje

- extrai cor a partir da imagem oficial;
- guarda a cor dentro do model;
- atualiza o estado com MobX;
- anima a troca de fundo.

### O que ele nao faz hoje

- nao usa cor por tipo;
- nao escolhe contraste automatico para o texto;
- nao faz cache proprio da cor;
- nao trata erro de extracao de cor;
- nao impede recalculos em cenarios de rebuild de novos cards.

## 13. Pontos que costumam confundir

### A cor nao vem da PokeAPI

A API de listagem nao entrega um campo de cor.

A cor e calculada localmente no app.

### A cor nao e definida no `HomePage`

A `HomePage` so constroi a grade.

A logica de cor esta dividida entre:

- `Pokemon`, que possui `imageUrl` e `color`;
- `PokeCard`, que extrai a paleta;
- `HomeStore`, que atualiza a lista.

### O campo `backgroundColor` do card nao esta sendo usado

No arquivo `poke_card.widget.dart` existe:

```dart
Color backgroundColor = Colors.white;
```

Mas essa variavel nao participa da renderizacao atual.

Hoje a cor usada de verdade vem de:

```dart
widget.pokemon.color
```

## 14. Limitacoes atuais

Hoje esse fluxo tem alguns pontos fracos:

- a extracao de cor depende da imagem carregar corretamente;
- nao ha tratamento de excecao no metodo `getPaletteColor()`;
- o texto continua com a mesma cor, mesmo que o fundo fique muito claro ou muito escuro;
- a variavel `backgroundColor` esta sobrando;
- a extracao acontece por card, o que pode custar processamento conforme a lista cresce.

## 15. Resumo final

O fluxo das cores neste projeto e:

1. a API entrega a URL do Pokemon;
2. o model extrai o ID e monta a imagem;
3. o `PokeCard` analisa a imagem com `PaletteGenerator`;
4. a store atualiza o `Pokemon` com a cor encontrada;
5. o `Observer` reconstrui a interface;
6. o `AnimatedContainer` anima o fundo do card.

Se voce entender `imageUrl -> PaletteGenerator -> updatePokemonColor -> widget.pokemon.color`, a logica da cor deixa de parecer magica e passa a ficar bem clara.
