![Gestão de Empresas Participantes](https://github.com/TreinaDev/GestaoEmpresasTD10/assets/75085756/c2eb584a-d9e3-4665-b131-86b1782e9909)# Gestão de Empresas

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

![Up<?xml version="1.0" standalone="no"?><svg version="1.1" xmlns="http://www.w3.org/2000/svg" width="1181.82666015625" height="975"><svg x="509.52880859375" y="23.5" width="106.47119140625" height="186"><path d="M8,160L40.735595703125,160Q50.735595703125,160,50.735595703125,150L50.735595703125,36Q50.735595703125,26,60.735595703125,26L93.47119140625,26L60.735595703125,26Q50.735595703125,26,50.735595703125,36L50.735595703125,150Q50.735595703125,160,40.735595703125,160L8,160L8,160M18,156L18,164M83.47119140625,22L83.47119140625,30" fill="none" stroke="#3EA8DE" stroke-width="2"></path><text x="11" y="157" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 14px; font-weight: normal; fill: rgb(215, 215, 217);">1</text><text x="82.46630859375" y="23" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 14px; font-weight: normal; fill: rgb(215, 215, 217);">1</text></svg><svg x="509.52880859375" y="25.5" width="40.7646484375" height="786"><path d="M17.7646484375,760L27.7646484375,760Q37.7646484375,760,37.7646484375,750L37.7646484375,36Q37.7646484375,26,27.7646484375,26L8,26L27.7646484375,26Q37.7646484375,26,37.7646484375,36L37.7646484375,750Q37.7646484375,760,27.7646484375,760L17.7646484375,760L17.7646484375,760ZM27.7646484375,756L27.7646484375,764M18,22L18,30" fill="none" stroke="#3EA8DE" stroke-width="2"></path><text x="20.7646484375" y="757" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 14px; font-weight: normal; fill: rgb(215, 215, 217);">1</text><text x="11" y="23" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 14px; font-weight: normal; fill: rgb(215, 215, 217);">1</text></svg><svg x="204.466796875" y="340.5" width="123.35986328125" height="537"><path d="M8,26L49.179931640625,26Q59.179931640625,26,59.179931640625,36L59.179931640625,501Q59.179931640625,511,69.179931640625,511L110.35986328125,511L69.179931640625,511Q59.179931640625,511,59.179931640625,501L59.179931640625,36Q59.179931640625,26,49.179931640625,26L8,26L8,26M18,22L18,30M100.35986328125,507L100.35986328125,515" fill="none" stroke="#3EA8DE" stroke-width="2"></path><text x="11" y="23" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 14px; font-weight: normal; fill: rgb(215, 215, 217);">1</text><text x="99.35498046875" y="508" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 14px; font-weight: normal; fill: rgb(215, 215, 217);">1</text></svg><svg x="519.29345703125" y="635.5" width="369.53759765625" height="209"><path d="M8,183L172.268798828125,183Q182.268798828125,183,182.268798828125,173L182.268798828125,36Q182.268798828125,26,192.268798828125,26L356.53759765625,26L192.268798828125,26Q182.268798828125,26,182.268798828125,36L182.268798828125,173Q182.268798828125,183,172.268798828125,183L8,183L8,183M18,179L18,187M346.53759765625,22L346.53759765625,30" fill="none" stroke="#3EA8DE" stroke-width="2"></path><text x="11" y="180" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 14px; font-weight: normal; fill: rgb(215, 215, 217);">1</text><text x="345.53271484375" y="23" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 14px; font-weight: normal; fill: rgb(215, 215, 217);">1</text></svg><svg x="1137.23193359375" y="91.5" width="44.5947265625" height="596"><path d="M8,26L31.5947265625,26Q41.5947265625,26,41.5947265625,36L41.5947265625,560Q41.5947265625,570,31.5947265625,570L21.5947265625,570L31.5947265625,570Q41.5947265625,570,41.5947265625,560L41.5947265625,36Q41.5947265625,26,31.5947265625,26L8,26L8,26ZM18,22L18,30M31.5947265625,566L31.5947265625,574" fill="none" stroke="#3EA8DE" stroke-width="2"></path><text x="11" y="23" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 14px; font-weight: normal; fill: rgb(215, 215, 217);">1</text><text x="24.5947265625" y="567" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 14px; font-weight: normal; fill: rgb(215, 215, 217);">1</text></svg><svg x="204.466796875" y="25.5" width="123.3642578125" height="532"><path d="M8,506L49.18212890625,506Q59.18212890625,506,59.18212890625,496L59.18212890625,36Q59.18212890625,26,69.18212890625,26L110.3642578125,26L69.18212890625,26Q59.18212890625,26,59.18212890625,36L59.18212890625,496Q59.18212890625,506,49.18212890625,506L8,506L8,506M18,502L18,510M100.3642578125,22L100.3642578125,30" fill="none" stroke="#3EA8DE" stroke-width="2"></path><text x="11" y="503" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 14px; font-weight: normal; fill: rgb(215, 215, 217);">1</text><text x="99.359375" y="23" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 14px; font-weight: normal; fill: rgb(215, 215, 217);">1</text></svg><svg x="836.8310546875" y="23.5" width="116.46240234375" height="219"><path d="M8,26L45.731201171875,26Q55.731201171875,26,55.731201171875,36L55.731201171875,183Q55.731201171875,193,65.731201171875,193L103.46240234375,193L65.731201171875,193Q55.731201171875,193,55.731201171875,183L55.731201171875,36Q55.731201171875,26,45.731201171875,26L8,26L8,26M18,22L18,30M93.46240234375,189L93.46240234375,197" fill="none" stroke="#3EA8DE" stroke-width="2"></path><text x="11" y="23" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 14px; font-weight: normal; fill: rgb(215, 215, 217);">1</text><text x="92.45751953125" y="190" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 14px; font-weight: normal; fill: rgb(215, 215, 217);">1</text></svg><svg x="603" y="0"><rect x="0" y="0" width="241.8310546875" height="33" fill="#222"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; font-weight: bold; fill: rgb(255, 255, 255);">companies</text></svg><svg x="603" y="33"><rect x="0" y="0" width="241.8310546875" height="33" fill="#4B4C53"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">id</text><text x="186.064453125" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">varchar</text></svg><svg x="603" y="66"><rect x="0" y="0" width="241.8310546875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">brand_name</text><text x="197.3759765625" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">string</text></svg><svg x="603" y="99"><rect x="0" y="0" width="241.8310546875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">corporate_name</text><text x="197.3759765625" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">string</text></svg><svg x="603" y="132"><rect x="0" y="0" width="241.8310546875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">registration_number</text><text x="197.3759765625" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">string</text></svg><svg x="603" y="165"><rect x="0" y="0" width="241.8310546875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">address</text><text x="197.3759765625" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">string</text></svg><svg x="603" y="198"><rect x="0" y="0" width="241.8310546875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">phone_number</text><text x="197.3759765625" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">string</text></svg><svg x="603" y="231"><rect x="0" y="0" width="241.8310546875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">email</text><text x="197.3759765625" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">string</text></svg><svg x="603" y="264"><rect x="0" y="0" width="241.8310546875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">domain</text><text x="197.3759765625" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">string</text></svg><svg x="603" y="297"><rect x="0" y="0" width="241.8310546875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">active</text><text x="182.458984375" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">boolean</text></svg><svg x="603" y="330"><rect x="0" y="0" width="241.8310546875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">created_at</text><text x="177.4697265625" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">datetime</text></svg><svg x="603" y="363"><rect x="0" y="0" width="241.8310546875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">updated_at</text><text x="177.4697265625" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">datetime</text></svg><svg x="314.8310546875" y="2"><rect x="0" y="0" width="202.69775390625" height="33" fill="#222"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; font-weight: bold; fill: rgb(255, 255, 255);">departments</text></svg><svg x="314.8310546875" y="35"><rect x="0" y="0" width="202.69775390625" height="33" fill="#4B4C53"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">id</text><text x="146.93115234375" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">varchar</text></svg><svg x="314.8310546875" y="68"><rect x="0" y="0" width="202.69775390625" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">name</text><text x="158.24267578125" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">string</text></svg><svg x="314.8310546875" y="101"><rect x="0" y="0" width="202.69775390625" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">description</text><text x="158.24267578125" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">string</text></svg><svg x="314.8310546875" y="134"><rect x="0" y="0" width="202.69775390625" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">code</text><text x="158.24267578125" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">string</text></svg><svg x="314.8310546875" y="167"><rect x="0" y="0" width="202.69775390625" height="33" fill="#4B4C53"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">company_id</text><text x="149.83837890625" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">integer</text></svg><svg x="314.8310546875" y="200"><rect x="0" y="0" width="202.69775390625" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">created_at</text><text x="138.33642578125" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">datetime</text></svg><svg x="314.8310546875" y="233"><rect x="0" y="0" width="202.69775390625" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">updated_at</text><text x="138.33642578125" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">datetime</text></svg><svg x="314.82666015625" y="307"><rect x="0" y="0" width="212.466796875" height="33" fill="#222"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; font-weight: bold; fill: rgb(255, 255, 255);">employee_profiles</text></svg><svg x="314.82666015625" y="340"><rect x="0" y="0" width="212.466796875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">id</text><text x="156.7001953125" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">varchar</text></svg><svg x="314.82666015625" y="373"><rect x="0" y="0" width="212.466796875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">name</text><text x="168.01171875" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">string</text></svg><svg x="314.82666015625" y="406"><rect x="0" y="0" width="212.466796875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">social_name</text><text x="168.01171875" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">string</text></svg><svg x="314.82666015625" y="439"><rect x="0" y="0" width="212.466796875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">cpf</text><text x="168.01171875" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">string</text></svg><svg x="314.82666015625" y="472"><rect x="0" y="0" width="212.466796875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">rg</text><text x="168.01171875" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">string</text></svg><svg x="314.82666015625" y="505"><rect x="0" y="0" width="212.466796875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">address</text><text x="168.01171875" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">string</text></svg><svg x="314.82666015625" y="538"><rect x="0" y="0" width="212.466796875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">email</text><text x="168.01171875" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">string</text></svg><svg x="314.82666015625" y="571"><rect x="0" y="0" width="212.466796875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">phone_number</text><text x="168.01171875" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">string</text></svg><svg x="314.82666015625" y="604"><rect x="0" y="0" width="212.466796875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">status</text><text x="159.607421875" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">integer</text></svg><svg x="314.82666015625" y="637"><rect x="0" y="0" width="212.466796875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">birth_date</text><text x="175.35595703125" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">date</text></svg><svg x="314.82666015625" y="670"><rect x="0" y="0" width="212.466796875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">admission_date</text><text x="175.35595703125" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">date</text></svg><svg x="314.82666015625" y="703"><rect x="0" y="0" width="212.466796875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">dismissal_date</text><text x="175.35595703125" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">date</text></svg><svg x="314.82666015625" y="736"><rect x="0" y="0" width="212.466796875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">marital_status</text><text x="159.607421875" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">integer</text></svg><svg x="314.82666015625" y="769"><rect x="0" y="0" width="212.466796875" height="33" fill="#4B4C53"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">department_id</text><text x="159.607421875" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">integer</text></svg><svg x="314.82666015625" y="802"><rect x="0" y="0" width="212.466796875" height="33" fill="#4B4C53"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">user_id</text><text x="159.607421875" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">integer</text></svg><svg x="314.82666015625" y="835"><rect x="0" y="0" width="212.466796875" height="33" fill="#4B4C53"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">position_id</text><text x="159.607421875" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">integer</text></svg><svg x="314.82666015625" y="868"><rect x="0" y="0" width="212.466796875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">created_at</text><text x="148.10546875" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">datetime</text></svg><svg x="314.82666015625" y="901"><rect x="0" y="0" width="212.466796875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">updated_at</text><text x="148.10546875" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">datetime</text></svg><svg x="314.82666015625" y="934"><rect x="0" y="0" width="212.466796875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">card_status</text><text x="153.0947265625" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">boolean</text></svg><svg x="940.29345703125" y="2"><rect x="0" y="0" width="204.9384765625" height="33" fill="#222"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; font-weight: bold; fill: rgb(255, 255, 255);">manager_emails</text></svg><svg x="940.29345703125" y="35"><rect x="0" y="0" width="204.9384765625" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">id</text><text x="149.171875" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">varchar</text></svg><svg x="940.29345703125" y="68"><rect x="0" y="0" width="204.9384765625" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">email</text><text x="160.4833984375" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">string</text></svg><svg x="940.29345703125" y="101"><rect x="0" y="0" width="204.9384765625" height="33" fill="#4B4C53"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">created_by_id</text><text x="152.0791015625" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">integer</text></svg><svg x="940.29345703125" y="134"><rect x="0" y="0" width="204.9384765625" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">created_at</text><text x="140.5771484375" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">datetime</text></svg><svg x="940.29345703125" y="167"><rect x="0" y="0" width="204.9384765625" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">updated_at</text><text x="140.5771484375" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">datetime</text></svg><svg x="940.29345703125" y="200"><rect x="0" y="0" width="204.9384765625" height="33" fill="#4B4C53"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">company_id</text><text x="152.0791015625" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">integer</text></svg><svg x="940.29345703125" y="233"><rect x="0" y="0" width="204.9384765625" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">status</text><text x="145.56640625" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">boolean</text></svg><svg x="0" y="317"><rect x="0" y="0" width="212.466796875" height="33" fill="#222"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; font-weight: bold; fill: rgb(255, 255, 255);">positions</text></svg><svg x="0" y="350"><rect x="0" y="0" width="212.466796875" height="33" fill="#4B4C53"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">id</text><text x="156.7001953125" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">varchar</text></svg><svg x="0" y="383"><rect x="0" y="0" width="212.466796875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">name</text><text x="168.01171875" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">string</text></svg><svg x="0" y="416"><rect x="0" y="0" width="212.466796875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">description</text><text x="168.01171875" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">string</text></svg><svg x="0" y="449"><rect x="0" y="0" width="212.466796875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">code</text><text x="168.01171875" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">string</text></svg><svg x="0" y="482"><rect x="0" y="0" width="212.466796875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">card_type_id</text><text x="159.607421875" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">integer</text></svg><svg x="0" y="515"><rect x="0" y="0" width="212.466796875" height="33" fill="#4B4C53"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">department_id</text><text x="159.607421875" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">integer</text></svg><svg x="0" y="548"><rect x="0" y="0" width="212.466796875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">created_at</text><text x="148.10546875" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">datetime</text></svg><svg x="0" y="581"><rect x="0" y="0" width="212.466796875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">updated_at</text><text x="148.10546875" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">datetime</text></svg><svg x="875.8310546875" y="612"><rect x="0" y="0" width="282.99560546875" height="33" fill="#222"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; font-weight: bold; fill: rgb(255, 255, 255);">users</text></svg><svg x="875.8310546875" y="645"><rect x="0" y="0" width="282.99560546875" height="33" fill="#4B4C53"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">id</text><text x="227.22900390625" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">varchar</text></svg><svg x="875.8310546875" y="678"><rect x="0" y="0" width="282.99560546875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">email</text><text x="238.54052734375" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">string</text></svg><svg x="875.8310546875" y="711"><rect x="0" y="0" width="282.99560546875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">encrypted_password</text><text x="238.54052734375" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">string</text></svg><svg x="875.8310546875" y="744"><rect x="0" y="0" width="282.99560546875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">reset_password_token</text><text x="238.54052734375" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">string</text></svg><svg x="875.8310546875" y="777"><rect x="0" y="0" width="282.99560546875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">reset_password_sent_at</text><text x="218.63427734375" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">datetime</text></svg><svg x="875.8310546875" y="810"><rect x="0" y="0" width="282.99560546875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">remember_created_at</text><text x="218.63427734375" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">datetime</text></svg><svg x="875.8310546875" y="843"><rect x="0" y="0" width="282.99560546875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">role</text><text x="230.13623046875" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">integer</text></svg><svg x="875.8310546875" y="876"><rect x="0" y="0" width="282.99560546875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">created_at</text><text x="218.63427734375" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">datetime</text></svg><svg x="875.8310546875" y="909"><rect x="0" y="0" width="282.99560546875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">updated_at</text><text x="218.63427734375" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">datetime</text></svg><svg x="875.8310546875" y="942"><rect x="0" y="0" width="282.99560546875" height="33" fill="#37383F"></rect><text x="10" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">cpf</text><text x="238.54052734375" y="19.75" style="font-family: &quot;Open Sans&quot;, sans-serif; font-size: 13px; fill: rgb(215, 215, 217);">string</text></svg></svg>loading Gestão de Empresas Participantes.svg…]()


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

:white_square_button: Ajustes de responsividade.

:white_square_button: Aprimorar responsvidade da aplicação.

:white_square_button: Implementação de Jobs para criação de departamento e cargo automáticos da criação da empresa.

:white_square_button: Implementação de Jobs para recargas gerais da empresa.
