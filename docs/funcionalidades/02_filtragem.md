# Filtragem

## O que esta documentacao vai explicar

Aqui o foco e mostrar como a busca do projeto funciona de verdade.

A ideia nao e explicar so a linha do `where`, mas o caminho completo:

- onde o texto da busca nasce;
- onde ele e guardado;
- onde o filtro e calculado;
- como o resultado volta para a tela;
- quais arquivos participam;
- quais comportamentos e limitacoes existem.

## Arquivos envolvidos

A filtragem atual depende principalmente destes arquivos:

- `lib/pages/home/home.page.dart`
- `lib/store/home.store.dart`
- `lib/store/home.store.g.dart`
- `lib/models/pokemon.model.dart`

## Visao geral do fluxo

O fluxo da busca e este:

1. o usuario digita no `TextField`;
2. a `HomePage` chama `store.setSearch`;
3. a store atualiza o campo `search`;
4. o getter computado `filteredPokemons` recalcula a lista;
5. o `Observer` reconstrui a grade;
6. a interface mostra apenas os itens filtrados.

## 1. Onde o usuario digita

Arquivo:

- `lib/pages/home/home.page.dart`

Trecho:

```dart
TextField(
  onChanged: store.setSearch,
  decoration: InputDecoration(
    hintText: "Nome ou identificador",
  ),
)
```

### O que isso significa

Toda vez que o texto muda:

1. o `TextField` dispara `onChanged`;
2. o texto digitado e enviado para a store;
3. a tela nao filtra por conta propria.

Ou seja, a filtragem nao mora no widget.

Ela mora na store.

## 2. Onde o texto da busca fica guardado

Arquivo:

- `lib/store/home.store.dart`

Trecho:

```dart
@observable
String? search;
```

Esse campo representa o texto atual da busca.

Como ele e `@observable`, o MobX consegue reagir quando esse valor muda.

## 3. Como o texto e atualizado

Trecho:

```dart
@action
void setSearch(String text) => search = text;
```

### O que essa action faz

- recebe o valor digitado;
- salva esse valor em `search`;
- dispara a reatividade do MobX.

Essa parte e importante porque o campo de busca nao altera a lista manualmente.

Ele altera apenas o estado.

## 4. Onde o filtro e calculado

O calculo real da lista filtrada acontece neste getter:

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

## 5. Passo a passo da logica

### Etapa 1: verificar se a busca esta vazia

```dart
if (search == null || search!.isEmpty) {
  return pokemons.toList();
}
```

Se o usuario ainda nao digitou nada:

- a store devolve todos os Pokemons carregados;
- nenhum filtro e aplicado.

### Etapa 2: percorrer a lista

```dart
return pokemons.where(...).toList();
```

O metodo `where` analisa item por item da lista.

Ele mantem somente os itens que passam na condicao.

### Etapa 3: testar o nome

```dart
pokemon.name.toLowerCase().contains(search!.toLowerCase())
```

Esse trecho faz duas coisas:

- converte nome e busca para minusculo;
- permite busca parcial com `contains`.

Isso significa:

- `pik` encontra `pikachu`;
- `PIK` tambem encontra `pikachu`;
- `char` encontra `charmander`.

### Etapa 4: testar o ID

```dart
pokemon.id == search
```

Esse trecho compara o texto digitado com o ID do Pokemon.

Aqui a comparacao e exata.

Isso significa:

- `25` encontra o Pokemon 25;
- `2` nao encontra automaticamente o 25;
- `01` nao encontra o ID `1`.

## 6. Por que o model participa da filtragem

Arquivo:

- `lib/models/pokemon.model.dart`

Trecho:

```dart
String get id {
  final data = url.split('/');
  data.removeLast();
  return data.last;
}
```

O filtro por ID depende desse getter.

Isso e importante porque o ID nao fica salvo como campo separado dentro da classe.

Ele e derivado da `url` recebida da API.

Entao o fluxo real do filtro por numero e:

