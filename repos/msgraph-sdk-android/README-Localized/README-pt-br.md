# Introdução ao SDK do Microsoft Graph para Android

[ ![Baixar](https://api.bintray.com/packages/microsoftgraph/Maven/msgraph-sdk-android/images/download.svg) ](https://bintray.com/microsoftgraph/Maven/msgraph-sdk-android/_latestVersion)

Integre a [API do Microsoft Graph](https://graph.microsoft.io/en-us/getting-started) ao seu aplicativo Android!

## 1. Instalação
### 1.1 Instalar o AAR via Gradle
Adicione o repositório JCenter e uma dependência de compilação para `msgraph-sdk-android` para `build.gradle` do projeto

```gradle
repository {
    jcenter()
}

dependency {
    // Include the sdk as a dependency
    compile('com.microsoft.graph:msgraph-sdk-android:1.2.+')

    // Include the gson dependency
    compile('com.google.code.gson:gson:2.3.1')
}
```

### 1.2 Habilitar o ProGuard
A natureza da API do Graph é tão ampla que o SDK precisa de um grande conjunto de classes para descrever suas funcionalidades. Será necessário garantir que o [ProGuard](https://developer.android.com/studio/build/shrink-code.html) esteja habilitado em seu projeto. Caso contrário, você incorrerá longos períodos de compilação para recursos que não são necessariamente relevantes para o seu aplicativo específico. Se você ainda estiver atingindo o limite do método 64K, também poderá habilitar o [multidexing](https://developer.android.com/studio/build/multidex.html).

## 2. Introdução

### 2.1 Registre seu aplicativo

Registre seu aplicativo seguindo [estas](https://graph.microsoft.io/en-us/app-registration) etapas.

### 2.2 Criar um objeto IAuthenticationProvider

Uma instância da classe **GraphServiceClient** manipula solicitações de criação, enviando-as à API do Microsoft Graph e processando as respostas.
Para criar uma nova instância dessa classe,
você precisa fornecer uma instância de
`IAuthenticationProvider` que possa autenticar solicitações para o Microsoft Graph.

Para obter um exemplo de autenticação em um aplicativo cliente, confira a [Autenticação do MSA do Android do SDK do MSGraph para o Adaptador do Android](https://github.com/microsoftgraph/msgraph-sdk-android-msa-auth-for-android-adapter).

### 2.3 Obter um objeto GraphServiceClient

Depois de definir a ID e a URL corretas do aplicativo, você deve obter um objeto **GraphServiceClient** para fazer solicitações no serviço. O SDK armazenará as informações da conta para você, mas quando um usuário entrar pela primeira vez, ele invocará a interface do usuário para obter as informações de conta do usuário.

```java
final IClientConfig mClientConfig = DefaultClientConfig
                                        .createWithAuthenticationProvider(mAuthenticationProvider);

final IGraphServiceClient mClient = new GraphServiceClient
                                            .Builder()
                                            .fromConfig(mClientConfig)
                                            .buildClient();
```

## 3. Fazer solicitações ao serviço

Depois de ter um GraphServiceClient autenticado, você pode começar a fazer chamadas de serviço. As solicitações ao serviço se parecem com a [API REST](https://graph.microsoft.io/en-us/docs).

### Obter a unidade

Para recuperar a unidade do usuário:

```java
graphClient
    .getMe()
    .getDrive()
    .buildRequest()
    .get(new ICallback<Drive>() {
  @Override
  public void success(final Drive result) {
    final String msg = "Found Drive " + result.id;
    Toast.makeText(getActivity(), msg, Toast.LENGTH_SHORT)
        .show();
  }
  ...
  // Handle failure case
});
```

Confira como o SDK foi desenvolvido na [visão geral](docs/overview.md).

## 4. Documentação

Confira uma documentação mais detalhada em:

* [Visão Geral](docs/overview.md)
* [Extensibilidade](docs/extensibility.md)
* [Manipulação de tipos abertos, suporte a PATCH com valores `nulos`](docs/opentypes.md)
* [Coleções](docs/collections.md)
* [Erros](docs/errors.md)
* [Fazer solicitações personalizadas](docs/custom-queries.md)
* [Problemas conhecidos](docs/known-issues.md)
* [Contribuições](docs/contributions.md)

## 5. Problemas

Confira problemas conhecidos em [problemas](https://github.com/MicrosoftGraph/sdk-android/issues).

## 6. Contribuições

O SDK do Microsoft Graph está aberto para contribuições. Leia como contribuir para este projeto [aqui](docs/contributions.md).

Este projeto adotou o [Código de Conduta de Código Aberto da Microsoft](https://opensource.microsoft.com/codeofconduct/).  Para saber mais, confira as [Perguntas frequentes sobre o Código de Conduta](https://opensource.microsoft.com/codeofconduct/faq/) ou entre em contato pelo [opencode@microsoft.com](mailto:opencode@microsoft.com) se tiver outras dúvidas ou comentários.

## 7. Versões do Android Compatíveis
O SDK do Microsoft Graph para biblioteca Android tem suporte em tempo de execução para a [API do Android revisão 15](http://source.android.com/source/build-numbers.html) e posteriores. Para criar o sdk você precisa instalar a API Android revisão 23 ou superior.

## 8. Licença

Copyright (c) Microsoft Corporation. Todos os direitos reservados. Licenciada sob a [Licença do MIT](LICENSE).

## 9. Avisos de terceiros

[Avisos de terceiros](THIRD%20PARTY%20NOTICES)
