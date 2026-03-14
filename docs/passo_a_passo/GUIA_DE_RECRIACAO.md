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

- por arquivo, em `docs/passo_a_passo/arquivos/`, quando quiser ver o arquivo inteiro;
- por funcionalidade, em `docs/passo_a_passo/funcionalidades/`, quando quiser montar o projeto em blocos com trechos de codigo.

## Onde esta o codigo

Se voce sentiu falta do codigo no roteiro, use esta regra:

- `arquivos/` mostra o conteudo completo de cada arquivo;
- `funcionalidades/` mostra a ordem de implementacao com os trechos principais;
- `06_recriacao_completa.md` junta a ordem geral e aponta para os arquivos certos.

## Ordem recomendada para recriar o projeto inteiro

1. [01_estrutura_base.md](funcionalidades/01_estrutura_base.md)
2. [07_pokemon.model.dart.md](arquivos/07_pokemon.model.dart.md)
3. [08_poke_response.model.dart.md](arquivos/08_poke_response.model.dart.md)
4. [13_pokemon_stat.model.dart.md](arquivos/13_pokemon_stat.model.dart.md)
5. [12_stat.model.dart.md](arquivos/12_stat.model.dart.md)
6. [14_pokemon_type.model.dart.md](arquivos/14_pokemon_type.model.dart.md)
7. [15_type.model.dart.md](arquivos/15_type.model.dart.md)
8. [11_pokemon_details.model.dart.md](arquivos/11_pokemon_details.model.dart.md)
9. [06_poke_api.service.dart.md](arquivos/06_poke_api.service.dart.md)
10. [04_home.store.dart.md](arquivos/04_home.store.dart.md)
11. [16_detail.store.dart.md](arquivos/16_detail.store.dart.md)
12. [05_home.store.g.dart.md](arquivos/05_home.store.g.dart.md)
13. [17_detail.store.g.dart.md](arquivos/17_detail.store.g.dart.md)
14. [02_colors.dart.md](arquivos/02_colors.dart.md)
15. [10_detail.page.dart.md](arquivos/10_detail.page.dart.md)
16. [18_characteristc.widget.dart.md](arquivos/18_characteristc.widget.dart.md)
17. [19_percentage_indicator.widget.dart.md](arquivos/19_percentage_indicator.widget.dart.md)
18. [09_poke_card.widget.dart.md](arquivos/09_poke_card.widget.dart.md)
19. [03_home.page.dart.md](arquivos/03_home.page.dart.md)
20. [01_main.dart.md](arquivos/01_main.dart.md)

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
- [11_pokemon_details.model.dart.md](arquivos/11_pokemon_details.model.dart.md)
- [12_stat.model.dart.md](arquivos/12_stat.model.dart.md)
- [13_pokemon_stat.model.dart.md](arquivos/13_pokemon_stat.model.dart.md)
- [14_pokemon_type.model.dart.md](arquivos/14_pokemon_type.model.dart.md)
- [15_type.model.dart.md](arquivos/15_type.model.dart.md)
- [16_detail.store.dart.md](arquivos/16_detail.store.dart.md)
- [17_detail.store.g.dart.md](arquivos/17_detail.store.g.dart.md)
- [18_characteristc.widget.dart.md](arquivos/18_characteristc.widget.dart.md)
- [19_percentage_indicator.widget.dart.md](arquivos/19_percentage_indicator.widget.dart.md)

## Passo a passo por funcionalidade

- [01_estrutura_base.md](funcionalidades/01_estrutura_base.md)
- [02_chamada_da_api.md](funcionalidades/02_chamada_da_api.md)
- [03_filtragem.md](funcionalidades/03_filtragem.md)
- [04_scroll_infinito.md](funcionalidades/04_scroll_infinito.md)
- [05_cores_dos_cards.md](funcionalidades/05_cores_dos_cards.md)
- [06_recriacao_completa.md](funcionalidades/06_recriacao_completa.md)
- [07_detalhes_do_pokemon.md](funcionalidades/07_detalhes_do_pokemon.md)

## Observacao importante

O arquivo `home.store.g.dart` nao deve ser escrito manualmente.

Ele precisa ser gerado pelo `build_runner`.

Outro ponto importante: a recriacao desta pasta agora acompanha o codigo atual, entao a `DetailPage` ja recebe um `Pokemon` e a `HomePage` ja navega para ela.
