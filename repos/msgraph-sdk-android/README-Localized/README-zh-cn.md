# 适用于 Android 的 Microsoft Graph SDK 入门

[ ![下载](https://api.bintray.com/packages/microsoftgraph/Maven/msgraph-sdk-android/images/download.svg) ](https://bintray.com/microsoftgraph/Maven/msgraph-sdk-android/_latestVersion)

将 [Microsoft Graph API](https://graph.microsoft.io/en-us/getting-started) 集成到你的 Android 应用程序中！

## 1.安装
### 1.1 通过 Gradle 安装 AAR
将 JCenter 存储库和 `msgraph-sdk-android` 的一个编译依赖项添加到项目的 `build.gradle`

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

### 1.2 启用 ProGuard
根据 Graph API 的特点，该 SDK 需要非常大量的类来描述其功能。你需要确保为项目启用 [ProGuard](https://developer.android.com/studio/build/shrink-code.html)。否则，对于不需要与你的特定应用程序相关的功能，将导致生成时间很长。如果仍然达到 64k 方法限制，还可以启用 [multidexing](https://developer.android.com/studio/build/multidex.html)。

## 2.入门

### 2.1 注册应用程序

按照[这些](https://graph.microsoft.io/en-us/app-registration)步骤注册你的应用程序。

### 2.2 创建 IAuthenticationProvider 对象

**GraphServiceClient** 类的一个实例会处理生成请求，将这些请求发送到
Microsoft Graph API，并处理响应。
若要创建此类的新实例，需要提供
`IAuthenticationProvider` 的实例，可用于对提供给 Microsoft Graph 的请求进行身份验证。

有关客户端应用程序中的身份验证示例，请参阅[适用于 Android 适配器的 MSGraph SDK Android MSA 身份验证](https://github.com/microsoftgraph/msgraph-sdk-android-msa-auth-for-android-adapter)。

### 2.3 获取 GraphServiceClient 对象

设置正确的应用程序 ID 和 URL 后，必须获取 **GraphServiceClient** 对象，以便针对服务发出请求。该 SDK 将为你存储帐户信息，但当用户首次登录时，它将调用 UI 以获取用户的帐户信息。

```java
final IClientConfig mClientConfig = DefaultClientConfig
                                        .createWithAuthenticationProvider(mAuthenticationProvider);

final IGraphServiceClient mClient = new GraphServiceClient
                                            .Builder()
                                            .fromConfig(mClientConfig)
                                            .buildClient();
```

## 3.针对服务发出请求

拥有经过身份验证的 GraphServiceClient 后，即可开始针对服务执行调用。针对服务的请求看起来像我们的 [REST API](https://graph.microsoft.io/en-us/docs)。

### 获取驱动器

检索用户的驱动器：

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

有关该 SDK 的设计方式的一般性概述，请参阅[概述](docs/overview.md)。

## 4.文档

有关更详细的文档，请参阅：

* [概述](docs/overview.md)
* [可扩展性](docs/extensibility.md)
* [处理开放式类型，带 `null` 值的 PATCH 支持](docs/opentypes.md)
* [集合](docs/collections.md)
* [错误](docs/errors.md)
* [发出自定义请求](docs/custom-queries.md)
* [已知问题](docs/known-issues.md)
* [参与](docs/contributions.md)

## 5.问题

有关已知问题，请参阅[问题](https://github.com/MicrosoftGraph/sdk-android/issues)。

## 6.参与

Microsoft Graph SDK 项目欢迎开发者的积极参与。请在[此处](docs/contributions.md)查看如何参与此项目。

此项目遵循 [Microsoft 开放源代码行为准则](https://opensource.microsoft.com/codeofconduct/)。有关详细信息，请参阅[行为准则常见问题解答](https://opensource.microsoft.com/codeofconduct/faq/)。如有其他任何问题或意见，也可联系 [opencode@microsoft.com](mailto:opencode@microsoft.com)。

## 7.支持的 Android 版本
[Android API 修订版 15](http://source.android.com/source/build-numbers.html) 及更高版本在运行时支持适用于 Android 的 Microsoft Graph SDK 库。必须安装 Android API 修订版 23 或更高版本，才能生成该 SDK。

## 8.许可证

版权所有 (c) Microsoft Corporation。保留所有权利。根据 [MIT 许可证](LICENSE)获得许可。

## 9.第三方声明

[第三方声明](THIRD%20PARTY%20NOTICES)
