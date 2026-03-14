# Guia de Estudo

A documentacao foi separada em varios arquivos menores para facilitar o estudo.

Se voce ainda nao entende bem termos como `model`, `fromJson`, `copyWith`, `store` ou `service`, comece por:

- [GUIA_PARA_INICIANTES.md](GUIA_PARA_INICIANTES.md)

Voce pode ler de dois jeitos:

- por arquivo, em `docs/arquivos/`;
- por funcionalidade, em `docs/funcionalidades/`.

Se quiser aprender recriando o projeto do zero, use tambem:

- por arquivo, em `docs/passo_a_passo/arquivos/`;
- por funcionalidade, em `docs/passo_a_passo/funcionalidades/`;
- indice geral de recriacao em `docs/passo_a_passo/GUIA_DE_RECRIACAO.md`.

## Ordem recomendada

1. [GUIA_PARA_INICIANTES.md](GUIA_PARA_INICIANTES.md)
2. [Visao geral e fluxo](funcionalidades/01_estrutura_e_fluxo.md)
3. [main.dart](arquivos/01_main.dart.md)
4. [home.page.dart](arquivos/03_home.page.dart.md)
5. [home.store.dart](arquivos/04_home.store.dart.md)
6. [chamada da API](funcionalidades/03_chamada_da_api.md)
7. [pokemon.model.dart](arquivos/07_pokemon.model.dart.md)
8. [poke_response.model.dart](arquivos/08_poke_response.model.dart.md)
9. [pokemon_details.model.dart](arquivos/11_pokemon_details.model.dart.md)
10. [detail.store.dart](arquivos/16_detail.store.dart.md)
11. [detalhes do Pokemon](funcionalidades/07_detalhes_do_pokemon.md)
12. [filtragem](funcionalidades/02_filtragem.md)
13. [poke_card.widget.dart](arquivos/09_poke_card.widget.dart.md)
14. [cores dos cards](funcionalidades/04_cores_dos_cards.md)
15. [scroll infinito](funcionalidades/05_scroll_infinito.md)
16. [detail.page.dart](arquivos/10_detail.page.dart.md)

## Documentacao por arquivo

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
- [11_pokemon_details.model.dart.md](arquivos/11_pokemon_details.model.dart.md)
- [12_stat.model.dart.md](arquivos/12_stat.model.dart.md)
- [13_pokemon_stat.model.dart.md](arquivos/13_pokemon_stat.model.dart.md)
- [14_pokemon_type.model.dart.md](arquivos/14_pokemon_type.model.dart.md)
- [15_type.model.dart.md](arquivos/15_type.model.dart.md)
- [16_detail.store.dart.md](arquivos/16_detail.store.dart.md)
- [17_detail.store.g.dart.md](arquivos/17_detail.store.g.dart.md)

## Documentacao por funcionalidade

- [01_estrutura_e_fluxo.md](funcionalidades/01_estrutura_e_fluxo.md)
- [02_filtragem.md](funcionalidades/02_filtragem.md)
- [03_chamada_da_api.md](funcionalidades/03_chamada_da_api.md)
- [04_cores_dos_cards.md](funcionalidades/04_cores_dos_cards.md)
- [05_scroll_infinito.md](funcionalidades/05_scroll_infinito.md)
- [06_como_o_projeto_foi_montado.md](funcionalidades/06_como_o_projeto_foi_montado.md)
- [07_detalhes_do_pokemon.md](funcionalidades/07_detalhes_do_pokemon.md)

## Documentacao de Recriacao

- [passo_a_passo/GUIA_DE_RECRIACAO.md](passo_a_passo/GUIA_DE_RECRIACAO.md)

## Observacao importante

A tela [10_detail.page.dart.md](arquivos/10_detail.page.dart.md) continua sendo a entrada visual do detalhe e agora ja dispara o carregamento pela `DetailStore`.

Ao mesmo tempo, o projeto agora ja possui uma camada pronta para detalhes completos com:

- [11_pokemon_details.model.dart.md](arquivos/11_pokemon_details.model.dart.md)
- [16_detail.store.dart.md](arquivos/16_detail.store.dart.md)
- [07_detalhes_do_pokemon.md](funcionalidades/07_detalhes_do_pokemon.md)

Hoje essa tela ja mostra o loading e tambem renderiza nome, ID e tipos do Pokemon.
