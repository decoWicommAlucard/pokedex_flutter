# Recriando a Estrutura Base

## Objetivo

Montar a base minima do projeto antes de implementar as funcionalidades.

## Passo 1: criar o projeto Flutter

```bash
flutter create pokedex_flutter
```

## Passo 2: instalar as dependencias

```bash
flutter pub add uno mobx flutter_mobx palette_generator
flutter pub add --dev build_runner mobx_codegen
```

## Passo 3: criar as pastas principais

Dentro de `lib/`, organize:

```text
lib/
|- models/
|- services/
|- store/
|- widgets/
|- pages/
   |- home/
   |- detail/
```

## Passo 4: criar os arquivos base

Crie:

- `main.dart`
- `colors.dart`
- `models/pokemon.model.dart`
- `models/poke_response.model.dart`
- `services/poke_api.service.dart`
- `store/home.store.dart`
- `widgets/poke_card.widget.dart`
- `pages/home/home.page.dart`
- `pages/detail/detail.page.dart`

## Passo 5: gerar a store do MobX

Depois de terminar `home.store.dart`, rode:

```bash
dart run build_runner build
```

## Resultado esperado

Ao final dessa etapa, a estrutura do projeto ja deve estar pronta para receber API, filtro, scroll e cores dinamicas.
