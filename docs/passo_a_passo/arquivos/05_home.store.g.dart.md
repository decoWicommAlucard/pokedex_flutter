# Recriando home.store.g.dart

## Objetivo

Gerar o arquivo automatico do MobX.

## Regra principal

Voce nao deve escrever esse arquivo manualmente.

Ele e criado a partir do `home.store.dart`.

## Antes de gerar

Voce precisa ter:

- `mobx_codegen` em `dev_dependencies`;
- `build_runner` em `dev_dependencies`;
- `part 'home.store.g.dart';` no arquivo `home.store.dart`;
- anotacoes como `@observable`, `@computed` e `@action`.

## Passo 1: conferir o `pubspec.yaml`

Voce precisa ter algo assim:

```yaml
dev_dependencies:
  build_runner: ^2.10.5
  mobx_codegen: ^2.7.6
```

## Passo 2: gerar o arquivo

Rode:

```bash
dart run build_runner build
```

## Passo 3: conferir se o arquivo apareceu

Verifique se foi criado:

```text
lib/store/home.store.g.dart
```

## Passo 4: entender o que foi gerado

Esse arquivo deve conter estruturas como:

- `Atom`;
- `Computed`;
- `AsyncAction`;
- `ActionController`.

## Se quiser regenerar automaticamente

Use:

```bash
dart run build_runner watch
```

## Como verificar

Se o comando terminar sem erro e o arquivo `.g.dart` aparecer, essa etapa esta pronta.
