# Heroic Database
**Heroic Database** é um aplicativo para iOS que demonstra a utilização da [API de quadrinhos da Marvel](https://developer.marvel.com). Para executar o aplicativo, é necessário criar uma conta de desenvolvedor no site da Marvel, para receber as chaves de acesso a API. O projeto utiliza algumas bibliotecas Open Source e usa [CocoaPods](https://cocoapods.org) como gerenciador de dependencias.

# Instalação
Faça um clone (ou download) deste repositório, e execute o comando ```pod install``` para instalar as dependencias via CocoaPods. 

Entre na pasta *HeroicBase* e crie um novo [arquivo plist](https://developer.apple.com/library/content/documentation/General/Reference/InfoPlistKeyReference/Articles/AboutInformationPropertyListFiles.html) com o nome ```apikeys.plist```. O projeto não funcionará sem este arquivo, nele ficam as chaves pública e privada da API da Marvel:
  - Propriedade *HBMarvelServicePublicKey*: chave pública fornecida pela Marvel
  - Propriedade *HBMarvelServicePrivateKey*: chave privada fornecida pela Marvel

# Arquitetura
O aplicativo foi desenvolvido usando a [arquitetura MVC](https://developer.apple.com/library/content/documentation/General/Conceptual/DevPedia-CocoaCore/MVC.html). As classes de modelo são responsáveis pela conexão e tratamento de dados da API da Marvel. A conexão é gerenciada pela classe ```HBMarvelService```, que é uma subclasse de ```AFHTTPSessionManager```. O servidor retorna dados no formato JSON, que é convertido para classes nativas através da biblioteca ```JSONModel```.

As controllers utilizam a classe de acesso a API e os objetos nativos de dados, já convertidos. As controllers também controlam o ciclo de vida de views.

Os testes unitários foram criados usando ```XCTestCase``` para definir as verificações dos testes, e utiliza ```OHHTTPStubs``` para fazer o mock de dados.
# Dependencias
  - AFNetworking
  - JSONModel
  - MD5Digest
  - OHHTTPStubs

# Problemas conhecidos
  - A paginação não está sendo tratada. A lista mostra os 20 primeiros personagens apenas.
  - O aplicativo não está mostrando uma barra de progresso ou outro feedback visual durante o download de dados. 
  - O aplicativo não implementa a busca de personagens por nome.
  - O aplicativo não segue algumas recomendações de interface da apple.
  - O aplicativo não mostra a mensagem de crédito da origem dos dados, solicitada pela Marvel.
  - A suite de testes cobre apenas as classes de modelo.

