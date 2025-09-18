# Testes de API com Robot Framework

Este projeto contém testes automatizados de API usando o Robot Framework, focando na API Restful-Booker.

## Estrutura do Projeto

- `tests/`: Contém os arquivos de teste (.robot)
- `variables/`: Contém as variáveis globais usadas nos testes
- `results/`: Pasta gerada automaticamente com relatórios de execução (não versionada)

## Dependências

- Robot Framework
- Robot Framework Requests Library

## Como Executar

1. Ative o ambiente virtual:
   ```bash
   source venv/bin/activate  # Linux/macOS
   venv\Scripts\activate     # Windows
   ```

2. Execute os testes:
   ```bash
   robot -d results tests/
   ```

3. Visualize os relatórios:
   - `results/report.html`: Relatório principal
   - `results/log.html`: Log detalhado

## Testes Incluídos

- **Criar Token**: Autenticação na API
- **Criar Reserva**: POST para criar uma nova reserva
- **Editar Reserva**: PUT para atualizar uma reserva existente
- **Excluir Reserva**: DELETE para remover uma reserva

## API Utilizada

- **Restful-Booker**: https://restful-booker.herokuapp.com
  - API pública para testes de reservas de hotel
  - Suporta operações CRUD com autenticação

## Notas

- A API Reqres (https://reqres.in/api) foi removida do projeto devido a mudanças na API que requerem autenticação não disponível publicamente.
- Todos os testes estão passando para a API Restful-Booker.
