# iQueChumbei
## _Nunca mais vou esquecer_

[![N|Solid](https://upload.wikimedia.org/wikipedia/commons/1/1a/Logo_ulht_horizontal_v1-01.png)](https://deisi.ulusofona.pt/)

A iQueChumbei, uma empresa fictícia, contratualizou os serviços dos alunos da Universidade Lusófona de Humanidades e Tecnologias para o desenvolvimento de uma aplicação móvel que permitirá aos seus utilizadores (alunos de uma escola ou universidade) registar as avaliações de cada disciplina, funcionando assim como uma agenda.

A aplicação foi desenvolvida em Flutter, de forma a servir tanto os utilizadores de Android como os de iOS, e foi projetada para ir ao encontro das boas práticas UI/UX, garantindo assim um maior nível de aceitabilidade por parte dos utilizadores.

## Aluno 🤝
| Nome | Número de Aluno |
| ------ | ------ |
| Marcelo Domingues | 22201217 |

## Features 💻
- Registo de avaliações com nome da disciplina, tipo de avaliação, data e hora da realização, nível de dificuldade e observações
- Listage de avaliações ordenadas pela data e hora da realização
- Consulta detalhada das avaliações com opção de edição e eliminação para registos futuros
- Dashboard com médias de dificuldade das avaliações dos próximos 7 e 7 a 14 dias e lista de avaliações dos próximos 7 dias
- Funcionalidade "Dealer" para partilha de informação de avaliação via mensagem de texto

## Features Bónus: 🚀

- Dashboard Pie Chart
- DarkMode Disponível

**Dashboard Pie Chart**

A implementação de um gráfico _Pie Chart_ foi feito com o intuito do utilizador consiga ver de uma forma geral as dificuldades das avaliações que teve ao longo do tempo. Ao adicionar uma nova avaliação, o gráfico vai ser atualizado automáticamente.

*Android/iOS:*

<img src="https://i.imgur.com/bTZHmrZ.png" alt="Android-Image-Dashboard-2" width="20%" height="20%">
<img width="5%" height="5%">
<img src="https://i.imgur.com/xK1bBXJ.png" alt="Android-Image-Dashboard" width="20%" height="20%">


**DarkMode**

A funcionalidade _Dark Mode_ está dispovível em todos os ecrãs. Foi adicionado esta funcionalidade de forma a dar ao utilizador a escolha e conforto de como quer a aplicação (Fundo Branco ou Fundo Preto). Sendo programador, fundo preto é vida.

*Android/iOS:*

<img src="https://i.imgur.com/guwGT1H.png" alt="Android-Image-Dashboard-DM" width="20%" height="20%">
<img src="https://i.imgur.com/DrrBs9k.png" alt="Android-Image-Dashboard-DM-2" width="20%" height="20%">
<img width="5%" height="5%">
<img src="https://i.imgur.com/gwB0Qeg.png" alt="IOS-Image-Dashboard-DM" width="20%" height="20%">
<img src="https://i.imgur.com/wpSjoCc.png" alt="IOS-Image-Dashboard-DM-2" width="20%" height="20%">


## Implementação 💡

| Features | Estado |
| ------ | ------ |
| Navegação | Done ✅ |
| Registo de avaliação | Done ✅ |
| Listagem de avaliações | Done ✅ |
| Consulta detalhada de avaliações | Done ✅ |
| Eliminação e edição de avaliações |  Done ✅  |
| Dashboard - Funcionalidade Avançada | Done ✅ |
| Funcionalidade “Dealer” - Funcionalidade Avançada | Done ✅ ||
| Testes unitários |  Desenvolvimento 🚧

## Ecrãs 📱

Na explicação em baixo de cada ecrã e a sua respetiva funcionalidade, irão ser usados _screenshots_ de ambos os sistemas operativos que o flutter permite usar, sendo esses _Android_ e _iOS_.

**Navegação:**

A navegação da aplicação foi projetada para ser simples e intuitiva, sendo realizada através de uma BottomNavigationBar que dá acesso a três telas principais: a Dashboard, a Listagem de Avaliações e o Registo de Avaliação.

O Dashboard é a primeira tela que o utilizador visualiza e é esta que fornece informações importantes sobre as avaliações futuras, incluindo a média de dificuldade das avaliações nos próximos 7 e 14 dias e uma lista das avaliações nos próximos 7 dias.

A Listagem de Avaliações permite que o utilizador visualize todas as avaliações num só lugar e faça alterações, como adicionar, editar ou eliminar avaliações.

O Registo de Avaliação é a tela onde o utilizador pode adicionar novas avaliações à aplicação. É possível definir a data e hora, a disciplina e a dificuldade da avaliação, bem como adicionar uma descrição ou comentário. O Registo de Avaliação é uma tela importante para manter um controlo preciso das avaliações futuras.

Em resumo, a BottomNavigationBar é uma forma eficiente e intuitiva de navegar na aplicação, permitindo que o utilizador acesse facilmente as principais funcionalidades, como o Dashboard, a Listagem de Avaliações e o Registo de Avaliação.

*Android/iOS:*

<img src="https://i.imgur.com/7kH7KWL.png" alt="Android-Image-Dashboard-DM-2" width="20%" height="20%">
<img width="5%" height="5%">
<img src="https://i.imgur.com/CzNTHEH.png" alt="IOS-Image-Dashboard-DM" width="20%" height="20%">

**Registo de avaliação:**

A aplicação de registos de avaliação foi projetada para ser fácil e intuitiva de usar, com um formulário que solicita ao utilizador informações importantes sobre a avaliação que ele deseja registrar. O formulário pede o nome da disciplina, o tipo de avaliação, a data e hora da realização, o nível de dificuldade esperado pelo aluno e observações opcionais.

O tipo de avaliação pode ser selecionado a partir de uma lista de opções, que inclui frequência, mini-teste, projeto ou defesa. A data e hora da realização devem ser inseridas no formato AAAA/MM/DD HH:MM, e a aplicação só permite que sejam registradas avaliações para datas futuras.

Após a submissão bem-sucedida do formulário, a aplicação exibe uma mensagem de confirmação, informando que a avaliação foi registrada com sucesso. Isso permite ao utilizador saber imediatamente que a operação foi concluída com êxito.

Em resumo, o formulário de registos de avaliação é simples, mas completo, permitindo que o utilizador insira facilmente todas as informações necessárias para registrar uma avaliação. A mensagem de confirmação também é útil para garantir que o utilizador saiba que a operação foi concluída com sucesso.

*Android/iOS:*

<img src="https://i.imgur.com/EJDopmh.png" alt="Android-Image-Dashboard-DM-2" width="20%" height="20%">
<img width="5%" height="5%">
<img src="https://i.imgur.com/jmWFcpa.png" alt="IOS-Image-Registo" width="20%" height="20%">

**Listagem de avaliações:**

A aplicação possui um ecrã de Listagem de Avaliações, que permite ao utilizador visualizar todos os registos de avaliações num só lugar. Cada elemento da lista exibe informações importantes sobre cada registo, incluindo o nome da disciplina, o nível de dificuldade esperado, o tipo de avaliação e a data e hora da realização.

A lista é automaticamente ordenada pela data e hora da realização de cada avaliação, facilitando a visualização das avaliações futuras. A partir deste ecrã, o utilizador pode editar ou excluir avaliações existentes, bem como adicionar novas avaliações.

A Listagem de Avaliações é uma tela importante para que o utilizador possa gerir efetivamente as suas avaliações académicas, permitindo que ele tenha uma visão geral de todas as suas avaliações futuras em um só lugar. A ordenação automática pela data e hora da realização também é um recurso valioso que ajuda o utilizador a se manter organizado e preparado para as suas avaliações.

Em resumo, o ecrã de Listagem de Avaliações é uma ferramenta valiosa na aplicação, permitindo que o utilizador gerencie facilmente as suas avaliações académicas. Com as informações apresentadas e a ordenação automática, o utilizador pode facilmente visualizar, editar ou excluir registos de avaliações.

*Android/iOS:*

<img src="https://i.imgur.com/tWzecg7.png" alt="Android-Image-Dashboard-DM-2" width="20%" height="20%">
<img width="5%" height="5%">
<img src="https://i.imgur.com/7ZOPU12.png" alt="IOS-Image-Lista" width="20%" height="20%">

**Consulta detalhada de avaliações:**

Este é um ecrã de consulta que permite aos utilizadores visualizar todas as informações associadas a uma avaliação previamente registada, sem a possibilidade de edição involuntária. É importante destacar que, embora a tela esteja disponível apenas para consulta, pode ser reutilizada para edição se for necessário, mas somente se houver um mecanismo que habilite a edição por iniciativa do usuário. O ecrã será acessado a partir da "Listagem de avaliações" e permitirá que os usuários retornem à tela anterior. Em resumo, este ecrã é fundamental para a visualização detalhada de uma avaliação, sem o risco de perda ou alteração acidental de informações.

*Android/iOS:*

<img src="https://i.imgur.com/ofkaD9v.png" alt="Android-Image-Dashboard-DM-2" width="20%" height="20%">
<img width="5%" height="5%">
<img src="https://i.imgur.com/glZJB9P.png" alt="IOS-Image-Dashboard-DM" width="20%" height="20%">

**Eliminação e Edição de avaliações:**

A aplicação permite a _edição e a eliminação_ de avaliações futuras. Quando uma avaliação é editada ou eliminada com sucesso, a aplicação exibe uma mensagem a indicar o sucesso da operação. Se o registo for para o passado, a aplicação apresentará uma mensagem informando que não é possível editar ou excluir registos passados.

No ecrã de Listagem de Avaliações, é possível excluir uma avaliação deslizando o dedo sobre o registo que se deseja eliminar. Uma vez editado ou excluído, o utilizador será sempre redirecionado de volta para o ecrã de Listagem de Avaliações.

Essas funcionalidades são importantes para permitir que os utilizadores gerirem todas as suas avaliações académicas de forma eficiente, podendo alterar ou excluir registos quando necessário. A opção de exclusão por swipe é especialmente útil para permitir que o utilizador realize operações rapidamente e sem problemas.

Em resumo, a aplicação oferece recursos úteis para _edição e eliminação_ de registos de avaliação futuros, com mensagens de confirmação de operação bem-sucedida. A opção de exclusão por swipe torna a operação ainda mais fácil e rápida. A navegação é eficiente, permitindo que o utilizador retorne facilmente ao ecrã de Listagem de Avaliações após concluir uma operação de edição ou exclusão.

*Android/iOS:*

<img src="https://i.imgur.com/DLoWK26.png" alt="Android-Image-Dashboard-DM-2" width="20%" height="20%">
<img src="https://i.imgur.com/PRqbtzz.png" alt="IOS-Image-Lista" width="20%" height="20%">
<img src="https://i.imgur.com/SAk0w99.png" alt="IOS-Image-Lista" width="20%" height="20%">
<img width="5%" height="5%">
<img src="https://i.imgur.com/NjH6UJq.png" alt="IOS-Image-Lista" width="20%" height="20%">
<img src="https://i.imgur.com/wAGSEoA.png" alt="IOS-Image-Lista" width="20%" height="20%">
<img src="https://i.imgur.com/j0gGAlF.png" alt="IOS-Image-Lista" width="20%" height="20%">
<img src="https://i.imgur.com/RAM6Gw6.png" alt="IOS-Image-Lista" width="20%" height="20%">
<img src="https://i.imgur.com/RAM6Gw6.png" alt="IOS-Image-Lista" width="20%" height="20%">



**Dashboard:**

A _Dashboard_ da aplicação foi projetada para ser o primeiro ecrã apresentado ao utilizador, com o objetivo de fornecer uma visão rápida e fácil do seu estado em relação às avaliações nos próximos 7 e 14 dias. Para isso, foram incluídas informações sobre o nível médio de dificuldade das avaliações em ambos os períodos, permitindo que o utilizador tenha uma ideia geral da sua carga de trabalho.

Além disso, a dashboard também exibe uma lista das avaliações nos próximos 7 dias, com os mesmos dados do nível médio de dificuldade, o que permite ao utilizador ter uma visão mais detalhada da sua programação e se preparar adequadamente para as avaliações futuras. Ainda foi implementado também um _Pie Chart_ de forma a conseguir ver de modo mais fácil uma média das dificuldades.

Em resumo, a _Dashboard_ da aplicação é uma ferramenta valiosa para o utilizador gerir efetivamente a sua carga de trabalho académica, proporcionando uma visão rápida e fácil do seu estado atual e futuro em relação às avaliações.

*Android/iOS:*

<img src="https://i.imgur.com/7kH7KWL.png" alt="Android-Image-Dashboard" width="20%" height="20%">
<img src="https://i.imgur.com/guwGT1H.png" alt="Android-Image-Dashboard-2" width="20%" height="20%">
<img width="5%" height="5%">
<img src="https://i.imgur.com/CzNTHEH.png" alt="Android-Image-Dashboard" width="20%" height="20%">
<img src="https://i.imgur.com/zSkHqHf.png" alt="Android-Image-Dashboard" width="20%" height="20%">

**Dealer:**

A funcionalidade _Dealer_ é uma funcionalidade avançada que permite que o utilizador compartilhe automaticamente um registo de avaliação com amigos ou colegas através de mensagens, e-mails ou outras plataformas. Essa funcionalidade pode ser acessada a partir do ecrã de Consulta Detalhada, onde o utilizador poderá enviar uma mensagem contendo todas as informações do registo de avaliação.

A mensagem gerada pela funcionalidade _Dealer_ contém todas as informações relevantes do registo de avaliação, como nome da disciplina, data e hora da avaliação, nível de dificuldade esperado e observações opcionais. Essa mensagem pode ser personalizada pelo utilizador antes de ser enviada, permitindo que ele adicione outras informações relevantes ou uma mensagem pessoal.

A funcionalidade _Dealer_ é especialmente útil para alunos que desejam compartilhar informações sobre avaliações com amigos ou colegas, facilitando a organização e a preparação para futuras avaliações. Essa funcionalidade promove o espírito de entreajuda entre os alunos, permitindo que eles se apoiem mutuamente em sua jornada académica.

Em resumo, a funcionalidade "Dealer" é uma ferramenta útil para compartilhar informações sobre avaliações com amigos ou colegas, acessível a partir do ecrã de Consulta Detalhada. A mensagem gerada contém todas as informações relevantes do registo de avaliação e pode ser personalizada pelo utilizador antes de ser enviada. Essa funcionalidade promove a colaboração entre os alunos e a organização eficiente para futuras avaliações.

_Nota:_ A funcionalidade _Dealer_ apenas está funcional em _**Android**_, visto que o o _**iOS**_ tem limitações.

<img src="https://i.imgur.com/j8aijWs.png" alt="Android-Image-Dashboard" width="20%" height="20%">
<img src="https://i.imgur.com/Vswx1n3.png" alt="Android-Image-Dashboard" width="20%" height="20%">
<img src="https://i.imgur.com/vItVnm5.png" alt="Android-Image-Dashboard" width="20%" height="20%">
<img width="5%" height="5%">
<img src="https://i.imgur.com/QTIJ0Sk.png" alt="Android-Image-Dashboard" width="20%" height="20%">

## Referências

| Observação | Link | 
| ------ | ------ |
| Construção do Ficheiro README | https://jbt.github.io/markdown-editor/ |
| Dúvidas não encontradas no StackOverflow | https://chat.openai.com/|
| Esclarecimento de dúvidas | https://stackoverflow.com/ |
| Documentação do Flutter| https://docs.flutter.dev/get-started/install |
| Imagens dos Ecrãs | https://imgur.com/a/1xCEHeH |

## Autoavaliação

**17 Valores** - Por muito que tentasse, os testes unitários estavam sempre a falhar, portanto decidi removê-los e encarar com as consequências.