1. a API entrega `url`;
2. o model extrai o `id`;
3. a store compara `pokemon.id` com `search`.

## 7. Como a tela recebe o resultado filtrado

Arquivo:

- `lib/pages/home/home.page.dart`

Trecho:

```dart
Observer(
  builder: (_) {
    return Expanded(
      child: GridView.builder(
        itemCount: store.filteredPokemons.length + 1,
```

E depois:

```dart
if (index < store.filteredPokemons.length) {
  return PokeCard(
    pokemon: store.filteredPokemons[index],
    store: store,
  );
}
```

### O que acontece aqui

1. a tela le `store.filteredPokemons`;
2. o `Observer` registra essa dependencia;
3. quando `search` muda, o `filteredPokemons` recalcula;
4. o `Observer` reconstrui a grade;
5. a lista mostrada na tela muda automaticamente.

## 8. Exemplos praticos do comportamento atual

### Busca vazia

Se o usuario apagar tudo:

- `search` fica vazio;
- `filteredPokemons` devolve todos os itens carregados.

### Busca por trecho do nome

Se o usuario digitar:

```text
bul
```

o filtro procura qualquer nome contendo esse trecho.

Resultado esperado:

- `bulbasaur`

### Busca com maiusculas

Se o usuario digitar:

```text
PIKA
```

o filtro ainda funciona, porque a comparacao e feita em minusculo.

### Busca por numero

Se o usuario digitar:

```text
25
```

o filtro compara `pokemon.id == search`.

### Busca com zero a esquerda

Se o usuario digitar:

```text
025
```

o comportamento atual nao encontra o `25`, porque:

- o ID armazenado no model e `25`;
- o filtro compara a string exatamente como ela foi digitada.

## 9. O que o filtro faz e o que ele nao faz

### O que ele faz hoje

- busca parcial por nome;
- ignora diferenca entre maiuscula e minuscula;
- busca exata por ID;
- atualiza a lista em tempo real enquanto o usuario digita.

### O que ele nao faz hoje

- nao busca direto na API;
- nao filtra por tipo;
- nao ignora espacos extras;
- nao converte `025` em `25`;
- nao aplica debounce;
- nao procura em Pokemons que ainda nao foram carregados.

## 10. Pontos que costumam confundir

### A busca nao acontece na API

Mesmo existindo uma API, a filtragem atual e local.

Ou seja:

- a API entrega uma lista;
- a store filtra essa lista em memoria.

### A busca so vale para o que ja foi carregado

Se a lista atual tem apenas os primeiros 20 ou 40 Pokemons, a busca vai procurar apenas neles.

Entao:

- se o Pokemon ainda nao chegou pela paginacao, ele nao aparece no filtro.

### O filtro por ID depende do model

O ID nao vem como campo simples na listagem.

Ele e calculado a partir da URL.

## 11. Limitacoes atuais

Hoje a filtragem tem algumas limitacoes tecnicas:

- funciona so nos itens ja carregados;
- nao existe `trim()` antes de comparar o texto;
- nao ha debounce no `TextField`;
- o filtro por numero exige igualdade exata;
- a busca continua funcionando sobre strings, nao inteiros.

## 12. Como isso poderia evoluir no futuro

Melhorias que fariam sentido:

- aplicar `trim()` no texto digitado;
- normalizar busca numerica removendo zeros a esquerda;
- implementar debounce;
- permitir filtro por tipo;
- fazer busca global em vez de apenas local;
- exibir estado de "nenhum resultado encontrado".

## 13. Resumo final

O fluxo da filtragem neste projeto e:

1. a `HomePage` envia o texto digitado;
2. a store salva esse texto em `search`;
3. o getter `filteredPokemons` percorre `pokemons`;
4. ele compara nome e ID;
5. o `Observer` reconstrui a grade;
6. a interface mostra o resultado sem precisar de `setState()` manual para a busca.

Se voce entender `TextField -> setSearch -> filteredPokemons -> Observer`, ja domina a parte principal da busca deste projeto.
