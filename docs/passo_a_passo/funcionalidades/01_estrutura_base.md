# Recriando a Estrutura Base

## Objetivo

Montar a base minima do projeto antes de implementar as funcionalidades.

## Passo 1: criar o projeto Flutter

```bash
flutter create pokedex_flutter
```

## Passo 2: instalar as dependencias

```bash
flutter pub add uno mobx flutter_mobx palette_generator cached_network_image percent_indicator
flutter pub add --dev build_runner mobx_codegen
```

## Passo 3: criar as pastas principais

Dentro de `lib/`, organize:

```text
lib/
|- models/
|  |- pokemon.model.dart
|  |- poke_response.model.dart
|  |- pokemon_details.model.dart
|  |- stat.model.dart
|  |- pokemon_stat.model.dart
|  |- pokemon_type.model.dart
|  |- type.model.dart
|- services/
|  |- poke_api.service.dart
|- store/
|  |- home.store.dart
|- widgets/
|  |- poke_card.widget.dart
|  |- characteristc.widget.dart
|  |- percentage_indicator.widget.dart
|- pages/
   |- home/
   |  |- home.page.dart
   |- detail/
      |- detail.page.dart
      |- stores/
         |- detail.store.dart
```

## Passo 4: criar um `main.dart` minimo para abrir a app

Use este ponto de partida:

```dart
import 'package:flutter/material.dart';
import 'package:pokedex_flutter/pages/home/home.page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokedex',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
```

## Passo 5: criar os arquivos base

Crie:

- `main.dart`
- `colors.dart`
- `models/pokemon.model.dart`
- `models/poke_response.model.dart`
- `models/pokemon_details.model.dart`
- `models/stat.model.dart`
- `models/pokemon_stat.model.dart`
- `models/pokemon_type.model.dart`
- `models/type.model.dart`
- `services/poke_api.service.dart`
- `store/home.store.dart`
- `widgets/poke_card.widget.dart`
- `widgets/characteristc.widget.dart`
- `widgets/percentage_indicator.widget.dart`
- `pages/home/home.page.dart`
- `pages/detail/detail.page.dart`
- `pages/detail/stores/detail.store.dart`

## Passo 6: gerar a store do MobX

Depois de terminar `home.store.dart` e `detail.store.dart`, rode:

```bash
dart run build_runner build
```

## Arquivos com codigo completo desta fase

- [01_main.dart.md](../arquivos/01_main.dart.md)
- [04_home.store.dart.md](../arquivos/04_home.store.dart.md)
- [03_home.page.dart.md](../arquivos/03_home.page.dart.md)
- [10_detail.page.dart.md](../arquivos/10_detail.page.dart.md)
- [16_detail.store.dart.md](../arquivos/16_detail.store.dart.md)
- [18_characteristc.widget.dart.md](../arquivos/18_characteristc.widget.dart.md)
- [19_percentage_indicator.widget.dart.md](../arquivos/19_percentage_indicator.widget.dart.md)

## Resultado esperado

Ao final dessa etapa, a estrutura do projeto ja deve estar pronta para receber API, filtro, scroll, cores dinamicas e a tela final de detalhe.
