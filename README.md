# beauty_network_boticario

Projeto Flutter para o desafio da Boticario. 

## Rodando o projeto

Para rodar esse projeto é necessário ter o Flutter instalado, assim como todas as suas dependencias. 

Suba na raiz do projeto e use o comando:

`flutter pub get`

Para baixar suas dependencias. Após isso, rode o projeto utilizando:

`flutter run`

Lembrando que é necessário ter um emulador aberto para que o Flutter consiga rodar a aplicação. 

## Um pouco mais sobre o projeto

Esse projeto utiliza Firebase['https://firebase.google.com/?hl=pt-br'] como solução de backend. Utilzei Firebase Auth para autenticação e criação de usuários e Firestore para armazenamento dos posts. 

Estou utilizando MVVM como arquitetura de projeto e Mobx com provider para gerenciamento de estado. 
Também utilizei de principios de Clean Architecture, utilizando Injeção de dependencia (feita com classes abstratas do Dart) para facilitar o Mock nos testes automatizados e repository pattern.

A maioria dos testes são testes de widgets, e estou utilizando Mockito para mock das dependencias externas à classe.

A splashscreen foi feita utilizando as ferramentas nativas de splashscreen especificas de cada plataforma. :) (Falando em splashcreen, nela tem minha dog que é a Cookie e minha gatinha, que é a Lola!).

Espero que gostem, obrigada! 
