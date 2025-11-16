# Начало работы с Microsoft Graph SDK для Android

[ ![Загрузка](https://api.bintray.com/packages/microsoftgraph/Maven/msgraph-sdk-android/images/download.svg) ](https://bintray.com/microsoftgraph/Maven/msgraph-sdk-android/_latestVersion)

Интегрируйте [API Microsoft Graph](https://graph.microsoft.io/en-us/getting-started) в свое приложение Android!

## 1. Установка
### 1.1 Установка AAR с помощью Gradle
Добавьте репозиторий JCenter и зависимость компиляции для `msgraph-sdk-android` в `build.gradle` вашего проекта.

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

### 1.2 Включение ProGuard
Суть Graph API заключается в том, что для описания функциональности SDK необходимо использовать большой набор классов. Необходимо убедиться в том, что в вашем проекте включен [ProGuard](https://developer.android.com/studio/build/shrink-code.html). В противном случае вам понадобится долгое подключение функций, необязательных для конкретного приложения. Если у вас все еще ограничение методов 64 КБ, включите [мултидексинг](https://developer.android.com/studio/build/multidex.html).

## 2. Начало работы

### 2.1 Регистрация приложения

Чтобы зарегистрировать приложение, выполните [следующие](https://graph.microsoft.io/en-us/app-registration) действия.

### 2.2 Создание объекта IAuthenticationProvider

Экземпляр класса **GraphServiceClient** обрабатывает запросы на создание, отправляя их в API Microsoft Graph и обрабатывая ответы.
Чтобы создать экземпляр этого класса,
требуется предоставить экземпляр
`IAuthenticationProvider`, который может проверять подлинность запросов к Microsoft Graph.

Пример проверки подлинности в клиентском приложении см. в статье [MSGraph SDK Android MSA Auth для Android Adapter](https://github.com/microsoftgraph/msgraph-sdk-android-msa-auth-for-android-adapter).

### 2.3 Получение объекта GraphServiceClient

После настройки идентификатора приложения и URL-адреса, необходимо получить объект **GraphServiceClient**, чтобы отправить запросы к службе. В SDK будут храниться сведения об учетной записи, но когда пользователь войдет в систему в первый раз, откроется интерфейс для получения сведений об учетной записи пользователя.

```java
final IClientConfig mClientConfig = DefaultClientConfig
                                        .createWithAuthenticationProvider(mAuthenticationProvider);

final IGraphServiceClient mClient = new GraphServiceClient
                                            .Builder()
                                            .fromConfig(mClientConfig)
                                            .buildClient();
```

## 3. Создание запросов к службе

Проверив подлинность GraphServiceClient, можно приступить к созданию запросов к службе. Запрос к службе выглядит так же, как и [REST API](https://graph.microsoft.io/en-us/docs).

### Получение диска

Для получения диска пользователя, сделайте следующее:

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

Общие сведения о дизайне пакета SDK см. в [обзоре](docs/overview.md).

## 4. Документация

Подробнее см. в статьях:

* [Обзор](docs/overview.md)
* [Расширения](docs/extensibility.md)
* [Обработка открытых типов. Поддержка PATCH со значениями `NULL`](docs/opentypes.md)
* [Коллекции](docs/collections.md)
* [Ошибки](docs/errors.md)
* [Создание пользовательских запросов](docs/custom-queries.md)
* [Известные проблемы](docs/known-issues.md)
* [Правки](docs/contributions.md)

## 5. Проблемы

Известные проблемы см. в статье [проблемы](https://github.com/MicrosoftGraph/sdk-android/issues).

## 6. Правки

Microsoft Graph SDK открыт для внесения изменений. Сведения о том, как добавить данные, см. в [этой статье](docs/contributions.md).

Этот проект соответствует [Правилам поведения разработчиков открытого кода Майкрософт](https://opensource.microsoft.com/codeofconduct/). Дополнительные сведения см. в разделе [часто задаваемых вопросов о правилах поведения](https://opensource.microsoft.com/codeofconduct/faq/). Если у вас возникли вопросы или замечания, напишите нам по адресу [opencode@microsoft.com](mailto:opencode@microsoft.com).

## 7. Поддерживаемые версии Android
Библиотека Microsoft Graph SDK для Android поддерживается в среде выполнения для [API Android 15](http://source.android.com/source/build-numbers.html) и более поздних версий. Чтобы создать пакет SDK, необходимо установить API Android 23 или более поздней редакции.

## 8. Лицензия

© Корпорация Майкрософт. Все права защищены. Предоставляется по [лицензии MIT](LICENSE).

## 9. УВЕДОМЛЕНИЯ ТРЕТЬИХ ЛИЦ

[УВЕДОМЛЕНИЯ ТРЕТЬИХ ЛИЦ](THIRD%20PARTY%20NOTICES)
