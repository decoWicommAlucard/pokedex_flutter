# Guia de Recriacao

Esta secao foi criada para te ajudar a recriar o projeto do zero.

Aqui o foco nao e so entender o que o codigo faz.

O foco e:

- em que ordem criar cada coisa;
- o que escrever em cada arquivo;
- como testar se cada etapa funcionou;
- quais arquivos dependem de outros;
- como reconstruir cada funcionalidade separadamente.

## Como estudar esta secao

Voce pode seguir de dois jeitos:

- por arquivo, em `docs/passo_a_passo/arquivos/`;
- por funcionalidade, em `docs/passo_a_passo/funcionalidades/`.

## Ordem recomendada para recriar o projeto inteiro

1. [01_estrutura_base.md](funcionalidades/01_estrutura_base.md)
2. [07_pokemon.model.dart.md](arquivos/07_pokemon.model.dart.md)
3. [08_poke_response.model.dart.md](arquivos/08_poke_response.model.dart.md)
4. [06_poke_api.service.dart.md](arquivos/06_poke_api.service.dart.md)
5. [04_home.store.dart.md](arquivos/04_home.store.dart.md)
6. [05_home.store.g.dart.md](arquivos/05_home.store.g.dart.md)
7. [02_colors.dart.md](arquivos/02_colors.dart.md)
8. [03_home.page.dart.md](arquivos/03_home.page.dart.md)
9. [09_poke_card.widget.dart.md](arquivos/09_poke_card.widget.dart.md)
10. [01_main.dart.md](arquivos/01_main.dart.md)
11. [10_detail.page.dart.md](arquivos/10_detail.page.dart.md)

## Passo a passo por arquivo

- [01_main.dart.md](arquivos/01_main.dart.md)
- [02_colors.dart.md](arquivos/02_colors.dart.md)
- [03_home.page.dart.md](arquivos/03_home.page.dart.md)
- [04_home.store.dart.md](arquivos/04_home.store.dart.md)
- [05_home.store.g.dart.md](arquivos/05_home.store.g.dart.md)
- [06_poke_api.service.dart.md](arquivos/06_poke_api.service.dart.md)
- [07_pokemon.model.dart.md](arquivos/07_pokemon.model.dart.md)
- [08_poke_response.model.dart.md](arquivos/08_poke_response.model.dart.md)
- [09_poke_card.widget.dart.md](arquivos/09_poke_card.widget.dart.md)
- [10_detail.page.dart.md](arquivos/10_detail.page.dart.md)

## Passo a passo por funcionalidade

- [01_estrutura_base.md](funcionalidades/01_estrutura_base.md)
- [02_chamada_da_api.md](funcionalidades/02_chamada_da_api.md)
- [03_filtragem.md](funcionalidades/03_filtragem.md)
- [04_scroll_infinito.md](funcionalidades/04_scroll_infinito.md)
- [05_cores_dos_cards.md](funcionalidades/05_cores_dos_cards.md)
- [06_recriacao_completa.md](funcionalidades/06_recriacao_completa.md)

## Observacao importante

O arquivo `home.store.g.dart` nao deve ser escrito manualmente.

Ele precisa ser gerado pelo `build_runner`.
