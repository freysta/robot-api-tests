# Testes de API com Robot Framework

Este projeto contém testes automatizados de API usando o Robot Framework, focando na API Restful-Booker. O projeto segue as melhores práticas da comunidade Robot Framework, com estrutura organizada, keywords reutilizáveis e documentação completa.

## Pré-requisitos

- Python 3.8 ou superior
- pip (gerenciador de pacotes do Python)

## Como Configurar o Ambiente

1. Clone o repositório:
   ```bash
   git clone https://github.com/freysta/robot-api-tests.git
   cd robot-api-tests
   ```

2. Crie e ative o ambiente virtual:
   ```bash
   python -m venv venv
   source venv/bin/activate  # Linux/macOS
   venv\Scripts\activate     # Windows
   ```

3. Instale as dependências:
   ```bash
   pip install -r requirements.txt
   ```

## Estrutura do Projeto

```
robot-api-tests/
├── .gitignore              # Arquivos ignorados pelo Git
├── README.md               # Documentação do projeto
├── requirements.txt        # Dependências do projeto
├── results/                # Relatórios de execução (gerados automaticamente)
├── resources/              # Recursos reutilizáveis
│   ├── api_keywords.robot    # Keywords para operações de API
│   └── variables/
│       ├── common.robot       # Variáveis globais
└── tests/
    ├── restful_api.robot      # Testes da API Restful-Booker
```

## Como Executar os Testes

### Todos os Testes
```bash
robot -d results tests/
```

### Apenas Testes de Smoke
```bash
robot -d results -i smoke tests/
```

### Apenas Testes de Regressão
```bash
robot -d results -i regression tests/
```

### Apenas Testes de Autenticação
```bash
robot -d results -i auth tests/
```

## Visualizando os Relatórios

Após a execução, os relatórios estarão disponíveis em `results/`:

- `results/report.html`: Relatório principal com resumo dos testes
- `results/log.html`: Log detalhado de cada passo executado
- `results/output.xml`: Arquivo XML com dados brutos para integração com outras ferramentas

## Testes Incluídos

### Cenários de Teste

1. **Criar Token** [smoke, auth]
   - Autenticação na API Restful-Booker
   - Verifica se o token é gerado corretamente

2. **Criar Reserva** [smoke, regression]
   - Cria uma nova reserva de hotel
   - Valida a resposta e o ID da reserva

3. **Editar Reserva** [regression]
   - Atualiza uma reserva existente
   - Verifica se as mudanças foram aplicadas

4. **Excluir Reserva** [regression]
   - Remove uma reserva
   - Confirma a exclusão bem-sucedida

## API Utilizada

- **Restful-Booker**: https://restful-booker.herokuapp.com
  - API pública para testes de reservas de hotel
  - Suporta operações CRUD (Create, Read, Update, Delete) com autenticação
  - Ideal para testes de integração e automação

## Keywords Reutilizáveis

O projeto utiliza keywords abstratas para melhorar a manutenibilidade:

- `Criar Sessão API`: Inicializa sessão HTTP
- `Realizar Requisição GET/POST/PUT/DELETE`: Executa requisições HTTP
- `Verificar Status Code`: Valida códigos de resposta
- `Verificar JSON Contém`: Valida conteúdo da resposta JSON
- `Criar Dicionário`: Cria dicionários de dados
- `Adicionar Item ao Dicionário`: Manipula dicionários


