# Prise en main du Kit de développement logiciel (SDK) Microsoft Graph dans une application Android

[ ![Téléchargement](https://api.bintray.com/packages/microsoftgraph/Maven/msgraph-sdk-android/images/download.svg) ](https://bintray.com/microsoftgraph/Maven/msgraph-sdk-android/_latestVersion)

Intégrez l'[API Microsoft Graph](https://graph.microsoft.io/en-us/getting-started) dans votre application Android !

## 1. Installation
### 1.1 Installer AAR avec Gradle
Ajoutez le référentiel JCenter et une dépendance de compilation pour `msgraph-sdk-android` à `build.gradle` de votre projet.

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

### 1.2 Activer ProGuard
La nature de l’API Graph est telle que le kit de développement logiciel nécessite un groupe important de classes pour décrire ses fonctionnalités. Vous devez vous assurer que [ProGuard](https://developer.android.com/studio/build/shrink-code.html) est activé sur votre projet. Dans le cas contraire, vous vous exposez à de longues heures de build pour une fonctionnalité qui n'est pas pertinente dans l'application concernée. Si vous atteignez toujours la limite de la méthode 64k, vous pouvez également activer [multidexing](https://developer.android.com/studio/build/multidex.html).

## 2. Prise en main

### 2.1 Inscription de votre application

Enregistrez votre application en suivant [ces](https://graph.microsoft.io/en-us/app-registration) étapes.

### 2.2 Créer un objet IAuthenticationProvider

Une instance de la classe **GraphServiceClient** gère la création de demandes en les envoyant vers l’API Microsoft Graph et en traitant les réponses.
Pour créer une nouvelle instance de cette classe,
vous devez fournir une instance
`IAuthenticationProvider` pouvant authentifier les demandes adressées à Microsoft Graph.

Pour obtenir un exemple d’authentification dans une application cliente, voir le [Kit de développement logiciel Android MSGraph pour adaptateur Android](https://github.com/microsoftgraph/msgraph-sdk-android-msa-auth-for-android-adapter).

### 2.3 Obtenir un objet GraphServiceClient

Une fois les corrects ID et URL d'application configurés, vous devez obtenir un objet **GraphServiceClient** pour formuler des demandes auprès du service. Le kit de développement logiciel stocke les informations de compte à votre place, mais lorsqu’un utilisateur ouvre une session pour la première fois, il appelle l'interface utilisateur pour obtenir les informations de compte utilisateur.

```java
final IClientConfig mClientConfig = DefaultClientConfig
                                        .createWithAuthenticationProvider(mAuthenticationProvider);

final IGraphServiceClient mClient = new GraphServiceClient
                                            .Builder()
                                            .fromConfig(mClientConfig)
                                            .buildClient();
```

## 3. Effectuer des demandes auprès du service

Une fois que votre GraphServiceClient est authentifié, vous pouvez commencer à effectuer des appels auprès du service. Les demandes effectuées auprès du service ressemblent à celles de notre [API REST](https://graph.microsoft.io/en-us/docs).

### Obtenir le lecteur

Récupérer le lecteur d’un utilisateur :

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

Pour obtenir une vue générale de la conception du kit de développement logiciel, voir [vue d’ensemble](docs/overview.md).

## 4. Documentation

Pour plus de détails, voir :

* [Vue d'ensemble](docs/overview.md)
* [Extensibilité](docs/extensibility.md)
* [Gestion des types ouverts, prise en charge des CORRECTIFs avec des `null` valeurs](docs/opentypes.md)
* [Collections](docs/collections.md)
* [Erreurs](docs/errors.md)
* [Envoyer des demandes personnalisées](docs/custom-queries.md)
* [Problèmes connus](docs/known-issues.md)
* [Contributions](docs/contributions.md)

## 5. Problèmes

Pour les problèmes connus, voir [problèmes](https://github.com/MicrosoftGraph/sdk-android/issues).

## 6. Contributions

Le kit de développement logiciel Microsoft Graph est ouvert aux contributions. Veuillez consulter comment contribuer à ce projet [ici](docs/contributions.md).

Ce projet a adopté le [Code de conduite Open Source de Microsoft](https://opensource.microsoft.com/codeofconduct/). Pour en savoir plus, reportez-vous à la [FAQ relative au code de conduite](https://opensource.microsoft.com/codeofconduct/faq/) ou contactez [opencode@microsoft.com](mailto:opencode@microsoft.com) pour toute question ou tout commentaire.

## 7. Versions Android prises en charge
Le kit de développement logiciel Microsoft Graph pour Android est pris en charge lors de l’exécution de l’[API Android version 15](http://source.android.com/source/build-numbers.html) et versions ultérieures. Vous devez installer l’API Android version 23 ou ultérieure pour créer le kit de développement logiciel.

## 8. Licence

Copyright (c) Microsoft Corporation. Tous droits réservés. Sous [licence MIT](LICENSE).

## 9. Notifications tierces

[Notifications tierces](THIRD%20PARTY%20NOTICES)
