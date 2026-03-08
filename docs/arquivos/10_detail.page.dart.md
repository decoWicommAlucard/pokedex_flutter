# detail.page.dart

## O que esse arquivo faz hoje

`lib/pages/detail/detail.page.dart` existe, mas atualmente e apenas um placeholder.

## Codigo atual

```dart
class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
```

## O que isso significa

- a tela de detalhe foi criada;
- mas ainda nao possui layout;
- ainda nao mostra dados de Pokemon;
- ainda nao esta ligada a navegacao da `HomePage`.

## Como essa tela provavelmente sera usada no futuro

1. o usuario toca em um card;
2. a `HomePage` faz um `Navigator.push`;
3. a `DetailPage` recebe um Pokemon ou um ID;
4. a tela mostra imagem, nome, tipos e outras informacoes.

## Ponto importante para estudo

Este arquivo ainda nao ajuda no funcionamento principal do app.

Ele mostra apenas que a estrutura para uma futura tela de detalhe ja comecou.
