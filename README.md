# Gestão de Empresas

<p align="center">
  <img src="http://img.shields.io/static/v1?label=Ruby&message=3.1.2&color=red&style=for-the-badge&logo=ruby"/>
  <img src="http://img.shields.io/static/v1?label=Ruby%20On%20Rails%20&message=7.0.4.3&color=red&style=for-the-badge&logo=ruby-on-rails"/>
  <img src="http://img.shields.io/static/v1?label=TESTES&message=%3E200&color=GREEN&style=for-the-badge"/>
  <img src="http://img.shields.io/static/v1?label=STATUS&message=EM%20DESENVOLVIMENTO&color=RED&style=for-the-badge"/>
</p>

### Tópicos

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

:white_check_mark: Cadastro de Administrador via email com domínio **punti.com**

Administrador:
  - :white_check_mark: Cadastro de *Empresas*
  - :white_check_mark: Pre-Cadastro de *Gerentes* em *Empresas*
  - :white_check_mark: Remove de pre-cadastro *Gerentes*
  - :white_check_mark: Bloqueio de *Gerente* e/ou *Empresas*
  - :white_check_mark: Desbloqueio de *Gerente* e/ou *Empresas*
  - :white_check_mark: Ver lista de *Empresas*

Gerente:
  - :white_check_mark: Completa seus dados cadastrais(*employee_profile*)
  - :white_check_mark: Cadastro de *Departamentos*
  - :white_check_mark: Editação de *Departamentos*
  - :white_check_mark: Ver *Departamentos*
  - :white_check_mark: Cadastro de *Cargos*
  - :white_check_mark: Editação de *Cargos*
  - :white_check_mark: Ver *Cargos*
  - :white_check_mark: Pre-Cadastro do *Funcionários*
  - :white_check_mark: Ver *Funcionários*
  - :white_check_mark: Faz busca por(**nome ou cpf**) os *Funcionários*
  - :white_check_mark: Edita informações do *Funcionário*
  - :white_check_mark: Bloqueio do *Funcionário*
  - :white_check_mark: Desligamento do *Funcionário*
  - :white_check_mark: Solicitação de *Cartão* para o *Funcionário*
  - :white_check_mark: Bloqueio de *Cartão* do *Funcionário*
  - :white_check_mark: Solicita recarga no *Cartão* do *Funcionário*
  - :white_check_mark: Ver histórico de recargas do *Cartão* do *Funcionário*

Funcionário:
  - :white_check_mark: Ver seus dados
  - :white_check_mark: Ver dados do seu *Cartão*
  - :white_check_mark: Ver *Pontos* do seu *Cartão*
  - :white_check_mark: Ver dados de sua *Empresa*
  - :white_check_mark: Ver histórico de recargas em seu *Cartão*

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
yarn install
```

Rodando aplicação

```sh
./bin/dev
```

Acesse a aplicação em seu navegador através do endereço http://localhost:3000.
Para fazer login use os dados abaixo.
| nome    | E-mail                      | password | Tipo          |
| ------- | --------------------------- | -------- | ------------- |
| Admir   | admir@leilaodogalpao.com.br | password | Administrador |
| Ana     | ana@leilaodogalpao.com.br   | password | Administrador |
| Leandro | leandro@email.com           | password | Regular       |
| João    | joao@email.com              | password | Regular       |

## Como rodar os testes

Toda aplicação tem testes automatizados que podem ser executado rodando o comando abaixo

```sh
rspec
```

Para ver a cobertura de teste e só abrir o arquivo index ou executar um http server na pasta coverage.

## TODO

:white_square_button: Envio de email para confirmar cadastro do administrado do sistema.

:white_square_button: Listagem de todos funcionários de um empresa com paginação.

:white_square_button: Não bloquear gerente se este e o único gerente disponível

