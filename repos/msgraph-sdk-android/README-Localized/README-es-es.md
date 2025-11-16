# Introducción al SDK de Microsoft Graph para Android

[![Descargar](https://api.bintray.com/packages/microsoftgraph/Maven/msgraph-sdk-android/images/download.svg)](https://bintray.com/microsoftgraph/Maven/msgraph-sdk-android/_latestVersion)

Integre la [API de Microsoft Graph](https://graph.microsoft.io/en-us/getting-started) en su aplicación Android

## 1. Instalación
### 1.1 Instalar AAR mediante Gradle
Agregue el repositorio de JCenter y una dependencia de compilación para `msgraph-sdk-android` al `build.gradle` de su proyecto

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

### 1.2 Habilitar ProGuard
La naturaleza de la API de Graph es tal que el SDK necesita un conjunto de clases muy amplio para describir su funcionalidad. Debe asegurarse de que [ProGuard](https://developer.android.com/studio/build/shrink-code.html) está habilitado en su proyecto. En caso contrario, se provocarán largos tiempos de compilación para funciones que no sean necesarias para su aplicación en particular. Si sigue experimentando el límite del método de 64k, también puede habilitar [multidexing](https://developer.android.com/studio/build/multidex.html).

## 2. Introducción

### 2.1 Registrar la aplicación

Registre la aplicación siguiendo [estos](https://graph.microsoft.io/en-us/app-registration) pasos.

### 2.2 Crear un objeto IAuthenticationProvider

Una instancia de la clase **GraphServiceClient** controla las solicitudes de creación, su envío a la API de Microsoft Graph y el procesamiento de las respuestas.
Para crear una nueva instancia de esta clase, tiene que proporcionar una instancia de 
`IAuthenticationProvider`
que pueda autenticar solicitudes en Microsoft Graph.

Para obtener un ejemplo de autenticación en una aplicación cliente, vea el [Adaptador de MSGraph SDK Android MSA Auth para Android](https://github.com/microsoftgraph/msgraph-sdk-android-msa-auth-for-android-adapter).

### 2.3 Obtener un objeto GraphServiceClient

Una vez que haya establecido la dirección URL y el identificador de aplicación correctos, debe obtener un objeto **GraphServiceClient** para realizar solicitudes en el servicio. El SDK almacenará la información de la cuenta, pero cuando un usuario inicie sesión por primera vez, invocará la interfaz de usuario para obtener la información de la cuenta de usuario.

```java
final IClientConfig mClientConfig = DefaultClientConfig
                                        .createWithAuthenticationProvider(mAuthenticationProvider);

final IGraphServiceClient mClient = new GraphServiceClient
                                            .Builder()
                                            .fromConfig(mClientConfig)
                                            .buildClient();
```

## 3. Realizar solicitudes en el servicio

Una vez que tenga un GraphServiceClient que está autenticado, puede empezar a realizar llamadas en el servicio. Las solicitudes en el servicio son como nuestra [API de REST](https://graph.microsoft.io/en-us/docs).

### Obtener la unidad

Para recuperar la unidad de un usuario:

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

Para obtener información general sobre cómo está diseñado el SDK, vea [información general](docs/overview.md).

## 4. Documentación

Para ver documentación más detallada, consulte:

* [Información general](docs/overview.md)
* [Extensibilidad](docs/extensibility.md)
* [Control de tipos abiertos, compatibilidad de revisiones con valores `null`](docs/opentypes.md)
* [Colecciones](docs/collections.md)
* [Errores](docs/errors.md)
* [Realizar solicitudes personalizadas](docs/custom-queries.md)
* [Problemas conocidos](docs/known-issues.md)
* [Contribuciones](docs/contributions.md)

## 5. Problemas

Para los problemas conocidos, vea [problemas](https://github.com/MicrosoftGraph/sdk-android/issues).

## 6. Contribuciones

El SDK de Microsoft Graph está abierto para la contribución. Obtenga información acerca de cómo participar en este proyecto [aquí](docs/contributions.md).

Este proyecto ha adoptado el [Código de conducta de código abierto de Microsoft](https://opensource.microsoft.com/codeofconduct/). Para obtener más información, vea [Preguntas frecuentes sobre el código de conducta](https://opensource.microsoft.com/codeofconduct/faq/) o póngase en contacto con [opencode@microsoft.com](mailto:opencode@microsoft.com) si tiene otras preguntas o comentarios.

## 7. Versiones de Android admitidas
La biblioteca SDK de Microsoft Graph para Android es compatible durante el tiempo de ejecución para [la API de Android revisión 15](http://source.android.com/source/build-numbers.html) y posteriores. Para crear el sdk, necesita instalar la revisión de la API de Android 23 o posterior.

## 8. Licencia

Copyright (c) Microsoft Corporation. Reservados todos los derechos. Publicado bajo la [licencia MIT](LICENSE).

## 9. Avisos de terceros

[Avisos de terceros](THIRD%20PARTY%20NOTICES)
