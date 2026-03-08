# main.dart

## O que esse arquivo faz

`lib/main.dart` e o ponto de entrada do app.

Ele decide qual widget vai iniciar a aplicacao.

## Codigo principal

```dart
void main() {
  runApp(const MyApp());
}
```

## Passo a passo

1. O Flutter executa `main()`.
2. `main()` chama `runApp`.
3. `runApp` injeta `MyApp` na arvore de widgets.
4. `MyApp` cria o `MaterialApp`.
5. O `MaterialApp` abre a `HomePage`.

## Trecho mais importante

```dart
return MaterialApp(
  title: 'Pokedex',
  debugShowCheckedModeBanner: false,
  home: HomePage(),
);
```

## O que foi feito aqui

- foi criado um `MaterialApp` simples;
- foi removida a faixa de debug;
- foi definida a `HomePage` como primeira tela.

## O que estudar nesse arquivo

- `main()`
- `runApp`
- `StatelessWidget`
- `MaterialApp`
- `home`
