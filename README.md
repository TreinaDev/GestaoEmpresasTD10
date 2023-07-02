# Gestão de Empresas

<p align="center">
  <img src="http://img.shields.io/static/v1?label=Ruby&message=3.1.2&color=red&style=for-the-badge&logo=ruby"/>
  <img src="http://img.shields.io/static/v1?label=Ruby%20On%20Rails%20&message=7.0.4.3&color=red&style=for-the-badge&logo=ruby-on-rails"/>
  <img src="http://img.shields.io/static/v1?label=TESTES&message=%3E200&color=GREEN&style=for-the-badge"/>
  <img src="http://img.shields.io/static/v1?label=STATUS&message=EM%20DESENVOLVIMENTO&color=RED&style=for-the-badge"/>
  <img src="http://img.shields.io/static/v1?label=CODE%20STYLE&message=RUBOCOP&color=RED&style=for-the-badge"/>
</p>

### Tópicos|

:diamond_shape_with_a_dot_inside: [Descrição do projeto](#descrição-do-projeto)

:diamond_shape_with_a_dot_inside: [Gestão do projeto](#gestão-do-projeto)

:diamond_shape_with_a_dot_inside: [Modelo ER](#modelo-er)

:diamond_shape_with_a_dot_inside: [Funcionalidades](#funcionalidades)

:diamond_shape_with_a_dot_inside: [Pré-requisitos](#pré-requisitos)

:diamond_shape_with_a_dot_inside: [Como rodar a aplicação](#como-rodar-a-aplicação)

## Descrição do projeto

<p align="justify">
  Esta aplicação é a responsável por manter o cadastro das empresas participantes do Clube de Compras.
  Usuários com perfil administrador podem <b>cadastrar empresas</b>(<i>Administrador</i>) e <b>determinar quem são os usuários com perfil
  administrador de cada empresa</b>(<i>Gerente</i>). As pessoas com perfil gerente, no geral, pessoas dos departamentos de <b><i>RH</i></b> que irão <b>cadastrar os departamentos, cargos e funcionários de suas respectivas empresas.</b>
</p>

## Gestão do projeto

<p align="justify">
  Para auxiliar no gerenciamento das atividades a serem feitas pela equipe utilizamos do recurso do github, Projects que tem modelos específicos de quadros de backlog.

  Para ver todas atividades feitas e/ou em andamento pode acessar:
  [Backlog Gestão Empresas TD10](https://github.com/orgs/TreinaDev/projects/18/views/1)
</p>

## Modelo ER

## Funcionalidades

:heavy_check_mark: Cadastro de Administrador via email com domínio **punti.com**

Administrador:
  - :heavy_check_mark: Cadastro de *Empresas*
  - :heavy_check_mark: Pre-Cadastro de *Gerentes* em *Empresas*
  - :heavy_check_mark: Remove de pre-cadastro *Gerentes*
  - :heavy_check_mark: Bloqueio de *Gerente* e/ou *Empresas*
  - :heavy_check_mark: Desbloqueio de *Gerente* e/ou *Empresas*
  - :heavy_check_mark: Ver lista de *Empresas*

Gerente:
  - :heavy_check_mark: Completa seus dados cadastrais(*employee_profile*)
  - :heavy_check_mark: Cadastro de *Departamentos*
  - :heavy_check_mark: Editação de *Departamentos*
  - :heavy_check_mark: Ver *Departamentos*
  - :heavy_check_mark: Cadastro de *Cargos*
  - :heavy_check_mark: Editação de *Cargos*
  - :heavy_check_mark: Ver *Cargos*
  - :heavy_check_mark: Pre-Cadastro do *Funcionários*
  - :heavy_check_mark: Ver *Funcionários*
  - :heavy_check_mark: Faz busca por(**nome ou cpf**) os *Funcionários*
  - :heavy_check_mark: Edita informações do *Funcionário*
  - :heavy_check_mark: Bloqueio do *Funcionário*
  - :heavy_check_mark: Desligamento do *Funcionário*
  - :heavy_check_mark: Solicitação de *Cartão* para o *Funcionário*
  - :heavy_check_mark: Bloqueio de *Cartão* do *Funcionário*
  - :heavy_check_mark: Solicita recarga no *Cartão* do *Funcionário*
  - :heavy_check_mark: Ver histórico de recargas do *Cartão* do *Funcionário*

Funcionário:
  - :heavy_check_mark: Ver seus dados
  - :heavy_check_mark: Ver dados do seu *Cartão*
  - :heavy_check_mark: Ver *Pontos* do seu *Cartão*
  - :heavy_check_mark: Ver dados de sua *Empresa*
  - :heavy_check_mark: Ver histórico de recargas em seu *Cartão*

## Pré-requisitos

:warning: [Ruby: versão 3.1.2](https://www.ruby-lang.org/en/downloads/)

:warning: [Ruby on Rails: versão 7.0.4.3](https://rubygems.org/gems/rails/versions/7.0.4.3)

:warning: [Node](https://nodejs.org/en/download/)

:warning: [Yarn](https://yarnpkg.com/getting-started/install)

:warning: [SQLite](https://www.sqlite.org/download.html)

:warning: [Cartões e Pagamentos TD10](https://github.com/TreinaDev/CartoesEPagamentosTD10)

## Como rodar a aplicação

Executando projeto de dependência(Cartões e Pagamentos TD10):
- Siga as instruções do readme.

No terminal, clone o projeto:

```sh
git clone https://github.com/TreinaDev/GestaoEmpresasTD10
```

Entre na pasta do projeto:

```sh
cd GestaoEmpresasTD10
```

Comando para configuração inicial

```sh
./bin/setup
```

```sh
rails db:seed
```

```sh
yarn install
```

Rodando aplicação

```sh
./bin/dev
```

Acesse a aplicação em seu navegador através do endereço http://localhost:3000.

## Dados pré-cadastrados no *seed*

<details>
<summary>Dados de acesso</summary>

## Administrador

| E-mail           | password |
| ---------------- | -------- |
| admin@punti.com  | password |
| admin2@punti.com | password |

## Gerente

| E-mail                 | password |
| ---------------------- | -------- |
| manager@apple.com      | password |
| manager@microsoft.com  | password |
| manager@campuscode.com | password |
| manager@rebase.com     | password |
| manager@brainn.com     | password |
| manager@vindi.com      | password |

## Funcionários

### Apple

| E-mail                 | password |
| ---------------------- | -------- |
| funcionario@apple.com  | password |
| funcionario2@apple.com | password |
| funcionario3@apple.com | password |
| funcionario4@apple.com | password |
| funcionario5@apple.com | password |
| funcionario6@apple.com | password |

### Microsoft

| E-mail                     | password |
| -------------------------- | -------- |
| funcionario@microsoft.com  | password |
| funcionario2@microsoft.com | password |
| funcionario3@microsoft.com | password |
| funcionario4@microsoft.com | password |
| funcionario5@microsoft.com | password |
| funcionario6@microsoft.com | password |

### Campus Code

| E-mail                      | password |
| --------------------------- | -------- |
| funcionario@campuscode.com  | password |
| funcionario2@campuscode.com | password |
| funcionario3@campuscode.com | password |
| funcionario4@campuscode.com | password |
| funcionario5@campuscode.com | password |
| funcionario6@campuscode.com | password |

### Rebase

| E-mail                  | password |
| ----------------------- | -------- |
| funcionario@rebase.com  | password |
| funcionario2@rebase.com | password |
| funcionario3@rebase.com | password |
| funcionario4@rebase.com | password |
| funcionario5@rebase.com | password |
| funcionario6@rebase.com | password |

### Brainn

| E-mail                  | password |
| ----------------------- | -------- |
| funcionario@brainn.com  | password |
| funcionario2@brainn.com | password |
| funcionario3@brainn.com | password |
| funcionario4@brainn.com | password |
| funcionario5@brainn.com | password |
| funcionario6@brainn.com | password |

### Vindi

| E-mail                 | password |
| ---------------------- | -------- |
| funcionario@vindi.com  | password |
| funcionario2@vindi.com | password |
| funcionario3@vindi.com | password |
| funcionario4@vindi.com | password |
| funcionario5@vindi.com | password |
| funcionario6@vindi.com | password |

</details>


<details>
<summary>Empresas</summary>

| Nome        | CNPJ               | E-mail                 | Domínio        |
| ----------- | ------------------ | ---------------------- | -------------- |
| Apple       | 12.345.678/0001-95 | company@apple.com      | apple.com      |
| Microsoft   | 12.345.678/0002-95 | company@microsoft.com  | microsoft.com  |
| Campus Code | 12.345.678/0003-95 | company@campuscode.com | campuscode.com |
| Rebase      | 12.345.678/0004-95 | company@rebase.com     | rebase.com     |
| Brainn      | 12.345.678/0005-95 | company@brainn.com     | brainn.com     |
| Vindi       | 12.345.678/0006-95 | company@vindi.com      | vindi.com      |

</details>

<details>
<summary>Departamentos</summary>

### Apple

| Nome               | Descrição        | Código |
| ------------------ | ---------------- | ------ |
| Departamento de RH | Recursos Humanos | RHH001 |
| Financeiro         | Setor Financeiro | FIN001 |
| Jurídico           | Setor Jurídico   | JUR001 |

### Microsoft

| Nome               | Descrição        | Código |
| ------------------ | ---------------- | ------ |
| Departamento de RH | Recursos Humanos | RHH002 |
| Financeiro         | Setor Financeiro | FIN002 |
| Jurídico           | Setor Jurídico   | JUR002 |

### Campus Code

| Nome               | Descrição        | Código |
| ------------------ | ---------------- | ------ |
| Departamento de RH | Recursos Humanos | RHH003 |
| Financeiro         | Setor Financeiro | FIN003 |
| Jurídico           | Setor Jurídico   | JUR003 |


### Rebase

| Nome               | Descrição        | Código |
| ------------------ | ---------------- | ------ |
| Departamento de RH | Recursos Humanos | RHH004 |
| Financeiro         | Setor Financeiro | FIN004 |
| Jurídico           | Setor Jurídico   | JUR004 |


### Brainn

| Nome               | Descrição        | Código |
| ------------------ | ---------------- | ------ |
| Departamento de RH | Recursos Humanos | RHH005 |
| Financeiro         | Setor Financeiro | FIN005 |
| Jurídico           | Setor Jurídico   | JUR005 |


### Vindi

| Nome               | Descrição        | Código |
| ------------------ | ---------------- | ------ |
| Departamento de RH | Recursos Humanos | RHH006 |
| Financeiro         | Setor Financeiro | FIN006 |
| Jurídico           | Setor Jurídico   | JUR006 |

</details>

<details>
<summary>Cargos</summary>


### Apple

| Nome          | Código | Departamento       |
| ------------- | ------ | ------------------ |
| Gerente       | GER001 | Departamento de RH |
| Estagiário    | ERH001 | Departamento de RH |
| Administrador | ADM001 | Financeiro         |
| Tesoureiro    | TES001 | Financeiro         |
| Contador      | CON001 | Financeiro         |
| Advogado      | ADV001 | Jurídico           |
| Secretário    | SEC001 | Jurídico           |
| Estagiário    | EJU001 | Jurídico           |

### Microsoft

| Nome          | Código | Departamento       |
| ------------- | ------ | ------------------ |
| Estagiário    | ERH002 | Departamento de RH |
| Administrador | ADM002 | Financeiro         |
| Tesoureiro    | TES002 | Financeiro         |
| Contador      | CON002 | Financeiro         |
| Advogado      | ADV002 | Jurídico           |
| Secretário    | SEC002 | Jurídico           |
| Estagiário    | EJU002 | Jurídico           |

### Campus Code

| Nome          | Código | Departamento       |
| ------------- | ------ | ------------------ |
| Estagiário    | ERH003 | Departamento de RH |
| Administrador | ADM003 | Financeiro         |
| Tesoureiro    | TES003 | Financeiro         |
| Contador      | CON003 | Financeiro         |
| Advogado      | ADV003 | Jurídico           |
| Secretário    | SEC003 | Jurídico           |
| Estagiário    | EJU003 | Jurídico           |


### Rebase

| Nome          | Código | Departamento       |
| ------------- | ------ | ------------------ |
| Estagiário    | ERH004 | Departamento de RH |
| Administrador | ADM004 | Financeiro         |
| Tesoureiro    | TES004 | Financeiro         |
| Contador      | CON004 | Financeiro         |
| Advogado      | ADV004 | Jurídico           |
| Secretário    | SEC004 | Jurídico           |
| Estagiário    | EJU004 | Jurídico           |


### Brainn

| Nome          | Código | Departamento       |
| ------------- | ------ | ------------------ |
| Estagiário    | ERH005 | Departamento de RH |
| Administrador | ADM005 | Financeiro         |
| Tesoureiro    | TES005 | Financeiro         |
| Contador      | CON005 | Financeiro         |
| Advogado      | ADV005 | Jurídico           |
| Secretário    | SEC005 | Jurídico           |
| Estagiário    | EJU005 | Jurídico           |


### Vindi

| Nome          | Código | Departamento       |
| ------------- | ------ | ------------------ |
| Estagiário    | ERH006 | Departamento de RH |
| Administrador | ADM006 | Financeiro         |
| Tesoureiro    | TES006 | Financeiro         |
| Contador      | CON006 | Financeiro         |
| Advogado      | ADV006 | Jurídico           |
| Secretário    | SEC006 | Jurídico           |
| Estagiário    | EJU006 | Jurídico           |

</details>

## Como rodar os testes

Toda aplicação tem testes automatizados que podem ser executado rodando o comando abaixo

```sh
rspec
```

Para ver a cobertura de teste e só abrir o arquivo index ou executar um http server na pasta coverage.

## TODO

:white_square_button: Envio de email para confirmar cadastro do administrado do sistema.

:white_square_button: Listagem de todos funcionários de um empresa com paginação.

:white_square_button: Uma recarga deve ser validada por outro manager.

:white_square_button: Tabela de níveis de benefício para os cargos.

:white_square_button: Paginação para o histórico de recargas.

:white_square_button: Paginação na busca.

:white_square_button: Gravar o status do cartão para reduzir a quantidade de consultas na API.

:white_square_button: Sistema de busca para o administrador.

:white_square_button: Permitir que o usuário troque o email de acesso ao sistema.

:white_square_button: Envio de email para confirmar cadastro do administrado do sistema.

:white_square_button: Listagem de todos funcionários de um empresa com paginação.

:white_square_button: Uma recarga deve ser validada por outro manager.

:white_square_button: Tabela de níveis de benefício para os cargos.

:white_square_button: Paginação para o histórico de recargas.

:white_square_button: Paginação na busca.

:white_square_button: Gravar o status do cartão para reduzir a quantidade de consultas na API.

:white_square_button: Validações para a criação de empresa.


